package editors;

#if desktop
import Discord.DiscordClient;
#end
import openfl.geom.Rectangle;
import haxe.Json;
import haxe.format.JsonParser;
import haxe.io.Bytes;
import Conductor.BPMChangeEvent;
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUISlider;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import lime.media.AudioBuffer;
import lime.utils.Assets;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.media.Sound;
import openfl.net.FileReference;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.ByteArray;

import flixel.util.FlxTimer;
import openfl.system.System;
import openfl.Lib;

import haxe.ui.Toolkit;

import haxe.ui.containers.HBox;
import haxe.ui.containers.ContinuousHBox;
import haxe.ui.containers.TabView;
import haxe.ui.containers.VBox;
import haxe.ui.containers.Grid;

import haxe.ui.components.CheckBox;
import haxe.ui.components.Button;
import haxe.ui.components.Label;
import haxe.ui.components.NumberStepper;
import haxe.ui.components.TextField;
import haxe.ui.components.DropDown;
import haxe.ui.components.HorizontalSlider;

import haxe.ui.events.MouseEvent;

import haxe.ui.data.ArrayDataSource;

import haxe.ui.focus.FocusManager;

import haxe.ui.containers.windows.Window;

using StringTools;
#if sys
import openfl.media.Sound;
import sys.FileSystem;
import sys.io.File;
#end
import flixel.util.FlxStringUtil;


@:access(flixel.sound.FlxSound._sound)
@:access(openfl.media.Sound.__buffer)

class ChartingState extends MusicBeatState
{
	private var songStarted:Bool = false;
	public static var noteTypeList:Array<String> = //Used for backwards compatibility with 0.1 - 0.3.2 charts, though, you should add your hardcoded custom note types here too.
	[
		'',
		'Alt Animation',
		'Hey!',
		'Hurt Note',
		'HurtAgressive',
		'Mimic Note',
		'Invisible Hurt Note',
		'Instakill Note',
		'Mine Note',
		'HD Note',
		'Love Note',
		'Fire Note',
		'True Love Note',
		'GF Sing',
		'No Animation',
		'RollNote',
		'EndHit'
	];
	var curNoteTypes:Array<String> = [];

	public var ignoreWarnings = false;
	var undos = [];
	var redos = [];
	var eventStuff:Array<Dynamic> =
	[
		['', "Nothing. Yep, that's right."],
		['Dadbattle Spotlight', "Used in Dad Battle,\nValue 1: 0/1 = ON/OFF,\n2 = Target Dad\n3 = Target BF"],
		['Hey!', "Plays the \"Hey!\" animation from Bopeebo,\nValue 1: BF = Only Boyfriend, GF = Only Girlfriend,\nSomething else = Both.\nValue 2: Custom animation duration,\nleave it blank for 0.6s"],
		['Set GF Speed', "Sets GF head bopping speed,\nValue 1: 1 = Normal speed,\n2 = 1/2 speed, 4 = 1/4 speed etc.\nUsed on Fresh during the beatbox parts.\n\nWarning: Value must be integer!"],
		['Philly Glow', "Exclusive to Week 3\nValue 1: 0/1/2 = OFF/ON/Reset Gradient\n \nNo, i won't add it to other weeks."],
		['Kill Henchmen', "For Mom's songs, don't use this please, i love them :("],
		['Add Camera Zoom', "Used on MILF on that one \"hard\" part\nValue 1: Camera zoom add (Default: 0.015)\nValue 2: UI zoom add (Default: 0.03)\nLeave the values blank if you want to use Default."],
		['BG Freaks Expression', "Should be used only in \"school\" Stage!"],
		['Trigger BG Ghouls', "Should be used only in \"schoolEvil\" Stage!"],
		['Play Animation', "Plays an animation on a Character,\nonce the animation is completed,\nthe animation changes to Idle\n\nValue 1: Animation to play.\nValue 2: Character (Dad, BF, GF)"],
		['Camera Follow Pos', "Value 1: X\nValue 2: Y\n\nThe camera won't change the follow point\nafter using this, for getting it back\nto normal, leave both values blank."],
		['Alt Idle Animation', "Sets a specified suffix after the idle animation name.\nYou can use this to trigger 'idle-alt' if you set\nValue 2 to -alt\n\nValue 1: Character to set (Dad, BF or GF)\nValue 2: New suffix (Leave it blank to disable)"],
		['Screen Shake', "Value 1: Camera shake\nValue 2: HUD shake\n\nEvery value works as the following example: \"1, 0.05\".\nThe first number (1) is the duration.\nThe second number (0.05) is the intensity."],
		['Change Character', "Value 1: Character to change (Dad, BF, GF)\nValue 2: New character's name"],
		['Change Scroll Speed', "Value 1: Scroll Speed Multiplier (1 is default)\nValue 2: Time it takes to change fully in seconds."],
		['Set Property', "Value 1: Variable name\nValue 2: New value"],
		['ModchartEffects', "Value 1: Modchart variable\n0 = no effects\n1 = side to side movement\n2 = camera angle rotate\n3 = left to right simple move\n4 = copy note spin shit from qt mod (secret shit for her song lmao)\n8 = disable cam rotate effects lol"],
		['AllowHealthDrain', "Value 1: \ntrue to enable\nfalse to disable\nONLY WORKS FOR NON EDWHAK SONGS! (since Ed drains auto lmao)"],
		['Controls Player 2', "Value1: if enable Enables Player 2 shits lmao\ndisable to disable"],
		['Set Check Point', "Value 1: (Optional) Set Time Of The Check Point."]
	];

	var _file:FileReference;

	var UI_box:FlxUITabMenu;
	var UI_box2:FlxUITabMenu;

	public static var goToPlayState:Bool = false;
	/**
	 * Array of notes showing when each section STARTS in STEPS
	 * Usually rounded up??
	 */
	public static var curSec:Int = 0;
	public static var lastSection:Int = 0;
	private static var lastSong:String = '';

	var fuckingCheater:Bool = false;

	var bpmTxt:FlxText;

	var camPos:FlxObject;
	var strumLine:FlxSprite;
	var quant:AttachedSprite;
	var strumLineNotes:FlxTypedGroup<StrumNote>;
	var curSong:String = 'Test';
	var amountSteps:Int = 0;
	var bullshitUI:FlxGroup;

	var highlight:FlxSprite;

	public static var GRID_SIZE:Int = 40;
	var CAM_OFFSET:Int = 360;

	var dummyArrow:FlxSprite;

	var curRenderedSustains:FlxTypedGroup<FlxSprite>;
	var curRenderedNotes:FlxTypedGroup<Note>;
	var curRenderedNoteType:FlxTypedGroup<FlxText>;

	var nextRenderedSustains:FlxTypedGroup<FlxSprite>;
	var nextRenderedNotes:FlxTypedGroup<Note>;

	var gridBG:FlxSprite;
	var nextGridBG:FlxSprite;

	var daquantspot = 0;
	var curEventSelected:Int = 0;
	var curUndoIndex = 0;
	var curRedoIndex = 0;
	var _song:SwagSong;
	/*
	 * WILL BE THE CURRENT / LAST PLACED NOTE
	**/
	var curSelectedNote:Array<Dynamic> = null;

	var tempBpm:Float = 0;
	var playbackSpeed:Float = 1;

	var vocals:FlxSound = null;

	var leftIcon:HealthIcon;
	var rightIcon:HealthIcon;

	var value1InputText:TextField;
	var value2InputText:TextField;
	var currentSongName:String;

	var zoomTxt:FlxText;

	var zoomList:Array<Float> = [
		0.25,
		0.5,
		1,
		2,
		3,
		4,
		6,
		8,
		12,
		16,
		24
	];
	var curZoom:Int = 2;

	var waveformSprite:FlxSprite;
	var gridLayer:FlxTypedGroup<FlxSprite>;

	public static var quantization:Int = 16;
	public static var curQuant = 3;

	public var quantizations:Array<Int> = [
		4,
		8,
		12,
		16,
		20,
		24,
		32,
		48,
		64,
		96,
		192
	];



	var text:String = "";
	public static var vortex:Bool = false;
	public var mouseQuant:Bool = false;

	var hitmansSongs:Array<String> = ['c18h27no3-demo', 'forgotten', 'icebeat', 'hernameis', 'duality', 'hallucination', 'operating']; // Anti cheat system goes brrrrr
	var saveOldSectionOrTime:Int = 0;

	var ui:TabView;
    var box:ContinuousHBox;
    var box2:ContinuousHBox;
    var box3:ContinuousHBox;
    var box4:HBox;
    var box5:ContinuousHBox;
    var box6:ContinuousHBox;

	var textBlockers:Array<TextField> = [];
	var scrollBlockers:Array<DropDown> = [];
	var stepperBlockers:Array<NumberStepper> = [];

	override function create()
	{
		ui = new TabView();
		ui.text = "huh";
		ui.draggable = false;
		ui.x = 800;
		ui.y = 50;
		ui.height = 600;
		ui.width = 400;

        addTabs();

		if (PlayState.SONG != null)
			_song = PlayState.SONG;
		else
		{
			CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

			_song = {
				song: 'Test',
				notes: [],
				events: [],
				bpm: 150.0,
				needsVoices: true,
				arrowSkin: '',
				player1: 'player',
				player2: 'enemy',
				gfVersion: 'nogf',
				speed: 1,
				stage: 'stage',
				validScore: false,
				bossFight: false,
				notITG: false,
				rightScroll: false,
				middleScroll: false
			};
			addSection();
			PlayState.SONG = _song;
		}

		// Paths.clearMemory();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Chart Editor", StringTools.replace(_song.song, '-', ' '));
		#end

		vortex = FlxG.save.data.chart_vortex;
		ignoreWarnings = FlxG.save.data.ignoreWarnings;
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set();
		bg.color = 0xFF000000;
		add(bg);

		gridLayer = new FlxTypedGroup<FlxSprite>();
		add(gridLayer);

		waveformSprite = new FlxSprite(GRID_SIZE, 0).makeGraphic(FlxG.width, FlxG.height, 0x00FFFFFF);
		add(waveformSprite);

		var eventIcon:FlxSprite = new FlxSprite(-GRID_SIZE - 5, -90).loadGraphic(Paths.image('eventArrow'));
		leftIcon = new HealthIcon('bf');
		rightIcon = new HealthIcon('dad');
		eventIcon.scrollFactor.set(1, 1);
		leftIcon.scrollFactor.set(1, 1);
		rightIcon.scrollFactor.set(1, 1);

		eventIcon.setGraphicSize(30, 30);
		leftIcon.setGraphicSize(0, 45);
		rightIcon.setGraphicSize(0, 45);

		add(eventIcon);
		add(leftIcon);
		add(rightIcon);

		leftIcon.setPosition(GRID_SIZE + 10, -100);
		rightIcon.setPosition(GRID_SIZE * 5.2, -100);

		curRenderedSustains = new FlxTypedGroup<FlxSprite>();
		curRenderedNotes = new FlxTypedGroup<Note>();
		curRenderedNoteType = new FlxTypedGroup<FlxText>();

		nextRenderedSustains = new FlxTypedGroup<FlxSprite>();
		nextRenderedNotes = new FlxTypedGroup<Note>();

		if(curSec >= _song.notes.length) curSec = _song.notes.length - 1;

		//FlxG.save.bind('funkin', 'ninjamuffin99');

		tempBpm = _song.bpm;

		addSection();

		// sections = _song.notes;

		currentSongName = Paths.formatToSongPath(_song.song);
		loadSong();
		reloadGridLayer();
		Conductor.bpm = _song.bpm;
		Conductor.mapBPMChanges(_song);

		bpmTxt = new FlxText(10, 50, 0, "", 16);
		bpmTxt.scrollFactor.set();
		add(bpmTxt);

		strumLine = new FlxSprite(0, 50).makeGraphic(Std.int(GRID_SIZE * 9), 4);
		add(strumLine);

		quant = new AttachedSprite('chart_quant','chart_quant');
		quant.animation.addByPrefix('q','chart_quant',0,false);
		quant.animation.play('q', true, false, 0);
		quant.sprTracker = strumLine;
		quant.xAdd = -32;
		quant.yAdd = 8;
		add(quant);

		strumLineNotes = new FlxTypedGroup<StrumNote>();
		for (i in 0...8){
			var note:StrumNote = new StrumNote(GRID_SIZE * (i+1), strumLine.y, i % 4, 0);
			note.setGraphicSize(GRID_SIZE, GRID_SIZE);
			note.updateHitbox();
			note.playAnim('static', true);
			strumLineNotes.add(note);
			note.scrollFactor.set(1, 1);
		}
		add(strumLineNotes);

		camPos = new FlxObject(0, 0, 1, 1);
		camPos.setPosition(strumLine.x + CAM_OFFSET, strumLine.y);

		dummyArrow = new FlxSprite().makeGraphic(GRID_SIZE, GRID_SIZE);
		add(dummyArrow);
		//UI_box.selected_tab = 4;

		addSongAssetsAndOptionsUI();
		addNoteUI();
		addSectionUI();
		addSongUI();
		addEventsUI();
		addChartingUI();

		add(curRenderedSustains);
		add(curRenderedNotes);
		add(curRenderedNoteType);
		add(nextRenderedSustains);
		add(nextRenderedNotes);

		if(lastSong != currentSongName) {
			changeSection();
		}
		lastSong = currentSongName;

		if (curSection != saveOldSectionOrTime)
			changeSection(saveOldSectionOrTime);

		zoomTxt = new FlxText(10, 10, 0, "Zoom: 1 / 1", 16);
		zoomTxt.scrollFactor.set();
		add(zoomTxt);

		updateGrid();

		add(ui);
		super.create();
	}

	inline function addTabs()
	{
		box = new ContinuousHBox();
		box.padding = 5;
		box.width = 300;
		box.text = "Song Assets & Options";

		box2 = new ContinuousHBox();
		box2.width = 300;
		box2.padding = 5;
		box2.text = "Note";

		box3 = new ContinuousHBox();
		box3.width = 300;
		box3.padding = 5;
		box3.text = "Section";

		box4 = new HBox();
		box4.width = 300;
		box4.padding = 5;
		box4.text = "Events";
		box4.color = 0xFFD7BF7D;

		box5 = new ContinuousHBox();
		box5.width = 300;
		box5.padding = 5;
		box5.text = "Chart Settings";
		box5.color = 0xFFFF0000;

		box6 = new ContinuousHBox();
		box6.width = 300;
		box6.padding = 5;
		box6.text = "Data";
		box6.color = 0xFF8C8F88;

		// ignore

		ui.addComponent(box);
		ui.addComponent(box2);
		ui.addComponent(box3);
		ui.addComponent(box4);
		ui.addComponent(box5);
		ui.addComponent(box6);
	}

	var stageDropDown:DropDown;
	var notITGModchart:CheckBox = null;
	var difficultyDropDown:DropDown;
	//var usingHUD:CheckBox = null;

