package modcharting;

import flixel.tweens.misc.BezierPathTween;
import flixel.tweens.misc.BezierPathNumTween;
import flixel.util.FlxTimer.FlxTimerManager;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import flixel.FlxStrip;
import flixel.graphics.tile.FlxDrawTrianglesItem.DrawData;
import openfl.geom.Vector3D;
import flixel.util.FlxSpriteUtil;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import modcharting.Modifier;
import managers.*;
import flixel.system.FlxAssets.FlxShader;
#if LEATHER
import states.PlayState;
import game.Note;
import game.StrumNote;
import game.Conductor;
#else
import PlayState;
import Note;
#end
import HazardAFT_Capture.HazardAFT_CaptureMultiCam as MultiCamCapture;
import modcharting.Proxiefield.Proxie as Proxy;

// import modcharting.ArrowPathBitmap;

using StringTools;

// a few todos im gonna leave here:
//--ZORO--
// setup quaternions for everything else (incoming angles and the rotate mod)
// do add and remove buttons on stacked events in editor
// fix switching event type in editor so you can actually do set events
// finish setting up tooltips in editor
// start documenting more stuff idk
//--EDWHAK--
// finish editor itself and fix some errors zoro didn't
// setup notePath stuff (in progress) -- im sorry but this is impossible for my brain, im not smart enough to figure it out (;-;)
// Make editor optimized? (yeah idfk what causes a lag XD)
// Lua support for editor or even playstate so player can see what kind of modchart they do
// Grain shit for sustains (the higger value the most and most soft sustain looks) -- seems impossible
// Fix "Stealth" mods when using playfields (for some reason playfields ask a general change instead of individual even if they are their own note copy??)
// ^^^ this also happens in "McMadness mod" in combo-meal song when notes goes timeStop (added playfields and got same result!!) interesting.

typedef StrumNoteType = #if (PSYCH || LEATHER) StrumNote #elseif KADE StaticArrow #elseif FOREVER_LEGACY UIStaticArrow #elseif ANDROMEDA Receptor #else FlxSprite #end;

class PlayfieldRenderer extends FlxSprite // extending flxsprite just so i can edit draw
{
	public var strumGroup:FlxTypedGroup<StrumNoteType>;
	public var notes:FlxTypedGroup<Note>;
	public var instance:ModchartMusicBeatState;
	public var playStateInstance:PlayState;
	public var editorPlayStateInstance:editors.EditorPlayState;
	public var playfields:Array<Playfield> = []; // adding an extra playfield will add 1 for each player
	public var proxiefields:Array<Proxiefield> = [];

	public var eventManager:ModchartEventManager;
	public var modifierTable:ModTable;
	public var tweenManager:FlxTweenManager = null;
	public var timerManager:FlxTimerManager = null;

	public var modchart:ModchartFile;
	public var inEditor:Bool = false;
	public var editorPaused:Bool = false;

	public var speed:Float = 1.0;

	public var modifiers(get, default):Map<String, Modifier>;

	public var isEditor:Bool = false;

	public var aftCapture:MultiCamCapture = null;

	private function get_modifiers():Map<String, Modifier>
	{
		return modifierTable.modifiers; // back compat with lua modcharts
	}

	public function new(strumGroup:FlxTypedGroup<StrumNoteType>, notes:FlxTypedGroup<Note>, instance:ModchartMusicBeatState)
	{
		super(0, 0);
		this.strumGroup = strumGroup;
		this.notes = notes;
		this.instance = instance;
		if (Std.isOfType(instance, PlayState))
			playStateInstance = cast instance; // so it just casts once
		if (Std.isOfType(instance, editors.EditorPlayState))
		{
			editorPlayStateInstance = cast instance; // so it just casts once
			isEditor = true;
		}

		strumGroup.visible = false; // drawing with renderer instead
		notes.visible = false;

		// fix stupid crash because the renderer in playstate is still technically null at this point and its needed for json loading
		instance.playfieldRenderer = this;

		tweenManager = new FlxTweenManager();
		timerManager = new FlxTimerManager();
		eventManager = new ModchartEventManager(this);
		modifierTable = new ModTable(instance, this);
		addNewPlayfield(0, 0, 0);
		addNewProxiefield(new Proxy());
		modchart = new ModchartFile(this);
	}

	public function addNewPlayfield(?x:Float = 0, ?y:Float = 0, ?z:Float = 0, ?alpha:Float = 1)
	{
		playfields.push(new Playfield(x, y, z, alpha));
	}

	public function addNewProxiefield(proxy:Proxy)
	{
		proxiefields.push(new Proxiefield(proxy));
	}

