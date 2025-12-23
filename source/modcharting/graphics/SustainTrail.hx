package modcharting.graphics;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.tile.FlxDrawTrianglesItem;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import lime.math.Vector2;
import modcharting.*;
import openfl.display.TriangleCulling;
import openfl.geom.Vector3D;
import flixel.math.FlxAngle;
import objects.Note;

using utils.FloatTools;


/**
 * This is based heavily on the `FlxStrip` class. It uses `drawTriangles()` to clip a sustain note
 * trail at a certain time.
 * The whole `FlxGraphic` is used as a texture map. See the `NOTE_hold_assets.fla` file for specifics
 * on how it should be constructed.
 *
 * @author MtH
 */

 //TODO:
 /*
	- Make sure sustains are ALWAYS centered uppon their note/strum
	- Make XML support for sustain rather than sprite override (can use NewModchartArrow as base since they are the same class lmao)
	- ^^^ In case XML does not exist we can use the "basic default" one
	- Make sure math for the sustains work properly uppon modifier math (such as how Z changes it, incoming mods and etc etc)
	- If sustain is too long and we are using a modifier that makes Z go over screen use something to make it invisible, either "Stealth" shader forced for them, or smth
	- Make the rest "modifierVariables" for this (such as noteData.holdGrain, noteData.holdWidth and etc) (DONE PARTIALLY)
	
	- That'll be all ig.

	-Ed
 */
class SustainTrail extends FlxSprite
{
	/**
	 * The triangles corresponding to the hold, followed by the endcap.
	 * `top left, top right, bottom left`
	 * `top left, bottom left, bottom right`
	 */
	static final TRIANGLE_VERTEX_INDICES:Array<Int> = [0, 1, 2, 1, 2, 3, 4, 5, 6, 5, 6, 7];

	public var strumTime:Float = 0; // millis
	public var noteDirection:Int = 0;
	public var sustainLength(default, set):Float = 0; // millis
	public var fullSustainLength:Float = 0;

	// public var z:Float = 0;
	// maybe BlendMode.MULTIPLY if missed somehow, drawTriangles does not support!

	/**
	 * A `Vector` of floats where each pair of numbers is treated as a coordinate location (an x, y pair).
	 */
	public var vertices:DrawData<Float> = new DrawData<Float>();

	public var vertices_array:Array<Float> = [];

	/**
	 * A `Vector` of integers or indexes, where every three indexes define a triangle.
	 */
	public var indices:DrawData<Int> = new DrawData<Int>();

	/**
	 * A `Vector` of normalized coordinates used to apply texture mapping.
	 */
	public var uvtData:DrawData<Float> = new DrawData<Float>();

	/**
	 * A `Vector` of magic for color magic, IDFK
	 */
	public var colors:DrawData<Int> = null;

	private var zoom:Float = 1;

	/**
	 * What part of the trail's end actually represents the end of the note.
	 * This can be used to have a little bit sticking out.
	 */
	public var endOffset:Float = 0.5; // 0.73 is roughly the bottom of the sprite in the normal graphic!

	/**
	 * At what point the bottom for the trail's end should be clipped off.
	 * Used in cases where there's an extra bit of the graphic on the bottom to avoid antialiasing issues with overflow.
	 */
	public var bottomClip:Float = 0.9;
	
  	/**
   	* Whether the note will recieve custom vertex data
   	*/
  	public var customVertexData:Bool = false;

	public var isPixel:Bool;
	public var noteStyleOffsets:Array<Float>;

	var graphicWidth:Float = 0;
	var graphicHeight:Float = 0;

	public var isArrowPath:Bool = false;
	public var pfr:PlayfieldRenderer;
    public var noteField:NoteField;

	public var z:Float = 0;

	// Makes the mesh all wobbly! Taken from ZProjectSprite_Note.hx
  	public var vibrateEffect:Float = 0.0;

	/**
	 * Normally you would take strumTime:Float, noteData:Int, sustainLength:Float, parentNote:Note (?)
	 * @param NoteData
	 * @param SustainLength Length in milliseconds.
	 * @param fileName
	 */
	public function new(noteDirection:Int, sustainLength:Float, pfr:PlayfieldRenderer, noteField:NoteField)
	{
		super(0, 0);
		this.sustainLength = sustainLength;
		this.fullSustainLength = sustainLength;
		this.noteDirection = noteDirection;

		this.pfr = pfr;
        this.noteField = noteField;
		
		setIndices(TRIANGLE_VERTEX_INDICES);
    	setupHoldNoteGraphic();

   		this.active = true; // This NEEDS to be true for the note to be drawn!
	}

	/**
   * Sets the indices for the triangles.
   * @param indices The indices to set.
   */
	public function setIndices(indices:Array<Int>):Void
	{
		if (this.indices.length == indices.length)
		{
		for (i in 0...indices.length)
		{
			this.indices[i] = indices[i];
		}
		}
		else
		{
		this.indices = new DrawData<Int>(indices.length, false, indices);
		}
	}

	/**
	* Sets the vertices for the triangles.
	* @param vertices The vertices to set.
	*/
	public function setVertices(vertices:Array<Float>):Void
	{
		if (this.vertices.length == vertices.length)
		{
		for (i in 0...vertices.length)
		{
			this.vertices[i] = vertices[i];
		}
		}
		else
		{
		this.vertices = new DrawData<Float>(vertices.length, false, vertices);
		}
	}

	/**
	* Sets the UV data for the triangles.
	* @param uvtData The UV data to set.
	*/
	public function setUVTData(uvtData:Array<Float>):Void
	{
		if (this.uvtData.length == uvtData.length)
		{
		for (i in 0...uvtData.length)
		{
			this.uvtData[i] = uvtData[i];
		}
		}
		else
		{
		this.uvtData = new DrawData<Float>(uvtData.length, false, uvtData);
		}
	}

	/**
	* Creates hold note graphic and applies correct zooming
	* @param noteStyle The note style
	*/
	public function setupHoldNoteGraphic():Void
	{
		if (isArrowPath)
		{
		// if (parentStrumline != null)
		// {
		// 	loadGraphic(Paths.image(parentStrumline.arrowPathFileName));
		// }
		// else
		// {
		// 	loadGraphic(Paths.image('NOTE_ArrowPath'));
		// }
		}
		else
		{
			loadGraphic(Paths.image('NOTE_ArrowPath'));
		}

		antialiasing = true;

		this.isPixel = PlayState.isPixelStage;
		if (isPixel)
		{
			endOffset = bottomClip = 1;
			antialiasing = false;
		}
		else
		{
			endOffset = 0.5;
			bottomClip = 0.9;
		}

		zoom = 1.0;
		zoom *= isPixel ? 8.0 : 1.55;
		zoom *= 0.7;

		// CALCULATE SIZE
		graphicWidth = graphic.width / 8 * zoom; // amount of notes * 2
		graphicHeight = sustainHeight(sustainLength, pfr?.getCorrectScrollSpeed() ?? 1.0);
		// instead of scrollSpeed, PlayState.SONG.speed

		flipY = ClientPrefs.data.downScroll;

		// alpha = 0.6;
		alpha = 1.0;
		updateColorTransform();

		if (useHSVShader)
		{
			// if (hsvShader == null) hsvShader = new HSVNotesShader();
			// this.shader = hsvShader;
		}

		updateClipping();
	}

	function getBaseScrollSpeed():Float
	{
		return (pfr?.getCorrectScrollSpeed() ?? 1.0);
	}

	var previousScrollSpeed:Float = 1;