	/*var gameOverCharacterInputText:TextField;
	var gameOverSoundInputText:TextField;
	var gameOverLoopInputText:TextField;
	var gameOverEndInputText:TextField;*/
	var noteSkinInputText:TextField;
	//var noteSplashesInputText:TextField;
	inline function addSongAssetsAndOptionsUI()
	{
		var vbox1:VBox = new VBox();
		var vbox2:VBox = new VBox();
		var grid = new Grid();

		var startHere:Button = new Button();
		startHere.text = 'Start Here';
		startHere.onClick = function(e)
		{
			PlayState.timeToStart = Conductor.songPosition;
			startSong();
		}

		/*//Game Over Stuff
		gameOverCharacterInputText = new TextField();
		gameOverCharacterInputText.text = _song.gameOverChar != null ? _song.gameOverChar : '';
		gameOverCharacterInputText.onChange = function(e)
		{
			_song.gameOverChar = gameOverCharacterInputText.text;
			
		}

		var gameOverCharLabel:Label = new Label();
		gameOverCharLabel.text = "Game Over Character Name:";
		gameOverCharLabel.verticalAlign = "center";

		gameOverSoundInputText = new TextField();
		gameOverSoundInputText.text = _song.gameOverSound != null ? _song.gameOverSound : '';
		gameOverSoundInputText.onChange = function(e)
		{
			_song.gameOverSound = gameOverSoundInputText.text;
			
		}

		var gameOverDeathSLabel:Label = new Label();
		gameOverDeathSLabel.text = "Game Over Death Sound: (sounds/)";
		gameOverDeathSLabel.verticalAlign = "center";

		gameOverLoopInputText = new TextField();
		gameOverLoopInputText.text = _song.gameOverLoop != null ? _song.gameOverLoop : '';
		gameOverLoopInputText.onChange = function(e)
		{
			_song.gameOverLoop = gameOverLoopInputText.text;
			
		}

		var gameOverDeathLLabel:Label = new Label();
		gameOverDeathLLabel.text = "Game Over Loop Music: (music/)";
		gameOverDeathLLabel.verticalAlign = "center";

		gameOverEndInputText = new TextField();
		gameOverEndInputText.text = _song.gameOverEnd != null ? _song.gameOverEnd : '';
		gameOverEndInputText.onChange = function(e)
		{
			_song.gameOverEnd = gameOverEndInputText.text;
			
		}

		var gameOverDeathELabel:Label = new Label();
		gameOverDeathELabel.text = "Game Over Retry Music: (music/)";
		gameOverDeathELabel.verticalAlign = "center";*/

		#if MODS_ALLOWED
		var directories:Array<String> = [Paths.mods('characters/'), Paths.mods(Mods.currentModDirectory + '/characters/'), Paths.getPreloadPath('characters/')];
		for(mod in Mods.getGlobalMods())
			directories.push(Paths.mods(mod + '/characters/'));
		#else
		var directories:Array<String> = [Paths.getPreloadPath('characters/')];
		#end

		var tempArray:Array<String> = [];
		var characters:Array<String> = Mods.mergeAllTextsNamed('data/characterList.txt');
		for (character in characters)
		{
			if(character.trim().length > 0)
				tempArray.push(character);
		}

		#if MODS_ALLOWED
		for (i in 0...directories.length) {
			var directory:String = directories[i];
			if(FileSystem.exists(directory)) {
				for (file in FileSystem.readDirectory(directory)) {
					var path = haxe.io.Path.join([directory, file]);
					if (!FileSystem.isDirectory(path) && file.endsWith('.json')) {
						var charToCheck:String = file.substr(0, file.length - 5);
						if(charToCheck.trim().length > 0 && !charToCheck.endsWith('-dead') && !tempArray.contains(charToCheck)) {
							tempArray.push(charToCheck);
							characters.push(charToCheck);
						}
					}
				}
			}
		}
		#end
		tempArray = [];

		var charactersList = new ArrayDataSource<Dynamic>();
		for (name in 0...characters.length)
		{
			charactersList.add(characters[name]);
		}

		var player1DropDown = new DropDown();
		player1DropDown.text = "";
		player1DropDown.width = 130;
		player1DropDown.dataSource = charactersList;
		player1DropDown.selectedIndex = 0;
		player1DropDown.onChange = function(e)
		{
			_song.player1 = characters[player1DropDown.selectedIndex];
			updateHeads();
		}
		player1DropDown.selectedItem = _song.player1;

		var player1Label:Label = new Label();
		player1Label.text = "Boyfriend: ";
		player1Label.verticalAlign = "center";

		var gfVersionDropDown = new DropDown();
		gfVersionDropDown.text = "";
		gfVersionDropDown.width = 130;
		gfVersionDropDown.dataSource = charactersList;
		gfVersionDropDown.selectedIndex = 0;
		gfVersionDropDown.onChange = function(e)
		{
			_song.gfVersion = characters[gfVersionDropDown.selectedIndex];
			updateHeads();
		}
		gfVersionDropDown.selectedItem = _song.gfVersion;

		var gfVersionLabel:Label = new Label();
		gfVersionLabel.text = "Girlfriend: ";
		gfVersionLabel.verticalAlign = "center";

		var player2DropDown = new DropDown();
		player2DropDown.text = "";
		player2DropDown.width = 130;
		player2DropDown.dataSource = charactersList;
		player2DropDown.selectedIndex = 0;
		player2DropDown.onChange = function(e)
		{
			_song.player2 = characters[player2DropDown.selectedIndex];
			updateHeads();	
		}
		player2DropDown.selectedItem = _song.player2;

		var player2Label:Label = new Label();
		player2Label.text = "Opponent: ";
		player2Label.verticalAlign = "center";

		var player4DropDown = new DropDown();
		player4DropDown.text = "";
		player4DropDown.width = 130;
		player4DropDown.dataSource = charactersList;
		player4DropDown.selectedIndex = 0;
		player4DropDown.onChange = function(e)
		{
			_song.player1 = characters[player4DropDown.selectedIndex];
			updateHeads();
		}
		player4DropDown.selectedItem = _song.player1;

		var player4Label:Label = new Label();
		player4Label.text = "An Extra Opponent or Player: ";
		player4Label.verticalAlign = "center";

		#if MODS_ALLOWED
		var directories:Array<String> = [Paths.mods('stages/'), Paths.mods(Mods.currentModDirectory + '/stages/'), Paths.getPreloadPath('stages/')];
		for(mod in Mods.getGlobalMods())
			directories.push(Paths.mods(mod + '/stages/'));
		#else
		var directories:Array<String> = [Paths.getPreloadPath('stages/')];
		#end

		var stageFile:Array<String> = Mods.mergeAllTextsNamed('data/stageList.txt');
		var stages:Array<String> = [];
		for (stage in stageFile) {
			if(stage.trim().length > 0) {
				stages.push(stage);
			}
			tempArray.push(stage);
		}
		#if MODS_ALLOWED
		for (i in 0...directories.length) {
			var directory:String = directories[i];
			if(FileSystem.exists(directory)) {
				for (file in FileSystem.readDirectory(directory)) {
					var path = haxe.io.Path.join([directory, file]);
					if (!FileSystem.isDirectory(path) && file.endsWith('.json')) {
						var stageToCheck:String = file.substr(0, file.length - 5);
						if(stageToCheck.trim().length > 0 && !tempArray.contains(stageToCheck)) {
							tempArray.push(stageToCheck);
							stages.push(stageToCheck);
						}
					}
				}
			}
		}
		#end

		if(stages.length < 1) stages.push('stage');

		var stagesList = new ArrayDataSource<Dynamic>();
		for (stage in 0...stages.length)
		{
			stagesList.add(stages[stage]);
		}

		stageDropDown = new DropDown();
		stageDropDown.text = "";
		stageDropDown.width = 120;
		stageDropDown.dataSource = stagesList;
		stageDropDown.selectedIndex = 0;
		stageDropDown.onChange = function(e)
		{
			_song.stage = stages[stageDropDown.selectedIndex];
			
		}
		stageDropDown.selectedItem = _song.stage;

		var stageLabel:Label = new Label();
		stageLabel.text = "Stage: ";
		stageLabel.verticalAlign = "center";

		// Checks if all difficulties json files exists and removes difficulties that dont have a json file.
		var availableDifficulties:Array<Int> = [];
		var availableDifficultiesTexts:Array<String> = [];

		for(i in 0...CoolUtil.difficulties.length){
			var jsonInput:String;
			if(CoolUtil.difficulties[i].toLowerCase() == 'normal') jsonInput = _song.song.toLowerCase();
			else jsonInput = _song.song.toLowerCase() + "-" + CoolUtil.difficulties[i];

			var folder:String = _song.song.toLowerCase();
			var formattedFolder:String = Paths.formatToSongPath(folder);
			var formattedSong:String = Paths.formatToSongPath(jsonInput);

			var pathExists:Bool = Paths.fileExists('data/' + formattedFolder + '/' + formattedSong + '.json', BINARY);
			if(pathExists == true){
				availableDifficulties.push(i);
				availableDifficultiesTexts.push(CoolUtil.difficulties[i]);
			}
		}

		if(availableDifficulties == null || availableDifficulties.length <= 0){
			trace('Where are the difficulties...?');
			availableDifficulties.push(PlayState.storyDifficulty);
			availableDifficultiesTexts.push(CoolUtil.difficulties[0]);
		}

		var difficultiesList = new ArrayDataSource<Dynamic>();
		for (difficulty in 0...availableDifficultiesTexts.length)
		{
			difficultiesList.add(availableDifficultiesTexts[difficulty]);
		}

		difficultyDropDown = new DropDown();
		difficultyDropDown.text = "";
		difficultyDropDown.dataSource = difficultiesList;
		difficultyDropDown.selectedIndex = 0;
		difficultyDropDown.onChange = function(e)
		{
			var curSelected:Int = difficultyDropDown.selectedIndex;
			openSubState(new Prompt('This action will clear current progress.\n\nProceed?', 0, function(){
				PlayState.storyDifficulty = availableDifficulties[curSelected];
				PlayState.changedDifficulty = true;
				loadJson(_song.song.toLowerCase());
			}, null,ignoreWarnings));
		}
		difficultyDropDown.selectedItem = CoolUtil.difficulties[PlayState.storyDifficulty];

		var difficultyLabel:Label = new Label();
		difficultyLabel.text = "Difficulty: ";
		difficultyLabel.verticalAlign = "center";

		var check_disableNoteRGB:CheckBox = new CheckBox();
		check_disableNoteRGB.text = "Disable Note RGB";
		check_disableNoteRGB.selected = (_song.disableNoteRGB == true);
		check_disableNoteRGB.onClick = function(e)
		{
			_song.disableNoteRGB = check_disableNoteRGB.selected;
			
			updateGrid();
			//Debug.logTrace('CHECKED!');
		}

		noteSkinInputText = new TextField();
		noteSkinInputText.text = _song.arrowSkin != null ? _song.arrowSkin : '';

		var noteSkinLabel:Label = new Label();
		noteSkinLabel.text = "Note Skin: ";
		noteSkinLabel.verticalAlign = "center";

		var reloadNotesButton:Button = new Button();
		reloadNotesButton.text = 'Change Notes';
		reloadNotesButton.onClick = function(e) 
		{
			_song.arrowSkin = noteSkinInputText.text;
			
			updateGrid();
		}

		var notITGModchart = new CheckBox(); 
		notITGModchart.text = "NotITG modcharts";
		notITGModchart.selected = _song.notITG;
		notITGModchart.onClick = function(e)
		{
			_song.notITG = notITGModchart.selected;
			
			//Debug.logInfo('CHECKED!');
		}

		var forceRightScroll = new CheckBox();
		forceRightScroll.text = "Forced RightScroll";
		forceRightScroll.selected = _song.rightScroll;
		forceRightScroll.onClick = function(e)
		{
			_song.rightScroll = forceRightScroll.selected;
			
		}

		var forceMiddleScroll = new CheckBox(); 
		forceMiddleScroll.text = "Forced MiddleScroll";
		forceMiddleScroll.selected = _song.middleScroll;
		forceMiddleScroll.onClick = function(e)
		{
			_song.middleScroll = forceMiddleScroll.selected;
			
		}

		//Blockers
        var textNeedsBlock:Array<TextField> = [
			//gameOverCharacterInputText, gameOverSoundInputText, gameOverLoopInputText, gameOverEndInputText, 
			noteSkinInputText/*, noteSplashesInputText*/
		];
        for (blockedText in 0...textNeedsBlock.length) textBlockers.push(textNeedsBlock[blockedText]);

        var dropDownNeedsBlock:Array<DropDown> = [
			player4DropDown, player2DropDown, gfVersionDropDown, player1DropDown, 
			difficultyDropDown, stageDropDown
		];
        for (blockedMenu in 0...dropDownNeedsBlock.length) scrollBlockers.push(dropDownNeedsBlock[blockedMenu]);

		/*vbox2.addComponent(gameOverCharLabel);
		vbox2.addComponent(gameOverCharacterInputText);
		vbox2.addComponent(gameOverDeathSLabel);
		vbox2.addComponent(gameOverSoundInputText);
		vbox2.addComponent(gameOverDeathLLabel);
		vbox2.addComponent(gameOverLoopInputText);
		vbox2.addComponent(gameOverDeathELabel);
		vbox2.addComponent(gameOverEndInputText);*/

		vbox2.addComponent(check_disableNoteRGB);

		vbox2.addComponent(forceMiddleScroll);
		vbox2.addComponent(forceRightScroll);
		vbox2.addComponent(notITGModchart);

		vbox1.addComponent(noteSkinLabel);
		vbox1.addComponent(noteSkinInputText);
		vbox1.addComponent(reloadNotesButton);
		vbox1.addComponent(player1Label);
		vbox1.addComponent(player1DropDown);
		vbox1.addComponent(gfVersionLabel);
		vbox1.addComponent(gfVersionDropDown);
		vbox1.addComponent(player2Label);
		vbox1.addComponent(player2DropDown);
		vbox1.addComponent(player4Label);
		vbox1.addComponent(player4DropDown);
		vbox1.addComponent(difficultyLabel);
		vbox1.addComponent(difficultyDropDown);
		vbox1.addComponent(stageLabel);
		vbox1.addComponent(stageDropDown);

		grid.addComponent(vbox1);
		grid.addComponent(vbox2);
		grid.addComponent(startHere);

		box.addComponent(grid);
	}

	var stepperSusLength:NumberStepper;
	var strumTimeInputText:TextField; //I wanted to use a stepper but we can't scale these as far as i know :(
	var noteTypeDropDown:DropDown;
	var currentType:Int = 0;