	override function update(elapsed:Float)
	{
		if (aftCapture != null)
		{
			aftCapture.update(elapsed);
		}
		try
		{
			// for (note in this.notes) note.updateObjectPosition(note);
			// for (strum in this.strumGroup) strum.updateObjectPosition(strum);
			eventManager.update(elapsed);
			tweenManager.update(elapsed); // should be automatically paused when you pause in game
			timerManager.update(elapsed);
		}
		catch (e)
		{
			trace(e);
		}
		super.update(elapsed);
	}

	override public function draw()
	{
		if (alpha == 0 || !visible)
			return;

		if (aftCapture != null)
		{
			for (pf in 0...proxiefields.length)
			{
				if (proxiefields[pf].sprite.graphic == null)
				{
					proxiefields[pf].sprite.loadCapture(aftCapture.bitmap);
				}
			}
		}

		strumGroup.cameras = this.cameras;
		notes.cameras = this.cameras;


		if(disableTryCatchDraw){
			drawStuff(getNotePositions());
			return;
		}

		try
		{
			drawStuff(getNotePositions());
		}
		catch (e)
		{
			trace(e);
		}
		// draw notes to screen
	}
	private var disableTryCatchDraw:Bool = true; //to make tracing errors easier instead of a vague "null object reference"

	private function addDataToStrum(strumData:NotePositionData, strum:StrumNote)
	{
		strum.x = strumData.x;
		strum.y = strumData.y;
		// strum.z = strumData.z;
		strum.angle = strumData.angle;
		strum.alpha = strumData.alpha;
		strum.scale.x = strumData.scaleX;
		strum.scale.y = strumData.scaleY;
		// strum.skew.x = strumData.skewX;
		// strum.skew.y = strumData.skewY;

		strum.rgbShader.stealthGlow = strumData.stealthGlow;
		strum.rgbShader.stealthGlowRed = strumData.glowRed;
		strum.rgbShader.stealthGlowGreen = strumData.glowGreen;
		strum.rgbShader.stealthGlowBlue = strumData.glowBlue;

		// strum.scaleX = strum.scale.x;
		// strum.scaleY = strum.scale.y;
		// strum.scaleZ = strumData.scaleZ;

		// strum.skewX = strumData.skewX;
		// strum.skewY = strumData.skewY;
		// strum.skewZ = strumData.skewZ;

		// strum.angleX = strumData.angleX;
		// strum.angleY = strumData.angleY;
		// strum.angleZ = strum.angle;
	}

	private function getDataForStrum(i:Int, pf:Int)
	{
		var strumX = NoteMovement.defaultStrumX[i];
		var strumY = NoteMovement.defaultStrumY[i];
		var strumZ = 0;
		var strumScaleX = NoteMovement.defaultScale[i];
		var strumScaleY = NoteMovement.defaultScale[i];
		var strumSkewX = NoteMovement.defaultSkewX[i];
		var strumSkewY = NoteMovement.defaultSkewY[i];
		if (ModchartUtil.getIsPixelStage(instance))
		{
			// work on pixel stages
			strumScaleX = 1 * PlayState.daPixelZoom;
			strumScaleY = 1 * PlayState.daPixelZoom;
		}
		var strumData:NotePositionData = NotePositionData.get();
		strumData.setupStrum(strumX, strumY, strumZ, i, strumScaleX, strumScaleY, strumSkewX, strumSkewY, pf);
		playfields[pf].applyOffsets(strumData);
		modifierTable.applyStrumMods(strumData, i, pf);
		return strumData;
	}

	private function addDataToNote(noteData:NotePositionData, daNote:Note)
	{
		daNote.x = noteData.x;
		daNote.y = noteData.y;
		daNote.z = noteData.z;
		daNote.angle = noteData.angle;
		daNote.alpha = noteData.alpha;
		daNote.scale.x = noteData.scaleX;
		daNote.scale.y = noteData.scaleY;
		// daNote.skew.x = noteData.skewX;
		// daNote.skew.y = noteData.skewY;

		daNote.rgbShader.stealthGlow = noteData.stealthGlow;
		daNote.rgbShader.stealthGlowRed = noteData.glowRed;
		daNote.rgbShader.stealthGlowGreen = noteData.glowGreen;
		daNote.rgbShader.stealthGlowBlue = noteData.glowBlue;

		// daNote.scaleX = daNote.scale.x;
		// daNote.scaleY = daNote.scale.y;
		// daNote.scaleZ = noteData.scaleZ;

		// daNote.skewX = noteData.skewX;
		// daNote.skewY = noteData.skewY;
		// daNote.skewZ = noteData.skewZ;

		// daNote.angleX = noteData.angleX;
		// daNote.angleY = noteData.angleY;
		// daNote.angleZ = daNote.angle;
	}

