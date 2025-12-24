package objects;

import engine.Song.SwagSection;

class Strumline
{
    public var strums:FlxTypedGroup<objects.StrumNote>;
	public var notes:FlxTypedGroup<objects.Note>;
    public var unspawnNotes:Array<Note>;
	public var loadedNotes:Array<Note>;
	public var cpuControlled:Bool = false;
	public var guitarHeroSustains:Bool = false;
	public var noteKillOffset:Float = 350;
	public var renderer(get, never):PlayfieldRenderer;

	function get_renderer():PlayfieldRenderer 
		return field.renderer;
	
	public var field:NoteField;

	public function new(field:NoteField) {
		this.field = field;
		strums = new FlxTypedGroup<objects.StrumNote>();
		notes = new FlxTypedGroup<objects.Note>();
		unspawnNotes = [];
		loadedNotes = [];
	}

	public function clearNotesBefore(time:Float, ?completeClear:Bool = false)
	{
		var i:Int = unspawnNotes.length - 1;
		while (i >= 0)
		{
			var daNote:Note = unspawnNotes[i];
			if (daNote.strumTime + 350 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				if (completeClear)
				{
					daNote.ignoreNote = true;
					daNote.kill();
				}
				unspawnNotes.remove(daNote);
				if (completeClear) daNote.destroy();
			}
			--i;
		}

		i = notes.length - 1;
		while (i >= 0)
		{
			var daNote:Note = notes.members[i];
			if (daNote.strumTime + 350 < time)
			{
				daNote.active = false;
				daNote.visible = false;
                if (completeClear)
				{ 
                    daNote.ignoreNote = true;
				    daNote.kill();
                }
				notes.remove(daNote, true);
				if (completeClear) daNote.destroy();
			}
			--i;
		}
	}

	public function clearNotesAfter(time:Float, ?completeClear:Bool = false)
	{
		var i = notes.length - 1;
		while (i >= 0)
		{
			var daNote:Note = notes.members[i];
			if (daNote.strumTime > time)
			{
				daNote.active = false;
				daNote.visible = false;
				if (completeClear)
				{
					daNote.ignoreNote = true;
					daNote.kill();
				}
				notes.remove(daNote, true);
				if (completeClear) daNote.destroy();
			}
			--i;
		}
	}

	public function setUnspawnToLoaded(?time:Float, ?offsets:Array<Float>)
	{
		time ??= Conductor.songPosition;
		offsets ??= [2000.0, 0.0];
		clearNotesAfter(Conductor.songPosition + offsets[0]); // so scrolling back doesnt lag shit
		unspawnNotes = loadedNotes.copy();
		clearNotesBefore(Conductor.songPosition + offsets[1]);
	}