	inline function addNoteUI()
	{
		stepperSusLength = new NumberStepper();
		stepperSusLength.min = 0;
		stepperSusLength.max = Conductor.stepCrochet * 64;
		stepperSusLength.step = ((Conductor.stepCrochet / 2) / 10);
		stepperSusLength.pos = 0;
		stepperSusLength.precision = 2;
		stepperSusLength.onChange = function(e)
		{
			if(curSelectedNote != null && curSelectedNote[2] != null) {
				curSelectedNote[2] = stepperSusLength.pos;
				updateGrid();
			}
		}

		var lengthLabel = new Label();
		lengthLabel.text = "Sustain Length (Note 'Hold' Length)";
		lengthLabel.verticalAlign = "center";

		strumTimeInputText = new TextField();
		strumTimeInputText.text = "0";
		strumTimeInputText.onChange = function(e)
		{
			if (curSelectedNote == null) return;
			var value:Float = Std.parseFloat(strumTimeInputText.text);
			if (Math.isNaN(value)) value = 0;
			curSelectedNote[0] = value;
		}

		var timeLabel = new Label();
		timeLabel.text = "Strum Time (In MS)";
		timeLabel.verticalAlign = "center";

		var key:Int = 0;
		while (key < noteTypeList.length) {
			curNoteTypes.push(noteTypeList[key]);
			key++;
		}

		#if sys
		var foldersToCheck:Array<String> = Mods.directoriesWithFile(Paths.getPreloadPath(), 'custom_notetypes/');
		for (folder in foldersToCheck)
			for (file in FileSystem.readDirectory(folder))
			{
				var fileName:String = file.toLowerCase();
				var wordLen:Int = 4;
				if((#if LUA_ALLOWED fileName.endsWith('.lua') || #end
					#if HSCRIPT_ALLOWED  (fileName.endsWith('.hx') && (wordLen = 3) == 3) || #end
					fileName.endsWith('.txt')) && fileName != 'readme.txt')
				{
					var fileToCheck:String = file.substr(0, file.length - wordLen);
					if(!curNoteTypes.contains(fileToCheck))
					{
						curNoteTypes.push(fileToCheck);
						key++;
					}
				}
			}
		#end


		var displayNameList:Array<String> = curNoteTypes.copy();
		for (i in 1...displayNameList.length) {
			displayNameList[i] = i + '. ' + displayNameList[i];
		}

		noteTypeDropDown = new DropDown();
		noteTypeDropDown.text = "Normal";
		noteTypeDropDown.width = 340;

		var typeList = new ArrayDataSource<Dynamic>();
		for (type in 0...displayNameList.length)
		{
			typeList.add(displayNameList[type]);
		}
		noteTypeDropDown.dataSource = typeList;
		noteTypeDropDown.selectedIndex = 0;
		noteTypeDropDown.onChange = function(e)
		{
			currentType = noteTypeDropDown.selectedIndex;
			if(curSelectedNote != null && curSelectedNote[1] > -1) {
				curSelectedNote[3] = curNoteTypes[currentType];
				updateGrid();
			}
		}

		var typeLabel = new Label();
		typeLabel.text = "Note Type";
		typeLabel.verticalAlign = "center";

		//Blockers
        textBlockers.push(strumTimeInputText);
        scrollBlockers.push(noteTypeDropDown);
        stepperBlockers.push(stepperSusLength);

		box2.addComponent(stepperSusLength);
		box2.addComponent(lengthLabel);
		box2.addComponent(strumTimeInputText);
		box2.addComponent(timeLabel);
		box2.addComponent(typeLabel);
		box2.addComponent(noteTypeDropDown);
	}

	var stepperBeats:NumberStepper;
	var check_gfSection:CheckBox;
	var check_changeBPM:CheckBox;
	var check_mustHitSection:CheckBox;
	var stepperSectionBPM:NumberStepper;
	var check_altAnim:CheckBox;

	var sectionToCopy:Int = 0;
	var notesCopied:Array<Dynamic>;

	var secBox:VBox;
	var secBox2:VBox;
	var secGrid:Grid;
	var secGrid2:Grid;

	inline function addSectionUI()
	{
		secBox = new VBox();
		secBox2 = new VBox();
		secGrid = new Grid();
		secGrid2 = new Grid();

		check_mustHitSection = new CheckBox();
		check_mustHitSection.text = "Must Hit Section";
		check_mustHitSection.selected = false;
		check_mustHitSection.onClick = function(e)
		{
			_song.notes[curSec].mustHitSection = !_song.notes[curSec].mustHitSection;
			updateGrid();
			updateHeads();
		}

		check_gfSection = new CheckBox();
		check_gfSection.text = 'GF Section';
		check_gfSection.selected = _song.notes[curSec].gfSection;
		check_gfSection.onClick = function(e)
		{
			_song.notes[curSec].gfSection = !_song.notes[curSec].gfSection;
			
			updateGrid();
			updateHeads();
		}

		check_altAnim = new CheckBox();
		check_altAnim.text = 'Alt Anim Section';
		check_altAnim.selected = false;
		check_altAnim.onClick = function(e)
		{
			_song.notes[curSec].altAnim = !_song.notes[curSec].altAnim;
		}

		stepperBeats = new NumberStepper();
		stepperBeats.min = 1;
		stepperBeats.max = 8;
		stepperBeats.step = 1;
		stepperBeats.pos = getSectionBeats();
		stepperBeats.decimalSeparator = ".";
		stepperBeats.onChange = function(e)
		{
			_song.notes[curSec].sectionBeats = stepperBeats.pos;
			reloadGridLayer();
		}
		
		check_changeBPM = new CheckBox();
		check_changeBPM.text = 'Change BPM';
		check_changeBPM.selected = false;
		check_changeBPM.onClick = function(e)
		{
			_song.notes[curSec].changeBPM = !_song.notes[curSec].changeBPM;
			
		}

		stepperSectionBPM = new NumberStepper();
		stepperSectionBPM.min = 0;
		stepperSectionBPM.max = 999;
		stepperSectionBPM.precision = 3;
		stepperSectionBPM.step = 0.5;
		if(check_changeBPM.selected) {
			stepperSectionBPM.pos = _song.notes[curSec].bpm;
		} else {
			stepperSectionBPM.pos = Conductor.bpm;
		}
		stepperSectionBPM.decimalSeparator = ".";
		stepperSectionBPM.onChange = function(e)
		{
			
			_song.notes[curSec].bpm = stepperSectionBPM.pos;
			updateGrid();
		}

		var check_eventsSec:CheckBox = null;
		var check_notesSec:CheckBox = null;
		var copyButton:Button = new Button();
		copyButton.text = "Copy Section";
		copyButton.onClick = function(e)
		{
			notesCopied = [];
			sectionToCopy = curSec;
			for (i in 0..._song.notes[curSec].sectionNotes.length)
			{
				var note:Array<Dynamic> = _song.notes[curSec].sectionNotes[i];
				notesCopied.push(note);
			}

			var startThing:Float = sectionStartTime();
			var endThing:Float = sectionStartTime(1);
			for (event in _song.events)
			{
				var strumTime:Float = event[0];
				if(endThing > event[0] && event[0] >= startThing)
				{
					var copiedEventArray:Array<Dynamic> = [];
					for (i in 0...event[1].length)
					{
						var eventToPush:Array<Dynamic> = event[1][i];
						copiedEventArray.push([eventToPush[0], eventToPush[1], eventToPush[2]]);
					}
					notesCopied.push([strumTime, -1, copiedEventArray]);
				}
			}
		}

		var pasteButton:Button = new Button();
		pasteButton.text = "Paste Section";
		pasteButton.onClick = function(e)
		{
			if(notesCopied == null || notesCopied.length < 1)
			{
				return;
			}

			var addToTime:Float = Conductor.stepCrochet * (getSectionBeats() * 4 * (curSec - sectionToCopy));

			for (note in notesCopied)
			{
				var copiedNote:Array<Dynamic> = [];
				var newStrumTime:Float = note[0] + addToTime;
				if(note[1] < 0)
				{
					if(check_eventsSec.selected)
					{
						var copiedEventArray:Array<Dynamic> = [];
						for (i in 0...note[2].length)
						{
							var eventToPush:Array<Dynamic> = note[2][i];
							copiedEventArray.push([eventToPush[0], eventToPush[1], eventToPush[2]]);
						}
						_song.events.push([newStrumTime, copiedEventArray]);
					}
				}
				else
				{
					if(check_notesSec.selected)
					{
						if(note[4] != null) copiedNote = [newStrumTime, note[1], note[2], note[3], note[4]];
						else copiedNote = [newStrumTime, note[1], note[2], note[3]];

						_song.notes[curSec].sectionNotes.push(copiedNote);
					}
				}
			}
			
			updateGrid();
		}

		var clearSectionButton:Button = new Button();
		clearSectionButton.text = "Clear";
		clearSectionButton.onClick = function(e)
		{
			if(check_notesSec.selected)
			{
				_song.notes[curSec].sectionNotes = [];
			}

			if(check_eventsSec.selected)
			{
				var i:Int = _song.events.length - 1;
				var startThing:Float = sectionStartTime();
				var endThing:Float = sectionStartTime(1);
				while(i > -1) {
					var event:Array<Dynamic> = _song.events[i];
					if(event != null && endThing > event[0] && event[0] >= startThing)
					{
						_song.events.remove(event);
					}
					--i;
				}
			}
			
			updateGrid();
			updateNoteUI();
		}
		
		check_notesSec = new CheckBox();
		check_notesSec.text = "Notes";
		check_notesSec.selected = true;
		check_eventsSec = new CheckBox();
		check_eventsSec.text = "Events";
		check_eventsSec.selected = true;

		var swapSection:Button = new Button();
		swapSection.text = "Swap section";
		swapSection.onClick = function(e)
		{
			for (i in 0..._song.notes[curSec].sectionNotes.length)
			{
				var note:Array<Dynamic> = _song.notes[curSec].sectionNotes[i];
				note[1] = (note[1] + 4) % 8;
				_song.notes[curSec].sectionNotes[i] = note;
			}
			updateGrid();
			
		}

		var stepperCopy:NumberStepper = null;
		var copyLastButton:Button = new Button();
		copyLastButton.text = "Copy last section";
		copyLastButton.onClick = function(e)
		{
			var value:Int = Std.int(stepperCopy.pos);
			if(value == 0) return;

			var daSec = FlxMath.maxInt(curSec, value);

			for (note in _song.notes[daSec - value].sectionNotes)
			{
				var strum = note[0] + Conductor.stepCrochet * (getSectionBeats(daSec) * 4 * value);

				var copiedNote:Array<Dynamic> = [strum, note[1], note[2], note[3]];
				_song.notes[daSec].sectionNotes.push(copiedNote);
			}

			var startThing:Float = sectionStartTime(-value);
			var endThing:Float = sectionStartTime(-value + 1);
			for (event in _song.events)
			{
				var strumTime:Float = event[0];
				if(endThing > event[0] && event[0] >= startThing)
				{
					strumTime += Conductor.stepCrochet * (getSectionBeats(daSec) * 4 * value);
					var copiedEventArray:Array<Dynamic> = [];
					for (i in 0...event[1].length)
					{
						var eventToPush:Array<Dynamic> = event[1][i];
						copiedEventArray.push([eventToPush[0], eventToPush[1], eventToPush[2]]);
					}
					_song.events.push([strumTime, copiedEventArray]);
				}
			}
			
			updateGrid();
		}
		
		stepperCopy = new NumberStepper();
		stepperCopy.min = -999;
		stepperCopy.max = 999;
		stepperCopy.step = 1;
		stepperCopy.decimalSeparator = ".";

		var duetButton:Button = new Button();
		duetButton.text = "Duet Notes";
		duetButton.onClick = function(e)
		{
			var duetNotes:Array<Array<Dynamic>> = [];
			for (note in _song.notes[curSec].sectionNotes)
			{
				var boob = note[1];
				if (boob > 3){
					boob -= 4;
				}else{
					boob += 4;
				}

				var copiedNote:Array<Dynamic> = [note[0], boob, note[2], note[3]];
				duetNotes.push(copiedNote);
			}

			for (i in duetNotes){
			_song.notes[curSec].sectionNotes.push(i);

			}
			
			updateGrid();
		}
		var mirrorButton:Button = new Button();
		mirrorButton.text = "Mirror Notes";
		mirrorButton.onClick = function(e)
		{
			var duetNotes:Array<Array<Dynamic>> = [];
			for (note in _song.notes[curSec].sectionNotes)
			{
				var boob = note[1]%4;
				boob = 3 - boob;
				if (note[1] > 3) boob += 4;

				note[1] = boob;
				var copiedNote:Array<Dynamic> = [note[0], boob, note[2], note[3]];
			}

			for (i in duetNotes){}
			
			updateGrid();
		}

		//Blockers
        var stepperNeedsBlock:Array<NumberStepper> = [stepperBeats, stepperSectionBPM, stepperCopy];
        for (blockedStep in 0...stepperNeedsBlock.length) stepperBlockers.push(stepperNeedsBlock[blockedStep]);

		secBox.addComponent(check_mustHitSection); // really weird methods
		secBox.addComponent(check_gfSection);
		secBox.addComponent(check_altAnim);
		secBox.addComponent(stepperBeats);
		secBox.addComponent(check_changeBPM);
		secBox.addComponent(stepperSectionBPM);
		secBox.addComponent(copyButton);
		secBox.addComponent(pasteButton);
		secBox.addComponent(clearSectionButton);
		secBox.addComponent(check_notesSec);
		secBox.addComponent(check_eventsSec);
		secBox.addComponent(copyLastButton);
		secBox.addComponent(stepperCopy);
		secBox.addComponent(duetButton);
		secBox.addComponent(mirrorButton);

		secGrid.addComponent(secBox);

		box3.addComponent(secGrid);
	}

	var eventDropDown:DropDown;
	var descText:Label;
	var selectedEventText:Label;

