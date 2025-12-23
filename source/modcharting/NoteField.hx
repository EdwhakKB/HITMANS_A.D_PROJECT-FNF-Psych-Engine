package modcharting;

import flixel.math.FlxAngle;
import flixel.util.FlxTimer.FlxTimerManager;
import modcharting.Modifier;
import modcharting.Proxiefield.Proxie as Proxy;
import objects.Note;
import objects.NoteSplash;
import objects.StrumNote;
import objects.SustainSplash;
import modcharting.graphics.SustainTrail;
import objects.Strumline;
import openfl.geom.Vector3D;
import play.PlayState;

class NoteField extends FlxBasic
{
	public var renderer:PlayfieldRenderer = null;
	public var pfIndex:Int = 0;
	public var strumLine:Strumline = null;
	public var usingSusTrail:Bool = false;

	override public function set_cameras(cameras:Array<FlxCamera>):Array<FlxCamera>
	{
		strumGroup.cameras = cameras;
		noteGroup.cameras = cameras;
		return super.set_cameras(cameras);
	}

	public var strumLineNotes:FlxTypedGroup<StrumNote>;

	private var strumGroup(get, never):FlxTypedGroup<StrumNote>;

	private function get_strumGroup():FlxTypedGroup<StrumNote>
		return strumLineNotes ?? strumLine.strums;

	public var notes:FlxTypedGroup<Note>;

	private var noteGroup(get, never):FlxTypedGroup<Note>;

	private function get_noteGroup():FlxTypedGroup<Note>
		return notes ?? strumLine.notes;


	public function new(renderer:PlayfieldRenderer, ?pfIndex:Int = 0, ?strumNotes:FlxTypedGroup<StrumNote> = null,
		?notes:FlxTypedGroup<Note> = null, ?unspawnNotes:Array<Note> = null)
	{
		this.renderer = renderer;
		this.pfIndex = pfIndex;
		this.strumLine = new Strumline(this);
		super();
		if (pfIndex == 0)
		{
			this.strumLineNotes = strumNotes;
			this.notes = notes;
		}
		else 
		{
			strumLine.loadUnspawnNotes();
			strumLine.loadStrums();
		}
	}

	private var debuggingMode:Bool = false; // to make tracing errors easier instead of a vague "null object reference"

	private function addDataToObject(objectData:NotePositionData, object:NewModchartArrow)
	{
		// not really needed since we draw the shit manually now
		object.x = objectData.x;
		object.y = objectData.y;
		object.z = objectData.z;
		object.angle = objectData.angle;
		// object.angleZ = objectData.angleZ;
		object.angleY = objectData.angleY;
		object.angleX = objectData.angleX;
		object.alpha = objectData.alpha;
		object.scale.x = objectData.scaleX;
		object.scale.y = objectData.scaleY;
		object.skew.x = objectData.skewX;
		object.skew.y = objectData.skewY;

		if (object is Note)
		{
			final note:Note = cast object;
			note.rgbShader.stealthGlow = objectData.stealthGlow;
			note.rgbShader.stealthGlowRed = objectData.glowRed;
			note.rgbShader.stealthGlowGreen = objectData.glowGreen;
			note.rgbShader.stealthGlowBlue = objectData.glowBlue;
		}
		else if (object is StrumNote) 
		{
			final strum:StrumNote = cast object;
			strum.rgbShader.stealthGlow = objectData.stealthGlow;
			strum.rgbShader.stealthGlowRed = objectData.glowRed;
			strum.rgbShader.stealthGlowGreen = objectData.glowGreen;
			strum.rgbShader.stealthGlowBlue = objectData.glowBlue;
		}
	}