	private function createDataFromNote(noteIndex:Int, playfieldIndex:Int, curPos:Float, noteDist:Float, incomingAngle:Array<Float>)
	{
		var noteX = notes.members[noteIndex].x;
		var noteY = notes.members[noteIndex].y;
		var noteZ = notes.members[noteIndex].z;
		var lane = getLane(noteIndex);
		var noteScaleX = NoteMovement.defaultScale[lane];
		var noteScaleY = NoteMovement.defaultScale[lane];
		var noteSkewX = notes.members[noteIndex].skew.x;
		var noteSkewY = notes.members[noteIndex].skew.y;

		var noteAlpha:Float = 1;

		#if PSYCH
		if (!notes.members[noteIndex].specialHurt)
		{
			noteAlpha = notes.members[noteIndex].multAlpha;
			if (notes.members[noteIndex].hurtNote)
				noteAlpha = 0.55;
			if (notes.members[noteIndex].mimicNote)
				noteAlpha = ClientPrefs.mimicNoteAlpha;
		}
		else
		{
			noteAlpha = 0;
		}
		#else
		if (notes.members[noteIndex].isSustainNote)
			noteAlpha = 0.6;
		else
			noteAlpha = 1;
		#end

		if (ModchartUtil.getIsPixelStage(instance))
		{
			// work on pixel stages
			noteScaleX = 1 * PlayState.daPixelZoom;
			noteScaleY = 1 * PlayState.daPixelZoom;
		}

		var noteData:NotePositionData = NotePositionData.get();
		noteData.setupNote(noteX, noteY, noteZ, lane, noteScaleX, noteScaleY, noteSkewX, noteSkewY, playfieldIndex, noteAlpha, curPos, noteDist,
			incomingAngle[0], incomingAngle[1], notes.members[noteIndex].strumTime, noteIndex);
		playfields[playfieldIndex].applyOffsets(noteData);
		return noteData;
	}

	// private function addDataToPath(noteData:NotePositionData, arrowPath:ArrowPathBitmap)
	// {
		// arrowPath.x = noteData.x;
		// arrowPath.y = noteData.y;
		// arrowPath.z = noteData.z;
	// }

	private function getNoteCurPos(noteIndex:Int, strumTimeOffset:Float = 0, ?daDistance:Float = 0)
	{
		#if PSYCH
		if (notes.members[noteIndex].isSustainNote && ModchartUtil.getDownscroll(instance))
			strumTimeOffset -= Std.int(Conductor.stepCrochet / getCorrectScrollSpeed()); // psych does this to fix its sustains but that breaks the visuals so basically reverse it back to normal
		#else
		if (notes.members[noteIndex].isSustainNote && !ModchartUtil.getDownscroll(instance))
			strumTimeOffset += Conductor.stepCrochet; // fix upscroll lol
		#end
		if (notes.members[noteIndex].isSustainNote)
		{
			// moved those inside holdsMath cuz they are only needed for sustains ig?
			var noteDist = daDistance;

			strumTimeOffset += Std.int(Conductor.stepCrochet / getCorrectScrollSpeed());
			switch (ModchartUtil.getDownscroll(instance))
			{
				case true:
					if (noteDist > 0)
					{
						strumTimeOffset -= Std.int(Conductor.stepCrochet);
						strumTimeOffset += Std.int(Conductor.stepCrochet / getCorrectScrollSpeed());
					}
					else
					{
						strumTimeOffset += Std.int(Conductor.stepCrochet / getCorrectScrollSpeed());
					}
				case false:
					if (noteDist > 0)
					{
						strumTimeOffset -= Std.int(Conductor.stepCrochet);
					}
			}
			// FINALLY OMG I HATE THIS FUCKING MATH LMAO
		}

		var distance = (Conductor.songPosition - notes.members[noteIndex].strumTime) + strumTimeOffset;
		return distance * getCorrectScrollSpeed();
	}

	private function getLane(noteIndex:Int)
	{
		return (notes.members[noteIndex].mustPress ? notes.members[noteIndex].noteData + NoteMovement.keyCount : notes.members[noteIndex].noteData);
	}

	//lol XD
	public function getNoteDist(noteIndex:Int)
	{
		var noteDist = -0.55;
		if (ModchartUtil.getDownscroll(instance))
			noteDist *= -1;
		return noteDist;
	}