	override function update(elapsed):Void
	{
		super.update(elapsed);
		if (previousScrollSpeed != (pfr?.getCorrectScrollSpeed() ?? 1.0))
		{
			triggerRedraw();
		}
		previousScrollSpeed = pfr?.getCorrectScrollSpeed() ??  1.0;
	}

	/**
	 * Calculates height of a sustain note for a given length (milliseconds) and scroll speed.
	 * @param	susLength	The length of the sustain note in milliseconds.
	 * @param	scroll		The current scroll speed.
	 */
	public static inline function sustainHeight(susLength:Float, scroll:Float)
	{
		return (susLength * 0.45 * scroll);
	}

	function set_sustainLength(s:Float):Float
	{
		if (s < 0.0) s = 0.0;

		if (sustainLength == s) return s;
		this.sustainLength = s;
		triggerRedraw();
		return this.sustainLength;
	}

	function triggerRedraw():Void
	{
		graphicHeight = sustainHeight(sustainLength, pfr?.getCorrectScrollSpeed() ?? 1.0);
		if (!usingHazModHolds) //since we have this thingy ig?
			updateClipping();
		updateHitbox();
	}

	public override function updateHitbox():Void
	{
		width = graphicWidth;
		height = graphicHeight;

		offset.set(0, 0);
		origin.set(width * 0.5, height * 0.5);
	}

	var usingHazModHolds:Bool = true;

	public function updateLength()
		sustainLength = (strumTime + fullSustainLength) - Conductor.songPosition;

	/**
	 * Sets up new vertex and UV data to clip the trail.
	 * If flipY is true, top and bottom bounds swap places.
	 * @param songTime	The time to clip the note at, in milliseconds.
	 */
	public function updateClipping(songTime:Float = 0):Void
	{
		if (graphic == null || customVertexData)
		{
			return;
		}

		if (usingHazModHolds) updateClipping_mods(fakeNote, songTime);
	}

	var fakeNote:NotePositionData = new NotePositionData();
	var perspectiveShift:Vector3D = new Vector3D(0, 0, 0);

	function resetFakeNote():Void
	{
		fakeNote = NotePositionData.get();
		// fakeNote.x = 0;
		// fakeNote.y = 0;
		// fakeNote.z = 0;
		// fakeNote.angle = 0;


		// fakeNote.skewX = 0;
		// fakeNote.skewY = 0;

		// fakeNote.alpha = 1;
		// fakeNote.scaleX = 1;
		// fakeNote.scaleY = 1;
	}

	public var renderEnd:Bool = true; // test
	public var piece:Int = 0; // test
	public var previousPiece:SustainTrail = null;

	public var cullMode = TriangleCulling.NONE;

	private var old3Dholds:Bool = false;

	private var holdResolution:Int = 4;

  	private var useOldStealthGlowStyle:Bool = false;

	// Extra math for if you need information about the hold's TRUE curPos (not affected by being held down or not).
	function extraHoldRootInfo(data:NotePositionData):Void
	{
		/*if (this.hsvShader == null)*/ return;

		var notePos:Float = (Conductor.songPosition * 0.001);
		distanceFromReceptor_unscaledpos = notePos;
		updateStealthGlowV2(data);
	}

	/**
	* Forwards data to the hsvShader to render stealth transitions smoothly.
	* Hopefully will be updated in the future to use an array instead cuz at the moment, only supports 1 of each type (sudden, hidden, vanish)
	*/
	function updateStealthGlowV2(data:NotePositionData):Void
	{
		if (isArrowPath)
		{
		// this.hsvShader.setFloat('_holdHeight', holdResolution);
		return;
		}

		// this.hsvShader.setFloat('_stealthSustainSuddenAmount', 0.0);
		// this.hsvShader.setFloat('_stealthSustainHiddenAmount', 0.0);
		// this.hsvShader.setFloat('_stealthSustainVanishAmount', 0.0);

		useOldStealthGlowStyle = false;
		if (useOldStealthGlowStyle)
		{
		return;
		}

		// this.hsvShader.setFloat('_stealthSustainSuddenNoGlow', whichStrumNote?.strumExtraModData?.sudden_noGlow ?? 0.0);
		// this.hsvShader.setFloat('_stealthSustainHiddenNoGlow', whichStrumNote?.strumExtraModData?.hidden_noGlow ?? 0.0);
		// this.hsvShader.setFloat('_stealthSustainVanishNoGlow', whichStrumNote?.strumExtraModData?.vanish_noGlow ?? 0.0);

		// get the info we need
		// var sStart:Float = whichStrumNote?.strumExtraModData?.suddenStart ?? 500.0;
		// var sEnd:Float = whichStrumNote?.strumExtraModData?.suddenEnd ?? 300.0;

		// var hStart:Float = whichStrumNote?.strumExtraModData?.hiddenStart ?? 500.0;
		// var hEnd:Float = whichStrumNote?.strumExtraModData?.hiddenEnd ?? 300.0;

		// this.hsvShader.setFloat('_stealthSustainSuddenAmount', whichStrumNote?.strumExtraModData?.suddenModAmount ?? 0.0);
		// this.hsvShader.setFloat('_stealthSustainHiddenAmount', whichStrumNote?.strumExtraModData?.hiddenModAmount ?? 0.0);
		// this.hsvShader.setFloat('_stealthSustainVanishAmount', whichStrumNote?.strumExtraModData?.vanishModAmount ?? 0.0);

		// this.hsvShader.setBool('_isHold', true);
		// this.hsvShader.setFloat('_holdHeight', holdResolution);

		// var holdPosFromReceptor:Float = (distanceFromReceptor_unscaledpos - (whichStrumNote?.noteModData?.curPos_unscaled ?? 0)) * (flipY ? -1 : 1);

		// // 1.125 works really well for 2.5 scroll speed so let's go from there
		// // 2.5 = 1.125
		// // 1 = 0.45 (WAIT I RECONGISE THAT NUMBER!!!)
		// var magicNumber:Float = Constants.PIXELS_PER_MS * parentStrumline?.scrollSpeed ?? 1.0;

		// var spacingBetweenEachUVpiece:Float = this.fullSustainLength * magicNumber; // magic number?

		// // Sudden math
		// var holdPosFromSuddenStart:Float = holdPosFromReceptor - sStart;
		// var holdPosFromSuddenEnd:Float = holdPosFromReceptor - sEnd;

		// var test1:Float = holdPosFromSuddenStart / spacingBetweenEachUVpiece * -1;
		// var test2:Float = holdPosFromSuddenEnd / spacingBetweenEachUVpiece * -1;

		// this.hsvShader.setFloat('_stealthSustainSuddenStart', test2);
		// this.hsvShader.setFloat('_stealthSustainSuddenEnd', test1);

		// // Hidden math
		// var holdPosFromHiddenStart:Float = holdPosFromReceptor - hStart;
		// var holdPosFromHiddenEnd:Float = holdPosFromReceptor - hEnd;

		// var test1:Float = holdPosFromHiddenStart / spacingBetweenEachUVpiece * -1;
		// var test2:Float = holdPosFromHiddenEnd / spacingBetweenEachUVpiece * -1;

		// this.hsvShader.setFloat('_stealthSustainHiddenStart', test1);
		// this.hsvShader.setFloat('_stealthSustainHiddenEnd', test2);

		// // FUCK ME

		// sStart = whichStrumNote?.strumExtraModData?.vanish_SuddenStart ?? 202.5;
		// sEnd = whichStrumNote?.strumExtraModData?.vanish_SuddenEnd ?? 125.0;

		// hStart = whichStrumNote?.strumExtraModData?.vanish_HiddenStart ?? 475.0;
		// hEnd = whichStrumNote?.strumExtraModData?.vanish_HiddenEnd ?? 397.5;

		// var holdPosFromSuddenStart:Float = holdPosFromReceptor - sStart;
		// var holdPosFromSuddenEnd:Float = holdPosFromReceptor - sEnd;

		// var test1:Float = holdPosFromSuddenStart / spacingBetweenEachUVpiece * -1;
		// var test2:Float = holdPosFromSuddenEnd / spacingBetweenEachUVpiece * -1;

		// this.hsvShader.setFloat('_stealthSustainVanish_SuddenStart', test2);
		// this.hsvShader.setFloat('_stealthSustainVanish_SuddenEnd', test1);

		// var holdPosFromHiddenStart:Float = holdPosFromReceptor - hStart;
		// var holdPosFromHiddenEnd:Float = holdPosFromReceptor - hEnd;

		// var test1:Float = holdPosFromHiddenStart / spacingBetweenEachUVpiece * -1;
		// var test2:Float = holdPosFromHiddenEnd / spacingBetweenEachUVpiece * -1;

		// this.hsvShader.setFloat('_stealthSustainVanish_HiddenStart', test1);
		// this.hsvShader.setFloat('_stealthSustainVanish_HiddenEnd', test2);
	}