	public var totalColumns:Int = 4;
	public function loadUnspawnNotes(?given:Array<SwagSection>, ?set:Array<Note>) {
		if (set != null && set.length > 0)
		{
			this.unspawnNotes = set;
			return this.loadedNotes = set.copy();
		}
		var oldNote:Note = null;
		var sectionsData:Array<SwagSection> = given ?? PlayState.SONG.notes.copy();
		var ghostNotesCaught:Int = 0;
		var daBpm:Float = Conductor.bpm;
		var unspawnedNotes:Array<Note> = [];

		for (section in sectionsData)
		{
			if (section.changeBPM != null && section.changeBPM && section.bpm != null && daBpm != section.bpm)
				daBpm = section.bpm;

			for (i in 0...section.sectionNotes.length)
			{
				final songNotes:Array<Dynamic> = section.sectionNotes[i];
				var spawnTime:Float = songNotes[0];
				var noteColumn:Int = Std.int(songNotes[1] % totalColumns);
				var holdLength:Float = songNotes[2];
				var noteType:String = songNotes[3];
				if (Math.isNaN(holdLength))
					holdLength = 0.0;

				var gottaHitNote:Bool = (songNotes[1] < totalColumns);

				if (i != 0)
				{
					// CLEAR ANY POSSIBLE GHOST NOTES
					for (evilNote in unspawnedNotes)
					{
						var matches:Bool = (noteColumn == evilNote.noteData && gottaHitNote == evilNote.mustPress && evilNote.noteType == noteType);
						if (matches && Math.abs(spawnTime - evilNote.strumTime) < flixel.math.FlxMath.EPSILON)
						{
							if (evilNote.tail.length > 0)
								for (tail in evilNote.tail)
								{
									tail.destroy();
									unspawnedNotes.remove(tail);
								}
							evilNote.destroy();
							unspawnedNotes.remove(evilNote);
							ghostNotesCaught++;
							// continue;
						}
					}
				}

				var swagNote:Note = new Note(spawnTime, noteColumn, oldNote);
				var isAlt:Bool = section.altAnim && !gottaHitNote;
				swagNote.gfNote = (section.gfSection && gottaHitNote == section.mustHitSection);
				swagNote.animSuffix = isAlt ? "-alt" : "";
				swagNote.mustPress = gottaHitNote;
				swagNote.sustainLength = holdLength;
				swagNote.noteType = noteType;

				swagNote.scrollFactor.set();
				unspawnedNotes.push(swagNote);

				var curStepCrochet:Float = 60 / daBpm * 1000 / 4.0;
				final roundSus:Int = Math.round(swagNote.sustainLength / curStepCrochet);
				if (roundSus > 0)
				{
					for (susNote in 0...roundSus)
					{
						oldNote = unspawnedNotes[Std.int(unspawnedNotes.length - 1)];

						var sustainNote:Note = new Note(spawnTime + (curStepCrochet * susNote), noteColumn, oldNote, true);
						sustainNote.animSuffix = swagNote.animSuffix;
						sustainNote.mustPress = swagNote.mustPress;
						sustainNote.gfNote = swagNote.gfNote;
						sustainNote.noteType = swagNote.noteType;
						sustainNote.scrollFactor.set();
						sustainNote.parent = swagNote;
						unspawnedNotes.push(sustainNote);
						swagNote.tail.push(sustainNote);

						sustainNote.correctionOffset = swagNote.height / 2;
						if (!PlayState.isPixelStage)
						{
							if (oldNote.isSustainNote)
							{
								oldNote.scale.y *= Note.SUSTAIN_SIZE / oldNote.frameHeight;
								oldNote.scale.y /= renderer.rate;
								oldNote.resizeByRatio(curStepCrochet / ModchartUtil.getFakeCrochet() / 4);
							}

							if (ClientPrefs.data.downScroll)
								sustainNote.correctionOffset = 0;
						}
						else if (oldNote.isSustainNote)
						{
							oldNote.scale.y /= renderer.rate;
							oldNote.resizeByRatio(curStepCrochet / ModchartUtil.getFakeCrochet() / 4);
						}

						if (sustainNote.mustPress)
							sustainNote.x += FlxG.width / 2; // general offset
						else if (ClientPrefs.data.middleScroll)
						{
							sustainNote.x += 310;
							if (noteColumn > 1) // Up and Right
								sustainNote.x += FlxG.width / 2 + 25;
						}
					}
				}

				if (swagNote.mustPress)
					swagNote.x += FlxG.width / 2; // general offset
				else if (ClientPrefs.data.middleScroll)
				{
					swagNote.x += 310;
					if (noteColumn > 1) // Up and Right
						swagNote.x += FlxG.width / 2 + 25;
				}
				oldNote = swagNote;
			}
		}

		for (note in unspawnedNotes)
			note.setCustomColor("quant", !ClientPrefs.data.quantization);
		this.unspawnNotes = unspawnedNotes.copy();
		return this.loadedNotes = unspawnedNotes.copy();
	}