	inline function addEventsUI()
	{
		var vbox1 = new VBox();
		var vbox2 = new VBox();
		var grid = new Grid();

		#if LUA_ALLOWED
		var eventPushedMap:Map<String, Bool> = new Map<String, Bool>();
		var directories:Array<String> = [];

		#if MODS_ALLOWED
		directories.push(Paths.mods('custom_events/'));
		directories.push(Paths.mods(Mods.currentModDirectory + '/custom_events/'));
		for(mod in Mods.getGlobalMods())
			directories.push(Paths.mods(mod + '/custom_events/'));
		#end

		for (i in 0...directories.length) {
			var directory:String =  directories[i];
			if(FileSystem.exists(directory)) {
				for (file in FileSystem.readDirectory(directory)) {
					var path = haxe.io.Path.join([directory, file]);
					if (!FileSystem.isDirectory(path) && file != 'readme.txt' && file.endsWith('.txt')) {
						var fileToCheck:String = file.substr(0, file.length - 4);
						if(!eventPushedMap.exists(fileToCheck)) {
							eventPushedMap.set(fileToCheck, true);
							eventStuff.push([fileToCheck, File.getContent(path)]);
						}
					}
				}
			}
		}
		eventPushedMap.clear();
		eventPushedMap = null;
		#end

		descText = new Label();
		descText.text = eventStuff[0][0];
		descText.verticalAlign = "center";

		var leEvents:Array<String> = [];
		for (i in 0...eventStuff.length) {
			leEvents.push(eventStuff[i][0]);
		}

		var eventName:Label = new Label();
		eventName.text = "Event:";
		eventName.verticalAlign = "center";

		eventDropDown = new DropDown();
		eventDropDown.text = "";
		eventDropDown.width = 170;
		eventDropDown.selectedIndex = 0;

		var eventList = new ArrayDataSource<Dynamic>();
		for (event in 0...leEvents.length)
		{
			eventList.add(leEvents[event]);
		}
		eventDropDown.dataSource = eventList;
		eventDropDown.selectedIndex = 0;
		eventDropDown.onChange = function(e)
		{
			var selectedEvent:Int = eventDropDown.selectedIndex;
			descText.text = eventStuff[selectedEvent][1];
			if (curSelectedNote != null &&  eventStuff != null) {
				if (curSelectedNote != null && curSelectedNote[2] == null){
					curSelectedNote[1][curEventSelected][0] = eventStuff[selectedEvent][0];
				}
				updateGrid();
			}
		}

		//group 1
		var event1Label:Label = new Label();
		event1Label.text = "Value 1:";
		event1Label.verticalAlign = "center";

		value1InputText = new TextField();
		value1InputText.text = "";
		value1InputText.width = 100;
		value1InputText.onChange = function(e)
		{
			if (curSelectedNote != null)
			{
				curSelectedNote[1][curEventSelected][1] = value1InputText.text;
				updateGrid();
			}
		}

		var event2Label:Label = new Label();
		event2Label.text = "Value 2:";
		event2Label.verticalAlign = "center";

		value2InputText = new TextField();
		value2InputText.text = "";
		value2InputText.width = 100;
		value2InputText.onChange = function(e)
		{
			if (curSelectedNote != null)
			{
				curSelectedNote[1][curEventSelected][2] = value2InputText.text;
				updateGrid();
			}
		}

		// New event buttons
		var removeButton:Button = new Button();
		removeButton.text = 'Remove Event'; 
		removeButton.onClick = function(e)
		{
			if(curSelectedNote != null && curSelectedNote[2] == null) //Is event note
			{
				if(curSelectedNote[1].length < 2)
				{
					_song.events.remove(curSelectedNote);
					curSelectedNote = null;
				}
				else
				{
					curSelectedNote[1].remove(curSelectedNote[1][curEventSelected]);
				}

				var eventsGroup:Array<Dynamic>;
				--curEventSelected;
				if(curEventSelected < 0) curEventSelected = 0;
				else if(curSelectedNote != null && curEventSelected >= (eventsGroup = curSelectedNote[1]).length) curEventSelected = eventsGroup.length - 1;

				changeEventSelected();
				updateGrid();
			}
		}
		removeButton.color = FlxColor.RED;

		var addButton:Button = new Button();
		addButton.text = 'Add Event';
		addButton.onClick = function(e)
		{
			if(curSelectedNote != null && curSelectedNote[2] == null) //Is event note
			{
				var eventsGroup:Array<Dynamic> = curSelectedNote[1];
				//main event, value1, value 2, etc...
				eventsGroup.push(['', '', '']);

				changeEventSelected(1);
				updateGrid();
			}
		}
		addButton.color = FlxColor.GREEN;

		var moveLeftButton:Button = new Button();
		moveLeftButton.text = 'Move Left An Event';
		moveLeftButton.onClick = function(e)
		{
			changeEventSelected(-1);
		}

		var moveRightButton:Button = new Button();
		moveRightButton.text = 'Move Right An Event'; 
		moveRightButton.onClick = function(e)
		{
			changeEventSelected(1);
		}

		selectedEventText = new Label();
		selectedEventText.text = 'Selected Event: None';
		selectedEventText.verticalAlign = "center";

		//Blockers
        var textNeedsBlock:Array<TextField> = [value1InputText, value2InputText];
        for (blockedText in 0...textNeedsBlock.length) textBlockers.push(textNeedsBlock[blockedText]);

        scrollBlockers.push(eventDropDown);

		vbox1.addComponent(eventName);
		vbox1.addComponent(eventDropDown);
		vbox1.addComponent(event1Label);
		vbox1.addComponent(value1InputText);
		vbox1.addComponent(event2Label);
		vbox1.addComponent(value2InputText);
		vbox1.addComponent(addButton);
		vbox1.addComponent(removeButton);
		vbox1.addComponent(moveLeftButton);
		vbox1.addComponent(moveRightButton);
		vbox2.addComponent(selectedEventText);
		vbox2.addComponent(descText);

		grid.addComponent(vbox1);
		grid.addComponent(vbox2);

		box4.addComponent(grid);
	}

	var check_mute_inst:CheckBox = null;
	var check_mute_vocals:CheckBox = null;
	var check_vortex:CheckBox= null;
	var check_warnings:CheckBox = null;
	var playSoundBf:CheckBox = null;
	var playSoundDad:CheckBox = null;
	var metronome:CheckBox;
	var mouseScrollingQuant:CheckBox;
	var metronomeStepper:NumberStepper;
	var metronomeOffsetStepper:NumberStepper;
	var disableAutoScrolling:CheckBox;
	var instVolume:NumberStepper;
	var voicesVolume:NumberStepper;
	#if FLX_PITCH
	var sliderRate:HorizontalSlider;
	#end

	inline function addChartingUI() {
		var vbox1 = new VBox();
		var chartingData = new Grid();

		#if desktop
		if (FlxG.save.data.chart_waveformInst == null) FlxG.save.data.chart_waveformInst = false;
		if (FlxG.save.data.chart_waveformVoices == null) FlxG.save.data.chart_waveformVoices = false;

		var waveformUseInstrumental:CheckBox = null;
		var waveformUseVoices:CheckBox = null;

		waveformUseInstrumental = new CheckBox();
		waveformUseInstrumental.text = "Waveform\n(Instrumental)";
		waveformUseInstrumental.selected = FlxG.save.data.chart_waveformInst;
		waveformUseInstrumental.onClick = function(e)
		{
			waveformUseVoices.selected = false;
			FlxG.save.data.chart_waveformVoices = false;
			FlxG.save.data.chart_waveformInst = waveformUseInstrumental.selected;
			updateWaveform();
		}

		waveformUseVoices = new CheckBox();
		waveformUseVoices.text = "Waveform\n(Main Vocals)";
		waveformUseVoices.selected = FlxG.save.data.chart_waveformVoices && !waveformUseInstrumental.selected;
		waveformUseVoices.onClick = function(e)
		{
			waveformUseInstrumental.selected = false;
			FlxG.save.data.chart_waveformInst = false;
			FlxG.save.data.chart_waveformVoices = waveformUseVoices.selected;
			updateWaveform();
		}
		#end

		check_mute_inst = new CheckBox();
		check_mute_inst.text = "Mute Instrumental (in editor)";
		check_mute_inst.selected = false;
		check_mute_inst.onClick = function(e)
		{
			var vol:Float = instVolume.pos;
			if (check_mute_inst.selected) vol = 0;
			FlxG.sound.music.volume = vol;
		};
		mouseScrollingQuant = new CheckBox();
		mouseScrollingQuant.text = "Mouse Scrolling Quantization";
		if (FlxG.save.data.mouseScrollingQuant == null) FlxG.save.data.mouseScrollingQuant = false;
		mouseScrollingQuant.selected = FlxG.save.data.mouseScrollingQuant;
		mouseScrollingQuant.onClick = function(e)
		{
			FlxG.save.data.mouseScrollingQuant = mouseScrollingQuant.selected;
			mouseQuant = FlxG.save.data.mouseScrollingQuant;
		};

		check_vortex = new CheckBox();
		check_vortex.text = "Vortex Editor (BETA)";
		if (FlxG.save.data.chart_vortex == null) FlxG.save.data.chart_vortex = false;
		check_vortex.selected = FlxG.save.data.chart_vortex;
		check_vortex.onClick = function(e)
		{
			FlxG.save.data.chart_vortex = check_vortex.selected;
			vortex = FlxG.save.data.chart_vortex;
			reloadGridLayer();
		}

		check_warnings = new CheckBox();
		check_warnings.text = "Ignore Progress Warnings";
		if (FlxG.save.data.ignoreWarnings == null) FlxG.save.data.ignoreWarnings = false;
		check_warnings.selected = FlxG.save.data.ignoreWarnings;
		check_warnings.onClick = function(e)
		{
			FlxG.save.data.ignoreWarnings = check_warnings.selected;
			ignoreWarnings = FlxG.save.data.ignoreWarnings;
		}

		check_mute_vocals = new CheckBox();
		check_mute_vocals.text = "Mute Main Vocals (in editor)";
		check_mute_vocals.selected = false;
		check_mute_vocals.onClick = function(e)
		{
			var vol:Float = voicesVolume.pos;
			if(check_mute_vocals.selected) vol = 0;
			if(vocals != null) vocals.volume = vol;
		}

		playSoundBf = new CheckBox();
		playSoundBf.text = 'Play Sound (Boyfriend notes)';
		playSoundBf.onClick = function(e) FlxG.save.data.chart_playSoundBf = playSoundBf.selected;
		if (FlxG.save.data.chart_playSoundBf == null) FlxG.save.data.chart_playSoundBf = false;
		playSoundBf.selected = FlxG.save.data.chart_playSoundBf;

		playSoundDad = new CheckBox();
		playSoundDad.text = 'Play Sound (Opponent notes)';
		playSoundDad.onClick = function(e) FlxG.save.data.chart_playSoundDad = playSoundDad.selected;
		if (FlxG.save.data.chart_playSoundDad == null) FlxG.save.data.chart_playSoundDad = false;
		playSoundDad.selected = FlxG.save.data.chart_playSoundDad;

		metronome = new CheckBox();
		metronome.text = "Metronome Enabled";
		metronome.onClick = function(e) FlxG.save.data.chart_metronome = metronome.selected;
		if (FlxG.save.data.chart_metronome == null) FlxG.save.data.chart_metronome = false;
		metronome.selected = FlxG.save.data.chart_metronome;

		metronomeStepper = new NumberStepper();
		metronomeStepper.min = 1;
		metronomeStepper.max = 1500;
		metronomeStepper.step = 0.5;
		metronomeStepper.decimalSeparator = ".";
		metronomeStepper.pos = _song.bpm;

		var metronomeStepperLabel:Label = new Label();
		metronomeStepperLabel.text = "Metronome Ticks";
		metronomeStepperLabel.verticalAlign = "center";

		metronomeOffsetStepper = new NumberStepper();
		metronomeOffsetStepper.min = 0;
		metronomeOffsetStepper.max = 1000;
		metronomeOffsetStepper.step = 0.5;
		metronomeOffsetStepper.decimalSeparator = ".";
		metronomeOffsetStepper.pos = 0;

		var metronomeOffsetStepperLabel:Label = new Label();
		metronomeOffsetStepperLabel.text = "Metronome Tick Offset";
		metronomeOffsetStepperLabel.verticalAlign = "center";
		
		disableAutoScrolling = new CheckBox();
		disableAutoScrolling.text = "Disable Autoscroll (Not Recommended)";
		disableAutoScrolling.onClick = function(e) FlxG.save.data.chart_noAutoScroll = disableAutoScrolling.selected;
		if (FlxG.save.data.chart_noAutoScroll == null) FlxG.save.data.chart_noAutoScroll = false;
		disableAutoScrolling.selected = FlxG.save.data.chart_noAutoScroll;

		instVolume = new NumberStepper();
		instVolume.min = 0;
		instVolume.max = 1;
		instVolume.step = 0.1;
		instVolume.decimalSeparator = ".";
		instVolume.pos = FlxG.sound.music.volume;
		instVolume.onChange = function(e)
		{
			
			FlxG.sound.music.volume = instVolume.pos;
			if(check_mute_inst.selected) FlxG.sound.music.volume = 0;
		}

		var instVolumeLabel:Label = new Label();
		instVolumeLabel.text = "Volume for instrumental";
		instVolumeLabel.verticalAlign = "center";

		
		var voicesVolumeLabel:Label = new Label();
		voicesVolumeLabel.text = "Volume for main vocals";
		voicesVolumeLabel.verticalAlign = "center";

		voicesVolume = new NumberStepper();
		voicesVolume.min = 0;
		voicesVolume.max = 1;
		voicesVolume.step = 0.1;
		voicesVolume.decimalSeparator = ".";
		voicesVolume.pos = vocals.volume;
		voicesVolume.onChange = function(e)
		{
			
			vocals.volume = voicesVolume.pos;
			if(check_mute_vocals.selected) vocals.volume = 0;
		}

		var sliderLabel = new Label();
		sliderLabel.text = "PlaybackSpeed: 1.0";
		sliderLabel.verticalAlign = "center";
		
		sliderRate = new HorizontalSlider();
		sliderRate.min = 0.1;
		sliderRate.max = 3;
		sliderRate.step = 0.1;
		#if FLX_PITCH
		sliderRate.pos = playbackSpeed;
		sliderRate.onDrag = function(e)
		{
			playbackSpeed = sliderRate.pos;
			sliderLabel.text = "Playback Speed: " + Std.string(sliderRate.pos);
		}
		#end

		//Blockers
        var stepperNeedsBlock:Array<NumberStepper> = [metronomeStepper, metronomeOffsetStepper];
        for (blockedStep in 0...stepperNeedsBlock.length) stepperBlockers.push(stepperNeedsBlock[blockedStep]);
		
		vbox1.addComponent(waveformUseInstrumental);
		vbox1.addComponent(waveformUseVoices);
		vbox1.addComponent(check_mute_inst);
		vbox1.addComponent(check_mute_vocals);
		vbox1.addComponent(mouseScrollingQuant);
		vbox1.addComponent(disableAutoScrolling);
		vbox1.addComponent(check_vortex);
		vbox1.addComponent(check_warnings);
		vbox1.addComponent(playSoundBf);
		vbox1.addComponent(playSoundDad);
		vbox1.addComponent(metronome);
		vbox1.addComponent(metronomeStepperLabel);
		vbox1.addComponent(metronomeStepper);
		vbox1.addComponent(metronomeOffsetStepperLabel);
		vbox1.addComponent(metronomeOffsetStepper);
		vbox1.addComponent(instVolumeLabel);
		vbox1.addComponent(instVolume);
		vbox1.addComponent(voicesVolumeLabel);
		vbox1.addComponent(voicesVolume);
		vbox1.addComponent(sliderLabel);
		vbox1.addComponent(sliderRate);

		chartingData.addComponent(vbox1);
		box5.addComponent(chartingData);
	}
	var UI_songTitle:TextField;