	// reuse this vector2 and vector3 variable instead of creating a bunch of new ones all the time
	var tempVec2:Vector2 = new Vector2(0, 0);
	var tempVec3:Vector3D = new Vector3D(0, 0, 0);

	function susSample(noteData:NotePositionData, strumTimmy:Float, lane:Int, pf:Int):Void
	{
		try
		{
			resetFakeNote();
			// Apply the information of this sustain to the noteData such as the lane / direction, the strumTime of this note, etc
			// Apply any extra information here if needed to like, idk, "noteData.isHold = true"
			fakeNote.index = noteData.index;

			var songSpeed:Float = pfr.getCorrectScrollSpeed();

			var noteDist:Float = noteField.getNoteDist(); // ?????
			noteDist = pfr.modifierTable.applyNoteDistMods(noteDist, lane, pf);

			var curPos = getNoteCurPos(fakeNote.index, strumTimmy, pf);
			// var curPos = (Conductor.songPosition - strumTimmy) * songSpeed;

			curPos = pfr.modifierTable.applyCurPosMods(lane, curPos, pf);

			var daNote = noteField.strumLine.notes.members[fakeNote.index]; // first we need to know what the strum is though lol
			var daStrum = noteField.strumLine.strums.members[lane];

			if (!isArrowPath)
				if ((daNote.wasGoodHit) && curPos >= 0) curPos = 0.0;

			var incomingAngle:Array<Float> = pfr.modifierTable.applyIncomingAngleMods(lane, curPos, pf);
			if (noteDist < 0)
				incomingAngle[0] += 180; // make it match for both scrolls

			// get the general note path
			NoteMovement.setNotePath_positionData(fakeNote, lane, songSpeed, curPos, noteDist, incomingAngle[0], incomingAngle[1]);

			// move the x and y to properly be in the center of the strum graphic
			if (!isArrowPath){
				fakeNote.x += (daNote.width / 2) - (frameWidth / 15);
				fakeNote.y += (daNote.height / 2) - (frameHeight / 20);
			}else{
				fakeNote.x += (daStrum.width / 2) - (frameWidth / 15);
				fakeNote.y += (daStrum.height / 2) - (frameHeight / 20);
			}


			// add offsets to data with modifiers
			pfr.modifierTable.applyNoteMods(fakeNote, lane, curPos, pf);

			// add position data to list //idk what this does so I just commented it out lol cuz we just constantly reuse 1 notePosition data.
			// notePositions.push(noteData);

			// Apply z-axis projection!  (only apply it here if using old 3D math logic (not using 3d render mode (since this is arrowpaths, we don't really care about making them all fancy 3D anyway...?)))
			if (old3Dholds)
			{
				var pointWidth:Float = graphicWidth;
				var pointHeight:Float = 0;

				var thisNotePos = ModchartUtil.calculatePerspective(new Vector3D(fakeNote.x + (pointWidth / 2), fakeNote.y + (pointHeight / 2),
					fakeNote.z * 0.001),
					ModchartUtil.defaultFOV * (Math.PI / 180),
					-(pointWidth / 2),
					-(pointHeight / 2));

				fakeNote.x = thisNotePos.x;
				fakeNote.y = thisNotePos.y;
				fakeNote.scaleX *= (1 / -thisNotePos.z);
				fakeNote.scaleY *= (1 / -thisNotePos.z);
			}
			// temp fix for sus notes covering the entire fucking screen
			if (fakeNote.z > zCutOff)
			{
				fakeNote.alpha = 0;
				fakeNote.scaleX = 0.0;
				fakeNote.scaleY = 0.0;
			}
		}
		catch (e:haxe.Exception)
		{
		}
		// trace(e.message, e.stack);
	}

	var zCutOff:Float = 835;

	var is3D:Bool = false;

	private function getNoteCurPos(noteIndex:Int, strumTimeOffset:Float = 0, ?pf:Int = 0)
	{
		var distance = Conductor.songPosition - strumTimeOffset;
		return distance * pfr.getCorrectScrollSpeed();
	}

	// For now, default to the old 3D render method. We can make it work for 3D render mode another time.
	function applyPerspective(pos:Vector3D, rotatePivot:Vector2):Vector2
	{
		if (vibrateEffect != 0)
		{
			pos.x += FlxG.random.float(-1, 1) * vibrateEffect;
			pos.y += FlxG.random.float(-1, 1) * vibrateEffect;
			pos.z += FlxG.random.float(-1, 1) * vibrateEffect;
		}

		if (/*!is3D ||*/ old3Dholds)
		{
			tempVec2.setTo(pos.x, pos.y);

			// apply skew
			// Currently doesn't work when the sustain moves on the z axis!
			var xPercent_SkewOffset:Float = tempVec2.x - fakeNote.x - (graphicWidth / 2 * (perspectiveShift.z)); // this is dumb but at least for the time being, it makes the disconnect less bad.
			if (fakeNote.skewY != 0) tempVec2.y += xPercent_SkewOffset * Math.tan(fakeNote.skewY * FlxAngle.TO_RAD);
			return tempVec2;
		}
		else
		{
			tempVec3.setTo(pos.x, pos.y, pos.z);
			
      		// apply skew
      		var xPercent_SkewOffset:Float = tempVec3.x - fakeNote.x - (graphicWidth / 2);
			if (fakeNote.skewY != 0) tempVec3.y += xPercent_SkewOffset * Math.tan(fakeNote.skewY * FlxAngle.TO_RAD);

			// Rotate
			var angleY:Float = fakeNote.angleY;

			tempVec2.setTo(tempVec3.x, tempVec3.z);
			var rotateModPivotPoint:Vector2 = new Vector2(rotatePivot.x, tempVec3.z);
			tempVec2 = ModchartUtil.rotateAround(rotateModPivotPoint, tempVec2, angleY);
			tempVec3.x = tempVec2.x;
			tempVec3.z = tempVec2.y;

			// v0.8.0a -> playfield skewing
			// var playfieldSkewOffset_Y:Float = pos.x - (whichStrumNote?.strumExtraModData?.playfieldX ?? FlxG.width / 2);
			// var playfieldSkewOffset_X:Float = pos.y - (whichStrumNote?.strumExtraModData?.playfieldY ?? FlxG.height / 2);

			// if (noteModData.skewX_playfield != 0) tempVec3.x += playfieldSkewOffset_X * Math.tan(noteModData.skewX_playfield * FlxAngle.TO_RAD);
			// if (noteModData.skewY_playfield != 0) tempVec3.y += playfieldSkewOffset_Y * Math.tan(noteModData.skewY_playfield * FlxAngle.TO_RAD);

			// var playfieldSkewOffset_Z:Float = pos.y - (whichStrumNote?.strumExtraModData?.playfieldY ?? FlxG.height / 2);
			// if (noteModData.skewZ_playfield != 0) tempVec3.z += playfieldSkewOffset_Z * Math.tan(noteModData.skewZ_playfield * FlxAngle.TO_RAD);

			tempVec3.z *= 0.001;
			var thisNotePos:Vector3D = perspectiveMath(tempVec3, 0, 0);
			return new Vector2(thisNotePos.x, thisNotePos.y);
		}
	}