	public function loadStrums() {

		var strumLineX:Float = ClientPrefs.data.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X;
		var TRUE_STRUM_X:Float = strumLineX;

		for (j in 0...2)
		{
			for (i in 0...4)
			{
				// FlxG.log.add(i);
				var targetAlpha:Float = 1;
				if (j < 1)
				{
					if (ClientPrefs.data.middleScroll && !PlayState.forceRightScroll || PlayState.forceMiddleScroll)
						targetAlpha = 0.35;
				}
				final babyArrow:StrumNote = new StrumNote(!PlayState.forcedAScroll ? (ClientPrefs.data.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) : if (PlayState.forceRightScroll
					&& !PlayState.forceMiddleScroll) PlayState.STRUM_X else if (PlayState.forceMiddleScroll && !PlayState.forceRightScroll)
					PlayState.STRUM_X_MIDDLESCROLL else ClientPrefs.data.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X,
					ModchartUtil.getDownscroll(renderer.instance) ? FlxG.width - 150 : 50, i, j);
				babyArrow.downScroll = ClientPrefs.data.downScroll;
				babyArrow.alpha = targetAlpha;

				if (j == 0)
				{
					babyArrow.ai = true;
					if (ClientPrefs.data.middleScroll && !PlayState.forceRightScroll || PlayState.forceMiddleScroll)
					{
						babyArrow.x += 310;
						if (i > 1)
						{ // Up and Right
							babyArrow.x += FlxG.width / 2 + 25;
						}
					}
				}

				strums.add(babyArrow);
				babyArrow.field = field;
				babyArrow.playerPosition();
				renderer.allObjects.add(babyArrow);
			}
		}
    }

	public function rescaleNotes(ratio:Float)
	{
		for (note in unspawnNotes)
			note.resizeByRatio(ratio);
		for (note in notes.members)
			note.resizeByRatio(ratio);
	}

	public function killNotes()
	{
		while (notes.length > 0)
		{
			var note:Note = notes.members[0];
			note.active = false;
			note.visible = false;
			invalidateNote(note);
		}
		unspawnNotes = [];
	}

	public var spawnTime:Float = 2000;
	public var strumsBlocked:Array<Bool> = [false, false, false, false];

	public function keyPress(key:Int) {

		// more accurate hit time for the ratings?
		var lastTime:Float = Conductor.songPosition;
		if (Conductor.songPosition >= 0)
			Conductor.songPosition = FlxG.sound.music.time + Conductor.offset;

		// obtain notes that the player can hit
		var plrInputNotes:Array<Note> = notes.members.filter(function(n:Note):Bool
		{
			var canHit:Bool = n != null && !strumsBlocked[n.noteData] && n.canBeHit && n.mustPress && !n.tooLate && !n.wasGoodHit && !n.blockHit;
			return canHit && !n.isSustainNote && n.noteData == key;
		});
		plrInputNotes.sort(PlayState.sortHitNotes);

		if (plrInputNotes.length != 0)
		{ // slightly faster than doing `> 0` lol
			var funnyNote:Note = plrInputNotes[0]; // front note

			if (plrInputNotes.length > 1)
			{
				var doubleNote:Note = plrInputNotes[1];
				if (doubleNote.noteData == funnyNote.noteData)
				{
					// if the note has a 0ms distance (is on top of the current note), kill it
					if (Math.abs(doubleNote.strumTime - funnyNote.strumTime) < 1.0)
						invalidateNote(doubleNote);
					else if (doubleNote.strumTime < funnyNote.strumTime)
					{
						// replace the note if its ahead of time (or at least ensure "doubleNote" is ahead)
						funnyNote = doubleNote;
					}
				}
			}
			noteHit(funnyNote, true);
		}
		else if (!ClientPrefs.data.ghostTapping)
			noteMiss(key, null);

		// more accurate hit time for the ratings? part 2 (Now that the calculations are done, go back to the time it was before for not causing a note stutter)
		Conductor.songPosition = lastTime;

		final spr:StrumNote = strums.members[key + 4];
		if (spr == null || strumsBlocked[key] || spr.animation.curAnim.name == 'confirm') return;
		spr.playAnim('pressed');
		spr.released = false;
		spr.resetAnim = 0;
	}

	public function keyRelease(key:Int) 
	{
		final spr:StrumNote = strums.members[key + 4];
		if (spr == null) return;
		spr.playAnim('static');
		spr.released = true;
		spr.resetAnim = 0;
	}