	inline function addSongUI():Void
	{
		var vbox1 = new VBox();
		var vbox3 = new VBox();
		var grid = new Grid();
		var grid2 = new Grid();

		var song = new Label();
		song.text = "Current Song: " + _song.song;
		song.width = 300;

		UI_songTitle = new TextField();
		UI_songTitle.text = _song.song;
		UI_songTitle.verticalAlign = "center";
		UI_songTitle.width = 100;

		var check_voices = new CheckBox();
		check_voices.text = "Has vocal track";
		check_voices.selected = _song.needsVoices;
		check_voices.onClick = function(e)
		{
			_song.needsVoices = !_song.needsVoices;
		}

		var saveButton:Button = new Button();
		saveButton.text = "Save";
		saveButton.onClick = function(e)
		{
			saveLevel();
		}

		var reloadSongAudio:Button = new Button();
		reloadSongAudio.text = "Reload Song Audio";
		reloadSongAudio.onClick = function(e)
		{
			currentSongName = Paths.formatToSongPath(UI_songTitle.text);
			loadSong();
			updateWaveform();
		}

		var reloadSongJson:Button = new Button();
		reloadSongJson.text = "Reload JSON";
		reloadSongJson.onClick = function(e)
		{
			openSubState(new Prompt('This action will clear current progress.\n\nProceed?', 0, function() {
				loadJson(_song.song.toLowerCase());
			},
			null, ignoreWarnings));
		}

		var loadAutosaveBtn:Button = new Button();
		loadAutosaveBtn.text = 'Load Autosave';
		loadAutosaveBtn.onClick = function(e)
		{
			PlayState.SONG = Song.parseJSONshit(FlxG.save.data.autosave);
			MusicBeatState.resetState();
		}

		var loadEventJson:Button = new Button();
		loadEventJson.text = 'Load Events'; 
		loadEventJson.onClick = function(e)
		{

			var songName:String = Paths.formatToSongPath(_song.song);
			var file:String = Paths.json(songName + '/events');
			#if sys
			if (#if MODS_ALLOWED FileSystem.exists(Paths.modsJson(songName + '/events')) || #end FileSystem.exists(file))
			#else
			if (OpenFlAssets.exists(file))
			#end
			{
				clearEvents();
				var events:SwagSong = Song.loadFromJson('events', songName);
				_song.events = events.events;
				changeSection(curSec);
			}
		}

		var saveEventsFile:Button = new Button(); 
		saveEventsFile.text = 'Save Events'; 
		saveEventsFile.onClick = function(e)
		{
			saveEvents();
		}

		var clear_events:Button = new Button();
		clear_events.text = 'Clear events';
		clear_events.onClick = function(e)
		{
			openSubState(new Prompt('This action will clear current progress.\n\nProceed?', 0, clearEvents, null,ignoreWarnings));
		}
		clear_events.color = FlxColor.RED;

		var clear_notes:Button = new Button();
		clear_notes.text = 'Clear notes';
		clear_notes.onClick = function(e) 
		{
			openSubState(new Prompt('This action will clear current progress.\n\nProceed?', 0, function(){for (sec in 0..._song.notes.length) {
				_song.notes[sec].sectionNotes = [];
			}
				updateGrid();
			}, null,ignoreWarnings));
			updateGrid();
		}
		clear_notes.color = FlxColor.RED;

		var stepperBPM:NumberStepper = new NumberStepper();
		stepperBPM.min = 1;
		stepperBPM.max = 400;
		stepperBPM.step = 0.1;
		stepperBPM.pos = Conductor.bpm;
		stepperBPM.decimalSeparator = ".";
		stepperBPM.onChange = function(e)
		{
			_song.bpm = stepperBPM.pos;
			Conductor.mapBPMChanges(_song);
			Conductor.bpm = stepperBPM.pos;
			stepperSusLength.step = Math.ceil(((Conductor.stepCrochet / 2) / 10));
			updateGrid();
		}

		var bpmLabel:Label = new Label();
		bpmLabel.text = "Song BPM";
		bpmLabel.verticalAlign = "center";

		var stepperSpeed:NumberStepper = new NumberStepper();
		stepperSpeed.min = 0.1;
		stepperSpeed.max = 10;
		stepperSpeed.step = 0.1;
		stepperSpeed.pos = _song.speed;
		stepperSpeed.precision = 2;
		stepperSpeed.decimalSeparator = ".";
		stepperSpeed.autoCorrect = true;
		stepperSpeed.onChange = function(e)
		{
			_song.speed = stepperSpeed.pos;
		}

		var speedLabel:Label = new Label();
		speedLabel.text = "Song Speed";
		speedLabel.verticalAlign = "center";

		textBlockers.push(UI_songTitle);
		stepperBlockers.push(stepperBPM);
		stepperBlockers.push(stepperSpeed);

		FlxG.camera.follow(camPos, LOCKON, 999);

		grid.addComponent(song);
		grid.addComponent(UI_songTitle);

		grid2.addComponent(stepperBPM);
		grid2.addComponent(bpmLabel);

		grid2.addComponent(stepperSpeed);
		grid2.addComponent(speedLabel);

		vbox1.addComponent(grid);
		vbox1.addComponent(grid2);

		vbox3.addComponent(saveButton);
		vbox3.addComponent(loadAutosaveBtn);
		vbox3.addComponent(reloadSongAudio);
		vbox3.addComponent(reloadSongJson);
		vbox3.addComponent(loadEventJson);
		vbox3.addComponent(saveEventsFile);
		vbox3.addComponent(clear_notes);
		vbox3.addComponent(clear_events);
		vbox3.addComponent(check_voices);

		box6.addComponent(vbox1);
		box6.addComponent(vbox3);
	}
	
	function changeEventSelected(change:Int = 0)
	{
		if(curSelectedNote != null && curSelectedNote[2] == null) //Is event note
		{
			curEventSelected += change;
			if(curEventSelected < 0) curEventSelected = Std.int(curSelectedNote[1].length) - 1;
			else if(curEventSelected >= curSelectedNote[1].length) curEventSelected = 0;
			selectedEventText.text = 'Selected Event: ' + (curEventSelected + 1) + ' / ' + curSelectedNote[1].length;
		}
		else
		{
			curEventSelected = 0;
			selectedEventText.text = 'Selected Event: None';
		}
		updateNoteUI();
	}

	function loadSong():Void
	{
		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
			// vocals.stop();
		}

		var file:Dynamic = Paths.voices(currentSongName);
		vocals = new FlxSound();
		if (Std.isOfType(file, Sound) || OpenFlAssets.exists(file)) {
			vocals.loadEmbedded(file);
			FlxG.sound.list.add(vocals);
		}
		generateSong();
		FlxG.sound.music.pause();
		Conductor.songPosition = sectionStartTime();
		FlxG.sound.music.time = Conductor.songPosition;
	}

	function generateSong() {
		FlxG.sound.playMusic(Paths.inst(currentSongName), 0.6/*, false*/);
		if (instVolume != null) FlxG.sound.music.volume = instVolume.pos;
		if (check_mute_inst != null && check_mute_inst.selected) FlxG.sound.music.volume = 0;

		FlxG.sound.music.onComplete = function()
		{
			FlxG.sound.music.pause();
			Conductor.songPosition = 0;
			if(vocals != null) {
				vocals.pause();
				vocals.time = 0;
			}
			changeSection();
			curSec = 0;
			updateGrid();
			updateSectionUI();
			vocals.play();
		};
	}

	var updatedSection:Bool = false;

	function sectionStartTime(add:Int = 0):Float
	{
		var daBPM:Float = _song.bpm;
		var daPos:Float = 0;
		for (i in 0...curSec + add)
		{
			if(_song.notes[i] != null)
			{
				if (_song.notes[i].changeBPM)
				{
					daBPM = _song.notes[i].bpm;
				}
				daPos += getSectionBeats(i) * (1000 * 60 / daBPM);
			}
		}
		return daPos;
	}

	var lastConductorPos:Float;
	var colorSine:Float = 0;
	override function update(elapsed:Float)
	{
		curStep = recalculateSteps();

		if(FlxG.sound.music.time < 0) {
			FlxG.sound.music.pause();
			FlxG.sound.music.time = 0;
		}
		else if(FlxG.sound.music.time > FlxG.sound.music.length) {
			FlxG.sound.music.pause();
			FlxG.sound.music.time = 0;
			changeSection();
		}
		Conductor.songPosition = FlxG.sound.music.time;
		_song.song = UI_songTitle.text;

		strumLineUpdateY();
		for (i in 0...strumLineNotes.members.length){
			strumLineNotes.members[i].y = strumLine.y;
		}

		FlxG.mouse.visible = !songStarted;
		camPos.y = strumLine.y;
		if(!disableAutoScrolling.selected) {
			if (Math.ceil(strumLine.y) >= gridBG.height)
			{
				if (_song.notes[curSec + 1] == null)
				{
					addSection();
				}

				changeSection(curSec + 1, false);
			} else if(strumLine.y < -10) {
				changeSection(curSec - 1, false);
			}
		}
		FlxG.watch.addQuick('daBeat', curBeat);
		FlxG.watch.addQuick('daStep', curStep);


		if (FlxG.mouse.x > gridBG.x
			&& FlxG.mouse.x < gridBG.x + gridBG.width
			&& FlxG.mouse.y > gridBG.y
			&& FlxG.mouse.y < gridBG.y + (GRID_SIZE * getSectionBeats() * 4) * zoomList[curZoom])
		{
			dummyArrow.visible = true;
			dummyArrow.x = Math.floor(FlxG.mouse.x / GRID_SIZE) * GRID_SIZE;
			if (FlxG.keys.pressed.SHIFT)
				dummyArrow.y = FlxG.mouse.y;
			else
			{
				var gridmult = GRID_SIZE / (quantization / 16);
				dummyArrow.y = Math.floor(FlxG.mouse.y / gridmult) * gridmult;
			}
		} else {
			dummyArrow.visible = false;
		}

		if (FlxG.mouse.justPressed)
		{
			if (FlxG.mouse.overlaps(curRenderedNotes))
			{
				curRenderedNotes.forEachAlive(function(note:Note)
				{
					if (FlxG.mouse.overlaps(note))
					{
						if (FlxG.keys.pressed.CONTROL)
						{
							selectNote(note);
						}
						else if (FlxG.keys.pressed.ALT)
						{
							selectNote(note);
							curSelectedNote[3] = curNoteTypes[currentType];
							updateGrid();
						}
						else
						{
							//trace('tryin to delete note...');
							deleteNote(note);
						}
					}
				});
			}
			else
			{
				if (FlxG.mouse.x > gridBG.x
					&& FlxG.mouse.x < gridBG.x + gridBG.width
					&& FlxG.mouse.y > gridBG.y
					&& FlxG.mouse.y < gridBG.y + (GRID_SIZE * getSectionBeats() * 4) * zoomList[curZoom])
				{
					FlxG.log.add('added note');
					addNote();
				}
			}
		}

		var blockInput:Bool = false;
		if(!blockInput) {
			FlxG.sound.muteKeys = TitleState.muteKeys;
			FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
			FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
			for (inputText in textBlockers) {
				if(inputText.focus) {
					FlxG.sound.muteKeys = [];
					FlxG.sound.volumeDownKeys = [];
					FlxG.sound.volumeUpKeys = [];
					blockInput = true;
					break;
				}
			}

			for (stepper in stepperBlockers) {
				if(stepper.focus) {
					FlxG.sound.muteKeys = [];
					FlxG.sound.volumeDownKeys = [];
					FlxG.sound.volumeUpKeys = [];
					blockInput = true;
					break;
				}
			}

			for (dropDownMenu in scrollBlockers) {
				if(dropDownMenu.dropDownOpen) {
					blockInput = true;
					break;
				}
			}
		}

		if (!blockInput && !fuckingCheater)
		{
			if (FlxG.keys.justPressed.ESCAPE)
			{
				autosaveSong();
				LoadingState.loadAndSwitchState(new editors.EditorPlayState(sectionStartTime()));
			}
			if (FlxG.keys.justPressed.ENTER)
			{
				startSong();
			}

			if(curSelectedNote != null && curSelectedNote[1] > -1) {
				if (FlxG.keys.justPressed.E)
				{
					changeNoteSustain(Conductor.stepCrochet);
				}
				if (FlxG.keys.justPressed.Q)
				{
					changeNoteSustain(-Conductor.stepCrochet);
				}
			}


			if (FlxG.keys.justPressed.BACKSPACE) {
				PlayState.chartingMode = false;
				MusicBeatState.switchState(new editors.MasterEditorMenu());
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
				songStarted = true;
				return;
			}

			if(FlxG.keys.justPressed.Z && FlxG.keys.pressed.CONTROL) {
				undo();
			}



			if(FlxG.keys.justPressed.Z && curZoom > 0 && !FlxG.keys.pressed.CONTROL) {
				--curZoom;
				updateZoom();
			}
			if(FlxG.keys.justPressed.X && curZoom < zoomList.length-1) {
				curZoom++;
				updateZoom();
			}

			if (FlxG.keys.justPressed.SPACE)
			{
				if (FlxG.sound.music.playing)
				{
					FlxG.sound.music.pause();
					if(vocals != null) vocals.pause();
				}
				else
				{
					if(vocals != null) {
						vocals.play();
						vocals.pause();
						vocals.time = FlxG.sound.music.time;
						vocals.play();
					}
					FlxG.sound.music.play();
				}
			}

			if (!FlxG.keys.pressed.ALT && FlxG.keys.justPressed.R)
			{
				if (FlxG.keys.pressed.SHIFT)
					resetSection(true);
				else
					resetSection();
			}

			if (FlxG.mouse.wheel != 0)
			{
				FlxG.sound.music.pause();
				if (!mouseQuant)
					FlxG.sound.music.time -= (FlxG.mouse.wheel * Conductor.stepCrochet*0.8);
				else
					{
						var time:Float = FlxG.sound.music.time;
						var beat:Float = curDecBeat;
						var snap:Float = quantization / 4;
						var increase:Float = 1 / snap;
						if (FlxG.mouse.wheel > 0)
						{
							var fuck:Float = CoolUtil.quantize(beat, snap) - increase;
							FlxG.sound.music.time = Conductor.beatToSeconds(fuck);
						}else{
							var fuck:Float = CoolUtil.quantize(beat, snap) + increase;
							FlxG.sound.music.time = Conductor.beatToSeconds(fuck);
						}
					}
				if(vocals != null) {
					vocals.pause();
					vocals.time = FlxG.sound.music.time;
				}
			}

			//ARROW VORTEX SHIT NO DEADASS



			if (FlxG.keys.pressed.W || FlxG.keys.pressed.S)
			{
				FlxG.sound.music.pause();

				var holdingShift:Float = 1;
				if (FlxG.keys.pressed.CONTROL) holdingShift = 0.25;
				else if (FlxG.keys.pressed.SHIFT) holdingShift = 4;

				var daTime:Float = 700 * FlxG.elapsed * holdingShift;

				if (FlxG.keys.pressed.W)
				{
					FlxG.sound.music.time -= daTime;
				}
				else
					FlxG.sound.music.time += daTime;

				if(vocals != null) {
					vocals.pause();
					vocals.time = FlxG.sound.music.time;
				}
			}

			if(!vortex){
				if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN  )
				{
					FlxG.sound.music.pause();
					updateCurStep();
					var time:Float = FlxG.sound.music.time;
					var beat:Float = curDecBeat;
					var snap:Float = quantization / 4;
					var increase:Float = 1 / snap;
					if (FlxG.keys.pressed.UP)
					{
						var fuck:Float = CoolUtil.quantize(beat, snap) - increase; //(Math.floor((beat+snap) / snap) * snap);
						FlxG.sound.music.time = Conductor.beatToSeconds(fuck);
					}else{
						var fuck:Float = CoolUtil.quantize(beat, snap) + increase; //(Math.floor((beat+snap) / snap) * snap);
						FlxG.sound.music.time = Conductor.beatToSeconds(fuck);
					}
				}
			}

			var style = currentType;

			if (FlxG.keys.pressed.SHIFT){
				style = 3;
			}

			var conductorTime = Conductor.songPosition; //+ sectionStartTime();Conductor.songPosition / Conductor.stepCrochet;

			//AWW YOU MADE IT SEXY <3333 THX SHADMAR

			if(!blockInput){
				if(FlxG.keys.justPressed.RIGHT){
					curQuant++;
					if(curQuant>quantizations.length-1)
						curQuant = 0;

					quantization = quantizations[curQuant];
				}

				if(FlxG.keys.justPressed.LEFT){
					curQuant--;
					if(curQuant<0)
						curQuant = quantizations.length-1;

					quantization = quantizations[curQuant];
				}
				quant.animation.play('q', true, false, curQuant);
			}
			if(vortex && !blockInput){
				var controlArray:Array<Bool> = [FlxG.keys.justPressed.ONE, FlxG.keys.justPressed.TWO, FlxG.keys.justPressed.THREE, FlxG.keys.justPressed.FOUR,
											   FlxG.keys.justPressed.FIVE, FlxG.keys.justPressed.SIX, FlxG.keys.justPressed.SEVEN, FlxG.keys.justPressed.EIGHT];

				if(controlArray.contains(true))
				{
					for (i in 0...controlArray.length)
					{
						if(controlArray[i])
							doANoteThing(conductorTime, i, style);
					}
				}

				var feces:Float;
				if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN  )
				{
					FlxG.sound.music.pause();


					updateCurStep();
					//FlxG.sound.music.time = (Math.round(curStep/quants[curQuant])*quants[curQuant]) * Conductor.stepCrochet;

						//(Math.floor((curStep+quants[curQuant]*1.5/(quants[curQuant]/2))/quants[curQuant])*quants[curQuant]) * Conductor.stepCrochet;//snap into quantization
					var time:Float = FlxG.sound.music.time;
					var beat:Float = curDecBeat;
					var snap:Float = quantization / 4;
					var increase:Float = 1 / snap;
					if (FlxG.keys.pressed.UP)
					{
						var fuck:Float = CoolUtil.quantize(beat, snap) - increase;
						feces = Conductor.beatToSeconds(fuck);
					}else{
						var fuck:Float = CoolUtil.quantize(beat, snap) + increase; //(Math.floor((beat+snap) / snap) * snap);
						feces = Conductor.beatToSeconds(fuck);
					}
					FlxTween.tween(FlxG.sound.music, {time:feces}, 0.1, {ease:FlxEase.circOut});
					if(vocals != null) {
						vocals.pause();
						vocals.time = FlxG.sound.music.time;
					}

					var dastrum = 0;

					if (curSelectedNote != null){
						dastrum = curSelectedNote[0];
					}

					var secStart:Float = sectionStartTime();
					var datime = (feces - secStart) - (dastrum - secStart); //idk math find out why it doesn't work on any other section other than 0
					if (curSelectedNote != null)
					{
						var controlArray:Array<Bool> = [FlxG.keys.pressed.ONE, FlxG.keys.pressed.TWO, FlxG.keys.pressed.THREE, FlxG.keys.pressed.FOUR,
													   FlxG.keys.pressed.FIVE, FlxG.keys.pressed.SIX, FlxG.keys.pressed.SEVEN, FlxG.keys.pressed.EIGHT];

						if(controlArray.contains(true))
						{

							for (i in 0...controlArray.length)
							{
								if(controlArray[i])
									if(curSelectedNote[1] == i) curSelectedNote[2] += datime - curSelectedNote[2] - Conductor.stepCrochet;
							}
							updateGrid();
							updateNoteUI();
						}
					}
				}
			}
			var shiftThing:Int = 1;
			if (FlxG.keys.pressed.SHIFT)
				shiftThing = 4;