	var spiralHoldOldMath:Bool = false;
	var tinyOffsetForSpiral:Float = 0.01;
	var lastOrientAngle:Float = 0; // same bandaid fix for orient.

	private var holdRootX:Float = 0.0;
	private var holdRootY:Float = 0.0;
	private var holdRootZ:Float = 0.0;
	// private var holdRootAngle:Float = 0.0;
	// private var holdRootAlpha:Float = 0.0;
	private var holdRootScaleX:Float = 0.0;
	private var holdRootScaleY:Float = 0.0;

	private function clipTimeThing(songTimmy:Float, strumtimm:Float, piece:Int = 0):Float
	{
		var returnVal:Float = 0.0;
		if (songTimmy >= strumtimm)
		{
			returnVal = songTimmy - strumtimm;
			returnVal -= (grain * tinyOffsetForSpiral) * piece;
		}
		if (returnVal < 0) returnVal = 0;
		return returnVal;
	}

	// If set to false, will disable the hold being hidden when being dropped
	public var hideOnMiss:Bool = true;

	// The angle the hold note is coming from with spiral holds! used for hold covers!
	public var baseAngle:Float = 0;

	// TEST
	// public var distanceFromReceptor_pos:Float = 0;
	public var distanceFromReceptor_unscaledpos:Float = 0;

	// The lower the number, the more hold segments are rendered and calculated!
	public var grain:Float = 50;