	private function createBasicData(objectData:NotePositionData.ObjectData)
	{
		final noteData:NotePositionData = NotePositionData.get();
		noteData.setup({
			x: objectData?.x ?? 0, y: objectData?.y, z: objectData?.z, lane: objectData?.lane ?? 0, scaleX: objectData?.scaleX ?? 1, scaleY: objectData?.scaleY ?? 1, 
			skewX: objectData?.skewX ?? 1, skewY: objectData?.skewY ?? 1, 
			playfieldIndex: objectData?.playfieldIndex ?? pfIndex, alpha: objectData?.alpha ?? 1, index: objectData?.index ?? 1,
			curPos: objectData?.curPos ?? 0, noteDist: objectData?.noteDist ?? 0, 
			incomingAngleX: objectData?.incomingAngleX ?? 0, incomingAngleY: objectData?.incomingAngleY ?? 0, 
			strumTime: objectData?.strumTime ?? 0, noteIndex: objectData?.noteIndex ?? -1,
			isSus: objectData?.isSus ?? false, isStrum: objectData?.isStrum ?? false, 
			isHoldSplash: objectData?.isHoldSplash ?? false, isSplash: objectData?.isSplash ?? false,
			stealthGlow: objectData?.stealthGlow ?? 0, glowRed: objectData?.glowRed ?? 1, glowGreen: objectData?.glowGreen ?? 1, glowBlue: objectData?.glowBlue ?? 1,
			sustainWidth: objectData?.sustainWidth ?? 1, sustainGrain: objectData?.sustainGrain ?? 0,
			arrowPathAlpha: objectData?.arrowPathAlpha ?? 0, arrowPathLength: objectData?.arrowPathLength ?? 14,
			arrowPathBackwardsLength: objectData?.arrowPathBackwardsLength ?? 2, arrowPathWidth: objectData?.arrowPathWidth ?? 1,
			pathGrain: objectData?.pathGrain ?? 0, spiralHold: objectData?.spiralHold ?? 0, spiralPath: objectData?.spiralPath ?? 0,
			orient: objectData?.orient ?? 0, angleX: objectData?.angleX ?? 0, angleY: objectData?.angleY ?? 0, angleZ: objectData?.angleZ ?? 0,
			skewX_offset: objectData?.skewX_offset ?? 0.5, skewY_offset: objectData?.skewY_offset ?? 0.5, skewZ_offset: objectData?.skewZ_offset ?? 0.5,
			fovOffsetX: objectData?.fovOffsetX ?? 0, fovOffsetY: objectData?.fovOffsetY ?? 0,
			pivotOffsetX: objectData?.pivotOffsetX ?? 0, pivotOffsetY: objectData?.pivotOffsetY ?? 0, pivotOffsetZ: objectData?.pivotOffsetZ ?? 0,
			cullMode: objectData?.cullMode ?? "none"
		});
		return noteData;
	}

	private function getNoteCurPos(noteIndex:Int, strumTimeOffset:Float = 0)
	{
		#if PSYCH
		if (noteGroup.members[noteIndex].isSustainNote && ModchartUtil.getDownscroll(renderer.instance))
			strumTimeOffset -= Std.int(Conductor.stepCrochet / renderer.getCorrectScrollSpeed()); // psych does this to fix its sustains but that breaks the visuals so basically reverse it back to normal
		#else
		if (noteGroup.members[noteIndex].isSustainNote && !ModchartUtil.getDownscroll(renderer.instance))
			strumTimeOffset += Conductor.stepCrochet; // fix upscroll lol
		#end
		if (noteGroup.members[noteIndex].isSustainNote)
		{
			// moved those inside holdsMath cuz they are only needed for sustains ig?
			var lane:Int = getLane(noteIndex);
			var noteDist:Float = renderer.modifierTable.applyNoteDistMods(getNoteDist(), lane, pfIndex);

			strumTimeOffset += Std.int(Conductor.stepCrochet / renderer.getCorrectScrollSpeed());

			final scrollDivition = 1 / renderer.getCorrectScrollSpeed();
			if (ModchartUtil.getDownscroll(renderer.instance))
			{
				if (noteDist > 0)
					strumTimeOffset -= Std.int(Conductor.stepCrochet); // down
				else
				{
					strumTimeOffset += Std.int(Conductor.stepCrochet * scrollDivition);
					strumTimeOffset -= Std.int(Conductor.stepCrochet * scrollDivition);
				}
			}
			else
				strumTimeOffset -= Std.int(Conductor.stepCrochet * scrollDivition) + (noteDist > 0 ? Std.int(Conductor.stepCrochet) : 0); // down
			// FINALLY OMG I HATE THIS FUCKING MATH LMAO
		}

		var distance = (Conductor.songPosition - noteGroup.members[noteIndex].strumTime) + strumTimeOffset;
		return distance * renderer.getCorrectScrollSpeed();
	}