	private function getNotePositions()
	{
		var notePositions:Array<NotePositionData> = [];
		for (pf in 0...playfields.length)
		{
			for (i in 0...strumGroup.members.length)
			{
				var strumData = getDataForStrum(i, pf);
				notePositions.push(strumData);
			}
			for (i in 0...notes.members.length)
			{
				var songSpeed = getCorrectScrollSpeed();

				var lane = getLane(i);

				var noteDist = getNoteDist(i);
				noteDist = modifierTable.applyNoteDistMods(noteDist, lane, pf);

				var sustainTimeThingy:Float = 0;

				// just causes too many issues lol, might fix it at some point
				// if (notes.members[i].animation.curAnim.name.endsWith('end') && ClientPrefs.downScroll) //checking rn LMAO
				// {
				//     if (noteDist > 0)
				//         sustainTimeThingy = (ModchartUtil.getFakeCrochet()/4)/2; //fix stretched sustain ends (downscroll)
				//     //else
				//         //sustainTimeThingy = (-NoteMovement.getFakeCrochet()/4)/songSpeed;
				// }

				var curPos = getNoteCurPos(i, sustainTimeThingy, noteDist);
				curPos = modifierTable.applyCurPosMods(lane, curPos, pf);

				if ((notes.members[i].wasGoodHit || (notes.members[i].prevNote.wasGoodHit))
					&& curPos >= 0
					&& notes.members[i].isSustainNote)
					curPos = 0; // sustain clip

				var incomingAngle:Array<Float> = modifierTable.applyIncomingAngleMods(lane, curPos, pf);
				if (noteDist < 0)
					incomingAngle[0] += 180; // make it match for both scrolls

				// get the general note path
				NoteMovement.setNotePath(notes.members[i], lane, songSpeed, curPos, noteDist, incomingAngle[0], incomingAngle[1]);

				// save the position data
				var noteData = createDataFromNote(i, pf, curPos, noteDist, incomingAngle);

				// add offsets to data with modifiers
				modifierTable.applyNoteMods(noteData, lane, curPos, pf);

				// add position data to list
				notePositions.push(noteData);
			}
		}
		// sort by z before drawing
		notePositions.sort(function(a, b)
		{
			if (a.z < b.z)
				return -1;
			else if (a.z > b.z)
				return 1;
			else
				return 0;
		});
		return notePositions;
	}

	private function drawStrum(noteData:NotePositionData)
	{
		if (noteData.alpha <= 0)
			return;
		var changeX:Bool = noteData.z != 0;
		var strumNote = strumGroup.members[noteData.index];

		if (strumNote.arrowMesh == null){
			strumNote.setupMesh();
		}

		var thisNotePos;
		if (changeX)
			thisNotePos = ModchartUtil.calculatePerspective(new Vector3D(noteData.x + (strumNote.width / 2), noteData.y + (strumNote.height / 2),
				noteData.z * 0.001),
				ModchartUtil.defaultFOV * (Math.PI / 180),
				-(strumNote.width / 2),
				-(strumNote.height / 2));
		else
			thisNotePos = new Vector3D(noteData.x, noteData.y, 0);

		var skewX = ModchartUtil.getStrumSkew(strumNote, false);
		var skewY = ModchartUtil.getStrumSkew(strumNote, true);
		noteData.x = thisNotePos.x;
		noteData.y = thisNotePos.y;
		if (changeX)
		{
			noteData.scaleX *= (1 / -thisNotePos.z);
			noteData.scaleY *= (1 / -thisNotePos.z);
		}

		if (noteData.stealthGlow != 0)
			strumGroup.members[noteData.index].rgbShader.enabled = true; // enable stealthGlow once it finds its not 0?

		if (noteData.angleX != 0 || noteData.angleY != 0 || noteData.skewZ != 0 || noteData.skewX != 0 || noteData.skewY != 0)
		{
			strumNote.arrowMesh.x = noteData.x;
			strumNote.arrowMesh.y = noteData.y;
			strumNote.arrowMesh.z = noteData.z;
			
			strumNote.arrowMesh.scaleX = noteData.scaleX;
			strumNote.arrowMesh.scaleY = noteData.scaleY;
			strumNote.arrowMesh.scaleZ = noteData.scaleZ;

			strumNote.arrowMesh.skewX = noteData.skewX;
			strumNote.arrowMesh.skewY = noteData.skewY;
			strumNote.arrowMesh.skewZ = noteData.skewZ;
			strumNote.arrowMesh.skewX_offset = noteData.skewX_offset;
			strumNote.arrowMesh.skewY_offset = noteData.skewY_offset;
			strumNote.arrowMesh.skewZ_offset = noteData.skewZ_offset;

			strumNote.arrowMesh.fovOffsetX = noteData.fovOffsetX;
			strumNote.arrowMesh.fovOffsetY = noteData.fovOffsetY;

			strumNote.arrowMesh.pivotOffsetX = noteData.pivotOffsetX;
			strumNote.arrowMesh.pivotOffsetY = noteData.pivotOffsetY;
			strumNote.arrowMesh.pivotOffsetZ = noteData.pivotOffsetZ;

			strumNote.arrowMesh.angleX = noteData.angleX;
			strumNote.arrowMesh.angleY = noteData.angleY;
			strumNote.arrowMesh.angleZ = noteData.angle;

			strumNote.arrowMesh.offset = strumNote.offset;
		}
		else
		{
			strumNote.skew.x = noteData.skewX;
			strumNote.skew.y = noteData.skewY;
		}

		addDataToStrum(noteData, strumGroup.members[noteData.index]); // set position and stuff before drawing
		// strumGroup.members[noteData.index].cameras = this.cameras;
		if (strumNote.arrowMesh != null){
			strumGroup.members[noteData.index].arrowMesh.cameras = this.cameras;

			if (noteData.angleX != 0 || noteData.angleY != 0 || noteData.skewZ != 0 || noteData.skewX != 0 || noteData.skewY != 0){
				strumGroup.members[noteData.index].arrowMesh.updateTris();
				strumGroup.members[noteData.index].arrowMesh.drawManual(strumGroup.members[noteData.index].graphic, "");
			}else{
				strumGroup.members[noteData.index].cameras = this.cameras;
				strumGroup.members[noteData.index].draw();
			}
		}else{
			// draw it
			strumGroup.members[noteData.index].cameras = this.cameras;
			strumGroup.members[noteData.index].draw();
		}
	}