	public function updateNotes(elapsed:Float) {
		notes.forEachAlive(function(daNote:Note)
		{
			final strum:StrumNote = strums.members[daNote.mustPress ? daNote.noteData+4 : daNote.noteData];
			if (@:privateAccess strum.player > 0) strum.ai = cpuControlled;
			daNote.followStrumNote(strum, renderer.speed / renderer.rate);

			if (daNote.mustPress)
			{
				if (cpuControlled
					&& !daNote.blockHit
					&& daNote.canBeHit
					&& (daNote.isSustainNote || daNote.strumTime <= Conductor.songPosition))
					noteHit(daNote, true);
			}
			else if (daNote.wasGoodHit && !daNote.hitByOpponent && !daNote.ignoreNote)
				noteHit(daNote);

			if (daNote.isSustainNote && strum.sustainReduce)
				daNote.clipToStrumNote(strum);

			if (daNote.newMesh != null)
			{
				if (daNote.newMesh.sustainLength > 0.0)
					daNote.newMesh.updateLength();
				else
					invalidateNote(daNote);
			}
			else if (Conductor.songPosition - daNote.strumTime > noteKillOffset) // Kill extremely late notes and cause misses 
			{
				if (daNote.mustPress && !cpuControlled && !daNote.ignoreNote && (daNote.tooLate || !daNote.wasGoodHit))
					noteMiss(daNote.noteData, daNote);

				daNote.active = daNote.visible = false;
				invalidateNote(daNote);
			}
		});

		if (ClientPrefs.data.quantization)
		{
			for (index => strum in strums)
			{
				if (strum == null || index < 4) continue;
				if (strum.animation.curAnim.name == 'static')
				{
					strum.rgbShader.r = 0xFF808080;
					strum.rgbShader.b = 0xFFFFFFFF;
				}
			}
		}
	}