	private function getLane(noteIndex:Int)
		return (noteGroup.members[noteIndex].mustPress ? noteGroup.members[noteIndex].noteData + NoteMovement.keyCount : noteGroup.members[noteIndex].noteData);

	// lol XD
	public function getNoteDist()
		return -0.55 * (ModchartUtil.getDownscroll(renderer.instance) ? -1 : 1);

	// Todo: Find how to create arrow paths using strum notes and notes using this function to make both work (I.E Create NoteDataPositions for ArrowPath)
	private function getNotePositions()
	{
		var notePositions:Array<NotePositionData> = [];
		// trace(strumGroup == null, noteGroup == null);
		for (i => strum in strumGroup.members)
		{
			final data:NotePositionData = createBasicData({
				x: NoteMovement.defaultStrumPos[i][0], y: NoteMovement.defaultStrumPos[i][1], z: -0.001, lane: i, index: i,
				scaleX: NoteMovement.defaultScale[i][0] * (ModchartUtil.getIsPixelStage(renderer.instance) ? PlayState.daPixelZoom : 1), 
				scaleY: NoteMovement.defaultScale[i][1] * (ModchartUtil.getIsPixelStage(renderer.instance) ? PlayState.daPixelZoom : 1), 
				skewX: NoteMovement.defaultSkew[i][0], skewY: NoteMovement.defaultSkew[i][1],
				isStrum: true
			});
			renderer.modifierTable.applyStrumMods(data, i, pfIndex);
			notePositions.push(data);
			strum.notePositionData = data;
			if (strum.splash != null)
				strum.splash.notePositionData = data;
			if (strum.holdSplash != null)
				strum.holdSplash.notePositionData = data;
		}
		for (i => note in noteGroup.members)
		{
			final lane:Int = getLane(i);
			final sustainTimeThingy:Float = 0;

			final noteDist:Float = renderer.modifierTable.applyNoteDistMods(getNoteDist(), lane, pfIndex);
			var curPos:Float = renderer.modifierTable.applyCurPosMods(lane, getNoteCurPos(i, sustainTimeThingy), pfIndex);

			if ((note.wasGoodHit || note.prevNote.wasGoodHit) && curPos >= 0 && note.isSustainNote) {
				curPos = 0; // sustain clip
				// if (alreadyDrawn.contains(note?.mesh)) {
				// 	note?.mesh?.kill();
				// 	renderer.allObjects.remove(note?.mesh, true);
				// 	note?.mesh?.destroy();
				// }
			}

			var incomingAngle:Array<Float> = renderer.modifierTable.applyIncomingAngleMods(lane, curPos, pfIndex);
			if (noteDist < 0)
				incomingAngle[0] += 180; // make it match for both scrolls

			// get the general note path
			NoteMovement.setNotePath(note, lane, renderer.getCorrectScrollSpeed(), curPos, noteDist, incomingAngle[0], incomingAngle[1]);

			// save the position data
			final noteData:NotePositionData = createBasicData({
				x:  note.x, y: note.y, z: note.z + 0.001, lane: lane, index: i,
				scaleX: NoteMovement.defaultScale[lane][0] * (ModchartUtil.getIsPixelStage(renderer.instance) ? PlayState.daPixelZoom : 1), 
				scaleY: NoteMovement.defaultScale[lane][1] * (ModchartUtil.getIsPixelStage(renderer.instance) ? PlayState.daPixelZoom : 1), 
				skewX: note.skew.x, skewY: note.skew.y,
				alpha: note.specialHurt ? 0 : note.mimicNote ? ClientPrefs.data.mimicNoteAlpha : note.hurtNote ? 0.55 : note.multAlpha,
				curPos: curPos, 
				noteDist: noteDist, 
				isSus: note.isSustainNote,
				incomingAngleX: incomingAngle[0],
				incomingAngleY: incomingAngle[1]
			});

			// add offsets to data with modifiers
			renderer.modifierTable.applyNoteMods(noteData, lane, curPos, pfIndex);

			note.notePositionData = noteData;

			// add position data to list
			notePositions.push(noteData);
		}

		// sort by z before drawing
		// notePositions.sort(function(a, b) return ((a.z < b.z) ? -1 : ((a.z > b.z) ? 1 : 0)));
		return notePositions;
	}