	private function drawNote(noteData:NotePositionData)
	{
		if (noteData.alpha <= 0)
			return;
		var changeX:Bool = noteData.z != 0;
		var daNote = notes.members[noteData.index];

		if (daNote.arrowMesh == null){
			daNote.setupMesh();
		}

		var thisNotePos;
		if (changeX)
			thisNotePos = ModchartUtil.calculatePerspective(new Vector3D(noteData.x + (daNote.width / 2) + ModchartUtil.getNoteOffsetX(daNote, instance),
				noteData.y + (daNote.height / 2), noteData.z * 0.001),
				ModchartUtil.defaultFOV * (Math.PI / 180),
				-(daNote.width / 2),
				-(daNote.height / 2));
		else
			thisNotePos = new Vector3D(noteData.x, noteData.y, 0);

		var skewX = ModchartUtil.getNoteSkew(daNote, false);
		var skewY = ModchartUtil.getNoteSkew(daNote, true);
		noteData.x = thisNotePos.x;
		noteData.y = thisNotePos.y;
		if (changeX)
		{
			noteData.scaleX *= (1 / -thisNotePos.z);
			noteData.scaleY *= (1 / -thisNotePos.z);
		}

		if (noteData.angleX != 0 || noteData.angleY != 0 || noteData.skewZ != 0 || noteData.skewX != 0 || noteData.skewY != 0)
		{
			daNote.arrowMesh.x = noteData.x;
			daNote.arrowMesh.y = noteData.y;
			daNote.arrowMesh.z = noteData.z;

			daNote.arrowMesh.scaleX = noteData.scaleX;
			daNote.arrowMesh.scaleY = noteData.scaleY;
			daNote.arrowMesh.scaleZ = noteData.scaleZ;

			daNote.arrowMesh.skewX = noteData.skewX;
			daNote.arrowMesh.skewY = noteData.skewY;
			daNote.arrowMesh.skewZ = noteData.skewZ;
			daNote.arrowMesh.skewX_offset = noteData.skewX_offset;
			daNote.arrowMesh.skewY_offset = noteData.skewY_offset;
			daNote.arrowMesh.skewZ_offset = noteData.skewZ_offset;

			daNote.arrowMesh.fovOffsetX = noteData.fovOffsetX;
			daNote.arrowMesh.fovOffsetY = noteData.fovOffsetY;

			daNote.arrowMesh.pivotOffsetX = noteData.pivotOffsetX;
			daNote.arrowMesh.pivotOffsetY = noteData.pivotOffsetY;
			daNote.arrowMesh.pivotOffsetZ = noteData.pivotOffsetZ;

			daNote.arrowMesh.angleX = noteData.angleX;
			daNote.arrowMesh.angleY = noteData.angleY;
			daNote.arrowMesh.angleZ = noteData.angle;

			daNote.arrowMesh.offset = daNote.offset;
		}
		else
		{
			daNote.skew.x = noteData.skewX;
			daNote.skew.y = noteData.skewY;
		}

		// noteData.skewX = skewX + noteData.skewX;
		// noteData.skewY = skewY + noteData.skewY;
		// set note position using the position data
		addDataToNote(noteData, notes.members[noteData.index]);
		// make sure it draws on the correct camera
		// notes.members[noteData.index].cameras = this.cameras;

		if (daNote.arrowMesh != null){
			notes.members[noteData.index].arrowMesh.cameras = this.cameras;

			if (noteData.angleX != 0 || noteData.angleY != 0 || noteData.skewZ != 0 || noteData.skewX != 0 || noteData.skewY != 0){
				notes.members[noteData.index].arrowMesh.updateTris();
				notes.members[noteData.index].arrowMesh.drawManual(notes.members[noteData.index].graphic, notes.members[noteData.index].noteType);
			}else{
				notes.members[noteData.index].cameras = this.cameras;
				notes.members[noteData.index].draw();
			}
		}else{
			// draw it
			notes.members[noteData.index].cameras = this.cameras;
			notes.members[noteData.index].draw();
		}
	}