	public function noteMiss(direction:Int, note:Note = null) {
		if (note != null)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (note != daNote
					&& note.mustPress
					&& note.noteData == daNote.noteData
					&& note.isSustainNote == daNote.isSustainNote
					&& Math.abs(note.strumTime - daNote.strumTime) < 1)
					invalidateNote(daNote);
			});
		}

		// GUITAR HERO SUSTAIN CHECK LOL!!!!
		if (note != null && guitarHeroSustains && note.parent == null)
		{
			if (note.tail.length > 0)
			{
				note.alpha = 0.35;
				for (childNote in note.tail)
				{
					childNote.alpha = note.alpha;
					childNote.missed = true;
					childNote.canBeHit = false;
					childNote.ignoreNote = true;
					childNote.tooLate = true;
				}
				note.missed = true;
				note.canBeHit = false;
			}

			if (note.missed)
				return;
		}

		
		if (note != null && guitarHeroSustains && note.parent != null && note.isSustainNote)
		{
			if (note.missed)
				return;

			var parentNote:Note = note.parent;
			if (parentNote.wasGoodHit && parentNote.tail.length > 0)
			{
				for (child in parentNote.tail)
					if (child != note)
					{
						child.missed = true;
						child.canBeHit = false;
						child.ignoreNote = true;
						child.tooLate = true;
					}
			}
		}
	}

	public function prepareNotes() {
		notes.forEachAlive(function(daNote:Note)
		{
			daNote.canBeHit = false;
			daNote.wasGoodHit = false;
		});
	}

	public function invalidateNote(daNote:Note) {
		daNote?.mesh?.destroy();
		notes.remove(daNote, true);
		daNote.destroy();
	}

	public function handleSustainInput(hold:Array<Bool>) {
		for (n in notes)
		{ 
			// I can't do a filter here, that's kinda awesome
			var canHit:Bool = (n != null && !strumsBlocked[n.noteData] && n.canBeHit && n.mustPress && !n.tooLate && !n.wasGoodHit && !n.blockHit);

			if (guitarHeroSustains)
				canHit = canHit && n.parent != null && n.parent.wasGoodHit;

			if (canHit && n.isSustainNote)
			{
				var released:Bool = !hold[n.noteData];
				if (!released)
					noteHit(n, true);
			}
		}
		for (i => press in hold) {
			strums.members[i+4].released = !press;
		}
	}

	public function spawnNotes() {
		if (unspawnNotes[0] == null) return;
		final time:Float = (spawnTime * renderer.rate) / (renderer.speed < 1 ? renderer.speed : 1) / (unspawnNotes[0].multSpeed < 1 ? unspawnNotes[0].multSpeed : 1);
		while (unspawnNotes.length > 0 && unspawnNotes[0].strumTime - Conductor.songPosition < time)
		{
			final daNote:Note = unspawnNotes[0];
			notes.insert(0, daNote);
			daNote.field = field;
			renderer.allObjects.add(daNote);

			if (daNote.isSustainNote) if (daNote.mesh == null) daNote.mesh = new SustainStrip(daNote);
			if(!renderer.allObjects.members.contains(daNote.mesh)) renderer.allObjects.add(daNote.mesh);

			daNote.spawned = true;

			unspawnNotes.splice(unspawnNotes.indexOf(daNote), 1);
		}
	}

	public function skipIntro() {
		notes.forEachAlive(function(daNote:Note)
		{
			if (daNote.strumTime + 800 < Conductor.songPosition)
			{
				daNote.active = daNote.visible = false;
				daNote.kill();
				notes.remove(daNote, true);
				daNote.destroy();
			}
		});
		for (i in 0...unspawnNotes.length)
		{
			final daNote:Note = unspawnNotes[0];
			if (daNote.strumTime + 800 >= Conductor.songPosition)
				break;
			daNote.active = daNote.visible = false;
			daNote.kill();
			unspawnNotes.splice(unspawnNotes.indexOf(daNote), 1);
			daNote.destroy();
		}
	}

	public function noteHit(note:Note, player:Bool = false) {
		if (player && note.wasGoodHit) return;
		final strum:StrumNote = strums.members[note.noteData + (note.mustPress ? 4 : 0)];
		if (!player)
		{
			strum.playAnim('confirm', true);
			if (note.isSustainNote && note.nextNote != null) {
				strum.animation.curAnim.curFrame = 3;
				strum.animation.curAnim.pause();
			}
			strum.released = true;
			note.hitByOpponent = true;
		}
		else {
			note.wasGoodHit = true;
			strum.playAnim('confirm', true);
			if (strum.ai) {
				if (note.isSustainNote && note.nextNote != null) {
					strum.animation.curAnim.curFrame = 3;
					strum.animation.curAnim.pause();
				}
				strum.released = true;
			}
			if (!note.isSustainNote)
				playSplash(note, strum);
		}

		if (ClientPrefs.data.quantization)
		{
			strum.rgbShader.r = note.rgbShader.r;
			strum.rgbShader.b = note.rgbShader.b;
		}
		
		playHold(note, strum);
		if (!note.isSustainNote && (note.newMesh == null || note.newMesh.sustainLength <= 0.0))
			invalidateNote(note);

		if (strum.ai && note.isHoldEnd)
			strum.playAnim('static', true);
	}

	public function playHold(note:Note, strum:StrumNote)
	{
		if (ClientPrefs.data.holdSplashAlpha <= 0 || note.tail.length <= 1) return;
		strum.playHoldSplash(note, renderer.rate);
		if (!renderer?.splashObjects?.members?.contains(strum.holdSplash)) {
			strum.holdSplash.field = field;
			renderer.splashObjects.add(strum.holdSplash);
		}
	}

	public function playSplash(note:Note, strum:StrumNote) {
		if (ClientPrefs.data.splashAlpha <= 0) return;
		strum.playSplash(note);
		if (!renderer?.splashObjects?.members?.contains(strum.splash)) {
			strum.splash.field = field;
			renderer.splashObjects.add(strum.splash);
		}
	}

	public function strumPlayAnim(id:Int, time:Float = -1)
	{
		final spr:StrumNote = strums.members[id];
		if (spr == null) return;
		spr.playAnim('confirm', true);
		// if (time != -1)
		// 	spr.resetAnim = time;
	}
}