	private function drawStrum(noteData:NotePositionData)
	{
		if (noteData.alpha <= 0)
			return;
		var changeX:Bool = noteData.z != 0;

		/*targetGroup<Array<Array>> = new Array<Array>();

			targetGroup = [
				[0,1,2,3,4,5,6,7],
				[0,1,2,3,4,5,6,7]
			];

		 */
		// var strumNote = targetGroup[0][noteData.index];
		var strumNote = strumGroup.members[noteData.index];

		// if (strumNote == null)
		// {
		// 	strumNote.setupMesh();
		// }

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

		// var getNextNote = getNotePoss(noteData,1);

		// Orient can be fixed, just need make it on strums too
		// if (noteData.orient != 0)
		// 	noteData.angle = (-90 + (angle = Math.atan2(getNextNote.y - noteData.y , getNextNote.x - noteData.x) * FlxAngle.TO_DEG)) * noteData.orient;

		if (noteData.stealthGlow != 0)
			strumNote.rgbShader.enabled = true; // enable stealthGlow once it finds its not 0?

		addDataToObject(noteData, strumNote); // set position and stuff before drawing

		strumNote.cameras = this.cameras;
		if (strumNote.splash != null) {
			var data:NotePositionData = noteData.copy();
			final diffX:Float = Math.abs(strumNote.startingScale.x - strumNote.splash.startingScale.x);
			final diffY:Float = Math.abs(strumNote.startingScale.y - strumNote.splash.startingScale.y);
			data.scaleX = noteData.scaleX + diffX;
			data.scaleY = noteData.scaleY + diffY;
			data.alpha *= ClientPrefs.data.splashAlpha;
			strumNote.applyGeneralData(strumNote.splash, data);
			strumNote.splash.notePositionData = data; 
			strumNote.splash.cameras = this.cameras;
		}
		if (strumNote.holdSplash != null) {
			var data:NotePositionData = noteData.copy();
			final diffX:Float = Math.abs(strumNote.startingScale.x - strumNote.holdSplash.startingScale.x);
			final diffY:Float = Math.abs(strumNote.startingScale.y - strumNote.holdSplash.startingScale.y);
			data.scaleX = noteData.scaleX + diffX;
			data.scaleY = noteData.scaleY + diffY;
			data.alpha *= ClientPrefs.data.holdSplashAlpha;
			strumNote.applyGeneralData(strumNote.holdSplash, data);
			strumNote.holdSplash.notePositionData = data;
			strumNote.holdSplash.cameras = this.cameras;
		}

		// Same as strums case
		// if (strumNote != null)
		// {
		// 	strumNote.setupMesh(noteData);
		// 	strumNote.draw();
		// }
		// else
		// strumNote.applyNoteData(noteData);
		// strumNote.draw();
	}