	private function drawSustainNote(noteData:NotePositionData)
	{
		if (noteData.alpha <= 0)
			return;
		var daNote = notes.members[noteData.index];
		if (daNote.mesh == null)
			daNote.mesh = new SustainStrip(daNote);

		// daNote.scrollFactor.x = daNote.scrollFactor.x;
		// daNote.scrollFactor.y = daNote.scrollFactor.y;
		daNote.alpha = noteData.alpha;
		daNote.mesh.alpha = daNote.alpha;
		daNote.mesh.shader = daNote.rgbShader.parent.shader; // idfk if this works.
		daNote.mesh.spiralHolds = (noteData.spiralHold >= 1); // if noteData its 1 spiral holds mod should be enabled?

		// daNote.rgbShader.stealthGlow = noteData.stealthGlow; //make sure at the moment we render sustains they get shader changes? (OMG THIS FIXED SUDDEN HIDDEN AND ETC LMAO)
		// daNote.rgbShader.stealthGlowRed = noteData.glowRed;
		// daNote.rgbShader.stealthGlowGreen = noteData.glowGreen;
		// daNote.rgbShader.stealthGlowBlue = noteData.glowBlue;

		var songSpeed = getCorrectScrollSpeed();
		var lane = noteData.lane;

		// makes the sustain match the center of the parent note when at weird angles
		var yOffsetThingy = (NoteMovement.arrowSizes[lane] / 2);

		var thisNotePos = ModchartUtil.calculatePerspective(new Vector3D(noteData.x
			+ (daNote.width / 2)
			+ ModchartUtil.getNoteOffsetX(daNote, instance),
			noteData.y
			+ (NoteMovement.arrowSizes[noteData.lane] / 2), noteData.z * 0.001),
			ModchartUtil.defaultFOV * (Math.PI / 180),
			-(daNote.width / 2), yOffsetThingy
			- (NoteMovement.arrowSizes[noteData.lane] / 2));

		var timeToNextSustain = ModchartUtil.getFakeCrochet() / 4;
		if (noteData.noteDist < 0)
			timeToNextSustain *= -1; // weird shit that fixes upscroll lol
		// timeToNextSustain = -ModchartUtil.getFakeCrochet()/4; //weird shit that fixes upscroll lol

		var nextHalfNotePos = getSustainPoint(noteData, timeToNextSustain / 2);
		var nextNotePos = getSustainPoint(noteData, timeToNextSustain);

		var flipGraphic = false;

		// mod/bound to 360, add 360 for negative angles, mod again just in case
		var fixedAngY = ((noteData.incomingAngleY % 360) + 360) % 360;

		var reverseClip = (fixedAngY > 90 && fixedAngY < 270);

		if (noteData.noteDist > 0) // downscroll
		{
			if (!ModchartUtil.getDownscroll(instance)) // fix reverse
				flipGraphic = true;
		}
		else
		{
			if (ModchartUtil.getDownscroll(instance))
				flipGraphic = true;
		}
		// render that shit
		daNote.mesh.constructVertices(noteData, thisNotePos, nextHalfNotePos, nextNotePos, flipGraphic, reverseClip);

		daNote.mesh.cameras = this.cameras;
		daNote.mesh.draw();
	}

