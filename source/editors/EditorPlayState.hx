package editors;

import Section.SwagSection;
import Song.SwagSong;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;

import flixel.util.FlxSort;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import openfl.events.KeyboardEvent;
import editors.EditorLua;

using StringTools;

class EditorPlayState extends MusicBeatState
{
	// Yes, this is mostly a copy of PlayState, it's kinda dumb to make a direct copy of it but... ehhh
	private var strumLine:FlxSprite;
	private var comboGroup:FlxTypedGroup<FlxSprite>;
	public var strumLineNotes:FlxTypedGroup<StrumNote>;
	public var opponentStrums:FlxTypedGroup<StrumNote>;
	public var playerStrums:FlxTypedGroup<StrumNote>;

	public var notes:FlxTypedGroup<Note>;
	public var unspawnNotes:Array<Note> = [];

	public var activeModifiers:FlxText; //funny thing i added cuz why not?

	var generatedMusic:Bool = false;
	var vocals:FlxSound;

	var startOffset:Float = 0;
	var startPos:Float = 0;

	public function new(startPos:Float) {
		this.startPos = startPos;
		Conductor.songPosition = startPos - startOffset;

		startOffset = Conductor.crochet;
		timerToStart = startOffset;
		super();
	}

	var scoreTxt:FlxText;
	var stepTxt:FlxText;
	var beatTxt:FlxText;
	var sectionTxt:FlxText;
	
	var timerToStart:Float = 0;
	private var noteTypeMap:Map<String, Bool> = new Map<String, Bool>();
	
	// Less laggy controls
	private var keysArray:Array<Dynamic>;

	public static var instance:EditorPlayState;

	//quant stuff
	var beat:Float = 0;
	var dataStuff:Float = 0;
	var col:FlxColor = 0xFFFFD700;
	var col3:FlxColor = 0xFFFFD700;
	var col2:FlxColor = 0xFFFFD700;

	public var luaArray:Array<EditorLua> = [];