	private function drawNote(noteData:NotePositionData)
	{
		if (noteData.alpha <= 0)
			return;
		var changeX:Bool = noteData.z != 0;
		var daNote = noteGroup.members[noteData.index];

		// if (daNote == null)
		// {
		// 	daNote.setupMesh();
		// }

		var thisNotePos;
		if (changeX)
			thisNotePos = ModchartUtil.calculatePerspective(new Vector3D(noteData.x
				+ (daNote.width / 2)
				+ ModchartUtil.getNoteOffsetX(daNote, renderer.instance), noteData.y
				+ (daNote.height / 2), noteData.z * 0.001),
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

		var getNextNote = getNotePoss(noteData, 1);

		if (noteData.orient != 0)
			noteData.angle = ((Math.atan2(getNextNote.y - noteData.y, getNextNote.x - noteData.x) * FlxAngle.TO_DEG) - 90) * noteData.orient;

		addDataToObject(noteData, daNote);

		daNote.cameras = this.cameras;

		if (daNote.wasGoodHit)
			daNote.alpha = 0;
		// Same as strums case
		// if (daNote != null)
		// {
		// 	daNote.setupMesh(noteData);
		// 	daNote.draw();
		// }
		// else
		// daNote.applyNoteData(noteData);
		// daNote.draw();
	}

	public var alreadyDrawn:Array<SustainStrip> = [];

	private function drawSustainNote(noteData:NotePositionData)
	{
		if (noteData.alpha <= 0)
			return;

		var daNote = noteGroup.members[noteData.index];
		// if (daNote.mesh == null)
		//  	daNote.mesh = new SustainStrip(daNote);

		var spiral = (noteData.spiralHold >= 0.5);

		// daNote.alpha = noteData.alpha;
		// daNote.mesh.alpha = daNote.multAlpha;
		daNote.mesh.shader = daNote.rgbShader.parent.shader; // idfk if this works.
		daNote.mesh.spiralHolds = spiral; // if noteData its 1 spiral holds mod should be enabled?

		var songSpeed = renderer.getCorrectScrollSpeed();
		var lane = noteData.lane;

		// makes the sustain match the center of the parent note when at weird angles
		var yOffsetThingy = (NoteMovement.arrowSizes[lane] / 2);

		var timeToNextSustain = ModchartUtil.getFakeCrochet() / 4;
		if (noteData.noteDist < 0)
			timeToNextSustain *= -1; // weird shit that fixes upscroll lol

		var prevSustainNoteData = getSustainPoint(noteData, 0);
		var midSusPointData = getSustainPoint(noteData, timeToNextSustain * .5);
		var nextSustainNoteData = getSustainPoint(noteData, timeToNextSustain);

		daNote.rgbShader.isHold = true;

		daNote.rgbShader.bottomStealth = prevSustainNoteData.stealthGlow;
		daNote.rgbShader.bottomAlpha = prevSustainNoteData.alpha;
		daNote.rgbShader.bottomStealthRed = prevSustainNoteData.glowRed;
		daNote.rgbShader.bottomStealthGreen = prevSustainNoteData.glowGreen;
		daNote.rgbShader.bottomStealthBlue = prevSustainNoteData.glowBlue;

		daNote.rgbShader.topStealth = nextSustainNoteData.stealthGlow;
		daNote.rgbShader.topAlpha = nextSustainNoteData.alpha;
		daNote.rgbShader.topStealthRed = nextSustainNoteData.glowRed;
		daNote.rgbShader.topStealthGreen = nextSustainNoteData.glowGreen;
		daNote.rgbShader.topStealthBlue = nextSustainNoteData.glowBlue;

		daNote.rgbShader.topRed = 1;
		daNote.rgbShader.topGreen = 1;
		daNote.rgbShader.topBlue = 1;

		daNote.rgbShader.bottomRed = 1;
		daNote.rgbShader.bottomGreen = 1;
		daNote.rgbShader.bottomBlue = 1;

		var top = [];
		var mid = [];
		var bot = [];

		if (spiral)
		{
			top = [getSustainPoint(noteData, 0), getSustainPoint(noteData, 1)];
			mid = [
				getSustainPoint(noteData, timeToNextSustain * .5),
				getSustainPoint(noteData, timeToNextSustain * .5 + 1)
			];
			bot = [
				getSustainPoint(noteData, timeToNextSustain),
				getSustainPoint(noteData, timeToNextSustain + 1)
			];
		}
		else
		{
			top = [getSustainPoint(noteData, 0)];
			mid = [getSustainPoint(noteData, timeToNextSustain * .5)];
			bot = [getSustainPoint(noteData, timeToNextSustain)];
		}

		var flipGraphic = false;

		// mod/bound to 360, add 360 for negative angles, mod again just in case
		var fixedAngY = ((noteData.incomingAngleY % 360) + 360) % 360;

		var reverseClip = (fixedAngY > 90 && fixedAngY < 270);

		if (noteData.noteDist > 0) // downscroll
		{
			if (!ModchartUtil.getDownscroll(renderer.instance)) // fix reverse
				flipGraphic = true;
		}
		else
		{
			if (ModchartUtil.getDownscroll(renderer.instance))
				flipGraphic = true;
		}
		// render that shit
		daNote.mesh.constructVertices(noteData, top, mid, bot, flipGraphic, reverseClip);

		daNote.mesh.cameras = this.cameras;
		// if (!renderer.allObjects.members.contains(daNote.mesh) && !alreadyDrawn.contains(daNote.mesh)) {
		// 	renderer.allObjects.add(daNote.mesh);
		// 	alreadyDrawn.push(daNote.mesh);
		// }
		// daNote.mesh.draw();
	}

	private function drawNewSustainNote(noteData:NotePositionData)
	{
		if (noteData.alpha <= 0)
			return;

		var daNote:Note = noteGroup.members[noteData.index];
		if (daNote.newMesh == null)
			daNote.newMesh = new SustainTrail(noteData.lane, Math.ffloor(daNote.sustainLength), renderer, this);

		// noteData.isSus = true; //forcing the math to be called as "sustain"
		daNote.newMesh.alpha = 0.6 * noteData.alpha;
		daNote.newMesh.shader = daNote.rgbShader.parent.shader; // idfk if this works.

		var songSpeed = renderer.getCorrectScrollSpeed();
		// var lane = noteData.lane;

		// daNote.newMesh.strumTime -= arrowPathBackLength;
		// daNote.newMesh.x = 0;
		// daNote.newMesh.y = 0;

		daNote.newMesh.strumTime = daNote.strumTime;

		//noteData.z += 0.00001;

		daNote.newMesh.updateClipping_mods(noteData);

		daNote.newMesh.cameras = this.cameras;
		// daNote.newMesh.draw();

		// trace("Drawn");
	}

	private function drawArrowPathNew(noteData:NotePositionData)
	{ 
		// this one is unused since i have no clue what to do.
		if (noteData.arrowPathAlpha <= 0)
			return;

		// TODO:
		/*
			- make this draw similar to VSLICE sustain draw (so i can make sustain mesh correctly, maybe just copy paste sustain code and change info to MT?)
			- make sure this shit doesn't lag the engine out unlike the old one
			- make sure that if no graphic exist, we create one (such as a FlxGraphic with the size the strip needs and stuff like that)
			- optimize the code to make it easier to understand
		 */

		var strumNote = strumGroup.members[noteData.index];

		var arrowPathLength:Float = noteData.arrowPathLength * 100;
		var arrowPathBackLength:Float = noteData.arrowPathBackwardsLength * 100;

		if (strumNote.arrowPath == null)
			strumNote.arrowPath = new SustainTrail(noteData.index, arrowPathLength, renderer, this);

		strumNote.arrowPath.alpha = noteData.arrowPathAlpha;

		strumNote.arrowPath.fullSustainLength = strumNote.arrowPath.sustainLength = arrowPathLength + arrowPathBackLength;
		strumNote.arrowPath.strumTime = Conductor.songPosition;
		strumNote.arrowPath.strumTime -= arrowPathBackLength;
		strumNote.arrowPath.x = 0;
		strumNote.arrowPath.y = 0;

		strumNote.arrowPath.shader = strumNote.rgbShader.parent.shader; // idfk if this works.

		strumNote.arrowPath.updateClipping_mods(noteData);

		strumNote.arrowPath.cameras = this.cameras;
		// strumNote.arrowPath.draw();
	}

	private function forEach(positions:Array<NotePositionData>, callback:NotePositionData->Void)
	{
		for (noteData in positions) {
			if (noteData == null) continue;
			callback(noteData);
		}
	}

	private function drawStuff(positions:Array<NotePositionData>)
	{
		// forEach(positions, data -> if (data.isStrum) drawArrowPathNew(data)); // make sure we draw the path for each before we even draw each?
		// forEach(positions, data -> if (data.isStrum) drawStrum(data)); // draw notes after strums
		// forEach(positions, data -> {
		// 	if (data.isStrum || data.isSplash || data.isHoldSplash) return;
		// 	if (noteGroup.members[data.index].isSustainNote && !usingSusTrail) drawSustainNote(data);
		// });
		// forEach(positions, data -> {
		// 	if (data.isStrum || data.isSplash || data.isHoldSplash) return;
		// 	if (!noteGroup.members[data.index].isSustainNote)
		// 	{
		// 		if (usingSusTrail)
		// 			if (noteGroup.members[data.index].sustainLength > 0)
		// 				drawNewSustainNote(data);
		// 		drawNote(data);
		// 	}
		// });

		for (noteData in positions)
		{
			if (noteData.isStrum) // make sure we draw the path for each before we even draw each?
				drawArrowPathNew(noteData);
		}
		for (noteData in positions)
		{
			if (noteData.isStrum) // draw strum
				drawStrum(noteData);
		}
		for (noteData in positions)
		{
			if (!noteData.isStrum)
				if (noteGroup.members[noteData.index].isSustainNote && !usingSusTrail)
					drawSustainNote(noteData);
		}
		for (noteData in positions)
		{
			if (!noteData.isStrum)
				if (!noteGroup.members[noteData.index].isSustainNote)
				{
					if (usingSusTrail)
						if (noteGroup.members[noteData.index].sustainLength > 0)
							drawNewSustainNote(noteData);

					drawNote(noteData);
				}
		}
	}

	function getSustainPoint(noteData:NotePositionData, timeOffset:Float):NotePositionData
	{
		var daNote:Note = noteGroup.members[noteData.index];
		var songSpeed:Float = renderer.getCorrectScrollSpeed();
		var lane:Int = noteData.lane;

		var noteDist:Float = getNoteDist();
		var curPos:Float = renderer.modifierTable.applyCurPosMods(lane, getNoteCurPos(noteData.index, timeOffset), pfIndex);

		if ((daNote.wasGoodHit || (daNote.prevNote.wasGoodHit)) && curPos >= 0)
			curPos = 0; // so sustain does a "fake" clip

		noteDist = renderer.modifierTable.applyNoteDistMods(noteDist, lane, pfIndex);
		var incomingAngle:Array<Float> = renderer.modifierTable.applyIncomingAngleMods(lane, curPos, pfIndex);
		if (noteDist < 0)
			incomingAngle[0] += 180; // make it match for both scrolls
		// get the general note path for the next note
		NoteMovement.setNotePath(daNote, lane, songSpeed, curPos, noteDist, incomingAngle[0], incomingAngle[1]);
		// save the position data
		final noteData:NotePositionData = createBasicData({
			x: daNote.x, y: daNote.y, z: daNote.z, lane: lane, index: noteData.index,
			scaleX: NoteMovement.defaultScale[lane][0] * (ModchartUtil.getIsPixelStage(renderer.instance) ? PlayState.daPixelZoom : 1), 
			scaleY: NoteMovement.defaultScale[lane][1] * (ModchartUtil.getIsPixelStage(renderer.instance) ? PlayState.daPixelZoom : 1), 
			skewX: daNote.skew.x, skewY: daNote.skew.y,
			alpha: daNote.specialHurt ? 0 : daNote.mimicNote ? ClientPrefs.data.mimicNoteAlpha : daNote.hurtNote ? 0.55 : daNote.multAlpha,
			curPos: curPos, 
			noteDist: noteDist, 
			incomingAngleX: incomingAngle[0],
			incomingAngleY: incomingAngle[1]
		});
		// add offsets to data with modifiers
		renderer.modifierTable.applyNoteMods(noteData, lane, curPos, pfIndex);
		var yOffsetThingy = (NoteMovement.arrowSizes[lane] / 2);
		var finalNotePos = ModchartUtil.calculatePerspective(new Vector3D(noteData.x
			+ (daNote.width / 2)
			+ ModchartUtil.getNoteOffsetX(daNote, renderer.instance),
			noteData.y
			+ (NoteMovement.arrowSizes[noteData.lane] / 2), noteData.z * 0.001),
			ModchartUtil.defaultFOV * (Math.PI / 180), 0, 0);

		noteData.x = finalNotePos.x;
		noteData.y = finalNotePos.y;
		noteData.z = finalNotePos.z;

		return noteData;
	}

	function getNotePoss(noteData:NotePositionData, timeOffset:Float):NotePositionData
	{
		final daNote:Note = noteGroup.members[noteData.index];
		final songSpeed:Float = renderer.getCorrectScrollSpeed();
		final lane:Int = noteData.lane;

		final curPos:Float = renderer.modifierTable.applyCurPosMods(lane, getNoteCurPos(noteData.index, timeOffset), pfIndex);
		final noteDist:Float = renderer.modifierTable.applyNoteDistMods(getNoteDist(), lane, pfIndex);

		var incomingAngle:Array<Float> = renderer.modifierTable.applyIncomingAngleMods(lane, curPos, pfIndex);
		if (noteDist < 0)
			incomingAngle[0] += 180; // make it match for both scrolls
		// get the general note path for the next note
		NoteMovement.setNotePath(daNote, lane, songSpeed, curPos, noteDist, incomingAngle[0], incomingAngle[1]);
		// save the position data
		final noteData:NotePositionData = createBasicData({
			x: daNote.x, y: daNote.y, z: daNote.z, lane: lane, index: noteData.index,
			scaleX: NoteMovement.defaultScale[lane][0] * (ModchartUtil.getIsPixelStage(renderer.instance) ? PlayState.daPixelZoom : 1), 
			scaleY: NoteMovement.defaultScale[lane][1] * (ModchartUtil.getIsPixelStage(renderer.instance) ? PlayState.daPixelZoom : 1), 
			skewX: daNote.skew.x, skewY: daNote.skew.y,
			alpha: daNote.specialHurt ? 0 : daNote.mimicNote ? ClientPrefs.data.mimicNoteAlpha : daNote.hurtNote ? 0.55 : daNote.multAlpha,
			curPos: curPos, 
			noteDist: noteDist, 
			incomingAngleX: incomingAngle[0],
			incomingAngleY: incomingAngle[1]
		});

		// add offsets to data with modifiers
		renderer.modifierTable.applyNoteMods(noteData, lane, curPos, pfIndex);

		var changeX:Bool = noteData.z != 0;

		final vec:Vector3D = new Vector3D(noteData.x
				+ (daNote.width / 2)
				+ ModchartUtil.getNoteOffsetX(daNote, renderer.instance), noteData.y
				+ (daNote.height / 2), changeX ? noteData.z * 0.001 : 0);
		final finalNotePos:Vector3D = !changeX ? vec : ModchartUtil.calculatePerspective(vec, ModchartUtil.defaultFOV * (Math.PI / 180));

		noteData.x = finalNotePos.x;
		noteData.y = finalNotePos.y;
		noteData.z = finalNotePos.z;

		return noteData;
	}

	override public function draw()
	{
		try
			drawStuff(getNotePositions())
		catch (e:haxe.Exception)
			trace(e.message, e.stack);
	}
}