	private function drawArrowPathNew(noteData:NotePositionData){
		if (noteData.arrowPathAlpha <= 0)
			return;

		//TODO:
		/*
			- make this draw similar to VSLICE sustain draw (so i can make sustain mesh correctly, maybe just copy paste sustain code and change info to MT?)
			- make sure this shit doesn't lag the engine out unlike the old one
			- make sure that if no graphic exist, we create one (such as a FlxGraphic with the size the strip needs and stuff like that)
			- optimize the code to make it easier to understand
		*/

		//TODO: make sure this thing don't get note (sustainStrip) so i can grab any graphic and do a strip with it
		var daNote = notes.members[noteData.index];
		if (daNote.arrowPath == null)
			daNote.arrowPath = new SustainTrail(daNote.noteData, daNote.arrowPathLength, "");

		daNote.arrowPath.setNotePos(this, noteData, daNote.strumTime, noteData.lane, noteData.playfieldIndex);

		//TODO: change this to read arrowPath stuff instead
		daNote.alpha = noteData.alpha;
		daNote.arrowPath.alpha = daNote.alpha;

		daNote.arrowPath.shader = daNote.rgbShader.parent.shader; // idfk if this works. 
		//Warning: This is EXCLUSIVE for psych 0.7 and up (rgb shader) so any engine with HSV shouldn't call this

		// daNote.rgbShader.stealthGlow = noteData.stealthGlow; //make sure at the moment we render sustains they get shader changes? (OMG THIS FIXED SUDDEN HIDDEN AND ETC LMAO)
		// daNote.rgbShader.stealthGlowRed = noteData.glowRed;
		// daNote.rgbShader.stealthGlowGreen = noteData.glowGreen;
		// daNote.rgbShader.stealthGlowBlue = noteData.glowBlue;

		var songSpeed = getCorrectScrollSpeed();
		var lane = noteData.lane;

		// makes the sustain match the center of the parent note when at weird angles
		var yOffsetThingy = (NoteMovement.arrowSizes[lane] / 2);

		var thisNotePos = ModchartUtil.calculatePerspective(new Vector3D(noteData.x
			+ (daNote.width / 2)
			+ ModchartUtil.getNoteOffsetX(daNote, instance),
			noteData.y
			+ (NoteMovement.arrowSizes[noteData.lane] / 2), noteData.z * 0.001),
			ModchartUtil.defaultFOV * (Math.PI / 180),
			-(daNote.width / 2), yOffsetThingy
			- (NoteMovement.arrowSizes[noteData.lane] / 2));

		var timeToNextSustain = ModchartUtil.getFakeCrochet() / 4;
		if (noteData.noteDist < 0)
			timeToNextSustain *= -1; // weird shit that fixes upscroll lol
		// timeToNextSustain = -ModchartUtil.getFakeCrochet()/4; //weird shit that fixes upscroll lol

		var nextHalfNotePos = getSustainPoint(noteData, timeToNextSustain / 2);
		var nextNotePos = getSustainPoint(noteData, timeToNextSustain);

		var flipGraphic = false;

		// mod/bound to 360, add 360 for negative angles, mod again just in case
		var fixedAngY = ((noteData.incomingAngleY % 360) + 360) % 360;

		var reverseClip = (fixedAngY > 90 && fixedAngY < 270);

		if (noteData.noteDist > 0) // downscroll
		{
			if (!ModchartUtil.getDownscroll(instance)) // fix reverse
				flipGraphic = true;
		}
		else
		{
			if (ModchartUtil.getDownscroll(instance))
				flipGraphic = true;
		}
		// // render that shit
		// daNote.arrowPath.constructVertices(noteData, thisNotePos, nextHalfNotePos, nextNotePos, flipGraphic, reverseClip);

		daNote.arrowPath.cameras = this.cameras;
		daNote.arrowPath.draw();
	}

	// private function drawArrowPath(noteData:NotePositionData){
	// 	if (noteData.arrowPathAlpha <= 0)
	// 		return;

	// 	// var strumNote = strumGroup.members[noteData.index];
	// 	//as same as "sustainStripMesh" we are creating this path here so, once it draws, the path draws with it, instead of having it stored in PF renderer as an extra
	// 	//+ allows "noteData" to properly modify its variables

	// 	//Hazard's shitty arrowpath bitmap method! x.x -- with some of Edwhak's "optimization mindset"
	// 	var doArrowPaths_bitmapStyle:Bool = true; //default to false for now. Set to true for arrowpath rendering.
	// 	var arrowPaths_bitmapStyle:ArrowPathBitmap; //this is the path itself
	// 	var notitgPathSprite:FlxSprite; //this is the sprite that catch the path

	// 	// if(doArrowPaths_bitmapStyle){ //make sure this just skip if we don't want to draw it
	// 		arrowPaths_bitmapStyle = new ArrowPathBitmap(this);
	// 		notitgPathSprite = new FlxSprite(0,0); //sprite that exist ig? (grabs path info)
	// 		notitgPathSprite.loadGraphic(arrowPaths_bitmapStyle.bitmap);
	// 	// }

	// 	// noteData.x += strumNote.width/2;
    // 	// noteData.y += strumNote.height/2;

	// 	// addDataToPath(noteData, arrowPaths_bitmapStyle);