	override function create()
	{
		instance = this;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set();
		bg.color = FlxColor.fromHSB(FlxG.random.int(0, 359), FlxG.random.float(0, 0.8), FlxG.random.float(0.3, 1));
		add(bg);

		modcharting.ModchartFuncs.editor = true;

		keysArray = [
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_left')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_down')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_up')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_right'))
		];
		
		strumLine = new FlxSprite(!PlayState.forcedAScroll ? (ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) : 
															(if (PlayState.forceRightScroll && !PlayState.forceMiddleScroll) PlayState.STRUM_X 
															else if (PlayState.forceMiddleScroll && !PlayState.forceRightScroll) PlayState.STRUM_X_MIDDLESCROLL 
															else ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X)
			, 50).makeGraphic(FlxG.width, 10);
		if(ClientPrefs.downScroll) strumLine.y = FlxG.height - 150;
		strumLine.scrollFactor.set();
		
		comboGroup = new FlxTypedGroup<FlxSprite>();
		add(comboGroup);

		strumLineNotes = new FlxTypedGroup<StrumNote>();
		opponentStrums = new FlxTypedGroup<StrumNote>();
		playerStrums = new FlxTypedGroup<StrumNote>();
		add(strumLineNotes);

		generateStaticArrows(0);
		generateStaticArrows(1);
		modcharting.NoteMovement.getDefaultStrumPosFromEditor(this);
		/*if(ClientPrefs.middleScroll) {
			opponentStrums.forEachAlive(function (note:StrumNote) {
				note.visible = false;
			});
		}*/
		
		if (PlayState.SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		generateSong();

		scoreTxt = new FlxText(10, FlxG.height - 50, FlxG.width - 20, "Hits: 0 | Misses: 0", 20);
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		scoreTxt.borderSize = 1.25;
		scoreTxt.visible = !ClientPrefs.hideHud;
		add(scoreTxt);
		
		sectionTxt = new FlxText(10, 180, FlxG.width - 20, "Section: 0", 20);
		sectionTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		sectionTxt.scrollFactor.set();
		sectionTxt.borderSize = 1.25;
		add(sectionTxt);
		
		beatTxt = new FlxText(10, sectionTxt.y + 30, FlxG.width - 20, "Beat: 0", 20);
		beatTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		beatTxt.scrollFactor.set();
		beatTxt.borderSize = 1.25;
		add(beatTxt);

		stepTxt = new FlxText(10, beatTxt.y + 30, FlxG.width - 20, "Step: 0", 20);
		stepTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		stepTxt.scrollFactor.set();
		stepTxt.borderSize = 1.25;
		add(stepTxt);

		var tipText:FlxText = new FlxText(10, FlxG.height - 24, 0, 'Press ESC to Go Back to Chart Editor', 16);
		tipText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tipText.borderSize = 2;
		tipText.scrollFactor.set();
		add(tipText);

		if (PlayState.SONG.notITG){
			activeModifiers = new FlxText(0,0); //no need add the text if MT isn't active (if you want your own template then add the text manually in the lua/Hx)
			activeModifiers.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			activeModifiers.borderSize = 2;
			activeModifiers.scrollFactor.set();
			activeModifiers.screenCenter();
			add(activeModifiers);

			playfieldRenderer = new modcharting.PlayfieldRenderer(strumLineNotes, notes, this);
			playfieldRenderer.camera = this.camera;
			add(playfieldRenderer);
		}
		#if (LUA_ALLOWED && MODS_ALLOWED)
		for (notetype in noteTypeMap.keys()) {
			var luaToLoad:String = Paths.modFolders('custom_notetypes/' + notetype + '.lua');
			if(sys.FileSystem.exists(luaToLoad)) {
				luaArray.push(new EditorLua(luaToLoad));
			}
		}
		#end
		noteTypeMap.clear();
		noteTypeMap = null;

		FlxG.mouse.visible = false;

		#if LUA_ALLOWED
		for (folder in Mods.directoriesWithFile(Paths.getPreloadPath(), 'data/' + PlayState.SONG.song + '/'))
		{
			if(sys.FileSystem.exists(folder))
			{
				for (file in sys.FileSystem.readDirectory(folder))
				{
					if(file.toLowerCase().endsWith('.lua'))
						luaArray.push(new EditorLua(folder + file));
				}
			}
		}
		#end

		if (PlayState.SONG.notITG)
			modcharting.ModchartFuncs.loadLuaEditorFunctions();

		//sayGo();
		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		if (ClientPrefs.quantization)
			doNoteQuant();

		super.create();
		callOnLuas('onCreatePost', []);
	}

	public function doNoteQuant()
	{
		var bpmChanges = Conductor.bpmChangeMap;
		var strumTime:Float = 0;
		var currentBPM = PlayState.SONG.bpm;
		for (note in unspawnNotes) {
			strumTime = note.strumTime;
			var newTime = strumTime;
			for (i in 0...bpmChanges.length)
				if (strumTime > bpmChanges[i].songTime){
					currentBPM = bpmChanges[i].bpm;
					newTime = strumTime - bpmChanges[i].songTime;
				}
			if (note.rgbShader.enabled && !note.hurtNote){
				dataStuff = ((currentBPM * (newTime - ClientPrefs.noteOffset)) / 1000 / 60);
				beat = round(dataStuff * 48, 0);
				if (!note.isSustainNote){
					if(beat%(192/4)==0){
						col = ClientPrefs.arrowRGBQuantize[0][0];
						col3 = ClientPrefs.arrowRGBQuantize[0][1];
						col2 = ClientPrefs.arrowRGBQuantize[0][2];
					}
					else if(beat%(192/8)==0){
						col = ClientPrefs.arrowRGBQuantize[1][0];
						col3 = ClientPrefs.arrowRGBQuantize[1][1];
						col2 = ClientPrefs.arrowRGBQuantize[1][2];
					}
					else if(beat%(192/12)==0){
						col = ClientPrefs.arrowRGBQuantize[2][0];
						col3 = ClientPrefs.arrowRGBQuantize[2][1];
						col2 = ClientPrefs.arrowRGBQuantize[2][2];
					}
					else if(beat%(192/16)==0){
						col = ClientPrefs.arrowRGBQuantize[3][0];
						col3 = ClientPrefs.arrowRGBQuantize[3][1];
						col2 = ClientPrefs.arrowRGBQuantize[3][2];
					}
					else if(beat%(192/24)==0){
						col = ClientPrefs.arrowRGBQuantize[4][0];
						col3 = ClientPrefs.arrowRGBQuantize[4][1];
						col2 = ClientPrefs.arrowRGBQuantize[4][2];
					}
					else if(beat%(192/32)==0){
						col = ClientPrefs.arrowRGBQuantize[5][0];
						col3 = ClientPrefs.arrowRGBQuantize[5][1];
						col2 = ClientPrefs.arrowRGBQuantize[5][2];
					}
					else if(beat%(192/48)==0){
						col = ClientPrefs.arrowRGBQuantize[6][0];
						col3 = ClientPrefs.arrowRGBQuantize[6][1];
						col2 = ClientPrefs.arrowRGBQuantize[6][2];
					}
					else if(beat%(192/64)==0){
						col = ClientPrefs.arrowRGBQuantize[7][0];
						col3 = ClientPrefs.arrowRGBQuantize[7][1];
						col2 = ClientPrefs.arrowRGBQuantize[7][2];
					}else{
						col = 0xFF7C7C7C;
						col3 = 0xFFFFFFFF;
						col2 = 0xFF3A3A3A;
					}
					note.rgbShader.r = col;
					note.rgbShader.g = col3;
					note.rgbShader.b = col2;
			
				}else{
					note.rgbShader.r = note.prevNote.rgbShader.r;
					note.rgbShader.g = note.prevNote.rgbShader.g;
					note.rgbShader.b = note.prevNote.rgbShader.b;  
				}
			}
		}
		for (this2 in opponentStrums)
		{
			this2.rgbShader.r = 0xFFFFFFFF;
			this2.rgbShader.b = 0xFF000000;  
			this2.rgbShader.enabled = false;
		}
		for (this2 in playerStrums)
		{
			this2.rgbShader.r = 0xFFFFFFFF;
			this2.rgbShader.b = 0xFF000000;  
			this2.rgbShader.enabled = false;
		}
	}

	private function round(num:Float, numDecimalPlaces:Int){
		var mult = 10^numDecimalPlaces;
		return Math.floor(num * mult + 0.5) / mult;
	}

	function sayGo() {
		var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image('go'));
		go.scrollFactor.set();

		go.updateHitbox();

		go.screenCenter();
		go.antialiasing = ClientPrefs.globalAntialiasing;
		add(go);
		FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				go.destroy();
			}
		});
		FlxG.sound.play(Paths.sound('introGo'), 0.6);
	}

	//var songScore:Int = 0;
	var songHits:Int = 0;
	var songMisses:Int = 0;
	var startingSong:Bool = true;
	private function generateSong():Void
	{
		FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0, false);
		FlxG.sound.music.pause();
		FlxG.sound.music.onComplete = endSong;
		vocals.pause();
		vocals.volume = 0;

		var songData = PlayState.SONG;
		Conductor.bpm = songData.bpm;
		
		notes = new FlxTypedGroup<Note>();
		add(notes);
		
		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped

		for (section in noteData)
		{
			for (songNotes in section.sectionNotes)
			{
				if(songNotes[1] > -1) { //Real notes
					var daStrumTime:Float = songNotes[0];
					if(daStrumTime >= startPos) {
						var daNoteData:Int = Std.int(songNotes[1] % 4);

						var gottaHitNote:Bool = section.mustHitSection;

						if (songNotes[1] > 3)
						{
							gottaHitNote = !section.mustHitSection;
						}

						var oldNote:Note;
						if (unspawnNotes.length > 0)
							oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
						else
							oldNote = null;

						var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote);
						swagNote.mustPress = gottaHitNote;
						swagNote.sustainLength = songNotes[2];
						swagNote.noteType = songNotes[3];
						if(!Std.isOfType(songNotes[3], String)) swagNote.noteType = editors.ChartingState.noteTypeList[songNotes[3]]; //Backward compatibility + compatibility with Week 7 charts
						swagNote.scrollFactor.set();

						var susLength:Float = swagNote.sustainLength;

						susLength = susLength / Conductor.stepCrochet;
						unspawnNotes.push(swagNote);

						var floorSus:Int = Math.floor(susLength);
						if(floorSus > 0) {
							for (susNote in 0...floorSus+1)
							{
								oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

								var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(PlayState.SONG.speed, 2)), daNoteData, oldNote, true);
								sustainNote.mustPress = gottaHitNote;
								sustainNote.noteType = swagNote.noteType;
								sustainNote.scrollFactor.set();
								unspawnNotes.push(sustainNote);

								if (sustainNote.mustPress)
								{
									sustainNote.x += FlxG.width / 2; // general offset
								}
								else if(ClientPrefs.middleScroll && !PlayState.forceRightScroll || PlayState.forceMiddleScroll)
								{
									sustainNote.x += 310;
									if(daNoteData > 1)
									{ //Up and Right
										sustainNote.x += FlxG.width / 2 + 25;
									}
								}
							}
						}

						if (swagNote.mustPress)
						{
							swagNote.x += FlxG.width / 2; // general offset
						}
						else if(ClientPrefs.middleScroll && !PlayState.forceRightScroll || PlayState.forceMiddleScroll)
						{
							swagNote.x += 310;
							if(daNoteData > 1) //Up and Right
							{
								swagNote.x += FlxG.width / 2 + 25;
							}
						}
						
						if(!noteTypeMap.exists(swagNote.noteType)) {
							noteTypeMap.set(swagNote.noteType, true);
						}
					}
				}
			}
			daBeats += 1;
		}

		unspawnNotes.sort(sortByShit);
		generatedMusic = true;
	}

	function startSong():Void
	{
		startingSong = false;
		FlxG.sound.music.time = startPos;
		FlxG.sound.music.play();
		FlxG.sound.music.volume = 1;
		vocals.volume = 1;
		vocals.time = startPos;
		vocals.play();
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	private function endSong() {
		LoadingState.loadAndSwitchState(new editors.ChartingState());
	}

	public var noteKillOffset:Float = 350;
	public var spawnTime:Float = 2000;
	override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.sound.music.pause();
			vocals.pause();
			LoadingState.loadAndSwitchState(new editors.ChartingState());
		}

		callOnLuas('onUpdate', [elapsed]);
		callOnLuas('update', [elapsed]);

		if (startingSong) {
			timerToStart -= elapsed * 1000;
			Conductor.songPosition = startPos - timerToStart;
			if(timerToStart < 0) {
				startSong();
			}
		} else {
			Conductor.songPosition += elapsed * 1000;
		}

		setOnLuas('curDecBeat', curDecBeat);
		setOnLuas('curDecStep', curDecStep);

		if (unspawnNotes[0] != null)
		{
			var time:Float = spawnTime;
			if(PlayState.SONG.speed < 1) time /= PlayState.SONG.speed;
			if(unspawnNotes[0].multSpeed < 1) time /= unspawnNotes[0].multSpeed;

			while (unspawnNotes.length > 0 && unspawnNotes[0].strumTime - Conductor.songPosition < time)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.insert(0, dunceNote);
				dunceNote.spawned = true;

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}
		
		if (generatedMusic)
		{
			var fakeCrochet:Float = (60 / PlayState.SONG.bpm) * 1000;
			notes.forEachAlive(function(daNote:Note)
			{
				/*if (daNote.y > FlxG.height)
				{
					daNote.active = false;
					daNote.visible = false;
				}
				else
				{
					daNote.visible = true;
					daNote.active = true;
				}*/

				// i am so fucking sorry for this if condition
				var strumX:Float = 0;
				var strumY:Float = 0;
				var strumAlpha:Float = 0;
				var strumHeight:Float = 0;

				if(daNote.mustPress) {
					strumX = playerStrums.members[daNote.noteData].x;
					strumY = playerStrums.members[daNote.noteData].y;
					strumAlpha = playerStrums.members[daNote.noteData].alpha;
					strumHeight = playerStrums.members[daNote.noteData].height;
				} else {
					strumX = opponentStrums.members[daNote.noteData].x;
					strumY = opponentStrums.members[daNote.noteData].y;
					strumAlpha = opponentStrums.members[daNote.noteData].alpha;
					strumHeight = opponentStrums.members[daNote.noteData].height;
				}

				strumX += daNote.offsetX;
				strumY += daNote.offsetY;
				var center:Float = strumY + strumHeight / 2;

				if(daNote.copyAlpha) {
					daNote.alpha = strumAlpha * daNote.multAlpha;
				}
				if(daNote.copyX) {
					daNote.x = strumX;
				}
				if(daNote.copyY) {
					if (ClientPrefs.downScroll) {
						daNote.y = (strumY + 0.45 * (Conductor.songPosition - daNote.strumTime) * PlayState.SONG.speed);
						if (daNote.isSustainNote) {
							//Jesus fuck this took me so much mother fucking time AAAAAAAAAA
							if (daNote.animation.curAnim.name.endsWith('end')) {
								daNote.y += 10.5 * (fakeCrochet / 400) * 1.5 * PlayState.SONG.speed + (46 * (PlayState.SONG.speed - 1));
								daNote.y -= 46 * (1 - (fakeCrochet / 600)) * PlayState.SONG.speed;
								if(daNote.texture.contains('pixel') || PlayState.isPixelStage) {
									daNote.y += 8;
								} else {
									daNote.y -= 19;
								}
							} 
							daNote.y += (strumHeight / 2) - (60.5 * (PlayState.SONG.speed - 1));
							daNote.y += 27.5 * ((PlayState.SONG.bpm / 100) - 1) * (PlayState.SONG.speed - 1);

							if(daNote.mustPress || !daNote.ignoreNote)
							{
								if(daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= center
									&& (!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit))))
								{
									var swagRect = new FlxRect(0, 0, daNote.frameWidth, daNote.frameHeight);
									swagRect.height = (center - daNote.y) / daNote.scale.y;
									swagRect.y = daNote.frameHeight - swagRect.height;

									daNote.clipRect = swagRect;
								}
							}
						}
					} else {
						daNote.y = (strumY - 0.45 * (Conductor.songPosition - daNote.strumTime) * PlayState.SONG.speed);

						if(daNote.mustPress || !daNote.ignoreNote)
						{
							if (daNote.isSustainNote
								&& daNote.y + daNote.offset.y * daNote.scale.y <= center
								&& (!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit))))
							{
								var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
								swagRect.y = (center - daNote.y) / daNote.scale.y;
								swagRect.height -= swagRect.y;

								daNote.clipRect = swagRect;
							}
						}
					}
				}

				if (!daNote.mustPress && daNote.wasGoodHit && !daNote.hitByOpponent && !daNote.ignoreNote)
				{
					if (PlayState.SONG.needsVoices)
						vocals.volume = 1;

					var time:Float = 0.15;
					if(daNote.isSustainNote && !daNote.animation.curAnim.name.endsWith('end')) {
						time += 0.15;
					}
					StrumPlayAnim(true, Std.int(Math.abs(daNote.noteData)), time);
					daNote.hitByOpponent = true;
					opponentStrums.members[daNote.noteData].rgbShader.r = daNote.rgbShader.r;
					opponentStrums.members[daNote.noteData].rgbShader.b = daNote.rgbShader.b;
					if (!daNote.isSustainNote)
					{
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}
				}

				if (Conductor.songPosition > (noteKillOffset / PlayState.SONG.speed) + daNote.strumTime)
				{
					if (daNote.mustPress)
					{
						if (daNote.tooLate || !daNote.wasGoodHit)
						{
							//Dupe note remove
							notes.forEachAlive(function(note:Note) {
								if (daNote != note && daNote.mustPress && daNote.noteData == note.noteData && daNote.isSustainNote == note.isSustainNote && Math.abs(daNote.strumTime - note.strumTime) < 10) {
									note.kill();
									notes.remove(note, true);
									note.destroy();
								}
							});

							if(!daNote.ignoreNote) {
								songMisses++;
								vocals.volume = 0;
							}
						}
					}

					daNote.active = false;
					daNote.visible = false;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
			});
		}

		keyShit();
		scoreTxt.text = 'Hits: ' + songHits + ' | Misses: ' + songMisses;
		sectionTxt.text = 'Section: ' + curSection;
		beatTxt.text = 'Beat: ' + curBeat;
		stepTxt.text = 'Step: ' + curStep;

		if (ClientPrefs.quantization)
			noteQuantUpdatePost();

		var leText = "Active Modifiers: \n";
        for (modName => mod in playfieldRenderer.modifierTable.modifiers)
        {
            if (mod.currentValue != mod.baseValue)
            {
                leText += modName + ": " + FlxMath.roundDecimal(mod.currentValue, 2);
                for (subModName => subMod in mod.subValues)
                {
                    leText += "    " + subModName + ": " + FlxMath.roundDecimal(subMod.value, 2);
                }
                leText += "\n";
            }
        }

        activeModifiers.text = leText;
		activeModifiers.screenCenter();

		callOnLuas('onUpdatePost', [elapsed]);
		callOnLuas('updatePost', [elapsed]);

		super.update(elapsed);
	}
	
	function noteQuantUpdatePost()
	{
		for (this2 in playerStrums){
			if (this2.animation.curAnim.name == 'static'){
				this2.rgbShader.r = 0xFF808080;
				this2.rgbShader.b = 0xFFFFFFFF;
			}
		}
	}

	override public function onFocus():Void
	{
		vocals.play();

		super.onFocus();
	}
	
	override public function onFocusLost():Void
	{
		vocals.pause();

		super.onFocusLost();
	}

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, ClientPrefs.downScroll ? FlxSort.ASCENDING : FlxSort.DESCENDING);
		}
		setOnLuas('curBeat', curBeat);
		callOnLuas('onBeatHit', [curBeat]);
		callOnLuas('beatHit', [curBeat]);
	}

	var animSkins:Array<String> = ['ITHIT', 'MANIAHIT', 'STEPMANIA', 'NOTITG'];
	
	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}
		for (i in 0... animSkins.length){
			if (ClientPrefs.notesSkin[0].contains(animSkins[i])){
				if (curStep % 4 == 0){
					for (this2 in opponentStrums)
					{
						if (this2.animation.curAnim.name == 'static'){
							this2.rgbShader.r = 0xFF808080;
							this2.rgbShader.b = 0xFF474747;
							this2.rgbShader.enabled = true;
						}
					}
					for (this2 in playerStrums)
					{
						if (this2.animation.curAnim.name == 'static'){
							this2.rgbShader.r = 0xFF808080;
							this2.rgbShader.b = 0xFF474747;
							this2.rgbShader.enabled = true;
						}
					}
				}else if (curStep % 4 == 1){
					for (this2 in opponentStrums)
					{
						if (this2.animation.curAnim.name == 'static'){ 
							this2.rgbShader.enabled = false;
						}
					}
					for (this2 in playerStrums)
					{
						if (this2.animation.curAnim.name == 'static'){
							this2.rgbShader.enabled = false;
						}
					}
				}
			}
		}
		setOnLuas('curStep', curStep);
		callOnLuas('onStepHit', [curStep]);
		callOnLuas('stepHit', [curStep]);
	}

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();
	}
	private function onKeyPress(event:KeyboardEvent):Void
	{
		var eventKey:FlxKey = event.keyCode;
		var key:Int = getKeyFromEvent(eventKey);
		//trace('Pressed: ' + eventKey);

		if (key > -1 && (FlxG.keys.checkStatus(eventKey, JUST_PRESSED) || ClientPrefs.controllerMode))
		{
			if(generatedMusic)
			{
				//more accurate hit time for the ratings?
				var lastTime:Float = Conductor.songPosition;
				Conductor.songPosition = FlxG.sound.music.time;

				var canMiss:Bool = !ClientPrefs.ghostTapping;

				// heavily based on my own code LOL if it aint broke dont fix it
				var pressNotes:Array<Note> = [];
				//var notesDatas:Array<Int> = [];
				var notesStopped:Bool = false;

				//trace('test!');
				var sortedNotesList:Array<Note> = [];
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.isSustainNote)
					{
						if(daNote.noteData == key)
						{
							sortedNotesList.push(daNote);
							//notesDatas.push(daNote.noteData);
						}
						// if (!daNote.isSustainNote)
						// 	canMiss = true;
					}
				});
				sortedNotesList.sort(sortHitNotes);

				if (sortedNotesList.length > 0) {
					for (epicNote in sortedNotesList)
					{
						for (doubleNote in pressNotes) {
							if (Math.abs(doubleNote.strumTime - epicNote.strumTime) < 1) {
								doubleNote.kill();
								notes.remove(doubleNote, true);
								doubleNote.destroy();
							} else
								notesStopped = true;
						}

						// eee jack detection before was not super good
						if (!notesStopped) {
							goodNoteHit(epicNote);
							pressNotes.push(epicNote);
						}

					}
				}
				else if (canMiss) {
					noteMiss();
				}

				//more accurate hit time for the ratings? part 2 (Now that the calculations are done, go back to the time it was before for not causing a note stutter)
				Conductor.songPosition = lastTime;
			}

			var spr:StrumNote = playerStrums.members[key];
			if(spr != null && spr.animation.curAnim.name != 'confirm')
			{
				spr.playAnim('pressed');
				spr.resetAnim = 0;
			}
		}
	}

	function sortHitNotes(a:Note, b:Note):Int
	{
		if (a.lowPriority && !b.lowPriority)
			return 1;
		else if (!a.lowPriority && b.lowPriority)
			return -1;

		return FlxSort.byValues(FlxSort.ASCENDING, a.strumTime, b.strumTime);
	}

	private function onKeyRelease(event:KeyboardEvent):Void
	{
		var eventKey:FlxKey = event.keyCode;
		var key:Int = getKeyFromEvent(eventKey);
		if(key > -1)
		{
			var spr:StrumNote = playerStrums.members[key];
			if(spr != null)
			{
				spr.playAnim('static');
				spr.resetAnim = 0;
			}
		}
		//trace('released: ' + controlArray);
	}

	private function getKeyFromEvent(key:FlxKey):Int
	{
		if(key != NONE)
		{
			for (i in 0...keysArray.length)
			{
				for (j in 0...keysArray[i].length)
				{
					if(key == keysArray[i][j])
					{
						return i;
					}
				}
			}
		}
		return -1;
	}

	private function keyShit():Void
	{
		// HOLDING
		var up = controls.NOTE_UP;
		var right = controls.NOTE_RIGHT;
		var down = controls.NOTE_DOWN;
		var left = controls.NOTE_LEFT;
		var controlHoldArray:Array<Bool> = [left, down, up, right];
		
		// TO DO: Find a better way to handle controller inputs, this should work for now
		if(ClientPrefs.controllerMode)
		{
			var controlArray:Array<Bool> = [controls.NOTE_LEFT_P, controls.NOTE_DOWN_P, controls.NOTE_UP_P, controls.NOTE_RIGHT_P];
			if(controlArray.contains(true))
			{
				for (i in 0...controlArray.length)
				{
					if(controlArray[i])
						onKeyPress(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, true, -1, keysArray[i][0]));
				}
			}
		}

		// FlxG.watch.addQuick('asdfa', upP);
		if (generatedMusic)
		{
			// rewritten inputs???
			notes.forEachAlive(function(daNote:Note)
			{
				// hold note functions
				if (daNote.isSustainNote && controlHoldArray[daNote.noteData] && daNote.canBeHit 
				&& daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit) {
					goodNoteHit(daNote);
				}
			});
		}

		// TO DO: Find a better way to handle controller inputs, this should work for now
		if(ClientPrefs.controllerMode)
		{
			var controlArray:Array<Bool> = [controls.NOTE_LEFT_R, controls.NOTE_DOWN_R, controls.NOTE_UP_R, controls.NOTE_RIGHT_R];
			if(controlArray.contains(true))
			{
				for (i in 0...controlArray.length)
				{
					if(controlArray[i])
						onKeyRelease(new KeyboardEvent(KeyboardEvent.KEY_UP, true, true, -1, keysArray[i][0]));
				}
			}
		}
	}

	var combo:Int = 0;
	function goodNoteHit(note:Note):Void
	{
		if (!note.wasGoodHit)
		{
			switch(note.noteType) {
				case 'Hurt Note': //Hurt note
					noteMiss();
					--songMisses;

					note.wasGoodHit = true;
					vocals.volume = 0;

					if (!note.isSustainNote)
					{
						note.kill();
						notes.remove(note, true);
						note.destroy();
					}
					return;
			}

			if (!note.isSustainNote)
			{
				combo += 1;
				if(combo > 9999) combo = 9999;
				popUpScore(note);
				songHits++;
			}

			playerStrums.forEach(function(spr:StrumNote)
			{
				if (Math.abs(note.noteData) == spr.ID)
				{
					spr.playAnim('confirm', true);
				}
			});

			note.wasGoodHit = true;
			vocals.volume = 1;

			playerStrums.members[note.noteData].rgbShader.r = note.rgbShader.r;
			playerStrums.members[note.noteData].rgbShader.b = note.rgbShader.b;

			if (!note.isSustainNote)
			{
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		}
	}

	function noteMiss():Void
	{
		combo = 0;

		//songScore -= 10;
		songMisses++;

		// FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
		vocals.volume = 0;
	}

	var COMBO_X:Float = 400;
	var COMBO_Y:Float = 340;
	private function popUpScore(note:Note = null):Void
	{
		var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);

		vocals.volume = 1;

		var placement:String = Std.string(combo);

		var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
		coolText.x = COMBO_X;
		coolText.y = COMBO_Y;
		//

		var rating:FlxSprite = new FlxSprite();
		//var score:Int = 350;

		var daRating:String = "marvelous";

		if (noteDiff > Conductor.safeZoneOffset * 0.8)
		{
			daRating = 'shit';
			//score = 50;
		}
		else if (noteDiff > Conductor.safeZoneOffset * 0.6)
		{
			daRating = 'bad';
			//score = 100;
		}
		else if (noteDiff > Conductor.safeZoneOffset * 0.4)
		{
			daRating = 'good';
			//score = 200;
		}
		else if (noteDiff > Conductor.safeZoneOffset * 0.2)
		{
			daRating = 'sick';
			//score = 200;
		}

		//songScore += score;

		/* if (combo > 60)
				daRating = 'sick';
			else if (combo > 12)
				daRating = 'good'
			else if (combo > 4)
				daRating = 'bad';
			*/

		var pixelShitPart1:String = "";
		var pixelShitPart2:String = '';

		if (PlayState.isPixelStage)
		{
			pixelShitPart1 = 'pixelUI/';
			pixelShitPart2 = '-pixel';
		}

		rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
		rating.screenCenter();
		rating.x = coolText.x - 40;
		rating.y -= 60;
		rating.acceleration.y = 550;
		rating.velocity.y -= FlxG.random.int(140, 175);
		rating.velocity.x -= FlxG.random.int(0, 10);
		rating.visible = !ClientPrefs.hideHud;
		rating.x += ClientPrefs.comboOffset[0];
		rating.y -= ClientPrefs.comboOffset[1];

		var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
		comboSpr.screenCenter();
		comboSpr.x = coolText.x;
		comboSpr.acceleration.y = 600;
		comboSpr.velocity.y -= 150;
		comboSpr.visible = !ClientPrefs.hideHud;
		comboSpr.x += ClientPrefs.comboOffset[0];
		comboSpr.y -= ClientPrefs.comboOffset[1];

		comboSpr.velocity.x += FlxG.random.int(1, 10);
		comboGroup.add(rating);

		if (!PlayState.isPixelStage)
		{
			rating.setGraphicSize(Std.int(rating.width * 0.7));
			rating.antialiasing = ClientPrefs.globalAntialiasing;
			comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
			comboSpr.antialiasing = ClientPrefs.globalAntialiasing;
		}
		else
		{
			rating.setGraphicSize(Std.int(rating.width * PlayState.daPixelZoom * 0.85));
			comboSpr.setGraphicSize(Std.int(comboSpr.width * PlayState.daPixelZoom * 0.85));
		}

		comboSpr.updateHitbox();
		rating.updateHitbox();

		var seperatedScore:Array<Int> = [];

		if(combo >= 1000) {
			seperatedScore.push(Math.floor(combo / 1000) % 10);
		}
		seperatedScore.push(Math.floor(combo / 100) % 10);
		seperatedScore.push(Math.floor(combo / 10) % 10);
		seperatedScore.push(combo % 10);

		var daLoop:Int = 0;
		for (i in seperatedScore)
		{
			var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
			numScore.screenCenter();
			numScore.x = coolText.x + (43 * daLoop) - 90;
			numScore.y += 80;

			numScore.x += ClientPrefs.comboOffset[2];
			numScore.y -= ClientPrefs.comboOffset[3];

			if (!PlayState.isPixelStage)
			{
				numScore.antialiasing = ClientPrefs.globalAntialiasing;
				numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			}
			else
			{
				numScore.setGraphicSize(Std.int(numScore.width * PlayState.daPixelZoom));
			}
			numScore.updateHitbox();

			numScore.acceleration.y = FlxG.random.int(200, 300);
			numScore.velocity.y -= FlxG.random.int(140, 160);
			numScore.velocity.x = FlxG.random.float(-5, 5);
			numScore.visible = !ClientPrefs.hideHud;

			insert(members.indexOf(strumLineNotes), numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					numScore.destroy();
				},
				startDelay: Conductor.crochet * 0.002
			});

			daLoop++;
		}
		/* 
			trace(combo);
			trace(seperatedScore);
			*/

		coolText.text = Std.string(seperatedScore);
		// comboGroup.add(coolText);

		FlxTween.tween(rating, {alpha: 0}, 0.2, {
			startDelay: Conductor.crochet * 0.001
		});

		FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
			onComplete: function(tween:FlxTween)
			{
				coolText.destroy();
				comboSpr.destroy();

				rating.destroy();
			},
			startDelay: Conductor.crochet * 0.001
		});
	}

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var targetAlpha:Float = 1;
			if (player < 1)
			{
				if(!ClientPrefs.opponentStrums) targetAlpha = 0;
				else if(ClientPrefs.middleScroll && !PlayState.forceRightScroll || PlayState.forceMiddleScroll) targetAlpha = 0.35;
			}

			var babyArrow:StrumNote = new StrumNote(!PlayState.forcedAScroll ? (ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) : 
																				(if (PlayState.forceRightScroll && !PlayState.forceMiddleScroll) PlayState.STRUM_X 
																				else if (PlayState.forceMiddleScroll && !PlayState.forceRightScroll) PlayState.STRUM_X_MIDDLESCROLL 
																				else ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X)
				, strumLine.y, i, player);
			babyArrow.alpha = targetAlpha;

			if (player == 1)
			{
				playerStrums.add(babyArrow);
			}
			else
			{
				if(ClientPrefs.middleScroll && !PlayState.forceRightScroll || PlayState.forceMiddleScroll)
				{
					babyArrow.x += 310;
					if(i > 1) { //Up and Right
						babyArrow.x += FlxG.width / 2 + 25;
					}
				}
				opponentStrums.add(babyArrow);
			}

			strumLineNotes.add(babyArrow);
			babyArrow.postAddedToGroup();
		}
	}


	// For Opponent's notes glow
	function StrumPlayAnim(isDad:Bool, id:Int, time:Float) {
		var spr:StrumNote = null;
		if(isDad) {
			spr = strumLineNotes.members[id];
		} else {
			spr = playerStrums.members[id];
		}

		if(spr != null) {
			spr.playAnim('confirm', true);
			spr.resetAnim = time;
		}
	}

	override function destroy() {
		for (lua in luaArray) {
			lua.call('onDestroy', []);
			lua.stop();
		}
		luaArray = [];
		FlxG.sound.music.stop();
		vocals.stop();
		vocals.destroy();

		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		super.destroy();
	}

	public function setOnLuas(variable:String, arg:Dynamic) {
		#if LUA_ALLOWED
		for (i in 0...luaArray.length) {
			luaArray[i].set(variable, arg);
		}
		#end
	}

	public function callOnLuas(event:String, args:Array<Dynamic>, ignoreStops = true, exclusions:Array<String> = null):Dynamic {
		var returnVal:Dynamic = EditorLua.Function_Continue;
		#if LUA_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in luaArray) {
			if(exclusions.contains(script.scriptName))
				continue;

			var ret:Dynamic = script.call(event, args);
			if(ret == EditorLua.Function_Stop && !ignoreStops)
				break;
			
			// had to do this because there is a bug in haxe where Stop != Continue doesnt work
			var bool:Bool = ret == EditorLua.Function_Continue;
			if(!bool && ret != 0) {
				returnVal = cast ret;
			}
		}
		#end
		//trace(event, returnVal);
		return returnVal;
	}
}