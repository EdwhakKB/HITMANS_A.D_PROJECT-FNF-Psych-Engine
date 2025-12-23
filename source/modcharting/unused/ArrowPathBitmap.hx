package modcharting;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import lime.graphics.Image;
import lime.math.Vector2;
import openfl.Vector;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BitmapDataChannel;
import openfl.display.BlendMode;
import openfl.display.CapsStyle;
import openfl.display.Graphics;
import openfl.display.GraphicsPathCommand;
import openfl.display.JointStyle;
import openfl.display.LineScaleMode;
import openfl.display.Sprite;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.geom.Vector3D;
#if LEATHER
import game.Conductor;
import game.Note as StrumlineNote;
import game.StrumNote;
import states.PlayState;
#else
import Conductor;
import Note as StrumlineNote;
import PlayState;
#end

typedef Strumline = #if (PSYCH || LEATHER) StrumNote #elseif KADE StaticArrow #elseif FOREVER_LEGACY UIStaticArrow #elseif ANDROMEDA Receptor #else FlxSprite #end;

// SCRAPED BECAUSE IT JUST CAUSED MAJOR LAG PROBLEMS LOL
// ALSO BECAUSE IM NOT SMART ENOUGH TO FIGURE IT OUT

class ArrowPathBitmap
{
	// The actual bitmap data
	public var bitmap:BitmapData;

	var flashGfxSprite(default, null):Sprite = new Sprite();
	var flashGfx(default, null):Graphics;

	// For limiting the AFT update rate. Useful to make it less framerate dependent.
	public var updateTimer:Float = 0.0;
	public var updateRate:Float = 0.25;

	// Just a basic rectangle which fills the entire bitmap when clearing out the old pixel data
	var rec:Rectangle;

	var blendMode:String = "normal";
	var colTransf:ColorTransform;

	var pfr:PlayfieldRenderer;

	var noteData:NotePositionData;

	public function setNotePos(noteData:NotePositionData, strumTime:Float, lane:Int, pf:Int):Void
	{
		// Sample the current mod math!

		var songSpeed:Float = pfr.getCorrectScrollSpeed();

		var noteDist:Float = pfr.getNoteDist(0); // ?????

		var curPos = (Conductor.songPosition - strumTime) * songSpeed;

		curPos = pfr.modifierTable.applyCurPosMods(lane, curPos, pf);

		var incomingAngle:Array<Float> = pfr.modifierTable.applyIncomingAngleMods(lane, curPos, pf);
		if (noteDist < 0)
			incomingAngle[0] += 180; // make it match for both scrolls

		// get the general note path
		NoteMovement.setNotePath_positionData(noteData, lane, songSpeed, curPos, noteDist, incomingAngle[0], incomingAngle[1]);

		// move the x and y to properly be in the center of the strum graphic
		var strumNote = pfr.strumGroup.members[lane]; // first we need to know what the strum is though lol
		noteData.x += strumNote.width / 2;
		noteData.y += strumNote.height / 2;

		// add offsets to data with modifiers
		pfr.modifierTable.applyNoteMods(noteData, lane, curPos, pf);

		// add position data to list //idk what this does so I just commented it out lol cuz we just constantly reuse 1 notePosition data.
		// notePositions.push(noteData);

		// Apply z-axis projection!
		var pointWidth:Float = defaultLineSize;
		var pointHeight:Float = 1;

		var thisNotePos = ModchartUtil.calculatePerspective(new Vector3D(noteData.x + (pointWidth / 2), noteData.y + (pointHeight / 2), noteData.z * 0.001),
			ModchartUtil.defaultFOV * (Math.PI / 180), -(pointWidth / 2), -(pointHeight / 2));

		noteData.x = thisNotePos.x;
		noteData.y = thisNotePos.y;
		noteData.scaleX *= (1 / -thisNotePos.z);
		noteData.scaleY *= (1 / -thisNotePos.z);
	}

	var defaultLineSize:Float = 2;

	public function updateAFT():Void
	{
		bitmap.lock();
		clearAFT();
		flashGfx.clear();

		for (pf in 0...pfr.playfields.length)
		{
			for (l in 0...NoteMovement.keyCount * 2) // for opponent and player strums
			{
				// TODO -> ADD A WAY TO CHECK IF THE ARROWPATH MOD IS ENABLED FOR THIS LANE SO WE CAN SKIP ALL THE MATH FOR IT IF IT ISN'T ENABLED.
				var arrowPathAlpha:Float = 1;
				arrowPathAlpha = pfr.strumGroup.members[l].alpha; // TEMP CODE: just copy the strum alpha for now

				if (arrowPathAlpha <= 0)
					continue; // skip path if we can't see shit

				// ALSO TODO -> MAKE THESE VARIABLES ADJUSTABLE VIA MODS
				// var pathLength:Float = noteData.arrowPathLength != null ? noteData.arrowPathLength : 1800; //NoteData.arrowpathLength[l] != null ? NoteData.arrowpathLength[l] : 1500;
				// var pathBackLength:Float = noteData.arrowPathBackwardsLength != null ? noteData.arrowPathBackwardsLength : 200; //NoteData.arrowpathBackwardsLength[l] != null ? NoteData.arrowpathBackwardsLength[l] : 200;
				// var holdGrain:Float = noteData.pathGrain != null ? noteData.pathGrain : 50; // NoteData.pathGrain != null ? NoteData.pathGrain : 50;
				// var laneSpecificGrain:Float = strum?.mods?.pathGrain_Lane[l % 4] ?? 0; // NoteData.pathGrain_Lane[l % 4] != null ? NoteData.pathGrain_Lane[l % 4] : 0;
				// if (laneSpecificGrain > 0)
				// {
				//   holdGrain = laneSpecificGrain;
				// }

				var pathLength:Float = 1800;
				var pathBackLength:Float = 200;
				var holdGrain:Float = 50;

				var fullLength:Float = pathLength + pathBackLength;
				var holdResolution:Int = Math.floor(fullLength / holdGrain);

				// https://github.com/4mbr0s3-2/Schmovin/blob/main/SchmovinRenderers.hx
				var commands = new Vector<Int>();
				var data = new Vector<Float>();

				var tim:Float = Conductor.songPosition;
				tim -= pathBackLength;
				for (i in 0...holdResolution)
				{
					var timmy:Float = ((fullLength / holdResolution) * i);
					setNotePos(noteData, tim + timmy, l, pf);

					var scaleX = FlxMath.remapToRange(noteData.scaleX, 0, NoteMovement.defaultScale[l], 0, 1);
					var lineSize:Float = defaultLineSize * scaleX;

					var path2:Vector2 = new Vector2(noteData.x, noteData.y);

					if (i == 0) // first point
					{
						commands.push(GraphicsPathCommand.MOVE_TO);
						flashGfx.lineStyle(lineSize, 0xFFFFFFFF, arrowPathAlpha);
					}
					else
					{
						commands.push(GraphicsPathCommand.LINE_TO);
					}
					data.push(path2.x);
					data.push(path2.y);
				}
				flashGfx.drawPath(commands, data);
			}
		}

		bitmap.draw(flashGfxSprite);
		bitmap.disposeImage();
		flashGfx.clear();
		bitmap.unlock();
	}