	// 	notitgPathSprite.cameras = this.cameras; //ensure it's on the correct camera!

	// 	arrowPaths_bitmapStyle.updateAFT();//Update the arrowpaths!
	// 	notitgPathSprite.draw();//Draw it!
	// }

	private function drawStuff(notePositions:Array<NotePositionData>)
	{
		//separated due this being arrowPath lol
		//drawArrowPath(notePositions[0]);

		for (noteData in notePositions)
		{
			drawArrowPathNew(noteData); //draw path
			if (noteData.isStrum) // draw strum
				drawStrum(noteData);
			else if (!notes.members[noteData.index].isSustainNote) // draw note
				drawNote(noteData);
			else // draw Sustain
				drawSustainNote(noteData);
		}
	}

	function getSustainPoint(noteData:NotePositionData, timeOffset:Float):NotePositionData
	{
		var daNote:Note = notes.members[noteData.index];
		var songSpeed:Float = getCorrectScrollSpeed();
		var lane:Int = noteData.lane;
		var pf:Int = noteData.playfieldIndex;

		var noteDist:Float = getNoteDist(noteData.index);
		var curPos:Float = getNoteCurPos(noteData.index, timeOffset, noteDist);

		curPos = modifierTable.applyCurPosMods(lane, curPos, pf);

		if ((daNote.wasGoodHit || (daNote.prevNote.wasGoodHit)) && curPos >= 0)
			curPos = 0; // so sustain does a "fake" clip

		noteDist = modifierTable.applyNoteDistMods(noteDist, lane, pf);
		var incomingAngle:Array<Float> = modifierTable.applyIncomingAngleMods(lane, curPos, pf);
		if (noteDist < 0)
			incomingAngle[0] += 180; // make it match for both scrolls
		// get the general note path for the next note
		NoteMovement.setNotePath(daNote, lane, songSpeed, curPos, noteDist, incomingAngle[0], incomingAngle[1]);
		// save the position data
		var noteData = createDataFromNote(noteData.index, pf, curPos, noteDist, incomingAngle);
		// add offsets to data with modifiers
		modifierTable.applyNoteMods(noteData, lane, curPos, pf);
		var yOffsetThingy = (NoteMovement.arrowSizes[lane] / 2);
		var finalNotePos = ModchartUtil.calculatePerspective(new Vector3D(noteData.x
			+ (daNote.width / 2)
			+ ModchartUtil.getNoteOffsetX(daNote, instance),
			noteData.y
			+ (NoteMovement.arrowSizes[noteData.lane] / 2), noteData.z * 0.001),
			ModchartUtil.defaultFOV * (Math.PI / 180),
			-(daNote.width / 2), yOffsetThingy
			- (NoteMovement.arrowSizes[noteData.lane] / 2));

		noteData.x = finalNotePos.x;
		noteData.y = finalNotePos.y;
		noteData.z = finalNotePos.z;

		return noteData;
	}

	public function getCorrectScrollSpeed()
	{
		if (inEditor)
			return PlayState.SONG.speed; // just use this while in editor so the instance shit works
		else
			return ModchartUtil.getScrollSpeed(isEditor ? null : playStateInstance);
		return 1.0;
	}

	public function createTween(Object:Dynamic, Values:Dynamic, Duration:Float, ?Options:TweenOptions):FlxTween
	{
		var tween:FlxTween = tweenManager.tween(Object, Values, Duration, Options);
		tween.manager = tweenManager;
		return tween;
	}

	public function createTweenNum(FromValue:Float, ToValue:Float, Duration:Float = 1, ?Options:TweenOptions, ?TweenFunction:Float->Void):FlxTween
	{
		var tween:FlxTween = tweenManager.num(FromValue, ToValue, Duration, Options, TweenFunction);
		tween.manager = tweenManager;
		return tween;
	}

	public function createBezierPathTween(Object:Dynamic, Values:Dynamic, Duration:Float, ?Options:TweenOptions):FlxTween
	{
		var tween:FlxTween = tweenManager.bezierPathTween(Object, Values, Duration, Options);
		tween.manager = tweenManager;
		return tween;
	}

	public function createBezierPathNumTween(Points:Array<Float>, Duration:Float, ?Options:TweenOptions, ?TweenFunction:Float->Void):FlxTween
	{
		var tween:FlxTween = tweenManager.bezierPathNumTween(Points, Duration, Options, TweenFunction);
		tween.manager = tweenManager;
		return tween;
	}

	override public function destroy()
	{
		if (modchart != null)
		{
			for (customMod in modchart.customModifiers)
			{
				customMod.destroy(); // make sure the interps are dead
			}
		}
		super.destroy();
	}
}