	/**
	 * Sets up new vertex and UV data to clip the trail.
	 * @param songTime	The time to clip the note at, in milliseconds.
	 * @param uvSetup	Should UV's be updated?.
	 */
	public function updateClipping_mods(noteData:NotePositionData, songTime:Float = 0.0, uvSetup:Bool = true):Void
	{
		try
		{
			// trace(noteData.noteIndex);
			// trace(noteDirection);
			// trace(noteData.lane);
			if (fakeNote == null) fakeNote = new NotePositionData();

			grain = 50 + (isArrowPath ? noteData.pathGrain : noteData.sustainGrain);

			var songTimmy:Float = songTime;
			var scale:Float = 45 + (isArrowPath ? noteData.arrowPathWidth : noteData.sustainWidth);

			var longHolds:Float = 0;
			longHolds += 1;

			holdResolution = Math.floor(fullSustainLength * longHolds / grain);

			if (holdResolution < 1) // To ensure UV's to break (lol???)
				holdResolution = 1;

			// var spiralHolds:Bool = parentStrumline?.mods?.spiralHolds[noteDirection % 4] ?? false;
			var spiralHolds:Bool = (isArrowPath ? noteData.spiralPath >= 0.5 : noteData.spiralHold >= 0.5);

			var testCol:Array<Int> = [];
			var vertices:Array<Float> = [];
			var uvtData:Array<Float> = [];
			var noteIndices:Array<Int> = [];

			var dumbAlt:Bool = true;

			for (i in 0...Std.int(holdResolution * 2))
			{
				// for (k in 0...3)
				// {
				//  noteIndices.push(i + k);
				// }
				if (dumbAlt)
				{
					noteIndices.push(i + 0);
					noteIndices.push(i + 2);
					noteIndices.push(i + 1);
				}
				else
				{
					noteIndices.push(i + 0);
					noteIndices.push(i + 1);
					noteIndices.push(i + 2);
				}
				dumbAlt = !dumbAlt;
			}
			// add cap
			var highestNumSoFar_:Int = Std.int((holdResolution * 2) - 1 + 2);
			noteIndices.push(highestNumSoFar_ + 0 + 1);
			noteIndices.push(highestNumSoFar_ + 2 + 1);
			noteIndices.push(highestNumSoFar_ + 1 + 1);

			noteIndices.push(highestNumSoFar_ + 0 + 2);
			noteIndices.push(highestNumSoFar_ + 1 + 2);
			noteIndices.push(highestNumSoFar_ + 2 + 2);

			// for (k in 0...3)
			// {
			//  noteIndices.push(highestNumSoFar_ + k + 2);
			// }

			var clipHeight:Float = sustainHeight(sustainLength - (songTime - strumTime), pfr?.getCorrectScrollSpeed() ?? 1.0).clamp(0, graphicHeight);
			// trace(clipHeight);
			if (clipHeight <= 0.0)
			{
				//	trace('INVISIBLE HOLD!');
				visible = false;
				return;
			}
			else
			{
				visible = true;
			}

			var sussyLength:Float = fullSustainLength;
			var holdWidth = graphicWidth;
			// var scaleTest = fakeNote.scale.x;
			// var holdLeftSide = (holdWidth * (scaleTest - 1)) * -1;
			// var holdRightSide = holdWidth * scaleTest;

			var clippingTimeOffset:Float = clipTimeThing(songTimmy, strumTime);
			// trace("testing sussyL, holdWidth, and clippingTimeOffset", sussyLength, holdWidth, clippingTimeOffset);

			var bottomHeight:Float = graphic.height * zoom * endOffset;
			var partHeight:Float = clipHeight - bottomHeight;

			extraHoldRootInfo(noteData);
			susSample(noteData, this.strumTime + clippingTimeOffset, noteData.lane, noteData.playfieldIndex);
			var scaleTest = noteData.scaleX;
			var widthScaled = holdWidth * scaleTest + scale;
			var scaleChange = widthScaled - holdWidth;
			var holdLeftSide = 0 - (scaleChange / 2);
			var holdRightSide = widthScaled - (scaleChange / 2);

			// scaleTest = fakeNote.scale.x;
			// holdLeftSide = (holdWidth * (scaleTest - 1)) * -1;
			// holdRightSide = holdWidth * scaleTest;

			// ===HOLD VERTICES==
			// var uvHeight = (-partHeight) / graphic.height / zoom;
			// V0.7.4a -> Updated UV textures to not be stupid anymore. (0 -> 1 -> 2 -> 3) since we can just use the repeating texture power of drawTriangles.

			// just copy it from source idgaf
			if (uvSetup)
			{
				uvtData[0 * 2] = (1 / 4) * (noteDirection % 4); // 0%/25%/50%/75% of the way through the image
				uvtData[0 * 2 + 1] = 0; // top bound
				// Top left

				// Top right
				uvtData[1 * 2] = uvtData[0 * 2] + (1 / 8); // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left)
				uvtData[1 * 2 + 1] = uvtData[0 * 2 + 1]; // top bound
			}

			// grab left vert
			var rotateOrigin:Vector2 = new Vector2(fakeNote.x + holdLeftSide, fakeNote.y);
			// move rotateOrigin to be inbetween the left and right vert so it's centered
			rotateOrigin.x += ((fakeNote.x + holdRightSide) - (fakeNote.x + holdLeftSide)) / 2;
			var vert:Vector2 = applyPerspective(new Vector3D(fakeNote.x + holdLeftSide, fakeNote.y, fakeNote.z), rotateOrigin);

			// Top left
			vertices[0 * 2] = vert.x; // Inline with left side
			// vertices[0 * 2 + 1] = flipY ? clipHeight : graphicHeight - clipHeight;
			vertices[0 * 2 + 1] = vert.y;

			// testCol[0 * 2] = fakeNote.color;
			// testCol[0 * 2 + 1] = fakeNote.color;
			// testCol[1 * 2] = fakeNote.color;
			// testCol[1 * 2 + 1] = fakeNote.color;

			// this.color = fakeNote.color;
			// if (!isArrowPath)
			// {
			this.alpha = isArrowPath ? noteData.arrowPathAlpha : 0.6 * noteData.alpha;
			// }
			this.z = fakeNote.z; // for z ordering
			
			// if (useHSVShader && this.hsvShader != null)
			// {
			// 	this.hsvShader.stealthGlow = fakeNote.stealthGlow;
			// 	this.hsvShader.stealthGlowBlue = fakeNote.stealthGlowBlue;
			// 	this.hsvShader.stealthGlowGreen = fakeNote.stealthGlowGreen;
			// 	this.hsvShader.stealthGlowRed = fakeNote.stealthGlowRed;
			// }

			// Top right
			vert = applyPerspective(new Vector3D(fakeNote.x + holdRightSide, fakeNote.y, fakeNote.z), rotateOrigin);
			vertices[1 * 2] = vert.x;
			vertices[1 * 2 + 1] = vert.y; // Inline with top left vertex

			var holdPieceStrumTime:Float = 0.0;

			var previousSampleX:Float = fakeNote.x;
			var previousSampleY:Float = fakeNote.y;

			var rightSideOffX:Float = 0;
			var rightSideOffY:Float = 0;

			// var rememberMeX:Float = 0;
			// var rememberMeY:Float = 0;

			// THE REST, HOWEVER...
			for (k in 0...holdResolution)
			{
				var i:Int = (k + 1) * 2;

				holdPieceStrumTime = this.strumTime + ((sussyLength / holdResolution) * (k + 1) * longHolds);
				var tm:Float = holdPieceStrumTime;
				if (spiralHolds && !spiralHoldOldMath)
				{
					tm += (k +
						1) * (grain * tinyOffsetForSpiral); // ever so slightly offset the time so that it never hits 0, 0 on the strum time so spiral hold can do its magic
				}
				susSample(noteData, tm + clipTimeThing(songTimmy, holdPieceStrumTime), noteData.lane, noteData.playfieldIndex);

				// susSample(this.strumTime + clippingTimeOffset + ((sussyLength / holdResolution) * (k + 1)), true);
				// scaleTest = fakeNote.scale.x;
				// holdLeftSide = (holdWidth * (scaleTest - 1)) * -1;
				// holdRightSide = holdWidth * scaleTest;

				scaleTest = noteData.scaleX;
				widthScaled = holdWidth * scaleTest + scale;
				scaleChange = widthScaled - holdWidth;
				holdLeftSide = 0 - (scaleChange / 2);
				holdRightSide = widthScaled - (scaleChange / 2);

				// grab left vert
				var rotateOrigin:Vector2 = new Vector2(fakeNote.x + holdLeftSide, fakeNote.y);
				// move rotateOrigin to be inbetween the left and right vert so it's centered
				rotateOrigin.x += ((fakeNote.x + holdRightSide) - (fakeNote.x + holdLeftSide)) / 2;

				var vert:Vector2 = applyPerspective(new Vector3D(fakeNote.x + holdLeftSide, fakeNote.y, fakeNote.z), rotateOrigin);

				// Bottom left
				vertices[i * 2] = vert.x; // Inline with left side
				vertices[i * 2 + 1] = vert.y;

				if (spiralHolds && spiralHoldOldMath)
				{
					var calculateAngleDif:Float = 0;
					var a:Float = (fakeNote.y - previousSampleY) * -1; // height
					var b:Float = (fakeNote.x - previousSampleX); // length
					var angle:Float = Math.atan(b / a);
					angle *= (180 / Math.PI);
					calculateAngleDif = angle;
					tempVec2.setTo(vertices[i * 2], vertices[i * 2 + 1]);
					var thing:Vector2 = ModchartUtil.rotateAround(tempVec2, new Vector2(fakeNote.x + holdRightSide, vertices[i * 2 + 1]), calculateAngleDif);
					rightSideOffX = thing.x;
					rightSideOffY = thing.y;
					previousSampleX = fakeNote.x;
					previousSampleY = fakeNote.y;
					if (k == 0) // to orient the root of the hold properly!
					{
						var scuffedDifferenceX:Float = fakeNote.x + holdRightSide - rightSideOffX;
						var scuffedDifferenceY:Float = vertices[i * 2 + 1] - rightSideOffY;
						vertices[(i + 1 - 2) * 2] -= scuffedDifferenceX;
						vertices[(i + 1 - 2) * 2 + 1] -= scuffedDifferenceY;
						// rememberMeX = scuffedDifferenceX;
						// rememberMeY = scuffedDifferenceY;
					}
					// Bottom right
					vertices[(i + 1) * 2] = rightSideOffX;
					vertices[(i + 1) * 2 + 1] = rightSideOffY;
				}
				else if (spiralHolds)
				{
					var affectRoot:Bool = (k == 0);
					var angle:Float = 0;
					var a:Float = (fakeNote.y - previousSampleY) * -1; // height
					var b:Float = (fakeNote.x - previousSampleX); // length
					if (!(a == 0 && b == 0))
					{
						angle = Math.atan2(b,a);
						lastOrientAngle = angle;
					}
					else
					{
						angle = lastOrientAngle;
					}
					var calculateAngleDif:Float = angle * (180 / Math.PI);

					// rotate right point
					// var rvert:Vector2 = applyPerspective(new Vector3D(fakeNote.x + holdRightSide, fakeNote.y, fakeNote.z), rotateOrigin);
					var rotatePoint:Vector2 = new Vector2(fakeNote.x + holdRightSide, fakeNote.y);
					var thing:Vector2 = ModchartUtil.rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
					thing = applyPerspective(new Vector3D(thing.x, thing.y, fakeNote.z), rotateOrigin);
					rightSideOffX = thing.x;
					rightSideOffY = thing.y;

					// Bottom right
					vertices[(i + 1) * 2] = rightSideOffX;
					vertices[(i + 1) * 2 + 1] = rightSideOffY;

					// left
					rotatePoint.setTo(fakeNote.x + holdLeftSide, fakeNote.y);
					thing = ModchartUtil.rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
					thing = applyPerspective(new Vector3D(thing.x, thing.y, fakeNote.z), rotateOrigin);
					rightSideOffX = thing.x;
					rightSideOffY = thing.y;

					vertices[(i) * 2] = rightSideOffX;
					vertices[(i) * 2 + 1] = rightSideOffY;

					if (affectRoot)
					{
						baseAngle = calculateAngleDif;

						var rotateOrigin_rooter:Vector2 = new Vector2(vertices[(i - 2) * 2], vertices[(i - 2) * 2 + 1]);
						// move rotateOrigin to be inbetween the left and right vert so it's centered
						rotateOrigin_rooter.x += (vertices[(i - 2 + 1) * 2] - vertices[(i - 2) * 2]) / 2;

						rotatePoint = new Vector2(vertices[(i - 2) * 2], vertices[(i - 2) * 2 + 1]);
						thing = ModchartUtil.rotateAround(rotateOrigin_rooter, rotatePoint, calculateAngleDif);

						vertices[(i - 2) * 2] = thing.x;
						vertices[(i - 2) * 2 + 1] = thing.y;

						rotatePoint = new Vector2(vertices[(i - 2 + 1) * 2], vertices[(i - 2 + 1) * 2 + 1]);
						thing = ModchartUtil.rotateAround(rotateOrigin_rooter, rotatePoint, calculateAngleDif);

						vertices[(i - 2 + 1) * 2] = thing.x;
						vertices[(i - 2 + 1) * 2 + 1] = thing.y;
					}
					previousSampleX = fakeNote.x;
					previousSampleY = fakeNote.y;
				}
				else
				{
					// Bottom right
					var vert:Vector2 = applyPerspective(new Vector3D(fakeNote.x + holdRightSide, fakeNote.y, fakeNote.z), rotateOrigin);
					vertices[(i + 1) * 2] = vert.x;
					vertices[(i + 1) * 2 + 1] = vert.y;
				}

				// testCol[i * 2] = fakeNote.color;
				// testCol[i * 2 + 1] = fakeNote.color;
				// testCol[(i + 1) * 2] = fakeNote.color;
				// testCol[(i + 1) * 2 + 1] = fakeNote.color;
			}

			// trace("Post Hold Resolution");

			if (uvSetup)
			{
				for (k in 0...holdResolution)
				{
					var i = (k + 1) * 2;

					// Bottom left
					uvtData[i * 2] = uvtData[0 * 2]; // 0%/25%/50%/75% of the way through the image
					uvtData[i * 2 + 1] = 1 * (k + 1);

					// Bottom right
					uvtData[(i + 1) * 2] = uvtData[1 * 2]; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left)
					uvtData[(i + 1) * 2 + 1] = uvtData[i * 2 + 1]; // bottom bound
				}
			}

			// === END CAP VERTICES ===
			if (renderEnd)
			{
				var endvertsoftrail:Int = (holdResolution * 2);
				var highestNumSoFar:Int = endvertsoftrail + 2;

				// TODO - FIX HOLD ENDS MOD SAMPLE TIME!
				var sillyEndOffset = (graphic.height * (endOffset) * zoom);

				// just some random magic number for now. Don't know how to convert the pixels / height into strumTime
				sillyEndOffset = sillyEndOffset / (0.45 * pfr?.getCorrectScrollSpeed() ?? 1.0);

				sillyEndOffset *= 1.9; // MAGIC NUMBER IDFK

				// sillyEndOffset = sustainHeight(sustainLength, getScrollSpeed());

				// pixels = (susLength * 0.45 * getScrollSpeed());
				// sillyEndOffset = (? * 0.45)
				// ? = sillyEndOffset / (0.45 * getScrollSpeed());

				holdPieceStrumTime = this.strumTime + (sussyLength * longHolds) + sillyEndOffset;
				var tm_end:Float = holdPieceStrumTime;
				if (spiralHolds && !spiralHoldOldMath)
				{
					tm_end += holdResolution * (grain * tinyOffsetForSpiral); // ever so slightly offset the time so that it never hits 0, 0 on the strum time so spiral hold can do its magic
				}
				susSample(noteData, tm_end + clipTimeThing(songTimmy, holdPieceStrumTime), noteData.lane, noteData.playfieldIndex);

				scaleTest = noteData.scaleX;
				widthScaled = holdWidth * scaleTest + scale;
				scaleChange = widthScaled - holdWidth;
				holdLeftSide = 0 - (scaleChange / 2);
				holdRightSide = widthScaled - (scaleChange / 2);

				// scaleTest = fakeNote.scale.x;
				// holdLeftSide = (holdWidth * (scaleTest - 1)) * -1;
				// holdRightSide = holdWidth * scaleTest;

				// trace("Scale Change Post.");

				// Top left
				vertices[highestNumSoFar * 2] = vertices[endvertsoftrail * 2]; // Inline with bottom left vertex of hold
				vertices[highestNumSoFar * 2 + 1] = vertices[endvertsoftrail * 2 + 1]; // Inline with bottom left vertex of hold
				testCol[highestNumSoFar * 2] = testCol[endvertsoftrail * 2];
				testCol[highestNumSoFar * 2 + 1] = testCol[endvertsoftrail * 2 + 1];

				// vertices[highestNumSoFar * 2] = holdNoteJankX * -1;
				// vertices[highestNumSoFar * 2 + 1] = holdNoteJankY * -1;

				// Top right
				highestNumSoFar += 1;
				vertices[highestNumSoFar * 2] = vertices[(endvertsoftrail + 1) * 2]; // Inline with bottom right vertex of hold
				vertices[highestNumSoFar * 2 + 1] = vertices[(endvertsoftrail + 1) * 2 + 1]; // Inline with bottom right vertex of hold
				testCol[highestNumSoFar * 2] = testCol[(endvertsoftrail + 1) * 2]; // Inline with bottom right vertex of hold
				testCol[highestNumSoFar * 2 + 1] = testCol[(endvertsoftrail + 1) * 2 + 1]; // Inline with bottom right vertex of hold

				// vertices[highestNumSoFar * 2] = holdNoteJankX * -1;
				// vertices[highestNumSoFar * 2 + 1] = holdNoteJankY * -1;

				// Bottom left
				highestNumSoFar += 1;

				// grab left vert
				var rotateOrigin:Vector2 = new Vector2(fakeNote.x + holdLeftSide, fakeNote.y);
				// move rotateOrigin to be inbetween the left and right vert so it's centered
				rotateOrigin.x += ((fakeNote.x + holdRightSide) - (fakeNote.x + holdLeftSide)) / 2;

				vert = applyPerspective(new Vector3D(fakeNote.x + holdLeftSide, fakeNote.y, fakeNote.z), rotateOrigin);
				vertices[highestNumSoFar * 2] = vert.x;
				vertices[highestNumSoFar * 2 + 1] = vert.y;
				// testCol[highestNumSoFar * 2] = fakeNote.color;
				// testCol[highestNumSoFar * 2 + 1] = fakeNote.color;

				// vertices[highestNumSoFar * 2] = holdNoteJankX * -1;
				// vertices[highestNumSoFar * 2 + 1] = holdNoteJankY * -1;

				// Bottom right
				highestNumSoFar += 1;
				vert = applyPerspective(new Vector3D(fakeNote.x + holdRightSide, fakeNote.y, fakeNote.z), rotateOrigin);
				vertices[highestNumSoFar * 2] = vert.x;
				vertices[highestNumSoFar * 2 + 1] = vert.y;
				// testCol[highestNumSoFar * 2] = fakeNote.color;
				// testCol[highestNumSoFar * 2 + 1] = fakeNote.color;
				if (spiralHolds && !spiralHoldOldMath)
				{
					var a:Float = (fakeNote.y - previousSampleY) * -1; // height
					var b:Float = (fakeNote.x - previousSampleX); // length
					var angle:Float = Math.atan2(b, a);
					var calculateAngleDif:Float = angle * (180 / Math.PI);

					var ybeforerotate:Float = vertices[(highestNumSoFar - 1) * 2 + 1];

					// grab left vert
					rotateOrigin.setTo(vertices[(highestNumSoFar - 1) * 2], vertices[(highestNumSoFar - 1) * 2 + 1]);
					// move rotateOrigin to be inbetween the left and right vert so it's centered
					rotateOrigin.x += (vertices[highestNumSoFar * 2] - rotateOrigin.x) / 2;

					// rotate right point
					// var rotatePoint:Vector2 = new Vector2(fakeNote.x + holdRightSide,vertices[i * 2+1]);
					var rotatePoint:Vector2 = new Vector2(vertices[highestNumSoFar * 2], vertices[highestNumSoFar * 2 + 1]);

					var thing = ModchartUtil.rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);

					vertices[highestNumSoFar * 2 + 1] = thing.y;
					vertices[highestNumSoFar * 2] = thing.x;

					rotatePoint = new Vector2(vertices[(highestNumSoFar - 1) * 2], ybeforerotate);
					var thing = ModchartUtil.rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
					vertices[(highestNumSoFar - 1) * 2 + 1] = thing.y;
					vertices[(highestNumSoFar - 1) * 2] = thing.x;
				}
				else if (spiralHolds && spiralHoldOldMath)
				{
					var calculateAngleDif:Float = 0;
					var a:Float = (fakeNote.y - previousSampleY) * -1; // height
					var b:Float = (fakeNote.x - previousSampleX); // length
					var angle:Float = Math.atan(b / a);
					angle *= (180 / Math.PI);
					calculateAngleDif = angle;

					tempVec2.setTo(vertices[(highestNumSoFar - 1) * 2], vertices[(highestNumSoFar - 1) * 2 + 1]);
					var thing:Vector2 = ModchartUtil.rotateAround(tempVec2, new Vector2(vertices[highestNumSoFar * 2], vertices[highestNumSoFar * 2 + 1]), calculateAngleDif);
					vertices[highestNumSoFar * 2 + 1] = thing.y;
					vertices[highestNumSoFar * 2] = thing.x;
				}

				// vertices[highestNumSoFar * 2] = holdNoteJankX * -1;
				// vertices[highestNumSoFar * 2 + 1] = holdNoteJankY * -1;

				if (uvSetup)
				{
					highestNumSoFar = (holdResolution * 2) + 2;

					// === END CAP UVs ===
					// Top left
					uvtData[highestNumSoFar * 2] = uvtData[2 * 2] + (1 / 8); // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left of hold)
					uvtData[highestNumSoFar * 2 + 1] = if (partHeight > 0)
					{
						0;
					}
					else
					{
						(bottomHeight - clipHeight) / zoom / graphic.height;
					};

					// Top right
					uvtData[(highestNumSoFar + 1) * 2] = uvtData[highestNumSoFar * 2] +
						(1 / 8); // 25%/50%/75%/100% of the way through the image (1/8th past the top left of cap)
					uvtData[(highestNumSoFar + 1) * 2 + 1] = uvtData[highestNumSoFar * 2 + 1]; // top bound

					// Bottom left
					uvtData[(highestNumSoFar +
						2) * 2] = uvtData[highestNumSoFar * 2]; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left of hold)
					uvtData[(highestNumSoFar + 2) * 2 + 1] = bottomClip; // bottom bound

					// Bottom right
					uvtData[(highestNumSoFar + 3) * 2] = uvtData[(highestNumSoFar +
						1) * 2]; // 25%/50%/75%/100% of the way through the image (1/8th past the top left of cap)
					uvtData[(highestNumSoFar + 3) * 2 + 1] = uvtData[(highestNumSoFar + 2) * 2 + 1]; // bottom bound
				}
			}

			// trace("post UVTData");
			for (k in 0...vertices.length)
			{
				if (k % 2 == 1)
				{ // all y verts
					vertices[k] += 0;
					// if (Preferences.downscroll) vertices[k] += 23; // fix gap for downscroll lol
				}
				else
				{
					vertices[k] += 0;
					
					// If for whatever reason we need to rotate based on angle (like cuz of a draw func for playfields?)
					if (this.angle != 0 && vertices.length % 2 == 0)
					{
					// assume +1 means we access the y vert
					tempVec2.setTo(vertices[k], vertices[k + 1]);
					var rotateModPivotPoint:Vector2 = new Vector2(holdRootX, holdRootY); // TEMP FOR NOW
					tempVec2 = ModchartUtil.rotateAround(rotateModPivotPoint, tempVec2, this.angle);
					vertices[k] = tempVec2.x;
					vertices[k + 1] = tempVec2.y;
					}
				}

				// holdStripVerts_.vertices.push(vertices[k]);
			}
			setVerts(vertices);
			this.indices = new DrawData<Int>(noteIndices.length - 0, true, noteIndices);
			this.colors = new DrawData<Int>(testCol.length - 0, true, testCol);

			if (uvSetup)
			{
				// V0.8.0a -> Can now modify hold UV's!
				for (k in 0...uvtData.length)
				{
					if (k % 2 == 1)
					{ // all y verts
					uvtData[k] -= 0.5;
					uvtData[k] *= uvScale.y;
					uvtData[k] += 0.5;
					uvtData[k] += uvOffset.y;
					}
					else
					{
					uvtData[k] -= 0.5; // try to scale from center
					uvtData[k] *= uvScale.x;
					uvtData[k] += 0.5;
					uvtData[k] += uvOffset.x / 4;
					}
				}

				this.uvtData = new DrawData<Float>(uvtData.length, true, uvtData);
				uvtData = null;
			}
			// trace(vertices, indices, colors, uvtData);
			testCol = null;
			noteIndices = null;
			vertices = null;
		}
		catch (e:haxe.Exception)
			trace(e.message, e.stack);
	}
	
	function setVerts(vertices):Void
	{
		this.vertices_array = vertices;
		this.vertices = new DrawData<Float>(vertices.length - 0, true, vertices);
	}

	public var uvScale:Vector2 = new Vector2(1.0, 1.0);
  	public var uvOffset:Vector2 = new Vector2(0.0, 0.0);

	public var zNear:Float = 0.0;
	public var zFar:Float = 100.0;
	public var fov:Float = 90.0;

	// https://github.com/TheZoroForce240/FNF-Modcharting-Tools/blob/main/source/modcharting/ModchartUtil.hx
	public function perspectiveMath(pos:Vector3D, offsetX:Float = 0, offsetY:Float = 0):Vector3D
	{
		try
		{
			var _FOV:Float = this.fov;

			_FOV *= (Math.PI / 180.0);

			var newz:Float = pos.z - 1;
			var zRange:Float = zNear - zFar;
			var tanHalfFOV:Float = 1;
			var dividebyzerofix:Float = FlxMath.fastCos(_FOV * 0.5);
			if (dividebyzerofix != 0)
			{
				tanHalfFOV = FlxMath.fastSin(_FOV * 0.5) / dividebyzerofix;
			}

			if (pos.z > 1)
				newz = 0;

			var xOffsetToCenter:Float = pos.x - (FlxG.width * 0.5);
			var yOffsetToCenter:Float = pos.y - (FlxG.height * 0.5);

			var zPerspectiveOffset:Float = (newz + (2 * zFar * zNear / zRange));

			// divide by zero check
			if (zPerspectiveOffset == 0)
				zPerspectiveOffset = 0.001;

			xOffsetToCenter += (offsetX * -zPerspectiveOffset);
			yOffsetToCenter += (offsetY * -zPerspectiveOffset);

			xOffsetToCenter += (0 * -zPerspectiveOffset);
			yOffsetToCenter += (0 * -zPerspectiveOffset);

			var xPerspective:Float = xOffsetToCenter * (1 / tanHalfFOV);
			var yPerspective:Float = yOffsetToCenter * tanHalfFOV;
			xPerspective /= -zPerspectiveOffset;
			yPerspective /= -zPerspectiveOffset;

			pos.x = xPerspective + (FlxG.width * 0.5);
			pos.y = yPerspective + (FlxG.height * 0.5);
			pos.z = zPerspectiveOffset;
			return pos;
		}
		catch (e)
		{
			trace("OH GOD OH FUCK IT NEARLY DIED CUZ OF: \n" + e.toString());
			return pos;
		}
	}

	/**
	 * Sets up new vertex and UV data to clip the trail.
	 * If flipY is true, top and bottom bounds swap places.
	 * @param songTime	The time to clip the note at, in milliseconds.
	 */
	public function updateClipping_Vanilla(songTime:Float = 0.0):Void
	{
		var clipHeight:Float = sustainHeight(sustainLength - (songTime - strumTime), pfr?.getCorrectScrollSpeed() ?? 1.0).clamp(0, graphicHeight);
		if (clipHeight <= 0.1)
		{
			visible = false;
			return;
		}
		else
		{
			visible = true;
		}

		var bottomHeight:Float = graphic.height * zoom * endOffset;
		var partHeight:Float = clipHeight - bottomHeight;

		// ===HOLD VERTICES==
		// Top left
		vertices[0 * 2] = 0.0; // Inline with left side
		vertices[0 * 2 + 1] = flipY ? clipHeight : graphicHeight - clipHeight;

		// Top right
		vertices[1 * 2] = graphicWidth;
		vertices[1 * 2 + 1] = vertices[0 * 2 + 1]; // Inline with top left vertex

		// Bottom left
		vertices[2 * 2] = 0.0; // Inline with left side
		vertices[2 * 2 + 1] = if (partHeight > 0)
		{
			// flipY makes the sustain render upside down.
			flipY ? 0.0 + bottomHeight : vertices[1] + partHeight;
		}
		else
		{
			vertices[0 * 2 + 1]; // Inline with top left vertex (no partHeight available)
		}

		// Bottom right
		vertices[3 * 2] = graphicWidth;
		vertices[3 * 2 + 1] = vertices[2 * 2 + 1]; // Inline with bottom left vertex

		// ===HOLD UVs===

		// The UVs are a bit more complicated.
		// UV coordinates are normalized, so they range from 0 to 1.
		// We are expecting an image containing 8 horizontal segments, each representing a different colored hold note followed by its end cap.

		uvtData[0 * 2] = 1 / 4 * (noteDirection % 4); // 0%/25%/50%/75% of the way through the image
		uvtData[0 * 2 + 1] = (-partHeight) / graphic.height / zoom; // top bound
		// Top left

		// Top right
		uvtData[1 * 2] = uvtData[0 * 2] + 1 / 8; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left)
		uvtData[1 * 2 + 1] = uvtData[0 * 2 + 1]; // top bound

		// Bottom left
		uvtData[2 * 2] = uvtData[0 * 2]; // 0%/25%/50%/75% of the way through the image
		uvtData[2 * 2 + 1] = 0.0; // bottom bound

		// Bottom right
		uvtData[3 * 2] = uvtData[1 * 2]; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left)
		uvtData[3 * 2 + 1] = uvtData[2 * 2 + 1]; // bottom bound

		// === END CAP VERTICES ===
		// Top left
		vertices[4 * 2] = vertices[2 * 2]; // Inline with bottom left vertex of hold
		vertices[4 * 2 + 1] = vertices[2 * 2 + 1]; // Inline with bottom left vertex of hold

		// Top right
		vertices[5 * 2] = vertices[3 * 2]; // Inline with bottom right vertex of hold
		vertices[5 * 2 + 1] = vertices[3 * 2 + 1]; // Inline with bottom right vertex of hold

		// Bottom left
		vertices[6 * 2] = vertices[2 * 2]; // Inline with left side
		vertices[6 * 2 + 1] = flipY ? (graphic.height * (-bottomClip + endOffset) * zoom) : (graphicHeight + graphic.height * (bottomClip - endOffset) * zoom);

		// Bottom right
		vertices[7 * 2] = vertices[3 * 2]; // Inline with right side
		vertices[7 * 2 + 1] = vertices[6 * 2 + 1]; // Inline with bottom of end cap

		// === END CAP UVs ===
		// Top left
		uvtData[4 * 2] = uvtData[2 * 2] + 1 / 8; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left of hold)
		uvtData[4 * 2 + 1] = if (partHeight > 0)
		{
			0;
		}
		else
		{
			(bottomHeight - clipHeight) / zoom / graphic.height;
		};

		// Top right
		uvtData[5 * 2] = uvtData[4 * 2] + 1 / 8; // 25%/50%/75%/100% of the way through the image (1/8th past the top left of cap)
		uvtData[5 * 2 + 1] = uvtData[4 * 2 + 1]; // top bound

		// Bottom left
		uvtData[6 * 2] = uvtData[4 * 2]; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left of hold)
		uvtData[6 * 2 + 1] = bottomClip; // bottom bound

		// Bottom right
		uvtData[7 * 2] = uvtData[5 * 2]; // 25%/50%/75%/100% of the way through the image (1/8th past the top left of cap)
		uvtData[7 * 2 + 1] = uvtData[6 * 2 + 1]; // bottom bound
	}

	@:access(flixel.FlxCamera)
	override public function draw():Void
	{
		if (graphic == null || !this.alive) return;

		// Update tris if modchart system
		// if (usingHazModHolds && parentStrumline.doUpdateClipsInDraw)
		// {
		// 	updateClipping_mods();
		// 	if (this.previousPiece != null)
		// 	{
		// 		// I made the mimic
		// 		var v_prev:Array<Float> = this.previousPiece.vertices_array;
		// 		var v:Array<Float> = this.vertices_array;

		// 		// it was difficult, to put the pieces together
		// 		v[3] = v_prev[v_prev.length - 1];
		// 		v[2] = v_prev[v_prev.length - 2];
		// 		v[1] = v_prev[v_prev.length - 3];
		// 		v[0] = v_prev[v_prev.length - 4];

		// 		this.setVerts(v);
		// 	}
		// }

		if (alpha == 0 || vertices == null) return;

		var alphaMemory:Float = this.alpha;
		for (camera in cameras)
		{
			if (!camera.visible || !camera.exists) continue;
			// if (!isOnScreen(camera)) continue; // TODO: Update this code to make it work properly.

			alpha = alphaMemory * camera.alpha;

			getScreenPosition(_point, camera).subtractPoint(offset);

			camera.drawTriangles(graphic, vertices, indices, uvtData, colors, _point, blend, true, antialiasing, colorTransform, this.shader);
		}
		this.alpha = alphaMemory;

		#if FLX_DEBUG
		if (FlxG.debugger.drawDebug) drawDebug();
		#end
	}

	public override function kill():Void
	{
		super.kill();

		strumTime = 0;
		noteDirection = 0;
		sustainLength = 0;
		fullSustainLength = 0;
		fakeNote = null;
	}

	public override function revive():Void
	{
		super.revive();

		strumTime = 0;
		noteDirection = 0;
		sustainLength = 0;
		fullSustainLength = 0;
		fakeNote = null;
	}

	public override function destroy():Void
	{
		vertices = null;
		indices = null;
		uvtData = null;
		super.destroy();
	}

	// public function desaturate():Void
	// {
	// 	this.hsvShader.saturation = 0.2;
	// }

	// public function setHue(hue:Float):Void
	// {
	// 	this.hsvShader.hue = hue;
	// }

	var useHSVShader:Bool = false;

	//public var hsvShader:HSVNotesShader = null;
}