			if (FlxG.keys.justPressed.H)
				changeSection(0);
			if (FlxG.keys.justPressed.D)
				changeSection(curSec + shiftThing);
			if (FlxG.keys.justPressed.A) {
				if(curSec <= 0) {
					changeSection(_song.notes.length-1);
				} else {
					changeSection(curSec - shiftThing);
				}
			}
		}

		_song.bpm = tempBpm;

		strumLineNotes.visible = quant.visible = vortex;

		if(FlxG.sound.music.time < 0) {
			FlxG.sound.music.pause();
			FlxG.sound.music.time = 0;
		}
		else if(FlxG.sound.music.time > FlxG.sound.music.length) {
			FlxG.sound.music.pause();
			FlxG.sound.music.time = 0;
			changeSection();
		}
		Conductor.songPosition = FlxG.sound.music.time;
		strumLineUpdateY();
		camPos.y = strumLine.y;
		for (i in 0...strumLineNotes.members.length){
			strumLineNotes.members[i].y = strumLine.y;
			strumLineNotes.members[i].alpha = FlxG.sound.music.playing ? 1 : 0.35;
		}

		// PLAYBACK SPEED CONTROLS //
		var holdingShift = FlxG.keys.pressed.SHIFT;
		var holdingLB = FlxG.keys.pressed.LBRACKET;
		var holdingRB = FlxG.keys.pressed.RBRACKET;
		var pressedLB = FlxG.keys.justPressed.LBRACKET;
		var pressedRB = FlxG.keys.justPressed.RBRACKET;

		if (!holdingShift && pressedLB || holdingShift && holdingLB)
			playbackSpeed -= 0.01;
		if (!holdingShift && pressedRB || holdingShift && holdingRB)
			playbackSpeed += 0.01;
		if (FlxG.keys.pressed.ALT && (pressedLB || pressedRB || holdingLB || holdingRB))
			playbackSpeed = 1;
		//

		if (playbackSpeed <= 0.5)
			playbackSpeed = 0.5;
		if (playbackSpeed >= 3)
			playbackSpeed = 3;

		FlxG.sound.music.pitch = playbackSpeed;
		vocals.pitch = playbackSpeed;

		var showTime:String = FlxStringUtil.formatTime(FlxMath.roundDecimal(Conductor.songPosition / 1000, 2), false) + ' / ' + FlxStringUtil.formatTime(FlxMath.roundDecimal(FlxG.sound.music.length / 1000, 2), false);
		var currentDifficulty:String = CoolUtil.difficulties[PlayState.storyDifficulty];
		var daSongPosition = FlxMath.roundDecimal(Conductor.songPosition / 1000, 2);

		bpmTxt.text =
		currentSongName + ' [' + currentDifficulty + ']' +
		"\n"+ showTime +
		"\n"+
		"\n"+Std.string(daSongPosition) + " / " + Std.string(FlxMath.roundDecimal(FlxG.sound.music.length / 1000, 2))+
		"\nSection: " + curSec +
		"\n\nBeat: " + Std.string(curDecBeat).substring(0,4) +
		"\n\nStep: " + curStep +
		"\n\nBeat Snap: " + quantization + "th";

		var playedSound:Array<Bool> = [false, false, false, false]; //Prevents ouchy GF sex sounds
		curRenderedNotes.forEachAlive(function(note:Note) {
			note.alpha = 1;
			if(curSelectedNote != null) {
				var noteDataToCheck:Int = note.noteData;
				if(noteDataToCheck > -1 && note.mustPress != _song.notes[curSec].mustHitSection) noteDataToCheck += 4;

				if (curSelectedNote[0] == note.strumTime && ((curSelectedNote[2] == null && noteDataToCheck < 0) || (curSelectedNote[2] != null && curSelectedNote[1] == noteDataToCheck)))
				{
					colorSine += elapsed;
					var colorVal:Float = 0.7 + Math.sin(Math.PI * colorSine) * 0.3;
					note.color = FlxColor.fromRGBFloat(colorVal, colorVal, colorVal, 0.999); //Alpha can't be 100% or the color won't be updated for some reason, guess i will die
				}
			}

			if(note.strumTime <= Conductor.songPosition) {
				note.alpha = 0.4;
				if(note.strumTime > lastConductorPos && FlxG.sound.music.playing && note.noteData > -1) {
					var data:Int = note.noteData % 4;
					var noteDataToCheck:Int = note.noteData % 4;
					if(noteDataToCheck > -1 && note.mustPress != _song.notes[curSec].mustHitSection) noteDataToCheck += 4;
						strumLineNotes.members[noteDataToCheck].playAnim('confirm', true);
						strumLineNotes.members[noteDataToCheck].resetAnim = ((note.sustainLength / 1000) + 0.15) / playbackSpeed;
					if(!playedSound[data]) {
						if((playSoundBf.selected && note.mustPress) || (playSoundDad.selected && !note.mustPress)){
							var soundToPlay = 'hitsound';
							if(_song.player1 == 'gf') { //Easter egg
								soundToPlay = 'GF_' + Std.string(data + 1);
							}

							FlxG.sound.play(Paths.sound(soundToPlay)).pan = note.noteData < 4? -0.3 : 0.3; //would be coolio
							playedSound[data] = true;
						}

						data = note.noteData;
						if(note.mustPress != _song.notes[curSec].mustHitSection)
						{
							data += 4;
						}
					}
				}
			}
		});

		if(metronome.selected && lastConductorPos != Conductor.songPosition) {
			var metroInterval:Float = 60 / metronomeStepper.pos;
			var metroStep:Int = Math.floor(((Conductor.songPosition + metronomeOffsetStepper.pos) / metroInterval) / 1000);
			var lastMetroStep:Int = Math.floor(((lastConductorPos + metronomeOffsetStepper.pos) / metroInterval) / 1000);
			if(metroStep != lastMetroStep) {
				FlxG.sound.play(Paths.sound('Metronome_Tick'));
				//trace('Ticked');
			}
		}
		lastConductorPos = Conductor.songPosition;
		super.update(elapsed);
	}

	function startSong(){
		autosaveSong();
		songStarted = true;
		PlayState.SONG = _song;
		FlxG.sound.music.stop();
		if(vocals != null) vocals.stop();

		//if(_song.stage == null) _song.stage = stageDropDown.selectedLabel;
		StageData.loadDirectory(_song);
		LoadingState.loadAndSwitchState(new PlayState());
	}

	function updateZoom() {
		var daZoom:Float = zoomList[curZoom];
		var zoomThing:String = '1 / ' + daZoom;
		if(daZoom < 1) zoomThing = Math.round(1 / daZoom) + ' / 1';
		zoomTxt.text = 'Zoom: ' + zoomThing;
		reloadGridLayer();
	}

	/*
	function loadAudioBuffer() {
		if(audioBuffers[0] != null) {
			audioBuffers[0].dispose();
		}
		audioBuffers[0] = null;
		#if MODS_ALLOWED
		if(FileSystem.exists(Paths.modFolders('songs/' + currentSongName + '/Inst.ogg'))) {
			audioBuffers[0] = AudioBuffer.fromFile(Paths.modFolders('songs/' + currentSongName + '/Inst.ogg'));
			//trace('Custom vocals found');
		}
		else { #end
			var leVocals:String = Paths.getPath(currentSongName + '/Inst.' + Paths.SOUND_EXT, SOUND, 'songs');
			if (OpenFlAssets.exists(leVocals)) { //Vanilla inst
				audioBuffers[0] = AudioBuffer.fromFile('./' + leVocals.substr(6));
				//trace('Inst found');
			}
		#if MODS_ALLOWED
		}
		#end

		if(audioBuffers[1] != null) {
			audioBuffers[1].dispose();
		}
		audioBuffers[1] = null;
		#if MODS_ALLOWED
		if(FileSystem.exists(Paths.modFolders('songs/' + currentSongName + '/Voices.ogg'))) {
			audioBuffers[1] = AudioBuffer.fromFile(Paths.modFolders('songs/' + currentSongName + '/Voices.ogg'));
			//trace('Custom vocals found');
		} else { #end
			var leVocals:String = Paths.getPath(currentSongName + '/Voices.' + Paths.SOUND_EXT, SOUND, 'songs');
			if (OpenFlAssets.exists(leVocals)) { //Vanilla voices
				audioBuffers[1] = AudioBuffer.fromFile('./' + leVocals.substr(6));
				//trace('Voices found, LETS FUCKING GOOOO');
			}
		#if MODS_ALLOWED
		}
		#end
	}
	*/

	var lastSecBeats:Float = 0;
	var lastSecBeatsNext:Float = 0;
	function reloadGridLayer() {
		gridLayer.clear();
		gridBG = FlxGridOverlay.create(GRID_SIZE, GRID_SIZE, GRID_SIZE * 9, Std.int(GRID_SIZE * getSectionBeats() * 4 * zoomList[curZoom]));

		#if desktop
		if(FlxG.save.data.chart_waveformInst || FlxG.save.data.chart_waveformVoices) {
			updateWaveform();
		}
		#end

		var leHeight:Int = Std.int(gridBG.height);
		var foundNextSec:Bool = false;
		if(sectionStartTime(1) <= FlxG.sound.music.length)
		{
			nextGridBG = FlxGridOverlay.create(GRID_SIZE, GRID_SIZE, GRID_SIZE * 9, Std.int(GRID_SIZE * getSectionBeats(curSec + 1) * 4 * zoomList[curZoom]));
			leHeight = Std.int(gridBG.height + nextGridBG.height);
			foundNextSec = true;
		}
		else nextGridBG = new FlxSprite().makeGraphic(1, 1, FlxColor.TRANSPARENT);
		nextGridBG.y = gridBG.height;
		
		gridLayer.add(nextGridBG);
		gridLayer.add(gridBG);

		if(foundNextSec)
		{
			var gridBlack:FlxSprite = new FlxSprite(0, gridBG.height).makeGraphic(Std.int(GRID_SIZE * 9), Std.int(nextGridBG.height), FlxColor.BLACK);
			gridBlack.alpha = 0.4;
			gridLayer.add(gridBlack);
		}

		var gridBlackLine:FlxSprite = new FlxSprite(gridBG.x + gridBG.width - (GRID_SIZE * 4)).makeGraphic(2, leHeight, FlxColor.BLACK);
		gridLayer.add(gridBlackLine);

		for (i in 1...4) {
			var beatsep1:FlxSprite = new FlxSprite(gridBG.x, (GRID_SIZE * (4 * curZoom)) * i).makeGraphic(Std.int(gridBG.width), 1, 0x44FF0000);
			if(vortex)
			{
				gridLayer.add(beatsep1);
			}
		}

		var gridBlackLine:FlxSprite = new FlxSprite(gridBG.x + GRID_SIZE).makeGraphic(2, leHeight, FlxColor.BLACK);
		gridLayer.add(gridBlackLine);
		updateGrid();

		lastSecBeats = getSectionBeats();
		if(sectionStartTime(1) > FlxG.sound.music.length) lastSecBeatsNext = 0;
		else getSectionBeats(curSec + 1);
	}

	function strumLineUpdateY()
	{
		strumLine.y = getYfromStrum((Conductor.songPosition - sectionStartTime()) / zoomList[curZoom] % (Conductor.stepCrochet * 16)) / (getSectionBeats() / 4);
	}

	var waveformPrinted:Bool = true;
	var wavData:Array<Array<Array<Float>>> = [[[0], [0]], [[0], [0]]];
	function updateWaveform() {
		#if desktop
		if(waveformPrinted) {
			waveformSprite.makeGraphic(Std.int(GRID_SIZE * 8), Std.int(gridBG.height), 0x00FFFFFF);
			waveformSprite.pixels.fillRect(new Rectangle(0, 0, gridBG.width, gridBG.height), 0x00FFFFFF);
		}
		waveformPrinted = false;

		if(!FlxG.save.data.chart_waveformInst && !FlxG.save.data.chart_waveformVoices) {
			//trace('Epic fail on the waveform lol');
			return;
		}

		wavData[0][0] = [];
		wavData[0][1] = [];
		wavData[1][0] = [];
		wavData[1][1] = [];

		var steps:Int = Math.round(getSectionBeats() * 4);
		var st:Float = sectionStartTime();
		var et:Float = st + (Conductor.stepCrochet * steps);

		if (FlxG.save.data.chart_waveformInst) {
			var sound:FlxSound = FlxG.sound.music;
			if (sound._sound != null && sound._sound.__buffer != null) {
				var bytes:Bytes = sound._sound.__buffer.data.toBytes();

				wavData = waveformData(
					sound._sound.__buffer,
					bytes,
					st,
					et,
					1,
					wavData,
					Std.int(gridBG.height)
				);
			}
		}

		if (FlxG.save.data.chart_waveformVoices) {
			var sound:FlxSound = vocals;
			if (sound._sound != null && sound._sound.__buffer != null) {
				var bytes:Bytes = sound._sound.__buffer.data.toBytes();

				wavData = waveformData(
					sound._sound.__buffer,
					bytes,
					st,
					et,
					1,
					wavData,
					Std.int(gridBG.height)
				);
			}
		}

		// Draws
		var gSize:Int = Std.int(GRID_SIZE * 8);
		var hSize:Int = Std.int(gSize / 2);

		var lmin:Float = 0;
		var lmax:Float = 0;

		var rmin:Float = 0;
		var rmax:Float = 0;

		var size:Float = 1;

		var leftLength:Int = (
			wavData[0][0].length > wavData[0][1].length ? wavData[0][0].length : wavData[0][1].length
		);

		var rightLength:Int = (
			wavData[1][0].length > wavData[1][1].length ? wavData[1][0].length : wavData[1][1].length
		);

		var length:Int = leftLength > rightLength ? leftLength : rightLength;

		var index:Int;
		for (i in 0...length) {
			index = i;

			lmin = FlxMath.bound(((index < wavData[0][0].length && index >= 0) ? wavData[0][0][index] : 0) * (gSize / 1.12), -hSize, hSize) / 2;
			lmax = FlxMath.bound(((index < wavData[0][1].length && index >= 0) ? wavData[0][1][index] : 0) * (gSize / 1.12), -hSize, hSize) / 2;

			rmin = FlxMath.bound(((index < wavData[1][0].length && index >= 0) ? wavData[1][0][index] : 0) * (gSize / 1.12), -hSize, hSize) / 2;
			rmax = FlxMath.bound(((index < wavData[1][1].length && index >= 0) ? wavData[1][1][index] : 0) * (gSize / 1.12), -hSize, hSize) / 2;

			waveformSprite.pixels.fillRect(new Rectangle(hSize - (lmin + rmin), i * size, (lmin + rmin) + (lmax + rmax), size), FlxColor.BLUE);
		}

		waveformPrinted = true;
		#end
	}

	function waveformData(buffer:AudioBuffer, bytes:Bytes, time:Float, endTime:Float, multiply:Float = 1, ?array:Array<Array<Array<Float>>>, ?steps:Float):Array<Array<Array<Float>>>
	{
		#if (lime_cffi && !macro)
		if (buffer == null || buffer.data == null) return [[[0], [0]], [[0], [0]]];

		var khz:Float = (buffer.sampleRate / 1000);
		var channels:Int = buffer.channels;

		var index:Int = Std.int(time * khz);

		var samples:Float = ((endTime - time) * khz);

		if (steps == null) steps = 1280;

		var samplesPerRow:Float = samples / steps;
		var samplesPerRowI:Int = Std.int(samplesPerRow);

		var gotIndex:Int = 0;

		var lmin:Float = 0;
		var lmax:Float = 0;

		var rmin:Float = 0;
		var rmax:Float = 0;

		var rows:Float = 0;

		var simpleSample:Bool = true;//samples > 17200;
		var v1:Bool = false;

		if (array == null) array = [[[0], [0]], [[0], [0]]];

		while (index < (bytes.length - 1)) {
			if (index >= 0) {
				var byte:Int = bytes.getUInt16(index * channels * 2);

				if (byte > 65535 / 2) byte -= 65535;

				var sample:Float = (byte / 65535);

				if (sample > 0) {
					if (sample > lmax) lmax = sample;
				} else if (sample < 0) {
					if (sample < lmin) lmin = sample;
				}

				if (channels >= 2) {
					byte = bytes.getUInt16((index * channels * 2) + 2);

					if (byte > 65535 / 2) byte -= 65535;

					sample = (byte / 65535);

					if (sample > 0) {
						if (sample > rmax) rmax = sample;
					} else if (sample < 0) {
						if (sample < rmin) rmin = sample;
					}
				}
			}

			v1 = samplesPerRowI > 0 ? (index % samplesPerRowI == 0) : false;
			while (simpleSample ? v1 : rows >= samplesPerRow) {
				v1 = false;
				rows -= samplesPerRow;

				gotIndex++;

				var lRMin:Float = Math.abs(lmin) * multiply;
				var lRMax:Float = lmax * multiply;

				var rRMin:Float = Math.abs(rmin) * multiply;
				var rRMax:Float = rmax * multiply;

				if (gotIndex > array[0][0].length) array[0][0].push(lRMin);
					else array[0][0][gotIndex - 1] = array[0][0][gotIndex - 1] + lRMin;

				if (gotIndex > array[0][1].length) array[0][1].push(lRMax);
					else array[0][1][gotIndex - 1] = array[0][1][gotIndex - 1] + lRMax;

				if (channels >= 2) {
					if (gotIndex > array[1][0].length) array[1][0].push(rRMin);
						else array[1][0][gotIndex - 1] = array[1][0][gotIndex - 1] + rRMin;

					if (gotIndex > array[1][1].length) array[1][1].push(rRMax);
						else array[1][1][gotIndex - 1] = array[1][1][gotIndex - 1] + rRMax;
				}
				else {
					if (gotIndex > array[1][0].length) array[1][0].push(lRMin);
						else array[1][0][gotIndex - 1] = array[1][0][gotIndex - 1] + lRMin;

					if (gotIndex > array[1][1].length) array[1][1].push(lRMax);
						else array[1][1][gotIndex - 1] = array[1][1][gotIndex - 1] + lRMax;
				}

				lmin = 0;
				lmax = 0;

				rmin = 0;
				rmax = 0;
			}

			index++;
			rows++;
			if(gotIndex > steps) break;
		}

		return array;
		#else
		return [[[0], [0]], [[0], [0]]];
		#end
	}

	function changeNoteSustain(value:Float):Void
	{
		if (curSelectedNote != null)
		{
			if (curSelectedNote[2] != null)
			{
				curSelectedNote[2] += value;
				curSelectedNote[2] = Math.max(curSelectedNote[2], 0);
			}
		}

		updateNoteUI();
		updateGrid();
	}

	function recalculateSteps(add:Float = 0):Int
	{
		var lastChange:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: 0
		}
		for (i in 0...Conductor.bpmChangeMap.length)
		{
			if (FlxG.sound.music.time > Conductor.bpmChangeMap[i].songTime)
				lastChange = Conductor.bpmChangeMap[i];
		}

		curStep = lastChange.stepTime + Math.floor((FlxG.sound.music.time - lastChange.songTime + add) / Conductor.stepCrochet);
		updateBeat();

		return curStep;
	}

	function resetSection(songBeginning:Bool = false):Void
	{
		updateGrid();

		FlxG.sound.music.pause();
		// Basically old shit from changeSection???
		FlxG.sound.music.time = sectionStartTime();

		if (songBeginning)
		{
			FlxG.sound.music.time = 0;
			curSec = 0;
		}

		if(vocals != null) {
			vocals.pause();
			vocals.time = FlxG.sound.music.time;
		}
		updateCurStep();

		updateGrid();
		updateSectionUI();
		updateWaveform();
	}

	function changeSection(sec:Int = 0, ?updateMusic:Bool = true):Void
	{
		if (_song.notes[sec] != null)
		{
			curSec = sec;
			if (updateMusic)
			{
				FlxG.sound.music.pause();

				FlxG.sound.music.time = sectionStartTime();
				if(vocals != null) {
					vocals.pause();
					vocals.time = FlxG.sound.music.time;
				}
				updateCurStep();
			}

			var blah1:Float = getSectionBeats();
			var blah2:Float = getSectionBeats(curSec + 1);
			if(sectionStartTime(1) > FlxG.sound.music.length) blah2 = 0;
	
			if(blah1 != lastSecBeats || blah2 != lastSecBeatsNext)
			{
				reloadGridLayer();
			}
			else
			{
				updateGrid();
			}
			updateSectionUI();
		}
		else
		{
			changeSection();
		}
		Conductor.songPosition = FlxG.sound.music.time;
		updateWaveform();
	}

	function updateSectionUI():Void
	{
		var sec = _song.notes[curSec];

		stepperBeats.pos = getSectionBeats();
		check_mustHitSection.selected = sec.mustHitSection;
		check_gfSection.selected = sec.gfSection;
		check_altAnim.selected = sec.altAnim;
		check_changeBPM.selected = sec.changeBPM;
		stepperSectionBPM.pos = sec.bpm;

		updateHeads();
	}

	function updateHeads():Void
	{
		var healthIconP1:String = loadHealthIconFromCharacter(_song.player1);
		var healthIconP2:String = loadHealthIconFromCharacter(_song.player2);

		if (_song.notes[curSec].mustHitSection)
		{
			leftIcon.changeIcon(healthIconP1);
			rightIcon.changeIcon(healthIconP2);
			if (_song.notes[curSec].gfSection) leftIcon.changeIcon('gf');
		}
		else
		{
			leftIcon.changeIcon(healthIconP2);
			rightIcon.changeIcon(healthIconP1);
			if (_song.notes[curSec].gfSection) leftIcon.changeIcon('gf');
		}
	}

	function loadHealthIconFromCharacter(char:String) {
		var characterPath:String = 'characters/' + char + '.json';
		#if MODS_ALLOWED
		var path:String = Paths.modFolders(characterPath);
		if (!FileSystem.exists(path)) {
			path = Paths.getPreloadPath(characterPath);
		}

		if (!FileSystem.exists(path))
		#else
		var path:String = Paths.getPreloadPath(characterPath);
		if (!OpenFlAssets.exists(path))
		#end
		{
			path = Paths.getPreloadPath('characters/' + Character.DEFAULT_CHARACTER + '.json'); //If a character couldn't be found, change him to BF just to prevent a crash
		}

		#if MODS_ALLOWED
		var rawJson = File.getContent(path);
		#else
		var rawJson = OpenFlAssets.getText(path);
		#end

		var json:Character.CharacterFile = cast Json.parse(rawJson);
		return json.healthicon;
	}

	function updateNoteUI():Void
	{
		if (curSelectedNote != null) {
			if(curSelectedNote[2] != null) {
				stepperSusLength.pos = curSelectedNote[2];
				if(curSelectedNote[3] != null) {
					currentType = curNoteTypes.indexOf(curSelectedNote[3]);
					if(currentType <= 0) {
						noteTypeDropDown.selectedItem = '';
					} else {
						noteTypeDropDown.selectedItem = currentType + '. ' + curSelectedNote[3];
					}				
				}
			} else {
				eventDropDown.selectedItem = curSelectedNote[1][curEventSelected][0];
				var selected:Int = eventDropDown.selectedIndex;
				if(selected > 0 && selected < eventStuff.length) {
					descText.text = eventStuff[selected][1];
				}
				value1InputText.text = curSelectedNote[1][curEventSelected][1];
				value2InputText.text = curSelectedNote[1][curEventSelected][2];
			}
			strumTimeInputText.text = '' + curSelectedNote[0];
		}
	}

	function updateGrid():Void
	{
		curRenderedNotes.clear();
		curRenderedSustains.clear();
		curRenderedNoteType.clear();
		nextRenderedNotes.clear();
		nextRenderedSustains.clear();

		if (_song.notes[curSec].changeBPM && _song.notes[curSec].bpm > 0)
		{
			Conductor.bpm = _song.notes[curSec].bpm;
			//trace('BPM of this section:');
		}
		else
		{
			// get last bpm
			var daBPM:Float = _song.bpm;
			for (i in 0...curSec)
				if (_song.notes[i].changeBPM)
					daBPM = _song.notes[i].bpm;
			Conductor.bpm = daBPM;
		}

		// CURRENT SECTION
		var beats:Float = getSectionBeats();
		for (i in _song.notes[curSec].sectionNotes)
		{
			var note:Note = setupNoteData(i, false);
			curRenderedNotes.add(note);
			if (note.sustainLength > 0)
			{
				curRenderedSustains.add(setupSusNote(note, beats));
			}

			if(i[3] != null && note.noteType != null && note.noteType.length > 0) {
				var typeInt:Null<Int> = curNoteTypes.indexOf(i[3]);
				var theType:String = '' + typeInt;
				if(typeInt == null) theType = '?';

				var daText:AttachedFlxText = new AttachedFlxText(0, 0, 100, theType, 24);
				daText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				daText.xAdd = -32;
				daText.yAdd = 6;
				daText.borderSize = 1;
				curRenderedNoteType.add(daText);
				daText.sprTracker = note;
			}
			note.mustPress = _song.notes[curSec].mustHitSection;
			if(i[1] > 3) note.mustPress = !note.mustPress;
		}

		// CURRENT EVENTS
		var startThing:Float = sectionStartTime();
		var endThing:Float = sectionStartTime(1);
		for (i in _song.events)
		{
			if(endThing > i[0] && i[0] >= startThing)
			{
				var note:Note = setupNoteData(i, false);
				curRenderedNotes.add(note);

				var text:String = 'Event: ' + note.eventName + ' (' + Math.floor(note.strumTime) + ' ms)' + '\nValue 1: ' + note.eventVal1 + '\nValue 2: ' + note.eventVal2;
				if(note.eventLength > 1) text = note.eventLength + ' Events:\n' + note.eventName;

				var daText:AttachedFlxText = new AttachedFlxText(0, 0, 400, text, 12);
				daText.setFormat(Paths.font("vcr.ttf"), 12, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
				daText.xAdd = -410;
				daText.borderSize = 1;
				if(note.eventLength > 1) daText.yAdd += 8;
				curRenderedNoteType.add(daText);
				daText.sprTracker = note;
				//trace('test: ' + i[0], 'startThing: ' + startThing, 'endThing: ' + endThing);
			}
		}

		// NEXT SECTION
		var beats:Float = getSectionBeats(1);
		if(curSec < _song.notes.length-1) {
			for (i in _song.notes[curSec+1].sectionNotes)
			{
				var note:Note = setupNoteData(i, true);
				note.alpha = 0.6;
				nextRenderedNotes.add(note);
				if (note.sustainLength > 0)
				{
					nextRenderedSustains.add(setupSusNote(note, beats));
				}
			}
		}

		// NEXT EVENTS
		var startThing:Float = sectionStartTime(1);
		var endThing:Float = sectionStartTime(2);
		for (i in _song.events)
		{
			if(endThing > i[0] && i[0] >= startThing)
			{
				var note:Note = setupNoteData(i, true);
				note.alpha = 0.6;
				nextRenderedNotes.add(note);
			}
		}
	}

	function setupNoteData(i:Array<Dynamic>, isNextSection:Bool):Note
	{
		var daNoteInfo = i[1];
		var daStrumTime = i[0];
		var daSus:Dynamic = i[2];

		var note:Note = new Note(daStrumTime, daNoteInfo % 4, null, null, true);
		if(daSus != null) { //Common note
			if(!Std.isOfType(i[3], String)) //Convert old note type to new note type format
			{
				i[3] = curNoteTypes[i[3]];
			}
			if(i.length > 3 && (i[3] == null || i[3].length < 1))
			{
				i.remove(i[3]);
			}
			note.sustainLength = daSus;
			note.noteType = i[3];
		} else { //Event note
			note.loadGraphic(Paths.image('eventArrow'));
			note.eventName = getEventName(i[1]);
			note.eventLength = i[1].length;
			if(i[1].length < 2)
			{
				note.eventVal1 = i[1][0][1];
				note.eventVal2 = i[1][0][2];
			}
			note.noteData = -1;
			daNoteInfo = -1;
		}

		note.setGraphicSize(GRID_SIZE, GRID_SIZE);
		note.updateHitbox();
		note.x = Math.floor(daNoteInfo * GRID_SIZE) + GRID_SIZE;
		if(isNextSection && _song.notes[curSec].mustHitSection != _song.notes[curSec+1].mustHitSection) {
			if(daNoteInfo > 3) {
				note.x -= GRID_SIZE * 4;
			} else if(daSus != null) {
				note.x += GRID_SIZE * 4;
			}
		}

		var beats:Float = getSectionBeats(isNextSection ? 1 : 0);
		note.y = getYfromStrumNotes(daStrumTime - sectionStartTime(), beats);
		//if(isNextSection) note.y += gridBG.height;
		if(note.y < -150) note.y = -150;
		return note;
	}

	function getEventName(names:Array<Dynamic>):String
	{
		var retStr:String = '';
		var addedOne:Bool = false;
		for (i in 0...names.length)
		{
			if(addedOne) retStr += ', ';
			retStr += names[i][0];
			addedOne = true;
		}
		return retStr;
	}

	function setupSusNote(note:Note, beats:Float):FlxSprite {
		var height:Int = Math.floor(FlxMath.remapToRange(note.sustainLength, 0, Conductor.stepCrochet * 16, 0, GRID_SIZE * 16 * zoomList[curZoom]) + (GRID_SIZE * zoomList[curZoom]) - GRID_SIZE / 2);
		var minHeight:Int = Std.int((GRID_SIZE * zoomList[curZoom] / 2) + GRID_SIZE / 2);
		if(height < minHeight) height = minHeight;
		if(height < 1) height = 1; //Prevents error of invalid height

		var spr:FlxSprite = new FlxSprite(note.x + (GRID_SIZE * 0.5) - 4, note.y + GRID_SIZE / 2).makeGraphic(8, height);
		return spr;
	}

	private function addSection(sectionBeats:Float = 4):Void
	{
		var sec:SwagSection = {
			sectionBeats: sectionBeats,
			bpm: _song.bpm,
			changeBPM: false,
			mustHitSection: true,
			gfSection: false,
			sectionNotes: [],
			typeOfSection: 0,
			altAnim: false
		};

		_song.notes.push(sec);
	}

	function selectNote(note:Note):Void
	{
		var noteDataToCheck:Int = note.noteData;

		if(noteDataToCheck > -1)
		{
			if(note.mustPress != _song.notes[curSec].mustHitSection) noteDataToCheck += 4;
			for (i in _song.notes[curSec].sectionNotes)
			{
				if (i != curSelectedNote && i.length > 2 && i[0] == note.strumTime && i[1] == noteDataToCheck)
				{
					curSelectedNote = i;
					break;
				}
			}
		}
		else
		{
			for (i in _song.events)
			{
				if(i != curSelectedNote && i[0] == note.strumTime)
				{
					curSelectedNote = i;
					curEventSelected = Std.int(curSelectedNote[1].length) - 1;
					break;
				}
			}
		}
		changeEventSelected();

		updateGrid();
		updateNoteUI();
	}

	function deleteNote(note:Note):Void
	{
		var noteDataToCheck:Int = note.noteData;
		if(noteDataToCheck > -1 && note.mustPress != _song.notes[curSec].mustHitSection) noteDataToCheck += 4;

		if(note.noteData > -1) //Normal Notes
		{
			for (i in _song.notes[curSec].sectionNotes)
			{
				if (i[0] == note.strumTime && i[1] == noteDataToCheck)
				{
					if(i == curSelectedNote) curSelectedNote = null;
					//FlxG.log.add('FOUND EVIL NOTE');
					_song.notes[curSec].sectionNotes.remove(i);
					break;
				}
			}
		}
		else //Events
		{
			for (i in _song.events)
			{
				if(i[0] == note.strumTime)
				{
					if(i == curSelectedNote)
					{
						curSelectedNote = null;
						changeEventSelected();
					}
					//FlxG.log.add('FOUND EVIL EVENT');
					_song.events.remove(i);
					break;
				}
			}
		}

		updateGrid();
	}

	public function doANoteThing(cs, d, style){
		var delnote = false;
		if(strumLineNotes.members[d].overlaps(curRenderedNotes))
		{
			curRenderedNotes.forEachAlive(function(note:Note)
			{
				if (note.overlapsPoint(new FlxPoint(strumLineNotes.members[d].x + 1,strumLine.y+1)) && note.noteData == d%4)
				{
						//trace('tryin to delete note...');
						if(!delnote) deleteNote(note);
						delnote = true;
				}
			});
		}

		if (!delnote){
			addNote(cs, d, style);
		}
	}
	function clearSong():Void
	{
		for (daSection in 0..._song.notes.length)
		{
			_song.notes[daSection].sectionNotes = [];
		}

		updateGrid();
	}

	private function addNote(strum:Null<Float> = null, data:Null<Int> = null, type:Null<Int> = null):Void
	{
		//curUndoIndex++;
		//var newsong = _song.notes;
		//	undos.push(newsong);
		var noteStrum = getStrumTime(dummyArrow.y * (getSectionBeats() / 4), false) + sectionStartTime();
		var noteData = Math.floor((FlxG.mouse.x - GRID_SIZE) / GRID_SIZE);
		var noteSus = 0;
		var daAlt = false;
		var daType = currentType;

		if (strum != null) noteStrum = strum;
		if (data != null) noteData = data;
		if (type != null) daType = type;

		if(noteData > -1)
		{
			_song.notes[curSec].sectionNotes.push([noteStrum, noteData % 8, noteSus, curNoteTypes[daType]]);
			curSelectedNote = _song.notes[curSec].sectionNotes[_song.notes[curSec].sectionNotes.length - 1];
		}
		else
		{
			var event = eventStuff[eventDropDown.selectedIndex][0];
			var text1 = value1InputText.text;
			var text2 = value2InputText.text;
			_song.events.push([noteStrum, [[event, text1, text2]]]);
			curSelectedNote = _song.events[_song.events.length - 1];
			curEventSelected = 0;
		}
		changeEventSelected();

		if (FlxG.keys.pressed.CONTROL && noteData > -1)
		{
			_song.notes[curSec].sectionNotes.push([noteStrum, (noteData + 4) % 8, noteSus, curNoteTypes[daType]]);
		}

		//trace(noteData + ', ' + noteStrum + ', ' + curSec);
		strumTimeInputText.text = '' + curSelectedNote[0];

		updateGrid();
		updateNoteUI();
	}

	// will figure this out l8r
	function redo()
	{
		//_song = redos[curRedoIndex];
	}

	function undo()
	{
		//redos.push(_song);
		undos.pop();
		//_song.notes = undos[undos.length - 1];
		///trace(_song.notes);
		//updateGrid();
	}

	function getStrumTime(yPos:Float, doZoomCalc:Bool = true):Float
	{
		var leZoom:Float = zoomList[curZoom];
		if(!doZoomCalc) leZoom = 1;
		return FlxMath.remapToRange(yPos, gridBG.y, gridBG.y + gridBG.height * leZoom, 0, 16 * Conductor.stepCrochet);
	}

	function getYfromStrum(strumTime:Float, doZoomCalc:Bool = true):Float
	{
		var leZoom:Float = zoomList[curZoom];
		if(!doZoomCalc) leZoom = 1;
		return FlxMath.remapToRange(strumTime, 0, 16 * Conductor.stepCrochet, gridBG.y, gridBG.y + gridBG.height * leZoom);
	}
	
	function getYfromStrumNotes(strumTime:Float, beats:Float):Float
	{
		var value:Float = strumTime / (beats * 4 * Conductor.stepCrochet);
		return GRID_SIZE * beats * 4 * zoomList[curZoom] * value + gridBG.y;
	}

	function getNotes():Array<Dynamic>
	{
		var noteData:Array<Dynamic> = [];

		for (i in _song.notes)
		{
			noteData.push(i.sectionNotes);
		}

		return noteData;
	}

	function loadJson(song:String):Void
	{
		//shitty null fix, i fucking hate it when this happens
		//make it look sexier if possible
		if (hitmansSongs.contains(song.toLowerCase()) && !ClientPrefs.edwhakMode && !ClientPrefs.developerMode){
			antiCheat();
		}else{
			if (CoolUtil.difficulties[PlayState.storyDifficulty] != CoolUtil.defaultDifficulty) {
				if(CoolUtil.difficulties[PlayState.storyDifficulty] == null){
					PlayState.SONG = Song.loadFromJson(song.toLowerCase(), song.toLowerCase());
				}else{
					PlayState.SONG = Song.loadFromJson(song.toLowerCase() + "-" + CoolUtil.difficulties[PlayState.storyDifficulty], song.toLowerCase());
				}
			}else{
			PlayState.SONG = Song.loadFromJson(song.toLowerCase(), song.toLowerCase());
			}
			MusicBeatState.resetState();
		}
	}

	function autosaveSong():Void
	{
		FlxG.save.data.autosave = Json.stringify({
			"song": _song
		});
		FlxG.save.flush();
	}

	function clearEvents() {
		_song.events = [];
		updateGrid();
	}

	function antiCheat(){
		fuckingCheater=true;
			//fuck you
			if (FlxG.sound.music.playing)
			{
				FlxG.sound.music.pause();
				if(vocals != null) vocals.pause();
			}

			var edwhakBlack:BGSprite = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
			edwhakBlack.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
			edwhakBlack.scrollFactor.set(1);

			var edwhakBG:BGSprite = new BGSprite('Edwhak/Hitmans/unused/cheat-bg');
			edwhakBG.setGraphicSize(FlxG.width, FlxG.height);
			//edwhakBG.x += (FlxG.width/2); //Mmmmmm scuffed positioning, my favourite!
			//edwhakBG.y += (FlxG.height/2) - 20;
			edwhakBG.updateHitbox();
			edwhakBG.scrollFactor.set(1);
			edwhakBG.screenCenter();
			edwhakBG.x=0;

			var cheater:BGSprite = new BGSprite('Edwhak/Hitmans/unused/cheat', -600, -480, 0.5, 0.5);
			cheater.setGraphicSize(Std.int(cheater.width * 1.5));
			cheater.updateHitbox();
			cheater.scrollFactor.set(1);
			cheater.screenCenter();	
			cheater.x+=50;

			add(edwhakBlack);
			add(edwhakBG);
			add(cheater);
			FlxG.camera.shake(0.05,5);
			FlxG.sound.play(Paths.sound('Edwhak/cheatercheatercheater'), 1, true);
			#if desktop
			// Updating Discord Rich Presence
			DiscordClient.changePresence("CHEATER CHEATER CHEATER CHEATER CHEATER CHEATER ", StringTools.replace(_song.song, '-', ' '));
			#end

			//Stolen from the bob mod LMAO
			new FlxTimer().start(0.01, function(tmr:FlxTimer)
				{
					Lib.application.window.move(Lib.application.window.x + FlxG.random.int( -10, 10),Lib.application.window.y + FlxG.random.int( -8, 8));
				}, 0);

			new FlxTimer().start(1.5, function(tmr:FlxTimer) 
			{
				//trace("Quit");
				System.exit(0);
			});
	}

	private function saveLevel()
	{
		if(_song.events != null && _song.events.length > 1) _song.events.sort(sortByTime);
		var json = {
			"song": _song
		};

		var data:String = Json.stringify(json, "\t");

		if ((data != null) && (data.length > 0))
		{
			_file = new FileReference();
			_file.addEventListener(Event.COMPLETE, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(data.trim(), Paths.formatToSongPath(_song.song) + ".json");
		}
	}

	function sortByTime(Obj1:Array<Dynamic>, Obj2:Array<Dynamic>):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1[0], Obj2[0]);
	}

	private function saveEvents()
	{
		if(_song.events != null && _song.events.length > 1) _song.events.sort(sortByTime);
		var eventsSong:Dynamic = {
			events: _song.events
		};
		var json = {
			"song": eventsSong
		}

		var data:String = Json.stringify(json, "\t");

		if ((data != null) && (data.length > 0))
		{
			_file = new FileReference();
			_file.addEventListener(Event.COMPLETE, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(data.trim(), "events.json");
		}
	}

	function onSaveComplete(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.notice("Successfully saved LEVEL DATA.");
	}

	/**
	 * Called when the save file dialog is cancelled.
	 */
	function onSaveCancel(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
	}

	/**
	 * Called if there is an error while saving the gameplay recording.
	 */
	function onSaveError(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.error("Problem saving Level data");
	}

	function getSectionBeats(?section:Null<Int> = null)
	{
		if (section == null) section = curSec;
		var val:Null<Float> = null;
		
		if(_song.notes[section] != null) val = _song.notes[section].sectionBeats;
		return val != null ? val : 4;
	}
}

class AttachedFlxText extends FlxText
{
	public var sprTracker:FlxSprite;
	public var xAdd:Float = 0;
	public var yAdd:Float = 0;

	public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true) {
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null) {
			setPosition(sprTracker.x + xAdd, sprTracker.y + yAdd);
			angle = sprTracker.angle;
			alpha = sprTracker.alpha;
		}
	}
}