	// clear out the old bitmap data
	public function clearAFT():Void
	{
		bitmap.fillRect(rec, 0);
	}

	public function update(elapsed:Float = 0.0):Void
	{
		if (bitmap != null)
		{
			if (updateTimer >= 0 && updateRate != 0)
			{
				updateTimer -= elapsed;
			}
			else if (updateTimer < 0 || updateRate == 0)
			{
				updateTimer = updateRate;
				updateAFT();
			}
		}
	}

	var width:Int = 0;
	var height:Int = 0;

	public function new(s:PlayfieldRenderer, w:Int = -1, h:Int = -1)
	{
		this.pfr = s;
		height = h;
		width = w;
		if (width == -1 || height == -1)
		{
			width = FlxG.width;
			height = FlxG.height;
		}

		noteData = new NotePositionData();

		flashGfx = flashGfxSprite.graphics;
		bitmap = new BitmapData(width, height, true, 0);
		rec = new Rectangle(0, 0, width, height);
		colTransf = new ColorTransform();
	}
}

// function drawArrowPath(fields:Array<StrumLine>)
// 	{
// 		var data = new openfl.Vector<Float>();
// 		var commands = new openfl.Vector<Int>();
// 		var defaultPos = new Vector3D();
// 		__pathPoints.splice(0, __pathPoints.length);
// 		__pathCommands.splice(0, __pathCommands.length);
// 		__pathShape.graphics.clear();
// 		// so we draw every path of every receptor once
// 		// cus if not, it crashs (cus stack overflow or something like that (i dont founded the error....))
// 		for (f in fields) {
// 			__pathSprite.cameras = f._cameras.copy();
// 			for (r in f) {
// 				final l = r.extra.get('lane');
// 				final fn = r.extra.get('field');
// 				final alpha = getPercent('arrowPathAlpha', fn);
// 				final thickness = 1 + Math.round(getPercent('arrowPathThickness', fn));
// 				if ((alpha + thickness) <= 0)
// 					continue;
// 				final divitions = Math.round(35 / Math.max(1, getPercent('arrowPathDivitions', fn)));
// 				final limit = 1250 * (1 + getPercent('arrowPathLength', fn));
// 				final invertal = limit / divitions;
// 				var moved = false;
// 				defaultPos.setTo(getReceptorX(l, fn), getReceptorY(l, fn), 0);
// 				defaultPos.incrementBy(ModchartUtil.getHalfPos());
// 				__pathShape.graphics.lineStyle(thickness, 0xFFFFFFFF, alpha);
// 				for (sub in 0...divitions)
// 				{
// 					var time = invertal * sub;
// 					var position = modifiers.getPath(defaultPos.clone(), {
// 						time: Conductor.songPosition + time,
// 						hDiff: time,
// 						receptor: l,
// 						field: fn,
// 						arrow: true
// 					});
// 					/**
// 					 * So it seems that if the lines are too far from the screen
// 					   causes HORRIBLE memory leaks (from 60mb to 3gb-5gb in 2 seconds WHAT THE FUCK)
// 					 */
// 					if ((position.x <= 0 - thickness) || (position.x >= __pathSprite.pixels.rect.width) ||
// 						(position.y <= 0 - thickness) || (position.y >= __pathSprite.pixels.rect.height))
// 						continue;
// 					__pathCommands.push(moved ? GraphicsPathCommand.LINE_TO : GraphicsPathCommand.MOVE_TO);
// 					__pathPoints.push(position.x);
// 					__pathPoints.push(position.y);
// 					moved = true;
// 				}
// 			}
// 		}
// 		__pathShape.graphics.drawPath(__pathCommands, __pathPoints);
// 		// then drawing the path pixels into the sprite pixels
// 		__pathSprite.pixels.fillRect(__pathSprite.pixels.rect, 0x00FFFFFF);
// 		__pathSprite.pixels.draw(__pathShape);
// 		// draw the sprite to the cam
// 		__pathSprite.draw();
// 	}
