package;

import flixel.tweens.misc.NumTween;
import flixel.graphics.FlxGraphic;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;

import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets as OpenFlAssets;
import editors.ChartingState;
import editors.CharacterEditorState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Note.EventNote;
import openfl.events.KeyboardEvent;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxSave;
import flixel.animation.FlxAnimationController;
import animateatlas.AtlasFrameMaker;
// import modchart.*;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.tweens.FlxTween.FlxTweenManager;
import flixel.system.scaleModes.StageSizeScaleMode;
import flixel.system.scaleModes.BaseScaleMode;
import modcharting.ModchartFuncs;
import modcharting.NoteMovement;
import modcharting.PlayfieldRenderer;
import achievements.*;
import StageData;
import FunkinLua;
import DialogueBoxPsych;
import Conductor.Rating;
import ResultScreen;

#if !flash 
import flixel.addons.display.FlxRuntimeShader;
import Shaders.ShaderEffectNew as ShaderEffect;
import Shaders;
import shaders.FNFShader;
import openfl.filters.ShaderFilter;
import openfl.filters.BitmapFilter;
#end
import flixel.addons.effects.FlxSkewedSprite;
#if sys
import sys.FileSystem;
import sys.io.File;

#if VIDEOS_ALLOWED 
#if (hxCodec >= "3.0.0")
import hxcodec.flixel.FlxVideo as VideoHandler;
import lime.app.Event;
#elseif (hxCodec >= "2.6.1") 
import hxcodec.VideoHandler as VideoHandler;
#elseif (hxCodec == "2.6.0") 
import VideoHandler as VideoHandler;
#end
#end

#end
import flash.system.System;

#if HSCRIPT_ALLOWED
import codenameengine.scripting.Script as HScriptCode;
#end

import HazardAFT_Capture as AFT_capture;


@:structInit
class ThreadBeatList 
{
	public var beat:Float = 0;
	public var func:Void->Dynamic;

	public function new(newBeat:Float, newFunc:Dynamic)
	{
		this.beat = newBeat;
		this.func = () -> {newFunc;}
	}
}

@:structInit
class ThreadUpdateList 
{
	public var startbeat:Float;
	public var endbeat:Float;
	public var func:Void->Dynamic;
	public var oncompletefunc:Void->Dynamic;

	public function new(startBeat:Float, endBeat:Float, newFunc:Dynamic, onCompleteFunc:Dynamic)
	{
		this.startbeat = startBeat;
		this.endbeat = endBeat;
		this.func = () -> {newFunc;}
		this.oncompletefunc = () -> {onCompleteFunc;}
	}
}

class CheckpointData{ //this shit should work ig??
	public var time:Float = 0;

	public var marvelouss:Int = 0;
	public var sicks:Int = 0;
	public var goods:Int = 0;
	public var bads:Int = 0;
	public var shits:Int = 0;

	public var highestCombo:Int = 0;

	public var songScore:Int = 0;
	public var songHits:Int = 0;
	public var songMisses:Int = 0;
	public var totalPlayed:Int = 0;
	public var totalNotesHit:Float = 0.0;
	public var BPM:Float = 160.0;
	public function new(){
	}
}


class PlayState extends MusicBeatState
{
	var hitmansSongs:Array<String> = ['c18h27no3-demo', 'forgotten', 'icebeat', 'hernameis', 'duality', 'hallucination', 'operating', 'sweet-dreams', 'mylove']; // Anti cheat system goes brrrrr

	public var filters:Array<BitmapFilter> = [];
	public var filterList:Array<BitmapFilter> = [];
	public var camfilters:Array<BitmapFilter> = [];
	// var modchartedSongs:Array<String> = []; PUT THE SONG NAME HERE IF YOU WANT TO USE THE ANDROMEDA MODIFIER SYSTEM!!

	// // THEN GOTO MODCHARTSHIT.HX TO DEFINE MODIFIERS ETC
	// // IN THE SETUPMODCHART FUNCTION
	// public var useModchart:Bool = false;

	public static var STRUM_X = 42;
	public static var STRUM_X_MIDDLESCROLL = -278;

	// public var center:FlxPoint;

	public static var ratingStuff:Array<Dynamic> = [
		['You Suck!', 0.2], //From 0% to 19%
		['F', 0.4], //From 20% to 39%
		['E', 0.5], //From 40% to 49%
		['D', 0.6], //From 50% to 59%
		['C', 0.69], //From 60% to 68%
		['B', 0.7], //69%
		['A', 0.8], //From 70% to 79%
		['S', 0.9], //From 80% to 89%
		['S+', 1], //From 90% to 99%
		['H', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	//event variables
	private var isCameraOnForcedPos:Bool = false;

	public var boyfriendMap:Map<String, Character> = new Map<String, Character>();
	public var dadMap:Map<String, Character> = new Map<String, Character>();
	public var gfMap:Map<String, Character> = new Map<String, Character>();
	public var variables:Map<String, Dynamic> = new Map<String, Dynamic>();
	public var modchartTweens:Map<String, FlxTween> = new Map<String, FlxTween>();
	public var modchartSprites:Map<String, Dynamic> = new Map<String, Dynamic>();
	public var modchartTimers:Map<String, FlxTimer> = new Map<String, FlxTimer>();
	public var modchartSounds:Map<String, FlxSound> = new Map<String, FlxSound>();
	public var modchartTexts:Map<String, ModchartText> = new Map<String, ModchartText>();
	public var modchartSaves:Map<String, FlxSave> = new Map<String, FlxSave>();
	public var modchartCameras:Map<String, FlxCamera> = new Map<String, FlxCamera>(); // FUCK!!!
	public var modchartSkewedSprite:Map<String, FlxSkewedSprite> = new Map<String, FlxSkewedSprite>();

	#if windows // usseles but cool
	var wallpaper:FlxSprite;
	var havewallpaper:Bool = true;
	#end

	public var BF_X:Float = 770;
	public var BF_Y:Float = 100;
	public var DAD_X:Float = 100;
	public var DAD_Y:Float = 100;
	public var GF_X:Float = 400;
	public var GF_Y:Float = 130;

	public var songSpeedTween:FlxTween;
	public var songSpeed(default, set):Float = 1;
	public var songSpeedType:String = "multiplicative";
	public var noteKillOffset:Float = 350;

	public static var current:PlayState;
	public var playbackRate(default, set):Float = 1;

	public var boyfriendGroup:FlxSpriteGroup;
	public var dadGroup:FlxSpriteGroup;
	public var gfGroup:FlxSpriteGroup;
	public static var curStage:String = '';
	public static var isPixelStage:Bool = false;
	public static var SONG:SwagSong = null;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	//make it public so i can edit that when i need it lmao
	//stolen from Qt mod lmao, don't kill me hazzy pls -Ed
	public static var forceMiddleScroll:Bool = false; //yeah
	public static var forceRightScroll:Bool = false; //so modcharts that NEED rightscroll will be forced (mainly for player vs enemy classic stuff like bf vs someone)
	public static var forcedAScroll:Bool = false; //if forced then it should disable "clientPrefs" stuff
	var edwhakDrain:Float = 0.03; //0.03 or more if changed
	public var edwhakIsEnemy:Bool = false;
	public var allowEnemyDrain:Bool = false;
	public var controlsPlayer2:Bool = false; //mega stupid shit that enables double play lmao, this is disabled in edwhak songs, in 2 ways(song name and dadname so you can't do shit) -Ed
	var noteSpeen:Int = 0; //Used for interlope
	var modChartEffectWave:Int = 0; //simple Drunk Y and X shit, use 1 to only Y use 2 to X and Y use 0 to disable
	var modChartEffect:Int = 0;
	//0 = null
	//1 = side to side movement 			- 	Variable1 = speed
	//2 = me when left to right screen					
	//3 = aea				
	//4 = Interlope scrolling effect		-	Variable1 = Lerp% (0 = no effect, 1 = full effect)
	//5 = Interlope main effect + fake
	//6 = ScrollSpeed Pulse effect
	//7 = copy note spin shit from qt mod (secret shit for "her" song lmao)
	//8 = disable effects too but this don't affect lua effects
	var modChartVariable1:Float = 0;
	var modChartDefaultStrumX:Array<Float> = [0,0,0,0,0,0,0,0];
	var modChartDefaultStrumY:Array<Float> = [0,0,0,0,0,0,0,0];
	var deathVariableTXT:String = 'Notes'; //game load the shit here too to make death screen works well lmao -Ed
	var deathTimer:FlxTimer;
	public var gameOver:Bool = false; //simple shit to allow or disable death screen variables when a special note was hit/miss
	public var drain:Bool = false;
	public var gain:Bool = false;

	public var tgain:Bool = false;

	public var aftBitmap:AFT_capture; //hazzy stuff :3

	//I must add hardcoded shaders! -PastEd

	//and you did man, you did... -Ed

	//Of course, i always don't know how to make better code lmao, but well, this is made to make people have way more fair time doing modcharts with lua so, it is worthy -Ed

	//I HATE DOING THIS STUPID SHIT MANUALLY AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

	public var spawnTime:Float = 2000;

	public var vocals:FlxSound;

	public var dad:Character = null;
	public var gf:Character = null;
	public var boyfriend:Character = null;

	public var notes:FlxTypedGroup<Note>;
	public var unspawnNotes:Array<Note> = [];
	public var eventNotes:Array<EventNote> = [];

	// public var modManager:ModManager;
	// public var downscrollOffset = FlxG.height - 150;
	// public var upscrollOffset = 50;

	private var strumLine:FlxSprite;

	//Handles the new epic mega sexy cam code that i've done
	public var camFollow:FlxPoint;
	public var camFollowPos:FlxObject;
	public static var prevCamFollow:FlxPoint;
	public static var prevCamFollowPos:FlxObject;

	public var strumLineNotes:FlxTypedGroup<StrumNote>;
	public var opponentStrums:FlxTypedGroup<StrumNote>;
	public var playerStrums:FlxTypedGroup<StrumNote>;

	public var camZooming:Bool = true;
	public var autoCamZoom:Bool = false; //disable camZoom auto for some songs
	public var camZoomingMult:Float = 1;
	public var camZoomingDecay:Float = 1;
	private var curSong:String = "";

	public var gfSpeed:Int = 1;
	public var health:Float = 1;
	public var maxHealth:Float = 0; //Totally not stolen from Lullaby lol
	public var combo:Int = 0;
	public var comboOp:Int = 0;
	public var separateCombo:Bool = false;
	private var maxCombo:Int = 0;

	public var songPercent:Float = 0;

	public var ratingsData:Array<Rating> = [];
	public var marvelouss:Int = 0;
	public var sicks:Int = 0;
	public var goods:Int = 0;
	public var bads:Int = 0;
	public var shits:Int = 0;

	public var fantastics:Int = 0;
	public var excelents:Int = 0;
	public var greats:Int = 0;
	public var decents:Int = 0;
	public var wayoffs:Int = 0;

	private var generatedMusic:Bool = false;
	public var endingSong:Bool = false;
	public var startingSong:Bool = false;
	private var updateTime:Bool = true;
	public static var changedDifficulty:Bool = false;
	public static var chartingMode:Bool = false;

	public var shaderUpdates:Array<Float->Void> = [];
	public var camGameShaders:Array<ShaderEffect> = [];
	public var camHUDShaders:Array<ShaderEffect> = [];
	public var camOtherShaders:Array<ShaderEffect> = [];

	public static var dasicks:Int = 0;
	public static var dagoods:Int = 0;
	public static var dabads:Int = 0;
	public static var dashits:Int = 0;
	public static var misses:Int = 0;
	public static var weekMisses:Int = 0;
	public static var wrongs:Int = 0;
	public static var maxc:Int = 0;
	public static var keym:Int = 0;
	public static var inp:Int = 0;

	//Gameplay settings
	public var healthGain:Float = 1;
	public var healthLoss:Float = 1;
	public var instakillOnMiss:Bool = false;
	public var cpuControlled:Bool = false;
	public var practiceMode:Bool = false;
	public var notITGMod:Bool = true;
	public var chaosMod:Bool = false;
	public var chaosDifficulty:Float = 1;
	public var randomizedNotes:Bool = false;

	public var botplaySine:Float = 0;
	public var botplayTxt:FlxText;

	public var camHUD:FlxCamera;
	public var camInterfaz:FlxCamera;
	public var camVisuals:FlxCamera;
	public var camGame:FlxCamera;
	public var camOther:FlxCamera;
	public var camProxy:FlxCamera;
	public var cameraSpeed:Float = 1;

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];
	var dialogueJson:DialogueFile = null;

	var dadbattleBlack:BGSprite;
	var dadbattleLight:BGSprite;
	var dadbattleSmokes:FlxSpriteGroup;

	var halloweenBG:BGSprite;
	var halloweenWhite:BGSprite;

	var phillyLightsColors:Array<FlxColor>;
	var phillyWindow:BGSprite;
	var phillyStreet:BGSprite;
	var phillyTrain:BGSprite;
	var blammedLightsBlack:FlxSprite;
	var phillyWindowEvent:BGSprite;
	var trainSound:FlxSound;

	var phillyGlowGradient:PhillyGlow.PhillyGlowGradient;
	var phillyGlowParticles:FlxTypedGroup<PhillyGlow.PhillyGlowParticle>;

	var limoKillingState:Int = 0;
	var limo:BGSprite;
	var limoMetalPole:BGSprite;
	var limoLight:BGSprite;
	var limoCorpse:BGSprite;
	var limoCorpseTwo:BGSprite;
	var bgLimo:BGSprite;
	var grpLimoParticles:FlxTypedGroup<BGSprite>;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:BGSprite;

	var upperBoppers:BGSprite;
	var bottomBoppers:BGSprite;
	var santa:BGSprite;
	var heyTimer:Float;

	var bgGirls:BackgroundGirls;
	var bgGhouls:BGSprite;

	var tankWatchtower:BGSprite;
	var tankGround:BGSprite;
	var tankmanRun:FlxTypedGroup<TankmenBG>;
	var foregroundSprites:FlxTypedGroup<BGSprite>;

	public var songScore:Int = 0;
	public var songHits:Int = 0;
	public var songMisses:Int = 0;
	public var scoreTxt:FlxText;
	var timeTxt:FlxText;
	var scoreTxtTween:FlxTween;

	var resultScreen:ResultScreen;

	public static var exitResults:Bool = false;
	public static var inResultsScreen:Bool = false;
	private var hits:Int = 0;
	private var total:Int = 0;
	private var acc:Int = 0;

	public static var campaignScore:Int = 0;
	public static var campaignMisses:Int = 0;
	public static var seenCutscene:Bool = false;
	public static var deathCounter:Int = 0;

	public var defaultCamZoom:Float = 1.05;

	// how big to stretch the pixel art assets
	public static var daPixelZoom:Float = 6;
	private var singAnimations:Array<String> = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

	public var inCutscene:Bool = false;
	public var skipCountdown:Bool = false;
	public var songLength:Float = 0;

	public var boyfriendCameraOffset:Array<Float> = null;
	public var opponentCameraOffset:Array<Float> = null;
	public var girlfriendCameraOffset:Array<Float> = null;

	#if desktop
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	//Achievement shit
	var keysPressed:Array<Bool> = [];
	var boyfriendIdleTime:Float = 0.0;
	var boyfriendIdled:Bool = false;

	// Lua shit
	public static var instance:PlayState;
	public var luaArray:Array<FunkinLua> = [];
	private var luaDebugGroup:FlxTypedGroup<DebugLuaText>;
	public var introSoundsSuffix:String = '';

	// Debug buttons
	private var debugKeysChart:Array<FlxKey>;
	private var debugKeysCharacter:Array<FlxKey>;
	private var debugKeysModchart:Array<FlxKey>;

	// Less laggy controls
	private var keysArray:Array<Dynamic>;
	private var controlArray:Array<String>;

	var precacheList:Map<String, String> = new Map<String, String>();
	
	// stores the last judgement object
	public static var lastRating:FlxSprite;
	// stores the last combo sprite object
	public static var lastCombo:FlxSprite;
	// stores the last combo score objects in an array
	public static var lastScore:Array<FlxSprite> = [];

	//the 21 cameras
	public var noteCameras0:FlxCamera;
	public var noteCameras1:FlxCamera;
	// public var noteCameras2:FlxCamera;
	// public var noteCameras3:FlxCamera;
	// public var noteCameras4:FlxCamera;
	// public var noteCameras5:FlxCamera;
	// public var noteCameras6:FlxCamera;
	// public var noteCameras7:FlxCamera;
	// public var noteCameras8:FlxCamera;
	// public var noteCameras9:FlxCamera;
	// public var noteCameras10:FlxCamera;
	// public var noteCameras11:FlxCamera;
	// public var noteCameras12:FlxCamera;
	// public var noteCameras13:FlxCamera;
	// public var noteCameras14:FlxCamera;
	// public var noteCameras15:FlxCamera;
	// public var noteCameras16:FlxCamera;
	// public var noteCameras17:FlxCamera;
	// public var noteCameras18:FlxCamera;
	// public var noteCameras19:FlxCamera;
	// public var noteCameras20:FlxCamera;
	// public var noteCameras21:FlxCamera;
	// public var noteCameras22:FlxCamera;

	//checkpoint stuff (thanks hazard!)
	public static var checkpointsUsed:Int = 0;
	public static var checkpointHistory:Array<CheckpointData> = [];
	var checkpointSprite:FlxSprite;

	public static var tweenManager:FlxTweenManager = null;
	public static var timerManager:FlxTimerManager = null;

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

	public function createTimer(Time:Float = 1, ?OnComplete:FlxTimer->Void, Loops:Int = 1):FlxTimer
	{
		var timer:FlxTimer = new FlxTimer();
		timer.manager = timerManager;
		return timer.start(Time, OnComplete, Loops);
	}

	//quant stuff
	var beat:Float = 0;
	var dataStuff:Float = 0;
	var col:FlxColor = 0xFFFFD700;
	var col3:FlxColor = 0xFFFFD700;
	var col2:FlxColor = 0xFFFFD700;

	public static var timeToStart:Float = 0;

	//gameOver stuff
	var staticDeath:FlxSprite;
    var offEffect:FlxSprite;

	public var hitmansHUD:huds.Huds;

	#if HSCRIPT_ALLOWED
	public var instancesExclude:Array<String> = [];
	#end

	#if (HSCRIPT_ALLOWED && HScriptImproved)
	public var scripts:codenameengine.scripting.ScriptPack;
	#end

	public var startCallback:Void->Void;
	public var endCallback:Void->Void;

	var passedCheckPoint:FlxText;

	override public function create()
	{
		//trace('Playback Rate: ' + playbackRate);

		ModchartFuncs.editor = false;

		tweenManager = new FlxTweenManager();
		timerManager = new FlxTimerManager();

		Paths.clearStoredMemory();

		startCallback = startCountdown;
		endCallback = endSong;

		// for lua
		instance = this;

		#if (HSCRIPT_ALLOWED && HScriptImproved)
		if (scripts == null) (scripts = new codenameengine.scripting.ScriptPack("PlayState")).setParent(this);
		#end

		debugKeysChart = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));
		debugKeysCharacter = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_2'));
		debugKeysModchart = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_3'));
		PauseSubState.songName = null; //Reset to default
		playbackRate = ClientPrefs.getGameplaySetting('songspeed', 1);

		keysArray = [
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_left')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_down')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_up')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_right'))
		];

		controlArray = [
			'NOTE_LEFT',
			'NOTE_DOWN',
			'NOTE_UP',
			'NOTE_RIGHT'
		];

		//Ratings
		ratingsData.push(new Rating('marvelous')); //default rating

		var rating:Rating = new Rating('sick');
		rating.ratingMod = 1;
		rating.score = 350;
		ratingsData.push(rating);

		var rating:Rating = new Rating('good');
		rating.ratingMod = 0.7;
		rating.score = 200;
		ratingsData.push(rating);

		var rating:Rating = new Rating('bad');
		rating.ratingMod = 0.4;
		rating.score = 100;
		ratingsData.push(rating);

		var rating:Rating = new Rating('shit');
		rating.ratingMod = 0;
		rating.score = 50;
		ratingsData.push(rating);

		//hitmans gameOverShit ig lmao
		staticDeath = new FlxSprite();
		staticDeath.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/newGameOver/Static');
		staticDeath.animation.addByPrefix('idle', 'Static Animated', 48, true);	
		staticDeath.antialiasing = ClientPrefs.globalAntialiasing;
		staticDeath.scale.y = 3;
		staticDeath.scale.x = 3;	
		staticDeath.updateHitbox();	
		staticDeath.screenCenter();
		staticDeath.alpha =0 ;
		staticDeath.animation.play("idle");
		add(staticDeath);

		offEffect = new FlxSprite();
		offEffect.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/newGameOver/tv-effect');
		offEffect.animation.addByPrefix('play', 'shutdown', 24, false);
		offEffect.scale.y = 1;
		offEffect.scale.x = 1;
		offEffect.alpha = 0;
		offEffect.updateHitbox();
		offEffect.screenCenter();
		offEffect.antialiasing = ClientPrefs.globalAntialiasing;
		add(offEffect);
		// For the "Just the Two of Us" achievement
		for (i in 0...keysArray.length)
		{
			keysPressed.push(false);
		}

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		// Gameplay settings
		healthGain = ClientPrefs.getGameplaySetting('healthgain', 1);
		healthLoss = ClientPrefs.getGameplaySetting('healthloss', 1);
		instakillOnMiss = ClientPrefs.getGameplaySetting('instakill', false);
		notITGMod = ClientPrefs.getGameplaySetting('modchart', true);
		practiceMode = ClientPrefs.getGameplaySetting('practice', false);
		cpuControlled = ClientPrefs.getGameplaySetting('botplay', false);
		chaosMod = ClientPrefs.getGameplaySetting('chaosmode', false);
		chaosDifficulty = ClientPrefs.getGameplaySetting('chaosdifficulty', 1);
		randomizedNotes = ClientPrefs.getGameplaySetting('randomnotes', false);

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camInterfaz = new FlxCamera();
		camVisuals = new FlxCamera();
		camOther = new FlxCamera();
		camProxy = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camInterfaz.bgColor.alpha = 0;
		camVisuals.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;
		camProxy.bgColor.alpha = 0;
		noteCameras0 = new FlxCamera();
		noteCameras0.bgColor.alpha = 0;
		noteCameras0.visible = false;
		noteCameras1 = new FlxCamera();
		noteCameras1.bgColor.alpha = 0;
		noteCameras1.visible = false;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camInterfaz, false);
		FlxG.cameras.add(camHUD, false);

		FlxG.cameras.add(noteCameras0, false);
		FlxG.cameras.add(noteCameras1, false);
		FlxG.cameras.add(camProxy, false);
		FlxG.cameras.add(camVisuals, false);
		FlxG.cameras.add(camOther, false);

		FlxG.cameras.setDefaultDrawTarget(camGame, true);
		CustomFadeTransition.nextCamera = camOther;

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		Conductor.mapBPMChanges(SONG);
		Conductor.bpm = SONG.bpm;

		#if desktop
		if (!inResultsScreen){
		storyDifficultyText = " (" + CoolUtil.difficulties[storyDifficulty] + ")";

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: " + WeekData.getCurrentWeek().weekName;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;
	    }
		#end

		GameOverSubstate.resetVariables();
		NewHitmansGameOver.resetVariables();
		var songName:String = Paths.formatToSongPath(SONG.song);

		curStage = SONG.stage;
		//trace('stage is: ' + curStage);
		if(SONG.stage == null || SONG.stage.length < 1) {
			switch (songName)
			{
				default:
					curStage = 'stage';
			}
		}
		SONG.stage = curStage;

		var stageData:StageFile = StageData.getStageFile(curStage);
		if(stageData == null) { //Stage couldn't be found, create a dummy stage for preventing a crash
			stageData = {
				directory: "",
				defaultZoom: 0.8125,
				isPixelStage: false,

				boyfriend: [875, 403],
				girlfriend: [820, 355],
				opponent: [628, 403],
				hide_girlfriend: false,

				camera_boyfriend: [0, 0],
				camera_opponent: [0, 0],
				camera_girlfriend: [0, 0],
				camera_speed: 1
			};
			var bg:BGSprite = new BGSprite('DefaultBackGround', -605, -150, 0.5, 0.5);
			bg.scale.x = 0.7;
			bg.scale.y = 0.7;
			add(bg);
		}

		defaultCamZoom = stageData.defaultZoom;
		isPixelStage = stageData.isPixelStage;
		BF_X = stageData.boyfriend[0];
		BF_Y = stageData.boyfriend[1];
		GF_X = stageData.girlfriend[0];
		GF_Y = stageData.girlfriend[1];
		DAD_X = stageData.opponent[0];
		DAD_Y = stageData.opponent[1];

		if(stageData.camera_speed != null)
			cameraSpeed = stageData.camera_speed;

		boyfriendCameraOffset = stageData.camera_boyfriend;
		if(boyfriendCameraOffset == null) //Fucks sake should have done it since the start :rolling_eyes:
			boyfriendCameraOffset = [0, 0];

		opponentCameraOffset = stageData.camera_opponent;
		if(opponentCameraOffset == null)
			opponentCameraOffset = [0, 0];

		girlfriendCameraOffset = stageData.camera_girlfriend;
		if(girlfriendCameraOffset == null)
			girlfriendCameraOffset = [0, 0];

		boyfriendGroup = new FlxSpriteGroup(BF_X, BF_Y);
		dadGroup = new FlxSpriteGroup(DAD_X, DAD_Y);
		gfGroup = new FlxSpriteGroup(GF_X, GF_Y);


		checkpointSprite = new BGSprite('Huds/checkpoint/checkpointVignette', -600, -480, 0.5, 0.5);
		checkpointSprite.setGraphicSize(FlxG.width, FlxG.height);
		checkpointSprite.updateHitbox();
		checkpointSprite.cameras = [camOther]; //hud funny
		checkpointSprite.screenCenter();	
		checkpointSprite.alpha=0;
		add(checkpointSprite);

		switch (curStage)
		{
			case 'stage': //Week 1
				var bg:BGSprite = new BGSprite('DefaultBackGround', -605, -150, 0.5, 0.5);
				bg.scale.x = 0.7;
				bg.scale.y = 0.7;
				bg.screenCenter(Y);
				add(bg);
			case 'window': //MI WALLPAPER XD
				#if windows
				try
				{
					wallpaper = new FlxSprite()
						.loadGraphic(openfl.display.BitmapData.fromFile('${Sys.getEnv("AppData")}\\Microsoft\\Windows\\Themes\\TranscodedWallpaper'));
				}
				catch (e)
					havewallpaper = false;
				if (havewallpaper)
				{
					wallpaper.scrollFactor.set(0, 0);
					wallpaper.antialiasing = true;
					wallpaper.visible = true;
					wallpaper.setGraphicSize(FlxG.width, FlxG.height);
					wallpaper.updateHitbox();
					wallpaper.screenCenter(XY);
					add(wallpaper);
				}
				#end
		}

		if(isPixelStage) {
			introSoundsSuffix = '-pixel';
		}

		add(gfGroup); //Needed for blammed lights
		add(dadGroup);
		add(boyfriendGroup);

		aftBitmap = new AFT_capture(camHUD);
		aftBitmap.updateRate = 0.0;
		aftBitmap.recursive = false;

		// useModchart = modchartedSongs.contains(SONG.song.toLowerCase());
		// generateSong(SONG.song);

		#if LUA_ALLOWED
		luaDebugGroup = new FlxTypedGroup<DebugLuaText>();
		luaDebugGroup.cameras = [camOther];
		add(luaDebugGroup);
		#end

		// "GLOBAL" SCRIPTS
		#if (LUA_ALLOWED || HSCRIPT_ALLOWED)
		for (folder in Mods.directoriesWithFile(Paths.getPreloadPath(), 'scripts/'))
			for (file in FileSystem.readDirectory(folder))
			{
				#if LUA_ALLOWED
				if(file.toLowerCase().endsWith('.lua'))
					new FunkinLua(folder + file);
				#end

				#if HSCRIPT_ALLOWED
				if(file.toLowerCase().endsWith('.hx'))
					initHScript(folder + file);
				#end
			}
		#end

		// STAGE SCRIPTS
		#if LUA_ALLOWED
		startLuasNamed('stages/' + curStage + '.lua');
		#end

		#if HSCRIPT_ALLOWED
		startHScriptsNamed('stages/' + curStage + '.hx');
		#end


		var gfVersion:String = SONG.gfVersion;
		if(gfVersion == null || gfVersion.length < 1)
		{
			switch (curStage)
			{
				case 'limo':
					gfVersion = 'gf-car';
				case 'mall' | 'mallEvil':
					gfVersion = 'gf-christmas';
				case 'school' | 'schoolEvil':
					gfVersion = 'gf-pixel';
				case 'tank':
					gfVersion = 'gf-tankmen';
				default:
					gfVersion = 'gf';
			}

			switch(Paths.formatToSongPath(SONG.song))
			{
				case 'stress':
					gfVersion = 'pico-speaker';
			}
			SONG.gfVersion = gfVersion; //Fix for the Chart Editor
		}

		if (!stageData.hide_girlfriend)
		{
			gf = new Character(0, 0, gfVersion);
			startCharacterPos(gf);
			gf.scrollFactor.set(0.95, 0.95);
			gfGroup.add(gf);
			startCharacterScripts(gf.curCharacter);

			if(gfVersion == 'pico-speaker')
			{
				if(!ClientPrefs.lowQuality)
				{
					var firstTank:TankmenBG = new TankmenBG(20, 500, true);
					firstTank.resetShit(20, 600, true);
					firstTank.strumTime = 10;
					tankmanRun.add(firstTank);

					for (i in 0...TankmenBG.animationNotes.length)
					{
						if(FlxG.random.bool(16)) {
							var tankBih = tankmanRun.recycle(TankmenBG);
							tankBih.strumTime = TankmenBG.animationNotes[i][0];
							tankBih.resetShit(500, 200 + FlxG.random.int(50, 100), TankmenBG.animationNotes[i][1] < 2);
							tankmanRun.add(tankBih);
						}
					}
				}
			}
		}

		dad = new Character(0, 0, SONG.player2);
		startCharacterPos(dad, true);
		dadGroup.add(dad);
		startCharacterScripts(dad.curCharacter);

		boyfriend = new Character(0, 0, SONG.player1, true);
		startCharacterPos(boyfriend);
		boyfriendGroup.add(boyfriend);
		startCharacterScripts(boyfriend.curCharacter);

		var camPos:FlxPoint = new FlxPoint(girlfriendCameraOffset[0], girlfriendCameraOffset[1]);
		if(gf != null)
		{
			camPos.x += gf.getGraphicMidpoint().x + gf.cameraPosition[0];
			camPos.y += gf.getGraphicMidpoint().y + gf.cameraPosition[1];
		}

		if(dad.curCharacter.startsWith('gf')) {
			dad.setPosition(GF_X, GF_Y);
			if(gf != null)
				gf.visible = false;
		}
		var edwhakVariable:Array<String> = ['Edwhak', 'he', 'edwhakBroken', 'edkbmassacre'];
		if (edwhakVariable.contains(boyfriend.curCharacter)){
			Note.canDamagePlayer = false;
			Note.edwhakIsPlayer = true;
		}else{
			Note.canDamagePlayer = true;
			Note.edwhakIsPlayer = false;
		}
			// i can't die to my own notes u dumb

			/*———————————No instakill?———————————
			⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
			⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
			⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
			⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
			⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
			⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			—————————————————————————————*/
		if (edwhakVariable.contains(dad.curCharacter))
			edwhakIsEnemy = true;
		else
			edwhakIsEnemy = false;

		switch(curStage)
		{
			case 'limo':
				resetFastCar();
				addBehindGF(fastCar);

			case 'schoolEvil':
				var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069); //nice
				addBehindDad(evilTrail);
		}

		var file:String = Paths.json(songName + '/dialogue'); //Checks for json/Psych Engine dialogue
		if (OpenFlAssets.exists(file)) {
			dialogueJson = DialogueBoxPsych.parseDialogue(file);
		}

		var file:String = Paths.txt(songName + '/' + songName + 'Dialogue'); //Checks for vanilla/Senpai dialogue
		if (OpenFlAssets.exists(file)) {
			dialogue = CoolUtil.coolTextFile(file);
		}
		var doof:DialogueBox = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;
		doof.nextDialogueThing = startNextDialogue;
		doof.skipDialogueThing = skipDialogue;

		Conductor.songPosition = -5000;

		
		forceMiddleScroll = SONG.middleScroll;
		forceRightScroll = SONG.rightScroll;

		forcedAScroll = forceRightScroll || forceMiddleScroll; //so its forced to true

		strumLine = new FlxSprite(!forcedAScroll ? (ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X) : 
												   (if (forceRightScroll && !forceMiddleScroll) STRUM_X 
												   else if (forceMiddleScroll && !forceRightScroll) STRUM_X_MIDDLESCROLL 
												   else ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X), 
		50).makeGraphic(FlxG.width, 10);

		if(ClientPrefs.downScroll) strumLine.y = FlxG.height - 150;
		strumLine.scrollFactor.set();

		strumLineNotes = new FlxTypedGroup<StrumNote>();
		add(strumLineNotes);

		opponentStrums = new FlxTypedGroup<StrumNote>();
		playerStrums = new FlxTypedGroup<StrumNote>();

		// startCountdown();

		generateSong(SONG.song);

		// After all characters being loaded, it makes then invisible 0.01s later so that the player won't freeze when you change characters
		// add(strumLine);

		if (SONG.notITG && notITGMod){
			playfieldRenderer = new PlayfieldRenderer(strumLineNotes, notes, this);
			playfieldRenderer.cameras = [camHUD, noteCameras0, noteCameras1];
			add(playfieldRenderer);
		}

		camFollow = new FlxPoint();
		camFollowPos = new FlxObject(0, 0, 1, 1);

		snapCamFollowToPos(camPos.x, camPos.y);
		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}
		if (prevCamFollowPos != null)
		{
			camFollowPos = prevCamFollowPos;
			prevCamFollowPos = null;
		}
		add(camFollowPos);

		FlxG.camera.follow(camFollowPos, LOCKON, 1);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow);

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;
		moveCameraSection();

		hitmansHUD = new huds.Huds();
		add(hitmansHUD);

		strumLineNotes.cameras = notes.cameras = [camHUD, noteCameras0, noteCameras1];

		hitmansHUD.healthBar.cameras = [camInterfaz];
		hitmansHUD.healthBarBG.cameras = [camInterfaz];

		hitmansHUD.ratings.cameras = [camVisuals];
		hitmansHUD.ratingsOP.cameras = [camVisuals];
		hitmansHUD.noteScore.cameras = [camVisuals];
		hitmansHUD.noteScoreOp.cameras = [camVisuals];

		hitmansHUD.iconP1.cameras = [camInterfaz];
		hitmansHUD.iconP2.cameras = [camInterfaz];

		hitmansHUD.scoreTxt.cameras = [camInterfaz];
		hitmansHUD.botplayTxt.cameras = [camVisuals];
		hitmansHUD.timeBar.cameras = [camInterfaz];
		hitmansHUD.timeBarBG.cameras = [camInterfaz];
		hitmansHUD.timeTxt.cameras = [camInterfaz];
		doof.cameras = [camInterfaz];

		staticDeath.cameras = [camOther];
		offEffect.cameras = [camOther];
		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;

		#if LUA_ALLOWED
		for (notetype in noteTypeMap.keys())
			startLuasNamed('custom_notetypes/' + notetype + '.lua');
		for (event in eventPushedMap.keys())
			startLuasNamed('custom_events/' + event + '.lua');
		#end
		#if HSCRIPT_ALLOWED
		for (notetype in noteTypeMap.keys())
			startHScriptsNamed('custom_notetypes/' + notetype + '.hx');
		for (event in eventPushedMap.keys())
			startHScriptsNamed('custom_events/' + event + '.hx');
		#end
		noteTypeMap.clear();
		noteTypeMap = null;
		eventPushedMap.clear();
		eventPushedMap = null;

		// SONG SPECIFIC SCRIPTS
		#if (LUA_ALLOWED || HSCRIPT_ALLOWED)
		for (folder in Mods.directoriesWithFile(Paths.getPreloadPath(), 'data/' + songName + '/'))
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					#if LUA_ALLOWED
					if(file.toLowerCase().endsWith('.lua'))
						new FunkinLua(folder + file);
					#end

					#if HSCRIPT_ALLOWED
					if(file.toLowerCase().endsWith('.hx'))
						initHScript(folder + file);
					#end
				}
			}
		}
		#end

		startCallback = spawnDialogue;
	
		startCallback();
		RecalculateRating();

		//PRECACHING MISS SOUNDS BECAUSE I THINK THEY CAN LAG PEOPLE AND FUCK THEM UP IDK HOW HAXE WORKS
		if(ClientPrefs.hitsoundVolume > 0) precacheList.set('hitsound', 'sound');
		precacheList.set('missnote1', 'sound');
		precacheList.set('missnote2', 'sound');
		precacheList.set('missnote3', 'sound');

		if (PauseSubState.songName != null) {
			precacheList.set(PauseSubState.songName, 'music');
		} else if(ClientPrefs.pauseMusic != 'None') {
			precacheList.set(Paths.formatToSongPath(ClientPrefs.pauseMusic), 'music');
		}

		precacheList.set('alphabet', 'image');
	
		#if desktop
		// Updating Discord Rich Presence.
		if (!inResultsScreen){
			DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter());
		}
		#end

		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}

		if (notITGMod && SONG.notITG)
			ModchartFuncs.loadLuaFunctions();

		if (boyfriend.LNoteColors != null && boyfriend.DNoteColors != null && boyfriend.UNoteColors != null && boyfriend.RNoteColors != null)
		{
			trace('this is not null bruh');
			for (note in unspawnNotes) {
				if (note.mustPress){
					if (!note.isSustainNote) {
						switch (note.noteData)
						{
							case 0:
								note.rgbShader.r = FlxColor.fromString(boyfriend.LNoteColors[0]);
								note.rgbShader.g = FlxColor.fromString(boyfriend.LNoteColors[1]);
								note.rgbShader.b = FlxColor.fromString(boyfriend.LNoteColors[2]);
							case 1:
								note.rgbShader.r = FlxColor.fromString(boyfriend.DNoteColors[0]);
								note.rgbShader.g = FlxColor.fromString(boyfriend.DNoteColors[1]);
								note.rgbShader.b = FlxColor.fromString(boyfriend.DNoteColors[2]);
							case 2:
								note.rgbShader.r = FlxColor.fromString(boyfriend.UNoteColors[0]);
								note.rgbShader.g = FlxColor.fromString(boyfriend.UNoteColors[1]);
								note.rgbShader.b = FlxColor.fromString(boyfriend.UNoteColors[2]);
							case 3:
								note.rgbShader.r = FlxColor.fromString(boyfriend.RNoteColors[0]);
								note.rgbShader.g = FlxColor.fromString(boyfriend.RNoteColors[1]);
								note.rgbShader.b = FlxColor.fromString(boyfriend.RNoteColors[2]);
						}
					}else{
						if (note.sustainRGB){
							note.rgbShader.r = note.prevNote.rgbShader.r;
							note.rgbShader.g = note.prevNote.rgbShader.g;
							note.rgbShader.b = note.prevNote.rgbShader.b;  
						}
					}
				}
			}
		}

		if (dad.LNoteColors != null && dad.DNoteColors != null && dad.UNoteColors != null && dad.RNoteColors != null)
		{
			trace('this is not null bruh');
			for (note in unspawnNotes) {
				if (!note.mustPress){
					if (!note.isSustainNote) {
						switch (note.noteData)
						{
							case 0:
								note.rgbShader.r = FlxColor.fromString(dad.LNoteColors[0]);
								note.rgbShader.g = FlxColor.fromString(dad.LNoteColors[1]);
								note.rgbShader.b = FlxColor.fromString(dad.LNoteColors[2]);
							case 1:
								note.rgbShader.r = FlxColor.fromString(dad.DNoteColors[0]);
								note.rgbShader.g = FlxColor.fromString(dad.DNoteColors[1]);
								note.rgbShader.b = FlxColor.fromString(dad.DNoteColors[2]);
							case 2:
								note.rgbShader.r = FlxColor.fromString(dad.UNoteColors[0]);
								note.rgbShader.g = FlxColor.fromString(dad.UNoteColors[1]);
								note.rgbShader.b = FlxColor.fromString(dad.UNoteColors[2]);
							case 3:
								note.rgbShader.r = FlxColor.fromString(dad.RNoteColors[0]);
								note.rgbShader.g = FlxColor.fromString(dad.RNoteColors[1]);
								note.rgbShader.b = FlxColor.fromString(dad.RNoteColors[2]);
						}
					}else{
						if (note.sustainRGB){
							note.rgbShader.r = note.prevNote.rgbShader.r;
							note.rgbShader.g = note.prevNote.rgbShader.g;
							note.rgbShader.b = note.prevNote.rgbShader.b;  
						}
					}
				}
			}
		}

		callOnScripts('onCreatePost');
		callOnScripts('onModchart');

		// camHUD.height = 1300; //some modcharts compatibility (need fix some stuff such as Y poss for camera but oh well)

		// threadBeat(10, () -> {
		// 	trace('Working Thread #10 (beat 10)');
		// });
		// threadBeat(20, () -> {
		// 	trace('Working Thread #20 (beat 20)');
		// });
		// threadBeat(30, () -> {
		// 	trace('Working Thread #30 (beat 30)');
		// });
		// threadBeat(40, () -> {
		// 	trace('Working Thread #40 (beat 40)');
		// });


		if (ClientPrefs.quantization)
			doNoteQuant();

		super.create();

		cacheCountdown();
		cachePopUpScore();
		for (key => type in precacheList)
		{
			//trace('Key $key is type $type');
			switch(type)
			{
				case 'image':
					Paths.image(key);
				case 'sound':
					Paths.sound(key);
				case 'music':
					Paths.music(key);
			}
		}
		Paths.clearUnusedMemory();

		if(timeToStart > 0){						
			clearNotesBefore(timeToStart);
		}

		CustomFadeTransition.nextCamera = camOther;

		passedCheckPoint = new FlxText(0, 0, 0, "Player's current checkpoint spot is 0.", 20);
		passedCheckPoint.size = 40;
		passedCheckPoint.alpha = 0;
		add(passedCheckPoint);

		// refresh(); //z sort shit LOL
		// refreshZ();
	}

	public function spawnDialogue()
	{
		var file:String = "";
		var music:String = "";
		switch (Paths.formatToSongPath(SONG.song).toLowerCase())
		{
			case 'operating':
				file = 'dialogue';
		}
		findDialogue(file, music);
	}

	public function findDialogue(dialogueFile:String, music:String = "")
	{
		var path:String;
		#if MODS_ALLOWED
		path = Paths.modsJson(Paths.formatToSongPath(SONG.song) + '/' + dialogueFile);
		if(!FileSystem.exists(path))
		#end
			path = Paths.json(Paths.formatToSongPath(SONG.song) + '/' + dialogueFile);

		#if MODS_ALLOWED
		if(FileSystem.exists(path))
		#else
		if(Assets.exists(path))
		#end
		{
			var shit:DialogueFile = DialogueBoxPsych.parseDialogue(path);
			if(shit.dialogue.length > 0) {
				startDialogue(shit, music);
			} else {
				trace('startDialogue: Your dialogue file is badly formatted!');
			}
		} else {
			if(endingSong) {
				if (!inResultsScreen) endSong();
			} else {
				if (!inResultsScreen) startCountdown();
			}
		}
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
			if (note.rgbShader.enabled && !note.hurtNote && ((note.mustPress && !boyfriend.disableQuant) || (!note.mustPress && !dad.disableQuant))){
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

	#if (!flash && sys)
	public var runtimeShaders:Map<String, Array<String>> = new Map<String, Array<String>>();
	public function createRuntimeShader(name:String):FlxRuntimeShader
	{
		if(!ClientPrefs.shaders) return new FlxRuntimeShader();

		#if (!flash && MODS_ALLOWED && sys)
		if(!runtimeShaders.exists(name) && !initLuaShader(name))
		{
			FlxG.log.warn('Shader $name is missing!');
			return new FlxRuntimeShader();
		}

		var arr:Array<String> = runtimeShaders.get(name);
		return new FlxRuntimeShader(arr[0], arr[1]);
		#else
		FlxG.log.warn("Platform unsupported for Runtime Shaders!");
		return null;
		#end
	}

	public function initLuaShader(name:String, ?glslVersion:Int = 120)
	{
		if(!ClientPrefs.shaders) return false;

		if(runtimeShaders.exists(name))
		{
			FlxG.log.warn('Shader $name was already initialized!');
			return true;
		}

		for (folder in Mods.directoriesWithFile(Paths.getPreloadPath(), 'shaders/'))
		{
			if(FileSystem.exists(folder))
			{
				var frag:String = folder + name + '.frag';
				var vert:String = folder + name + '.vert';
				var found:Bool = false;
				if(FileSystem.exists(frag))
				{
					frag = File.getContent(frag);
					found = true;
				}
				else frag = null;

				if (FileSystem.exists(vert))
				{
					vert = File.getContent(vert);
					found = true;
				}
				else vert = null;

				if(found)
				{
					runtimeShaders.set(name, [frag, vert]);
					//trace('Found shader $name!');
					return true;
				}
			}
		}
		FlxG.log.warn('Missing shader $name .frag AND .vert files!');
		return false;
	}
	#end

	function set_songSpeed(value:Float):Float
	{
		if(generatedMusic)
		{
			var ratio:Float = value / songSpeed; //funny word huh
			for (note in notes) note.resizeByRatio(ratio);
			for (note in unspawnNotes) note.resizeByRatio(ratio);
		}
		songSpeed = value;
		noteKillOffset = 350 / songSpeed;
		return value;
	}

	function set_playbackRate(value:Float):Float
	{
		if(generatedMusic)
		{
			if(vocals != null) vocals.pitch = value;
			FlxG.sound.music.pitch = value;
		}
		playbackRate = value;
		FlxAnimationController.globalSpeed = value;
		// trace('Anim speed: ' + FlxAnimationController.globalSpeed);
		Conductor.safeZoneOffset = (ClientPrefs.safeFrames / 60) * 1000 * value;
		setOnScripts('playbackRate', playbackRate);
		return value;
	}

	#if (LUA_ALLOWED || HSCRIPT_ALLOWED)
	public function addTextToDebug(text:String, color:FlxColor, ?timeTaken:Float = 6) {
		var newText:DebugLuaText = luaDebugGroup.recycle(DebugLuaText);
		newText.text = text;
		newText.color = color;
		newText.disableTime = timeTaken;
		newText.alpha = 1;
		newText.setPosition(10, 8 - newText.height);

		luaDebugGroup.forEachAlive(function(spr:DebugLuaText) {
			spr.y += newText.height + 2;
		});
		luaDebugGroup.add(newText);

		Sys.println(text);
	}
	#end

	public function addCharacterToList(newCharacter:String, type:Int) {
		switch(type) {
			case 0:
				if(!boyfriendMap.exists(newCharacter)) {
					var newBoyfriend:Character = new Character(0, 0, newCharacter);
					boyfriendMap.set(newCharacter, newBoyfriend);
					boyfriendGroup.add(newBoyfriend);
					startCharacterPos(newBoyfriend);
					newBoyfriend.alpha = 0.00001;
					startCharacterScripts(newBoyfriend.curCharacter);
				}

			case 1:
				if(!dadMap.exists(newCharacter)) {
					var newDad:Character = new Character(0, 0, newCharacter);
					dadMap.set(newCharacter, newDad);
					dadGroup.add(newDad);
					startCharacterPos(newDad, true);
					newDad.alpha = 0.00001;
					startCharacterScripts(newDad.curCharacter);
				}

			case 2:
				if(gf != null && !gfMap.exists(newCharacter)) {
					var newGf:Character = new Character(0, 0, newCharacter);
					newGf.scrollFactor.set(0.95, 0.95);
					gfMap.set(newCharacter, newGf);
					gfGroup.add(newGf);
					startCharacterPos(newGf);
					newGf.alpha = 0.00001;
					startCharacterScripts(newGf.curCharacter);
				}
		}
	}

	function startCharacterScripts(name:String)
	{
		// Lua
		#if LUA_ALLOWED
		var doPush:Bool = false;
		var luaFile:String = 'characters/$name.lua';
		#if MODS_ALLOWED
		var replacePath:String = Paths.modFolders(luaFile);
		if(FileSystem.exists(replacePath)) 
		{
			luaFile = replacePath;
			doPush = true;
		} 
		else 
		{
			luaFile = Paths.getPreloadPath(luaFile);
			if(FileSystem.exists(luaFile))
				doPush = true;
		}
		#else
		luaFile = Paths.getPreloadPath(luaFile);
		if(Assets.exists(luaFile)) doPush = true;
		#end

		if(doPush)
		{
			for (script in luaArray)
			{
				if(script.scriptName == luaFile)
				{
					doPush = false;
					break;
				}
			}
			if(doPush) new FunkinLua(luaFile);
		}
		#end


		// HScript
		#if HSCRIPT_ALLOWED
		var doPush:Bool = false;
		var scriptFile:String = 'characters/' + name + '.hx';
		#if MODS_ALLOWED
		var replacePath:String = Paths.modFolders(scriptFile);
		if(FileSystem.exists(replacePath))
		{
			scriptFile = replacePath;
			doPush = true;
		} 
		else 
		#end
		{
			scriptFile = Paths.getPreloadPath(scriptFile);
			if(FileSystem.exists(scriptFile))
				doPush = true;
		}

		if(doPush)
		{
			initHScript(scriptFile);
		}
		#end
	}

	public function getLuaObject(tag:String, text:Bool=true):FlxSprite {
		if(modchartSprites.exists(tag)) return modchartSprites.get(tag);
		if(modchartSkewedSprite.exists(tag)) return modchartSkewedSprite.get(tag);
		if(text && modchartTexts.exists(tag)) return modchartTexts.get(tag);
		if(variables.exists(tag)) return variables.get(tag);
		return null;
	}

	function startCharacterPos(char:Character, ?gfCheck:Bool = false) {
		if(gfCheck && char.curCharacter.startsWith('gf')) { //IF DAD IS GIRLFRIEND, HE GOES TO HER POSITION
			char.setPosition(GF_X, GF_Y);
			char.scrollFactor.set(0.95, 0.95);
			char.danceEveryNumBeats = 2;
		}
		char.x += char.positionArray[0];
		char.y += char.positionArray[1];
	}

	public function startVideo(name:String)
	{
		#if VIDEOS_ALLOWED
		inCutscene = true;

		var filepath:String = Paths.video(name);
		#if sys
		if(!FileSystem.exists(filepath))
		#else
		if(!OpenFlAssets.exists(filepath))
		#end
		{
			FlxG.log.warn('Couldnt find video file: ' + name);
			startAndEnd();
			return;
		}

		var video:VideoHandler = new VideoHandler();
			#if (hxCodec >= "3.0.0")
			// Recent versions
			video.play(filepath);
			video.onEndReached.add(function()
			{
				startAndEnd();
				return;
			}, true);
			#else
			// Older versions
			video.playVideo(filepath);
			video.finishCallback = function()
			{
				startAndEnd();
				return;
			}
			#end
		#else
		FlxG.log.warn('Platform not supported!');
		startAndEnd();
		return;
		#end
	}

	function startAndEnd()
	{
		if(endingSong)
			if (!inResultsScreen)
				endSong();
		else
			if (!inResultsScreen)
				startCountdown();
	}

	var dialogueCount:Int = 0;
	public var psychDialogue:DialogueBoxPsych;
	//You don't have to add a song, just saying. You can just do "startDialogue(dialogueJson);" and it should work
	public function startDialogue(dialogueFile:DialogueFile, ?song:String = null):Void
	{
		// TO DO: Make this more flexible, maybe?
		if(psychDialogue != null) return;

		if(dialogueFile.dialogue.length > 0) {
			inCutscene = true;
			precacheList.set('dialogue', 'sound');
			precacheList.set('dialogueClose', 'sound');
			psychDialogue = new DialogueBoxPsych(dialogueFile, song);
			psychDialogue.scrollFactor.set();
			if(endingSong) {
				psychDialogue.finishThing = function() {
					psychDialogue = null;
					if (!inResultsScreen)
						endSong();
				}
			} else {
				psychDialogue.finishThing = function() {
					psychDialogue = null;
					if (!inResultsScreen)
						startCountdown();
				}
			}
			psychDialogue.nextDialogueThing = startNextDialogue;
			psychDialogue.skipDialogueThing = skipDialogue;
			psychDialogue.cameras = [camHUD];
			add(psychDialogue);
		} else {
			FlxG.log.warn('Your dialogue file is badly formatted!');
			if(endingSong) {
				if (!inResultsScreen)
					endSong();
			} else {
				if (!inResultsScreen)
					startCountdown();
			}
		}
	}

	var startTimer:FlxTimer;
	var finishTimer:FlxTimer = null;

	// For being able to mess with the sprites on Lua
	public var countdownGet:FlxSprite;
	public var countdownReady:FlxSprite;
	public var countdownSet:FlxSprite;
	public var countdownGo:FlxSprite;
	public static var startOnTime:Float = 0;

	function cacheCountdown()
	{
		var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
		introAssets.set('default', ['get', 'ready', 'set', 'go']);
		introAssets.set('pixel', ['pixelUI/ready-pixel', 'pixelUI/set-pixel', 'pixelUI/date-pixel']);

		var introAlts:Array<String> = introAssets.get('default');
		if (isPixelStage) introAlts = introAssets.get('pixel');
		
		for (asset in introAlts)
			Paths.image(asset);
		
		Paths.sound('intro3' + introSoundsSuffix);
		Paths.sound('intro2' + introSoundsSuffix);
		Paths.sound('intro1' + introSoundsSuffix);
		Paths.sound('introGo' + introSoundsSuffix);
	}

	public function updateLuaDefaultPos() {
		for (i in 0...playerStrums.length) {
			setOnScripts('defaultPlayerStrumX' + i, playerStrums.members[i].x);
			setOnScripts('defaultPlayerStrumY' + i, playerStrums.members[i].y);
		}
		for (i in 0...opponentStrums.length) {
			setOnScripts('defaultOpponentStrumX' + i, opponentStrums.members[i].x);
			setOnScripts('defaultOpponentStrumY' + i, opponentStrums.members[i].y);
		}
	}

	public static var ignoreCheckpointOnStart:Bool = false;
	var startedFrom:Float = 0;
	var backwardsSkip:Bool = false;

	public function startCountdown():Void
	{
		var startingfromCheckpoint:Bool = false;
		if(PlayState.checkpointHistory.length > 0 && !PlayState.ignoreCheckpointOnStart){
			startOnTime = PlayState.checkpointHistory[PlayState.checkpointHistory.length-1].time;
			startingfromCheckpoint=true;
			trace("Starting from checkpoint!");

			if (SONG.notITG && notITGMod){
				playfieldRenderer.modifierTable.clear();
				playfieldRenderer.modchart.loadModifiers();
				playfieldRenderer.tweenManager.completeAll();
				playfieldRenderer.eventManager.clearEvents();
				playfieldRenderer.modifierTable.resetMods();
				playfieldRenderer.modchart.loadEvents();
				playfieldRenderer.update(0);
				ModchartFuncs.loadLuaFunctions();
				callOnScripts('onModchart');
			}
		}
		if(startedCountdown) {
			callOnScripts('onStartCountdown');
			return;
		}

		inCutscene = false;
		var ret:Dynamic = callOnScripts('onStartCountdown', null, true);
		if(ret != FunkinLua.Function_Stop) {
			if (skipCountdown || startOnTime > 0) skipArrowStartTween = true;

			generateStaticArrows(0);
			generateStaticArrows(1);

			//add after generating strums
			NoteMovement.getDefaultStrumPos(this);
			
			updateLuaDefaultPos();

			startedCountdown = true;
			Conductor.songPosition = 0;
			Conductor.songPosition = -Conductor.crochet * 5;
			setOnScripts('startedCountdown', true);
			callOnScripts('onCountdownStarted', []);

			var swagCounter:Int = 0;

			backwardsSkip=false;
			if (startOnTime > 0 && startingfromCheckpoint) {
				startedFrom = startOnTime;
				checkpointsUsed++;
				clearNotesBefore(startOnTime);
				setSongTime(startOnTime - Conductor.crochet * 20);
				for (i in 0...playerStrums.length) {
					playerStrums.members[i].alpha=1;
				}
				FlxG.sound.music.volume = 0;
				vocals.volume = 0;
				modchartTweens.set("checkpointVolumeFadeIn", FlxTween.num(0, 1, (Conductor.crochet/1000) * 10, {ease: FlxEase.sineOut, onComplete: function(twn:FlxTween) {
					modchartTweens.remove("checkpointVolumeFadeIn");
				}}, function(v){
					vocals.volume = v;
					FlxG.sound.music.volume = v;
				}));

				//return;
			}
			else if (skipCountdown || startOnTime > 0) {
				if(PlayState.ignoreCheckpointOnStart){
					for (i in 0...playerStrums.length) {
						playerStrums.members[i].alpha = 1;
						opponentStrums.members[i].alpha = 1;
					}
					backwardsSkip=true;
					PlayState.ignoreCheckpointOnStart = false;
					trace("Starting from skip time! " + startOnTime);
				}
				startedFrom = startOnTime;
				clearNotesBefore(startOnTime);
				setSongTime(startOnTime - 500);
				return;
			}

			startTimer = new FlxTimer().start(Conductor.crochet / 1000 / playbackRate, function(tmr:FlxTimer)
			{
				characterBopper(tmr.loopsLeft);

				var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
				introAssets.set('default', ['get', 'ready', 'set', 'go']);
				introAssets.set('pixel', ['pixelUI/ready-pixel', 'pixelUI/set-pixel', 'pixelUI/date-pixel']);

				var introAlts:Array<String> = introAssets.get('default');
				var antialias:Bool = ClientPrefs.globalAntialiasing;
				if(isPixelStage) {
					introAlts = introAssets.get('pixel');
					antialias = false;
				}

				// head bopping for bg characters on Mall
				if(curStage == 'mall') {
					if(!ClientPrefs.lowQuality)
						upperBoppers.dance(true);

					bottomBoppers.dance(true);
					santa.dance(true);
				}

				switch (swagCounter)
				{
					case 0:
						countdownGet = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
						countdownGet.cameras = [camOther];
						countdownGet.scrollFactor.set();
						countdownGet.updateHitbox();

						if (PlayState.isPixelStage)
							countdownGet.setGraphicSize(Std.int(countdownGet.width * daPixelZoom));

						countdownGet.screenCenter();
						countdownGet.antialiasing = antialias;
						insert(members.indexOf(notes), countdownGet);
						FlxTween.tween(countdownGet, {/*y: countdownGet.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								remove(countdownGet);
								countdownGet.destroy();
							}
						});
						FlxG.sound.play(Paths.sound('intro3' + introSoundsSuffix), 1);
					case 1:
						countdownReady = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
						countdownReady.cameras = [camOther];
						countdownReady.scrollFactor.set();
						countdownReady.updateHitbox();

						if (PlayState.isPixelStage)
							countdownReady.setGraphicSize(Std.int(countdownReady.width * daPixelZoom));

						countdownReady.screenCenter();
						countdownReady.antialiasing = antialias;
						insert(members.indexOf(notes), countdownReady);
						FlxTween.tween(countdownReady, {/*y: countdownReady.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								remove(countdownReady);
								countdownReady.destroy();
							}
						});
						FlxG.sound.play(Paths.sound('intro2' + introSoundsSuffix), 1);
					case 2:
						countdownSet = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
						countdownSet.cameras = [camOther];
						countdownSet.scrollFactor.set();

						if (PlayState.isPixelStage)
							countdownSet.setGraphicSize(Std.int(countdownSet.width * daPixelZoom));

						countdownSet.screenCenter();
						countdownSet.antialiasing = antialias;
						insert(members.indexOf(notes), countdownSet);
						FlxTween.tween(countdownSet, {/*y: countdownSet.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								remove(countdownSet);
								countdownSet.destroy();
							}
						});
						FlxG.sound.play(Paths.sound('intro1' + introSoundsSuffix), 1);
					case 3:
						countdownGo = new FlxSprite().loadGraphic(Paths.image(introAlts[3]));
						countdownGo.cameras = [camOther];
						countdownGo.scrollFactor.set();

						if (PlayState.isPixelStage)
							countdownGo.setGraphicSize(Std.int(countdownGo.width * daPixelZoom));

						countdownGo.updateHitbox();

						countdownGo.screenCenter();
						countdownGo.antialiasing = antialias;
						insert(members.indexOf(notes), countdownGo);
						FlxTween.tween(countdownGo, {/*y: countdownGo.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								remove(countdownGo);
								countdownGo.destroy();
							}
						});
						FlxG.sound.play(Paths.sound('introGo' + introSoundsSuffix), 1);
					case 4:
				}

				notes.forEachAlive(function(note:Note) {
					if(ClientPrefs.opponentStrums || note.mustPress)
					{
						note.copyAlpha = false;
						note.alpha = note.multAlpha;
						if(ClientPrefs.middleScroll && !note.mustPress && !forceRightScroll || forceMiddleScroll) {
							note.alpha *= 0.35;
						}
					}
				});
				callOnScripts('onCountdownTick', [swagCounter]);

				swagCounter += 1;
				// generateSong('fresh');
			}, 5);
		}
	}

	public function addBehindGF(obj:FlxObject)
	{
		insert(members.indexOf(gfGroup), obj);
	}
	public function addBehindBF(obj:FlxObject)
	{
		insert(members.indexOf(boyfriendGroup), obj);
	}
	public function addBehindDad (obj:FlxObject)
	{
		insert(members.indexOf(dadGroup), obj);
	}

	public function clearNotesBefore(time:Float)
	{
		var i:Int = unspawnNotes.length - 1;
		while (i >= 0) {
			var daNote:Note = unspawnNotes[i];
			if(daNote.strumTime - 350 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				daNote.ignoreNote = true;

				daNote.kill();
				unspawnNotes.remove(daNote);
				daNote.destroy();
			}
			--i;
		}

		i = notes.length - 1;
		while (i >= 0) {
			var daNote:Note = notes.members[i];
			if(daNote.strumTime - 350 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				daNote.ignoreNote = true;

				daNote.kill();
				notes.remove(daNote, true);
				daNote.destroy();
			}
			--i;
		}
	}

	public function updateScore(miss:Bool = false)
	{
		// hitmansHUD.updateScore();

		if(ClientPrefs.scoreZoom && !miss && !cpuControlled)
		{
			if(hitmansHUD.scoreTxtTween != null) {
				hitmansHUD.scoreTxtTween.cancel();
			}
			hitmansHUD.scoreTxt.scale.x = 1.075;
			hitmansHUD.scoreTxt.scale.y = 1.075;
			hitmansHUD.scoreTxtTween = FlxTween.tween(hitmansHUD.scoreTxt.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					hitmansHUD.scoreTxtTween = null;
				}
			});
		}

		callOnScripts('onUpdateScore', [miss]);
	}

	public function setSongTime(time:Float)
	{
		if(time < 0) time = 0;

		FlxG.sound.music.pause();
		vocals.pause();

		FlxG.sound.music.time = time;
		FlxG.sound.music.pitch = playbackRate;
		FlxG.sound.music.play();

		if (Conductor.songPosition <= vocals.length)
		{
			vocals.time = time;
			vocals.pitch = playbackRate;
		}
		vocals.play();
		Conductor.songPosition = time;
		songTime = time;
	}

	function startNextDialogue() {
		dialogueCount++;
		callOnScripts('onNextDialogue', [dialogueCount]);
	}

	function skipDialogue() {
		callOnScripts('onSkipDialogue', [dialogueCount]);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	public var songTime:Float = 0;

	public var songStarted = false;

	public function startSong():Void
	{
		startingSong = false;
		canPause = true;
		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;
		if((SONG.song.toLowerCase() == "system-reloaded" || SONG.song.toLowerCase() == "metakill" ) && storyDifficulty == 1){
			trace("USING OLD INST");
			FlxG.sound.playMusic(Paths.instClassic(PlayState.SONG.song), 1, false);
		}else{
			trace("USING NEW INST");
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		}
		// addShaderToCamera('hud', threeDShader);
		//FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		FlxG.sound.music.pitch = playbackRate;
		FlxG.sound.music.onComplete = finishSong.bind();
		vocals.play();

		NewHitmansGameOver.characterName = dad.curCharacter;
		
		switch (SONG.song.toLowerCase())
		{
			case "fatal error":
				NewHitmansGameOver.characterName = 'Edwhak';
			case "killer instinct":
				NewHitmansGameOver.characterName = 'Edwhak';
			case "annihilate":
				NewHitmansGameOver.characterName = 'Edwhak';
			case "c18h27no3-demo":
				NewHitmansGameOver.characterName = 'Edwhak';
			case "c18h27no3":
				NewHitmansGameOver.characterName = 'Edwhak';
			case "killbot":
				NewHitmansGameOver.characterName = 'Edwhak';
			case "digital massacre":
				NewHitmansGameOver.characterName = 'HITMANS';
		}

		if(backwardsSkip){
			if(startOnTime > 0)
			{
				setSongTime(startOnTime - 500);
				trace("dumb: " + startOnTime);
			}
		}	
		else
			startOnTime = 0;

		/*if(timeToStart > 0){
			setSongTime(timeToStart);
			timeToStart = 0;
		}*/

		if(paused) {
			//trace('Oopsie doopsie! Paused sound');
			FlxG.sound.music.pause();
			vocals.pause();
		}

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;
		FlxTween.tween(hitmansHUD.timeBar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(hitmansHUD.timeBarBG, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(hitmansHUD.timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

		hitmansHUD.beatHit();

		switch(curStage)
		{
			case 'tank':
				if(!ClientPrefs.lowQuality) tankWatchtower.dance();
				foregroundSprites.forEach(function(spr:BGSprite)
				{
					spr.dance();
				});
		}

		#if desktop
		// Updating Discord Rich Presence (with Time Left)
		if (!inResultsScreen){
			DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter(), true, songLength);
		}
		#end

		for (i in 0...checkpointQueueTimesArray.length) {
			hitmansHUD.markCheckpointOnTimebar(checkpointQueueTimesArray[i]);
		}

		if(!(backwardsSkip || PlayState.ignoreCheckpointOnStart) && PlayState.checkpointHistory.length > 0){
			var checkpoint:CheckpointData = PlayState.checkpointHistory[PlayState.checkpointHistory.length-1];
			trace(checkpoint);
			//trace("Test for sicks: " + PlayState.checkpointMemory_sicks);
			marvelouss = checkpoint.marvelouss;
			sicks = checkpoint.sicks;
			goods = checkpoint.goods;
			bads = checkpoint.bads;
			shits = checkpoint.shits;
			maxCombo = checkpoint.highestCombo;
			songScore = checkpoint.songScore;
			songHits = checkpoint.songHits;
			songMisses = checkpoint.songMisses;

			// hitTimesDiff=checkpoint.hitTimeDiff;
			// hitTimesTime=checkpoint.hitTimesTime;
			// hitTimesJudge=checkpoint.hitTimesJudge;
			// healthSamples=checkpoint.healthSamples;

			totalPlayed = checkpoint.totalPlayed;
			totalNotesHit = checkpoint.totalNotesHit;

			//if(checkpoint.time > 359600 && SONG.song.toLowerCase() == "mindfuck")
			//	mindfuckCheckpointTestCheckThingIDFKANYMOREPLEASESAVEME = true;

			Conductor.bpm=checkpoint.BPM;

			updateScore(true);
			skipIntro(checkpoint.time - Conductor.crochet * 5);

			if (SONG.notITG && notITGMod){
				playfieldRenderer.modifierTable.clear();
				playfieldRenderer.modchart.loadModifiers();
				playfieldRenderer.tweenManager.completeAll();
				playfieldRenderer.eventManager.clearEvents();
				playfieldRenderer.modifierTable.resetMods();
				playfieldRenderer.modchart.loadEvents();
				playfieldRenderer.update(0);
				ModchartFuncs.loadLuaFunctions();
				callOnScripts('onModchart');
			}
			
			trace("fixing modchart");
		}
		else{
		// 	if(introSkip>0 && deathCounter > 0) {
		// 		introSkipSprite.alpha=0;
		// 		add(introSkipSprite);
		// 		//Make introskipsprite fade in because it looks nicer
		// 		FlxTween.tween(introSkipSprite, {alpha: 0.49}, 1.25);
		// 		new FlxTimer().start(5, function(tmr:FlxTimer)
		// 		{
		// 			FlxTween.tween(introSkipSprite, {alpha:0.08}, 1.5, {ease: FlxEase.quadInOut });
		// 		});
		// 	}
		}

		songStarted = true;

		setOnScripts('songLength', songLength);
		callOnScripts('onSongStart', []);
	}

	var skippedIntro:Bool = false;
	var introSkip:Int = 0;
	function skipIntro(?songPosToGoTo:Float=0){
		trace((songPosToGoTo==0?"Skipped Intro!":("Went to position: " + songPosToGoTo)));
		skippedIntro = true;

		FlxG.sound.music.pause();
		vocals.pause();
		if(songPosToGoTo == 0) Conductor.songPosition = introSkip * 1000;
		else Conductor.songPosition = songPosToGoTo;
		notes.forEachAlive(function(daNote:Note)
		{
			if(daNote.strumTime + 800 < Conductor.songPosition) {
				daNote.active = false;
				daNote.visible = false;

				//if(daNote.trailShit!=null)
				//	arrowTrails.remove(daNote.trailShit);
				daNote.kill();
				notes.remove(daNote, true);
				daNote.destroy();
			}
		});
		for (i in 0...unspawnNotes.length) {
			var daNote:Note = unspawnNotes[0];
			if(daNote.strumTime + 800 >= Conductor.songPosition) {
				break;
			}
			daNote.active = false;
			daNote.visible = false;
			daNote.kill();
			unspawnNotes.splice(unspawnNotes.indexOf(daNote), 1);
			daNote.destroy();
		}
		FlxG.sound.music.time = Conductor.songPosition;
		FlxG.sound.music.play();
		FlxG.sound.music.pitch = playbackRate;
		vocals.time = Conductor.songPosition;
		vocals.play();
		vocals.pitch = playbackRate;
		if (startTimer != null && startTimer.finished)
		{
			DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter(), true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
		}
		else
		{
			DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter());
		}
	}

	public static var threadbeat:Array<ThreadBeatList> = [];

	public static function threadBeat(beat:Float, func:Dynamic)
	{
		trace('beat, $beat, func, $func');
		threadbeat.push(new ThreadBeatList(beat, func));
	}

	public static var threadupdate:Array<ThreadUpdateList> = [];

	public static function threadUpdate(startBeat:Float, endBeat:Float, func:Dynamic, onCompleteFunc:Dynamic)
	{
		trace('startingbeat, $startBeat, endingBeat, $endBeat, func, $func, onComplete, $onCompleteFunc');
		threadupdate.push(new ThreadUpdateList(startBeat, endBeat, func, onCompleteFunc));
	}

	var debugNum:Int = 0;
	private var noteTypeMap:Map<String, Bool> = new Map<String, Bool>();
	private var eventPushedMap:Map<String, Bool> = new Map<String, Bool>();
	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());
		songSpeedType = ClientPrefs.getGameplaySetting('scrolltype','multiplicative');

		switch(songSpeedType)
		{
			case "multiplicative":
				songSpeed = SONG.speed * ClientPrefs.getGameplaySetting('scrollspeed', 1);
			case "constant":
				songSpeed = ClientPrefs.getGameplaySetting('scrollspeed', 1);
		}

		var songData = SONG;
		Conductor.bpm = songData.bpm;

		curSong = songData.song;

		if (SONG.needsVoices)
			if((SONG.song.toLowerCase() == "system-reloaded" || SONG.song.toLowerCase() == "metakill" ) && storyDifficulty == 1){
				trace("USING OLD VOCALS");
				vocals = new FlxSound().loadEmbedded(Paths.voicesClassic(PlayState.SONG.song));
			}else{
				trace("USING NEW VOCALS");
				vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
			}
		else
			vocals = new FlxSound();
		
		trace(storyDifficulty);

		vocals.pitch = playbackRate;
		FlxG.sound.list.add(vocals);

		//THE FUCK!? WHY DOUBLE WHAT-

		if((SONG.song.toLowerCase() == "system-reloaded" || SONG.song.toLowerCase() == "metakill" ) && storyDifficulty == 1){
			trace("USING OLD INST");
			FlxG.sound.list.add(new FlxSound().loadEmbedded(Paths.instClassic(PlayState.SONG.song)));
		}else{
			trace("USING NEW INST");
			FlxG.sound.list.add(new FlxSound().loadEmbedded(Paths.inst(PlayState.SONG.song)));
		}
		
		//FlxG.sound.list.add(new FlxSound().loadEmbedded(Paths.inst(PlayState.SONG.song)));

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped

		var songName:String = Paths.formatToSongPath(SONG.song);
		var file:String = Paths.json(songName + '/events');
		#if MODS_ALLOWED
		if (FileSystem.exists(Paths.modsJson(songName + '/events')) || FileSystem.exists(file))
		#else
		if (OpenFlAssets.exists(file))
		#end
		{
			var eventsData:Array<Dynamic> = Song.loadFromJson('events', songName).events;
			for (event in eventsData) //Event Notes
			{
				for (i in 0...event[1].length)
				{
					var newEventNote:Array<Dynamic> = [event[0], event[1][i][0], event[1][i][1], event[1][i][2]];
					var subEvent:EventNote = {
						strumTime: newEventNote[0] + ClientPrefs.noteOffset,
						event: newEventNote[1],
						value1: newEventNote[2],
						value2: newEventNote[3]
					};
					subEvent.strumTime -= eventNoteEarlyTrigger(subEvent);
					eventNotes.push(subEvent);
					eventPushed(subEvent);
				}
			}
		}

		for (section in noteData)
		{
			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				var daNoteData:Int = randomizedNotes ? FlxG.random.int(0, 3) : Std.int(songNotes[1] % 4);

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
				swagNote.gfNote = (section.gfSection && (songNotes[1]<4));
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

						var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(songSpeed, 2)), daNoteData, oldNote, true);
						sustainNote.mustPress = gottaHitNote;
						sustainNote.gfNote = (section.gfSection && (songNotes[1]<4));
						sustainNote.noteType = swagNote.noteType;
						sustainNote.scrollFactor.set();
						swagNote.tail.push(sustainNote);
						sustainNote.parent = swagNote;
						unspawnNotes.push(sustainNote);

						if (sustainNote.mustPress)
						{
							sustainNote.x += FlxG.width / 2; // general offset
						}
						else if(ClientPrefs.middleScroll && !forceRightScroll || forceMiddleScroll)
						{
							sustainNote.x += 310;
							if(daNoteData > 1) //Up and Right
							{
								sustainNote.x += FlxG.width / 2 + 25;
							}
						}
					}
				}

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else if(ClientPrefs.middleScroll && !forceRightScroll || forceMiddleScroll)
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
			daBeats += 1;
		}
		for (event in songData.events) //Event Notes
		{
			for (i in 0...event[1].length)
			{
				var newEventNote:Array<Dynamic> = [event[0], event[1][i][0], event[1][i][1], event[1][i][2]];
				var subEvent:EventNote = {
					strumTime: newEventNote[0] + ClientPrefs.noteOffset,
					event: newEventNote[1],
					value1: newEventNote[2],
					value2: newEventNote[3]
				};
				subEvent.strumTime -= eventNoteEarlyTrigger(subEvent);
				eventNotes.push(subEvent);
				eventPushed(subEvent);
			}
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);
		if(eventNotes.length > 1) { //No need to sort if there's a single one or none at all
			eventNotes.sort(sortByTime);
		}
		checkEventNote();
		generatedMusic = true;
	
		function set_chromaIntensity(value:Float):Float {
			throw new haxe.exceptions.NotImplementedException();
		}
	}

	function eventPushed(event:EventNote) {
		switch(event.event) {
			case "Set CheckPoint":
				markCheckpointQueue(event.strumTime, (event.value1.toLowerCase() == "hide"));
			case 'Change Character':
				var charType:Int = 0;
				switch(event.value1.toLowerCase()) {
					case 'gf' | 'girlfriend' | '1':
						charType = 2;
					case 'dad' | 'opponent' | '0':
						charType = 1;
					default:
						charType = Std.parseInt(event.value1);
						if(Math.isNaN(charType)) charType = 0;
				}

				var newCharacter:String = event.value2;
				addCharacterToList(newCharacter, charType);

			case 'Dadbattle Spotlight':
				dadbattleBlack = new BGSprite(null, -800, -400, 0, 0);
				dadbattleBlack.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
				dadbattleBlack.alpha = 0.25;
				dadbattleBlack.visible = false;
				add(dadbattleBlack);

				dadbattleLight = new BGSprite('spotlight', 400, -400);
				dadbattleLight.alpha = 0.375;
				dadbattleLight.blend = ADD;
				dadbattleLight.visible = false;

				dadbattleSmokes.alpha = 0.7;
				dadbattleSmokes.blend = ADD;
				dadbattleSmokes.visible = false;
				add(dadbattleLight);
				add(dadbattleSmokes);

				var offsetX = 200;
				var smoke:BGSprite = new BGSprite('smoke', -1550 + offsetX, 660 + FlxG.random.float(-20, 20), 1.2, 1.05);
				smoke.setGraphicSize(Std.int(smoke.width * FlxG.random.float(1.1, 1.22)));
				smoke.updateHitbox();
				smoke.velocity.x = FlxG.random.float(15, 22);
				smoke.active = true;
				dadbattleSmokes.add(smoke);
				var smoke:BGSprite = new BGSprite('smoke', 1550 + offsetX, 660 + FlxG.random.float(-20, 20), 1.2, 1.05);
				smoke.setGraphicSize(Std.int(smoke.width * FlxG.random.float(1.1, 1.22)));
				smoke.updateHitbox();
				smoke.velocity.x = FlxG.random.float(-15, -22);
				smoke.active = true;
				smoke.flipX = true;
				dadbattleSmokes.add(smoke);


			case 'Philly Glow':
				blammedLightsBlack = new FlxSprite(FlxG.width * -0.5, FlxG.height * -0.5).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
				blammedLightsBlack.visible = false;
				insert(members.indexOf(phillyStreet), blammedLightsBlack);

				phillyWindowEvent = new BGSprite('philly/window', phillyWindow.x, phillyWindow.y, 0.3, 0.3);
				phillyWindowEvent.setGraphicSize(Std.int(phillyWindowEvent.width * 0.85));
				phillyWindowEvent.updateHitbox();
				phillyWindowEvent.visible = false;
				insert(members.indexOf(blammedLightsBlack) + 1, phillyWindowEvent);


				phillyGlowGradient = new PhillyGlow.PhillyGlowGradient(-400, 225); //This shit was refusing to properly load FlxGradient so fuck it
				phillyGlowGradient.visible = false;
				insert(members.indexOf(blammedLightsBlack) + 1, phillyGlowGradient);
				if(!ClientPrefs.flashing) phillyGlowGradient.intendedAlpha = 0.7;

				precacheList.set('philly/particle', 'image'); //precache particle image
				phillyGlowParticles = new FlxTypedGroup<PhillyGlow.PhillyGlowParticle>();
				phillyGlowParticles.visible = false;
				insert(members.indexOf(phillyGlowGradient) + 1, phillyGlowParticles);
		}

		if(!eventPushedMap.exists(event.event)) {
			eventPushedMap.set(event.event, true);
		}
	}

	function eventNoteEarlyTrigger(event:EventNote):Float {
		var returnedValue:Null<Float> = callOnScripts('eventEarlyTrigger', [event.event, event.value1, event.value2, event.strumTime], true, [], [0]);
		if(returnedValue != null && returnedValue != 0 && returnedValue != FunkinLua.Function_Continue) {
			return returnedValue;
		}

		switch(event.event) {
			case 'Kill Henchmen': //Better timing so that the kill sound matches the beat intended
				return 280; //Plays 280ms before the actual position
		}
		return 0;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	function sortByTime(Obj1:EventNote, Obj2:EventNote):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	public var skipArrowStartTween:Bool = false; //for lua
	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var targetAlpha:Float = 1;
			if (player < 1)
			{
				if(!ClientPrefs.opponentStrums) targetAlpha = 0;
				else if(ClientPrefs.middleScroll && !forceRightScroll || forceMiddleScroll) targetAlpha = 0.35;
			}

			var babyArrow:StrumNote = new StrumNote(!forcedAScroll ? (ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X) : 
																	(if (forceRightScroll && !forceMiddleScroll) STRUM_X 
																	else if (forceMiddleScroll && !forceRightScroll) STRUM_X_MIDDLESCROLL 
																	else ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X)
			, strumLine.y, i, player);
			babyArrow.downScroll = ClientPrefs.downScroll;
			if (!isStoryMode && !skipArrowStartTween)
			{
				//babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {/*y: babyArrow.y + 10,*/ alpha: targetAlpha}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}
			else
			{
				babyArrow.alpha = targetAlpha;
			}

			if (player == 1)
			{
				playerStrums.add(babyArrow);
			}
			else
			{
				if(ClientPrefs.middleScroll && !forceRightScroll || forceMiddleScroll)
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

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			if (startTimer != null && !startTimer.finished)
				startTimer.active = false;
			if (finishTimer != null && !finishTimer.finished)
				finishTimer.active = false;
			if (songSpeedTween != null)
				songSpeedTween.active = false;

			if(carTimer != null) carTimer.active = false;

			for (tween in modchartTweens) {
				tween.active = false;
			}
			for (timer in modchartTimers) {
				timer.active = false;
			}
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		
		if (PauseSubState.goToOptions){
			if (PauseSubState.goBack)
			{
				PauseSubState.goToOptions = false;

				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				PauseSubState.goBack = false;
			}
			else
			{
				openSubState(new OptionsMenu(true));
			}
		}else if (PauseSubState.goToModifiers)
		{
			trace("pause thingyt");
			if (PauseSubState.goBackToPause)
			{
				trace("pause thingyt");
				PauseSubState.goToModifiers = false;

				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				PauseSubState.goBackToPause = false;
			}
			else
			{
				openSubState(new GameplayChangersSubstate(true));
			}
		}
		else if (paused){
				
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (startTimer != null && !startTimer.finished)
				startTimer.active = true;
			if (finishTimer != null && !finishTimer.finished)
				finishTimer.active = true;
			if (songSpeedTween != null)
				songSpeedTween.active = true;

			if(carTimer != null) carTimer.active = true;
			for (tween in modchartTweens) {
				tween.active = true;
			}
			for (timer in modchartTimers) {
				timer.active = true;
			}
			paused = false;
			callOnLuas('onResume', []);

			#if desktop
			if (!inResultsScreen){
				if (startTimer != null && startTimer.finished)
				{
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter(), true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
				}
				else
				{
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter());
				}
			}
			#end
		}

		super.closeSubState();
	}

	override public function onFocus():Void
	{
		#if desktop
		if (health > 0 && !paused)
		{
			if (!inResultsScreen){
				if (Conductor.songPosition > 0.0)
				{
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter(), true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
				}
				else
				{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter());
				}
			}
		}
		#end

		super.onFocus();
	}

	override public function onFocusLost():Void
	{
		#if desktop
		if (health > 0 && !paused)
		{
			if (!inResultsScreen){
				DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter());
			}
		}
		#end

		super.onFocusLost();
	}

	function resyncVocals():Void
	{
		if(finishTimer != null) return;

		vocals.pause();

		FlxG.sound.music.play();
		FlxG.sound.music.pitch = playbackRate;
		Conductor.songPosition = FlxG.sound.music.time;
		if (Conductor.songPosition <= vocals.length)
		{
			vocals.time = Conductor.songPosition;
			vocals.pitch = playbackRate;
		}
		vocals.play();
	}

	public function getScrollPos(time:Float, mult:Float = 1)
		{
			var speed:Float = songSpeed * mult;
			return (-(time * (0.45 * speed)));
		}
	
		public function getScrollPosByStrum(strum:Float, mult:Float = 1)
		{
			return getScrollPos(Conductor.songPosition - strum, mult);
		}

	public var paused:Bool = false;
	public var canReset:Bool = true;
	var startedCountdown:Bool = false;
	var canPause:Bool = false;
	var limoSpeed:Float = 0;
	var lastSection:Int = 0;
	public var camDisplaceX:Float = 0;
	public var camDisplaceY:Float = 0;
	var fakeCrochet:Float = 5000;
	var pisslets:Float = 0;

	public function getXPosition(diff:Float, direction:Int, player:Int):Float
		{
			var x:Float = (FlxG.width / 2) - Note.swagWidth - 54 + Note.swagWidth * direction;
			if (!ClientPrefs.middleScroll && !forceRightScroll || forceMiddleScroll)
			{
				switch (player)
				{
					case 0:
						x += FlxG.width / 2 - Note.swagWidth * 2 - 100;
					case 1:
						x -= FlxG.width / 2 - Note.swagWidth * 2 - 100;
				}
			}
			x -= 56;
	
			return x;
		}

	var resetted:Bool = false;
	override public function update(elapsed:Float)
	{
		/*if (FlxG.keys.justPressed.NINE)
		{
			iconP1.swapOldIcon();
		}*/
		callOnScripts('onUpdate', [elapsed]);
		if (notITGMod && SONG.notITG)
			playfieldRenderer.speed = playbackRate; //LMAO IT LOOKS SOO GOOFY AS FUCK
		
		
		if (aftBitmap != null) aftBitmap.update(elapsed); //if it fail this don't load

		// refresh(); //z sort shit LOL
		// refreshZ();

		switch (modChartEffect){
			case 4:
				for (i in 0...playerStrums.length) {
					playerStrums.members[i].x = FlxMath.lerp(
					modChartDefaultStrumX[i+4], 
					modChartDefaultStrumX[i+4] + (Math.sin((Conductor.songPosition/(Conductor.crochet*16))*Math.PI) * -200), 
					modChartVariable1);
				}

			case 1:
				//Scrolling effect/infinite shit lmao
				//x spacing is 112!!!! -Haz
				//New logic:
				//Scrolling Horizontal
				for (i in 0...playerStrums.length) {
					playerStrums.members[i].x += modChartVariable1;
					opponentStrums.members[i].x += modChartVariable1;
					//if(i == 1) trace(playerStrums.members[i].x);
				}
				if(SONG.song.toLowerCase()=="her" && curBeat < 608){
					//Checking if it needs to be looped around
					if(modChartVariable1>0){
						if(playerStrums.members[1].x >= 1250){
							playerStrums.members[2].x = -120;
							playerStrums.members[1].x = playerStrums.members[2].x-112;
							playerStrums.members[3].x = playerStrums.members[2].x+112; 
							playerStrums.members[0].x = playerStrums.members[2].x-224;
						}
					}else{
						if(playerStrums.members[2].x <= -120){
							playerStrums.members[1].x = 1250;
							playerStrums.members[0].x = playerStrums.members[1].x-112;
							playerStrums.members[2].x = playerStrums.members[1].x+112; 
							playerStrums.members[3].x = playerStrums.members[1].x+224;
						}
					}
					if(modChartVariable1>0){
						if(opponentStrums.members[1].x >= 1250){
							opponentStrums.members[2].x = -120;
							opponentStrums.members[1].x = opponentStrums.members[2].x-112;
							opponentStrums.members[3].x = opponentStrums.members[2].x+112; 
							opponentStrums.members[0].x = opponentStrums.members[2].x-224;
						}
					}else{
						if(opponentStrums.members[2].x <= -120){
							opponentStrums.members[1].x = 1250;
							opponentStrums.members[0].x = opponentStrums.members[1].x-112;
							opponentStrums.members[2].x = opponentStrums.members[1].x+112; 
							opponentStrums.members[3].x = opponentStrums.members[1].x+224;
						}
					}
				}else{
					//Checking if it needs to be looped around
					if(modChartVariable1>0){
						if(playerStrums.members[1].x >= 1400){
							playerStrums.members[2].x = -270;
							playerStrums.members[1].x = playerStrums.members[2].x-112;
							playerStrums.members[3].x = playerStrums.members[2].x+112; 
							playerStrums.members[0].x = playerStrums.members[2].x-224;
						}
					}else{
						if(playerStrums.members[2].x <= -270){
							playerStrums.members[1].x = 1400;
							playerStrums.members[0].x = playerStrums.members[1].x-112;
							playerStrums.members[2].x = playerStrums.members[1].x+112; 
							playerStrums.members[3].x = playerStrums.members[1].x+224;
						}
					}
					if(modChartVariable1>0){
						if(opponentStrums.members[1].x >= 1400){
							opponentStrums.members[2].x = -270;
							opponentStrums.members[1].x = opponentStrums.members[2].x-112;
							opponentStrums.members[3].x = opponentStrums.members[2].x+112; 
							opponentStrums.members[0].x = opponentStrums.members[2].x-224;
						}
					}else{
						if(opponentStrums.members[2].x <= -270){
							opponentStrums.members[1].x = 1400;
							opponentStrums.members[0].x = opponentStrums.members[1].x-112;
							opponentStrums.members[2].x = opponentStrums.members[1].x+112; 
							opponentStrums.members[3].x = opponentStrums.members[1].x+224;
						}
					}
				}

			case 7:
				//Speen (code from Inhuman mod. Does this count as an Inhuman mod leak?)
				for (i in 0...playerStrums.length) {
					if(i % 2 == 0){
						playerStrums.members[i].x = modChartDefaultStrumX[i+4]+55 + (Math.cos((Conductor.songPosition/Conductor.crochet)*Math.PI) * -55);
						playerStrums.members[i].y = modChartDefaultStrumY[i+4] + (Math.sin((Conductor.songPosition/Conductor.crochet)*Math.PI) * -55);
					}else{
						playerStrums.members[i].x = modChartDefaultStrumX[i+4]-55 + (Math.cos((Conductor.songPosition/Conductor.crochet)*Math.PI) * 55);
						playerStrums.members[i].y = modChartDefaultStrumY[i+4] + (Math.sin((Conductor.songPosition/Conductor.crochet)*Math.PI) * 55);
					}
				}

			
			case 2:
				//Screen shaking effect
				camHUD.angle = Math.sin((Conductor.songPosition/Conductor.crochet)*Math.PI) * modChartVariable1;

			case 8:
				camHUD.angle = 0;
			default:
				//do nothing
		}
		if (drain){
			if (!ClientPrefs.casualMode){
				health -= 0.0035;
				new FlxTimer().start(3, function(subtmr2:FlxTimer)
					{
					drain = false;
				});
			}else if (ClientPrefs.casualMode){
				health -= 0.002;
				new FlxTimer().start(3, function(subtmr2:FlxTimer)
					{
					drain = false;
				});
			}
		}
		if (gain){
			if (!ClientPrefs.casualMode){
				health += 0.003;
				new FlxTimer().start(3, function(subtmr3:FlxTimer)
					{
					gain = false;
				});
			}else if (ClientPrefs.casualMode){
				health += 0.004;
				new FlxTimer().start(3, function(subtmr3:FlxTimer)
					{
					gain = false;
				});
			}
		}
		if (tgain){
			if (!ClientPrefs.casualMode){
				health += 0.004;
				new FlxTimer().start(3, function(subtmr3:FlxTimer)
					{
					tgain = false;
				});
			}else if (ClientPrefs.casualMode){
				health += 0.006;
				new FlxTimer().start(3, function(subtmr3:FlxTimer)
					{
					tgain = false;
				});
			}
		}

		if (health <= 0)
			health = 0;
		else if (health >= 2)
			health = 2;
		
		if(!inCutscene) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 2.4 * cameraSpeed * playbackRate, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
			if(!startingSong && !endingSong && boyfriend.animation.curAnim != null && boyfriend.animation.curAnim.name.startsWith('idle')) {
				boyfriendIdleTime += elapsed;
				if(boyfriendIdleTime >= 0.15) { // Kind of a mercy thing for making the achievement easier to get as it's apparently frustrating to some playerss
					boyfriendIdled = true;
				}
			} else {
				boyfriendIdleTime = 0;
			}
		}

		if (!paused)
		{
			tweenManager.update(elapsed);
			timerManager.update(elapsed);
		}

		super.update(elapsed);

		setOnScripts('curDecStep', curDecStep);
		setOnScripts('curDecBeat', curDecBeat);

		if ((controls.PAUSE || !Main.focused) && startedCountdown && canPause && !inResultsScreen)
		{
			var ret:Dynamic = callOnScripts('onPause', null, true);
			if(ret != FunkinLua.Function_Stop) {
				persistentUpdate = false;
				persistentDraw = true;
				paused = true;
		
				// 1 / 1000 chance for Gitaroo Man easter egg
				/*if (FlxG.random.bool(0.1))
				{
					// gitaroo man easter egg
					cancelMusicFadeTween();
					MusicBeatState.switchState(new GitarooPause());
				}
				else {*/
				if(FlxG.sound.music != null) {
					FlxG.sound.music.pause();
					vocals.pause();
				}
				if (!inResultsScreen)
					openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				//}
		
				#if desktop
				if (!inResultsScreen)
					DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter());
				#end
			}
		}

		if (!endingSong && !inCutscene)
		{
			if (FlxG.keys.anyJustPressed(debugKeysModchart)){
				if (hitmansSongs.contains(SONG.song.toLowerCase()) && !ClientPrefs.edwhakMode && !ClientPrefs.developerMode){
					antiCheat();
				}else{
					openModchartEditor();
				}
			}else if (FlxG.keys.anyJustPressed(debugKeysChart))
			{
				if (hitmansSongs.contains(SONG.song.toLowerCase()) && !ClientPrefs.edwhakMode && !ClientPrefs.developerMode){
					antiCheat();
				}else{
					openChartEditor();
				}
			}else if (FlxG.keys.anyJustPressed(debugKeysCharacter)) {
				persistentUpdate = false;
				paused = true;
				cancelMusicFadeTween();
				#if desktop DiscordClient.resetClientID(); #end
				MusicBeatState.switchState(new CharacterEditorState(SONG.player2));
			}
		}

		hitmansHUD.setHealth(health,elapsed,playbackRate);
		hitmansHUD.setScore(songScore, songMisses, ratingName, ratingPercent, ratingFC, combo, comboOp, separateCombo);
		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000 * playbackRate;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			Conductor.songPosition += FlxG.elapsed * 1000 * playbackRate;
			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}

				if(updateTime) {
					var curTime:Float = Conductor.songPosition - ClientPrefs.noteOffset;
					if(curTime < 0) curTime = 0;
					songPercent = (curTime / songLength);
					hitmansHUD.setTime(songLength);
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		var shaderThing = FunkinLua.lua_Shaders;

		for(shaderKey in shaderThing.keys())
		{
			if(shaderThing.exists(shaderKey))
				shaderThing.get(shaderKey).update(elapsed);
		}

		while (threadbeat.length > 0 && threadbeat[0] != null && curDecBeat >= threadbeat[0].beat) {
			threadbeat[0].func();
			threadbeat.splice(0, 1);
		}

		while (threadupdate.length > 0 && threadupdate[0] != null) {
			if (curDecBeat >= threadupdate[0].startbeat && curDecBeat < threadupdate[0].endbeat)
				threadupdate[0].func();
			else if (curDecBeat >= threadupdate[0].endbeat){
				if (threadupdate[0].oncompletefunc != null) threadupdate[0].oncompletefunc();
				threadupdate.splice(0, 1);
			}
		}
		
		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125 * camZoomingDecay * playbackRate), 0, 1));
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125 * camZoomingDecay * playbackRate), 0, 1));
		}

		FlxG.watch.addQuick("secShit", curSection);
		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		// RESET = Quick Game Over Screen
		if (!ClientPrefs.noReset && controls.RESET && canReset && !inCutscene && startedCountdown && !endingSong)
		{
			health = 0;
			trace("RESET = True");
		}
		doDeathCheck();

		if (unspawnNotes[0] != null)
		{
			var time:Float = spawnTime;
			if(songSpeed < 1) time /= songSpeed;
			if(unspawnNotes[0].multSpeed < 1) time /= unspawnNotes[0].multSpeed;

			while (unspawnNotes.length > 0 && unspawnNotes[0].strumTime - Conductor.songPosition < time)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.insert(0, dunceNote);
				dunceNote.spawned=true;
				callOnLuas('onSpawnNote', [notes.members.indexOf(dunceNote), dunceNote.noteData, dunceNote.noteType, dunceNote.isSustainNote, dunceNote.strumTime]);
				callOnHScript('onSpawnNote', [dunceNote]);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic && !inCutscene)
		{
			if(!cpuControlled) {
				keyShit();
			} else playerDance();

			if(startedCountdown)
			{
				var fakeCrochet:Float = (60 / SONG.bpm) * 1000;
				var isHolding:Bool = false;
				notes.forEachAlive(function(daNote:Note)
				{
					var strumGroup:FlxTypedGroup<StrumNote> = playerStrums;
					if(!daNote.mustPress) strumGroup = opponentStrums;

					var strumX:Float = strumGroup.members[daNote.noteData].x;
					var strumY:Float = strumGroup.members[daNote.noteData].y;
					var strumAngle:Float = strumGroup.members[daNote.noteData].angle;
					var strumDirection:Float = strumGroup.members[daNote.noteData].direction;
					var strumAlpha:Float = strumGroup.members[daNote.noteData].alpha;
					var strumScroll:Bool = strumGroup.members[daNote.noteData].downScroll;

					strumX += daNote.offsetX;
					strumY += daNote.offsetY;
					strumAngle += daNote.offsetAngle;
					strumAlpha *= daNote.multAlpha;

					if (strumScroll) //Downscroll
					{
						//daNote.y = (strumY + 0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed);
						daNote.distance = (0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed * daNote.multSpeed);
					}
					else //Upscroll
					{
						//daNote.y = (strumY - 0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed);
						daNote.distance = (-0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed * daNote.multSpeed);
					}

					var angleDir = strumDirection * Math.PI / 180;
					if (daNote.copyAngle)
						daNote.angle = strumDirection - 90 + strumAngle;

					if(daNote.copyAlpha)
						daNote.alpha = strumAlpha;
					
					if(daNote.copyX)
						daNote.x = strumX + Math.cos(angleDir) * daNote.distance;

					if(daNote.copyY)
					{
						daNote.y = strumY + Math.sin(angleDir) * daNote.distance;

						//Jesus fuck this took me so much mother fucking time AAAAAAAAAA
						if(strumScroll && daNote.isSustainNote)
						{
							if (daNote.animation.curAnim.name.endsWith('end')) {
								daNote.y += 10.5 * (fakeCrochet / 400) * 1.5 * songSpeed + (46 * (songSpeed - 1));
								daNote.y -= 46 * (1 - (fakeCrochet / 600)) * songSpeed;
								if(PlayState.isPixelStage) {
									daNote.y += 8 + (6 - daNote.originalHeightForCalcs) * PlayState.daPixelZoom;
								} else {
									daNote.y -= 19;
								}
							}
							daNote.y += (Note.swagWidth / 2) - (60.5 * (songSpeed - 1));
							daNote.y += 27.5 * ((SONG.bpm / 100) - 1) * (songSpeed - 1);
						}
					}

					if (!daNote.mustPress && daNote.wasGoodHit && !daNote.hitByOpponent && !daNote.ignoreNote)
					{
						opponentNoteHit(daNote);
						if (controlsPlayer2){
							if (Conductor.songPosition > noteKillOffset + daNote.strumTime){		
								daNote.active = false;
								daNote.visible = false;
								
								daNote.kill();
								notes.remove(daNote, true);
								daNote.destroy();
							}
						}
					}

					if(!daNote.blockHit && daNote.mustPress && cpuControlled && daNote.canBeHit) {
						if(daNote.isSustainNote) {
							if(daNote.canBeHit) {
								goodNoteHit(daNote);
							}
						} else if(daNote.strumTime <= Conductor.songPosition || daNote.isSustainNote) {
							goodNoteHit(daNote);
						}
					}

					var center:Float = strumY + Note.swagWidth / 2;
					if(strumGroup.members[daNote.noteData].sustainReduce && daNote.isSustainNote && (daNote.mustPress || !daNote.ignoreNote) &&
						(!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit))))
					{
						if (strumScroll)
						{
							if(daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= center)
							{
								var swagRect = new FlxRect(0, 0, daNote.frameWidth, daNote.frameHeight);
								swagRect.height = (center - daNote.y) / daNote.scale.y;
								swagRect.y = daNote.frameHeight - swagRect.height;

								daNote.clipRect = swagRect;
							}
						}
						else
						{
							if (daNote.y + daNote.offset.y * daNote.scale.y <= center)
							{
								var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
								swagRect.y = (center - daNote.y) / daNote.scale.y;
								swagRect.height -= swagRect.y;

								daNote.clipRect = swagRect;
							}
						}
					}

					// Kill extremly late notes and cause misses
					if (Conductor.songPosition > noteKillOffset + daNote.strumTime)
					{
						if (daNote.mustPress && !cpuControlled &&!daNote.ignoreNote && !endingSong && (daNote.tooLate || !daNote.wasGoodHit)) {
							noteMiss(daNote);
						}

						daNote.active = false;
						daNote.visible = false;
	
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}	
				});
			}
			else
			{
				notes.forEachAlive(function(daNote:Note)
				{
					daNote.canBeHit = false;
					daNote.wasGoodHit = false;
				});
			}
		}
		checkEventNote();

		#if debug
		if(!endingSong && !startingSong) {
			if (FlxG.keys.justPressed.ONE) {
				KillNotes();
				FlxG.sound.music.onComplete();
			}
			if(FlxG.keys.justPressed.TWO) { //Go 10 seconds into the future :O
				setSongTime(Conductor.songPosition + 10000);
				clearNotesBefore(Conductor.songPosition);
			}
		}
		#end
		setOnScripts('cameraX', camFollowPos.x);
		setOnScripts('cameraY', camFollowPos.y);
		setOnScripts('botPlay', cpuControlled);

		if (shaderUpdates != [])
			{
				for (i in shaderUpdates){
					i(elapsed);
				}
			}

		callOnScripts('onUpdatePost', [elapsed]);

		//code by someguywhouhhhh on discord
		var sustainScale = (((120 / PlayState.SONG.bpm) * (songSpeed * 1.278414)) * (PlayState.isPixelStage ? (PlayState.daPixelZoom * 1.222222222) : 1)) + (0.000014 * songSpeed);
		set_smoothNotes(unspawnNotes, sustainScale);
		set_smoothNotes(notes.members, sustainScale);
		if (ClientPrefs.quantization)
			noteQuantUpdatePost();
	}
	
	function set_smoothNotes(noteGroup:Array<Note>, sustainScale:Float) {
		for (note in noteGroup) {
			if (note.isSustainNote && note.scale.y != sustainScale * (44 / (note.frameHeight * (PlayState.isPixelStage ? (PlayState.daPixelZoom * 1.222222222) : 1)))) {
				if (!StringTools.endsWith(note.animation.curAnim.name, 'end')) {
					note.scale.y = sustainScale * (44 / (note.frameHeight * (PlayState.isPixelStage ? (PlayState.daPixelZoom * 1.222222222) : 1)));
					note.updateHitbox();
				} else {
					note.offsetY = 0.01375;
				}
				note.antialiasing = false;
			}
		}
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

	function openPauseMenu()
	{
		persistentUpdate = false;
		persistentDraw = true;
		paused = true;

		if(FlxG.sound.music != null) {
			FlxG.sound.music.pause();
			vocals.pause();
		}
		if (!inResultsScreen)
			openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

		#if desktop
		if (!inResultsScreen){
			DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter());
		}
		#end
	}

	function antiCheat()
	{
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
			DiscordClient.changePresence("CHEATER CHEATER CHEATER CHEATER CHEATER CHEATER ", StringTools.replace(SONG.song, '-', ' '));
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

	public static function resetPlayData()
	{
		PlayState.deathCounter = 0;
		PlayState.seenCutscene = false;
		PlayState.checkpointsUsed = 0;
		PlayState.checkpointHistory = [];
		PlayState.startOnTime = 0;
		PlayState.ignoreCheckpointOnStart = false;
	}

	function openChartEditor()
	{
		resetPlayData();
		persistentUpdate = false;
		paused = true;
		cancelMusicFadeTween();
		MusicBeatState.switchState(new ChartingState());
		chartingMode = true;

		#if desktop
		DiscordClient.changePresence("Chart Editor", null, null, true);
		DiscordClient.resetClientID();
		#end
	}

	function openModchartEditor(?old:Bool)
	{
		resetPlayData();
		persistentUpdate = false;
		paused = true;
		cancelMusicFadeTween();
		MusicBeatState.switchState(new modcharting.ModchartEditorState());

		chartingMode = true;
	
		#if desktop
		DiscordClient.changePresence("Modchart Editor", null, null, true);
		DiscordClient.resetClientID();
		#end
	}

	public var isDead:Bool = false; //Don't mess with this on Lua!!!
	public var diedPractice:Bool = false; //to fix all stuff since isDead bug all LMAO
	function doDeathCheck(?skipHealthCheck:Bool = false) {
		if (((skipHealthCheck && instakillOnMiss) || health <= 0) && !practiceMode && !isDead)
		{
			canPause = false;
			var ret:Dynamic = callOnScripts('onGameOver', null, true);
			if(ret != FunkinLua.Function_Stop) {
				gameOver = true; //just for notes to stop changing variables while gameOver does the funny
				boyfriend.stunned = true;
				deathCounter++;

				paused = true;

				persistentUpdate = false;
				persistentDraw = false;
				for (tween in modchartTweens) {
					tween.active = true;
				}
				for (timer in modchartTimers) {
					timer.active = true;
				}
				var defaultPlaybackRate:Float = playbackRate;
				FlxTween.num(defaultPlaybackRate, 0, 2, {onUpdate: 	function(tween:FlxTween){
					var thing = FlxMath.lerp(defaultPlaybackRate,0, tween.percent);
                    playbackRate = thing;
				},ease:FlxEase.elasticOut, onComplete: function(tween:FlxTween) {
					playbackRate = 1;
				}});
				FlxTween.tween(staticDeath, {alpha: 1}, 2, {ease:FlxEase.sineIn, onComplete:function(daTween:FlxTween){
					FlxG.sound.music.volume = 0;
					vocals.volume = 0;
					// vocals.stop();
					vocals.pause();
					FlxG.sound.play(Paths.sound('Edwhak/deathSound'), 1, false);
					playbackRate = 1;
					staticDeath.alpha = 0;
                	offEffect.alpha = 1;
                	offEffect.animation.play('play');
					new FlxTimer().start(1, function(tmr2:FlxTimer)
					{
						vocals.stop();
						FlxG.sound.music.stop();
						openSubState(new NewHitmansGameOver(deathVariableTXT,this));	
					});
				}});
				//openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x - boyfriend.positionArray[0], boyfriend.getScreenPosition().y - boyfriend.positionArray[1], camFollowPos.x, camFollowPos.y));

				// MusicBeatState.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

				#if ACHIEVEMENTS_ALLOWED
				var kills = Achievements.addScore("inmortal");
				FlxG.log.add('Deaths: $kills');
				trace('Deaths: ' + kills);
				#end

				#if desktop
				// Game Over doesn't get his own variable because it's only used here
				DiscordClient.changePresence("Game Over - " + detailsText, SONG.song + " (" + storyDifficultyText + ")", hitmansHUD.iconP2.getCharacter());
				#end
				isDead = true;
				return true;
			}
		}else if (((skipHealthCheck && instakillOnMiss) || health <= 0) && practiceMode && !diedPractice){
			diedPractice = true; //bro died in practice mode LMAO
			var youdied:huds.DiedHud = new huds.DiedHud(deathVariableTXT); //should work ig?
			youdied.cameras = [camOther];
        	add(youdied);
		}
		return false;
	}

	public function checkEventNote() {
		while(eventNotes.length > 0) {
			var leStrumTime:Float = eventNotes[0].strumTime;
			if(Conductor.songPosition < leStrumTime) {
				break;
			}

			var value1:String = '';
			if(eventNotes[0].value1 != null)
				value1 = eventNotes[0].value1;

			var value2:String = '';
			if(eventNotes[0].value2 != null)
				value2 = eventNotes[0].value2;

			triggerEventNote(eventNotes[0].event, value1, value2, leStrumTime);
			eventNotes.shift();
		}
	}

	public function getControl(key:String) {
		var pressed:Bool = Reflect.getProperty(controls, key);
		//trace('Control result: ' + pressed);
		return pressed;
	}

	public function triggerEventNote(eventName:String, value1:String, value2:String, strumTime:Float) {
		switch(eventName) {
			case 'Dadbattle Spotlight':
				var val:Null<Int> = Std.parseInt(value1);
				if(val == null) val = 0;

				switch(Std.parseInt(value1))
				{
					case 1, 2, 3: //enable and target dad
						if(val == 1) //enable
						{
							dadbattleBlack.visible = true;
							dadbattleLight.visible = true;
							dadbattleSmokes.visible = true;
							defaultCamZoom += 0.12;
						}

						var who:Character = dad;
						if(val > 2) who = boyfriend;
						//2 only targets dad
						dadbattleLight.alpha = 0;
						new FlxTimer().start(0.12, function(tmr:FlxTimer) {
							dadbattleLight.alpha = 0.375;
						});
						dadbattleLight.setPosition(who.getGraphicMidpoint().x - dadbattleLight.width / 2, who.y + who.height - dadbattleLight.height + 50);

					default:
						dadbattleBlack.visible = false;
						dadbattleLight.visible = false;
						defaultCamZoom -= 0.12;
						FlxTween.tween(dadbattleSmokes, {alpha: 0}, 1, {onComplete: function(twn:FlxTween)
						{
							dadbattleSmokes.visible = false;
						}});
				}

			case 'Hey!':
				var value:Int = 2;
				switch(value1.toLowerCase().trim()) {
					case 'bf' | 'boyfriend' | '0':
						value = 0;
					case 'gf' | 'girlfriend' | '1':
						value = 1;
				}

				var time:Float = Std.parseFloat(value2);
				if(Math.isNaN(time) || time <= 0) time = 0.6;

				if(value != 0) {
					if(dad.curCharacter.startsWith('gf')) { //Tutorial GF is actually Dad! The GF is an imposter!! ding ding ding ding ding ding ding, dindinding, end my suffering
						dad.playAnim('cheer', true);
						dad.specialAnim = true;
						dad.heyTimer = time;
					} else if (gf != null) {
						gf.playAnim('cheer', true);
						gf.specialAnim = true;
						gf.heyTimer = time;
					}

					if(curStage == 'mall') {
						bottomBoppers.animation.play('hey', true);
						heyTimer = time;
					}
				}
				if(value != 1) {
					boyfriend.playAnim('hey', true);
					boyfriend.specialAnim = true;
					boyfriend.heyTimer = time;
				}

			case 'Set GF Speed':
				var value:Int = Std.parseInt(value1);
				if(Math.isNaN(value) || value < 1) value = 1;
				gfSpeed = value;

			case 'Philly Glow':
				var lightId:Int = Std.parseInt(value1);
				if(Math.isNaN(lightId)) lightId = 0;

				var doFlash:Void->Void = function() {
					var color:FlxColor = FlxColor.WHITE;
					if(!ClientPrefs.flashing) color.alphaFloat = 0.5;

					FlxG.camera.flash(color, 0.15, null, true);
				};

				var chars:Array<Character> = [boyfriend, gf, dad];
				switch(lightId)
				{
					case 0:
						if(phillyGlowGradient.visible)
						{
							doFlash();
							if(ClientPrefs.camZooms)
							{
								FlxG.camera.zoom += 0.5;
								camHUD.zoom += 0.1;
							}

							blammedLightsBlack.visible = false;
							phillyWindowEvent.visible = false;
							phillyGlowGradient.visible = false;
							phillyGlowParticles.visible = false;
							curLightEvent = -1;

							for (who in chars)
							{
								who.color = FlxColor.WHITE;
							}
							phillyStreet.color = FlxColor.WHITE;
						}

					case 1: //turn on
						curLightEvent = FlxG.random.int(0, phillyLightsColors.length-1, [curLightEvent]);
						var color:FlxColor = phillyLightsColors[curLightEvent];

						if(!phillyGlowGradient.visible)
						{
							doFlash();
							if(ClientPrefs.camZooms)
							{
								FlxG.camera.zoom += 0.5;
								camHUD.zoom += 0.1;
							}

							blammedLightsBlack.visible = true;
							blammedLightsBlack.alpha = 1;
							phillyWindowEvent.visible = true;
							phillyGlowGradient.visible = true;
							phillyGlowParticles.visible = true;
						}
						else if(ClientPrefs.flashing)
						{
							var colorButLower:FlxColor = color;
							colorButLower.alphaFloat = 0.25;
							FlxG.camera.flash(colorButLower, 0.5, null, true);
						}

						var charColor:FlxColor = color;
						if(!ClientPrefs.flashing) charColor.saturation *= 0.5;
						else charColor.saturation *= 0.75;

						for (who in chars)
						{
							who.color = charColor;
						}
						phillyGlowParticles.forEachAlive(function(particle:PhillyGlow.PhillyGlowParticle)
						{
							particle.color = color;
						});
						phillyGlowGradient.color = color;
						phillyWindowEvent.color = color;

						color.brightness *= 0.5;
						phillyStreet.color = color;

					case 2: // spawn particles
						if(!ClientPrefs.lowQuality)
						{
							var particlesNum:Int = FlxG.random.int(8, 12);
							var width:Float = (2000 / particlesNum);
							var color:FlxColor = phillyLightsColors[curLightEvent];
							for (j in 0...3)
							{
								for (i in 0...particlesNum)
								{
									var particle:PhillyGlow.PhillyGlowParticle = new PhillyGlow.PhillyGlowParticle(-400 + width * i + FlxG.random.float(-width / 5, width / 5), phillyGlowGradient.originalY + 200 + (FlxG.random.float(0, 125) + j * 40), color);
									phillyGlowParticles.add(particle);
								}
							}
						}
						phillyGlowGradient.bop();
				}

			case 'Kill Henchmen':
				killHenchmen();

			case 'Add Camera Zoom':
				if(ClientPrefs.camZooms && FlxG.camera.zoom < 1.35) {
					var camZoom:Float = Std.parseFloat(value1);
					var hudZoom:Float = Std.parseFloat(value2);
					if(Math.isNaN(camZoom)) camZoom = 0.015;
					if(Math.isNaN(hudZoom)) hudZoom = 0.03;

					FlxG.camera.zoom += camZoom;
					camHUD.zoom += hudZoom;
				}

			case 'Trigger BG Ghouls':
				if(curStage == 'schoolEvil' && !ClientPrefs.lowQuality) {
					bgGhouls.dance(true);
					bgGhouls.visible = true;
				}

			case 'Play Animation':
				//trace('Anim to play: ' + value1);
				var char:Character = dad;
				switch(value2.toLowerCase().trim()) {
					case 'bf' | 'boyfriend':
						char = boyfriend;
					case 'gf' | 'girlfriend':
						char = gf;
					default:
						var val2:Int = Std.parseInt(value2);
						if(Math.isNaN(val2)) val2 = 0;

						switch(val2) {
							case 1: char = boyfriend;
							case 2: char = gf;
						}
				}

				if (char != null)
				{
					char.playAnim(value1, true);
					char.specialAnim = true;
				}

			case 'Camera Follow Pos':
				if(camFollow != null)
				{
					var val1:Float = Std.parseFloat(value1);
					var val2:Float = Std.parseFloat(value2);
					if(Math.isNaN(val1)) val1 = 0;
					if(Math.isNaN(val2)) val2 = 0;

					isCameraOnForcedPos = false;
					if(!Math.isNaN(Std.parseFloat(value1)) || !Math.isNaN(Std.parseFloat(value2))) {
						camFollow.x = val1;
						camFollow.y = val2;
						isCameraOnForcedPos = true;
					}
				}

			case 'Alt Idle Animation':
				var char:Character = dad;
				switch(value1.toLowerCase().trim()) {
					case 'gf' | 'girlfriend':
						char = gf;
					case 'boyfriend' | 'bf':
						char = boyfriend;
					default:
						var val:Int = Std.parseInt(value1);
						if(Math.isNaN(val)) val = 0;

						switch(val) {
							case 1: char = boyfriend;
							case 2: char = gf;
						}
				}

				if (char != null)
				{
					char.idleSuffix = value2;
					char.recalculateDanceIdle();
				}

			case 'Screen Shake':
				var valuesArray:Array<String> = [value1, value2];
				var targetsArray:Array<FlxCamera> = [camGame, camHUD];
				for (i in 0...targetsArray.length) {
					var split:Array<String> = valuesArray[i].split(',');
					var duration:Float = 0;
					var intensity:Float = 0;
					if(split[0] != null) duration = Std.parseFloat(split[0].trim());
					if(split[1] != null) intensity = Std.parseFloat(split[1].trim());
					if(Math.isNaN(duration)) duration = 0;
					if(Math.isNaN(intensity)) intensity = 0;

					if(duration > 0 && intensity != 0) {
						targetsArray[i].shake(intensity, duration);
					}
				}


			case 'Change Character':
				var charType:Int = 0;
				switch(value1.toLowerCase().trim()) {
					case 'gf' | 'girlfriend':
						charType = 2;
					case 'dad' | 'opponent':
						charType = 1;
					default:
						charType = Std.parseInt(value1);
						if(Math.isNaN(charType)) charType = 0;
				}
			
				switch(charType){
					case 1:
						switch(value2.toLowerCase()) {
							case 'edwhak' | 'he' | 'edwhakbroken' | 'edkbmassacre' | 'frontedwhak':
								edwhakIsEnemy = true;
							default:
								edwhakIsEnemy = false;
						}
					case 0:
						switch(value2.toLowerCase()) {
							case 'edwhak' | 'he' | 'edwhakbroken' | 'edkbmassacre' | 'frontedwhak':
								Note.canDamagePlayer = false;
								Note.edwhakIsPlayer = true;
							default:
								Note.canDamagePlayer = false;
								Note.edwhakIsPlayer = true;
						}
					
				}

				switch(charType) {
					case 0:
						if(boyfriend.curCharacter != value2) {
							if(!boyfriendMap.exists(value2)) {
								addCharacterToList(value2, charType);
							}

							var lastAlpha:Float = boyfriend.alpha;
							boyfriend.alpha = 0.00001;
							boyfriend = boyfriendMap.get(value2);
							boyfriend.alpha = lastAlpha;
							var edwhakVariable:Array<String> = ['Edwhak', 'he', 'edwhakBroken', 'edkbmassacre'];
							switch(edwhakVariable.contains(boyfriend.curCharacter)){
								case true:
									hitmansHUD.iconP1.changeIcon('icon-edwhak-pl');
								case false:
									hitmansHUD.iconP1.changeIcon(boyfriend.healthIcon);
								default:
									hitmansHUD.iconP1.changeIcon(boyfriend.healthIcon); //if it crash for some reazon?
							}
						}
						setOnScripts('boyfriendName', boyfriend.curCharacter);

					case 1:
						if(dad.curCharacter != value2) {
							if(!dadMap.exists(value2)) {
								addCharacterToList(value2, charType);
							}

							var wasGf:Bool = dad.curCharacter.startsWith('gf');
							var lastAlpha:Float = dad.alpha;
							dad.alpha = 0.00001;
							dad = dadMap.get(value2);
							if(!dad.curCharacter.startsWith('gf')) {
								if(wasGf && gf != null) {
									gf.visible = true;
								}
							} else if(gf != null) {
								gf.visible = false;
							}
							dad.alpha = lastAlpha;
							hitmansHUD.iconP2.changeIcon(dad.healthIcon);
						}
						setOnScripts('dadName', dad.curCharacter);

					case 2:
						if(gf != null)
						{
							if(gf.curCharacter != value2)
							{
								if(!gfMap.exists(value2))
								{
									addCharacterToList(value2, charType);
								}

								var lastAlpha:Float = gf.alpha;
								gf.alpha = 0.00001;
								gf = gfMap.get(value2);
								gf.alpha = lastAlpha;
							}
							setOnScripts('gfName', gf.curCharacter);
						}
				}
				hitmansHUD.reloadHealthBarColors();

			case 'BG Freaks Expression':
				if(bgGirls != null) bgGirls.swapDanceType();

			case 'Change Scroll Speed':
				if (songSpeedType == "constant")
					return;
				var val1:Float = Std.parseFloat(value1);
				var val2:Float = Std.parseFloat(value2);
				if(Math.isNaN(val1)) val1 = 1;
				if(Math.isNaN(val2)) val2 = 0;

				var newValue:Float = SONG.speed * ClientPrefs.getGameplaySetting('scrollspeed', 1) * val1;

				if(val2 <= 0)
				{
					songSpeed = newValue;
				}
				else
				{
					songSpeedTween = FlxTween.tween(this, {songSpeed: newValue}, val2 / playbackRate, {ease: FlxEase.linear, onComplete:
						function (twn:FlxTween)
						{
							songSpeedTween = null;
						}
					});
				}

			case 'Set Property':
				var killMe:Array<String> = value1.split('.');
				if(killMe.length > 1) {
					FunkinLua.setVarInArray(FunkinLua.getPropertyLoopThingWhatever(killMe, true, true), killMe[killMe.length-1], value2);
				} else {
					FunkinLua.setVarInArray(this, value1, value2);
				}
				//modchart variables
			case 'ModchartEffects':
				var modChartEffectShit:Int = Std.parseInt(value1);
				if(Math.isNaN(modChartEffectShit)) modChartEffectShit = 0;

				modChartEffect = modChartEffectShit;
				var value:Int = Std.parseInt(value2);
				if(Math.isNaN(value)) value = 0;
				modChartVariable1 = value;
			case 'AllowHealthDrain':
				if (value1 == 'true'){
					allowEnemyDrain = true;
				}else if (value1 == 'false'){
					allowEnemyDrain = false;	
				}
			case 'Controls Player 2':
				if (value1 == 'enable'){
					controlsPlayer2 = true;
				}else if (value1 == 'disable'){
					controlsPlayer2 = false;	
				}
			case "Set CheckPoint":
				onCheckPoint(strumTime, (value1.toLowerCase() == "hide"));
		}
		callOnScripts('onEvent', [eventName, value1, value2]);
	}

	function moveCameraSection():Void {
		if(SONG.notes[curSection] == null) return;

		if (gf != null && SONG.notes[curSection].gfSection)
		{
			camFollow.set(gf.getMidpoint().x, gf.getMidpoint().y);
			camFollow.x += gf.cameraPosition[0] + girlfriendCameraOffset[0];
			camFollow.y += gf.cameraPosition[1] + girlfriendCameraOffset[1];
			tweenCamIn();
			callOnScripts('onMoveCamera', ['gf']);
			return;
		}

		if (!SONG.notes[curSection].mustHitSection)
		{
			moveCamera(true);
			callOnScripts('onMoveCamera', ['dad']);
		}
		else
		{
			moveCamera(false);
			callOnScripts('onMoveCamera', ['boyfriend']);
		}
	}

	var cameraTwn:FlxTween;
	public function moveCamera(isDad:Bool)
	{
		if(isDad)
		{
			camFollow.set(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
			camFollow.x += dad.cameraPosition[0] + opponentCameraOffset[0];
			camFollow.y += dad.cameraPosition[1] + opponentCameraOffset[1];
			tweenCamIn();
		}
		else
		{
			camFollow.set(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
			camFollow.x -= boyfriend.cameraPosition[0] - boyfriendCameraOffset[0];
			camFollow.y += boyfriend.cameraPosition[1] + boyfriendCameraOffset[1];

			if (Paths.formatToSongPath(SONG.song) == 'tutorial' && cameraTwn == null && FlxG.camera.zoom != 1)
			{
				cameraTwn = FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut, onComplete:
					function (twn:FlxTween)
					{
						cameraTwn = null;
					}
				});
			}
		}
	}

	function tweenCamIn() {
		if (Paths.formatToSongPath(SONG.song) == 'tutorial' && cameraTwn == null && FlxG.camera.zoom != 1.3) {
			cameraTwn = FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut, onComplete:
				function (twn:FlxTween) {
					cameraTwn = null;
				}
			});
		}
	}

	function snapCamFollowToPos(x:Float, y:Float) {
		camFollow.set(x, y);
		camFollowPos.setPosition(x, y);
	}

	public function finishSong(?ignoreNoteOffset:Bool = false):Void
	{
		var finishCallback:Void->Void = endSong; //In case you want to change it in a specific song.

		if (isStoryMode)
		{
			weekMisses += songMisses;
		}

		hitmansHUD.updateTime = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		vocals.pause();
		if(ClientPrefs.noteOffset <= 0 || ignoreNoteOffset) {
			finishCallback();
		} else {
			finishTimer = new FlxTimer().start(ClientPrefs.noteOffset / 1000, function(tmr:FlxTimer) {
				finishCallback();
			});
		}
	}


	public var transitioning = false;

	public function rating():Void
	{
		resetPlayData();

		var oldBest:Int = Highscore.getScore(SONG.song, storyDifficulty);

		openSubState(new ResultScreen(Math.round(songScore), oldBest, maxCombo, Highscore.floorDecimal(ratingPercent * 100, 2), fantastics, excelents, greats, decents, wayoffs, songMisses));

		inResultsScreen = true;

		#if desktop
			DiscordClient.changePresence("Results - " + detailsText, SONG.song + " (" + storyDifficultyText +")" + "Score:" + Math.round(songScore), hitmansHUD.iconP2.getCharacter());
		#end

		var ret:Dynamic = callOnScripts('onRating', null, true);
		if (ret != FunkinLua.Function_Stop){
			#if PRELOAD_ALL	
				sys.thread.Thread.create(() ->
				{
					if (!practiceMode && notITGMod && SONG.validScore)
					{
						var percent:Float = ratingPercent;
						if(Math.isNaN(percent)) percent = 0;
						Highscore.saveScore(SONG.song, songScore, storyDifficulty, percent);
					}
				});
			#else
				if (!practiceMode && notITGMod && SONG.validScore)
				{	
					var percent:Float = ratingPercent;
					if(Math.isNaN(percent)) percent = 0;
					Highscore.saveScore(SONG.song, songScore, storyDifficulty, percent);
				}
			#end
		}
	}
	public function endSong():Void
	{
		//Should kill you if you tried to cheat
		if(!startingSong) {
			notes.forEach(function(daNote:Note) {
				if(daNote.strumTime < songLength - Conductor.safeZoneOffset) {
					health -= 0.05 * healthLoss;
				}
			});
			for (daNote in unspawnNotes) {
				if(daNote.strumTime < songLength - Conductor.safeZoneOffset) {
					health -= 0.05 * healthLoss;
				}
			}

			if(doDeathCheck()) {
				return;
			}
		}

		hitmansHUD.timeBarBG.visible = false;
		hitmansHUD.timeBar.visible = false;
		hitmansHUD.timeTxt.visible = false;
		canPause = false;
		endingSong = true;
		camZooming = true;
		autoCamZoom = false;
		inCutscene = false;
		hitmansHUD.updateTime = false;

		deathCounter = 0;
		seenCutscene = false;

		#if ACHIEVEMENTS_ALLOWED
		checkForAchievement(['massacred', 'hitman', 'massochist', 'headache', 'top', 'practice']);
		#end

		var ret:Dynamic = callOnScripts('onEndSong', null, true);
		if(ret != FunkinLua.Function_Stop && !transitioning) {
			
			playbackRate = 1;

			rating();

			transitioning = true;
		}
	
	}


	public function KillNotes() {
		while(notes.length > 0) {
			var daNote:Note = notes.members[0];
			daNote.active = false;
			daNote.visible = false;

			daNote.kill();
			notes.remove(daNote, true);
			daNote.destroy();
		}
		unspawnNotes = [];
		eventNotes = [];
	}

	public var totalPlayed:Int = 0;
	public var totalNotesHit:Float = 0.0;

	public var showCombo:Bool = false;
	public var showComboNum:Bool = true;
	public var showRating:Bool = true;

	private function cachePopUpScore()
	{
		var pixelShitPart1:String = '';
		var pixelShitPart2:String = '';
		if (isPixelStage)
		{
			pixelShitPart1 = 'pixelUI/';
			pixelShitPart2 = '-pixel';
		}

		Paths.image(pixelShitPart1 + "marvelous" + pixelShitPart2);
		Paths.image(pixelShitPart1 + "sick" + pixelShitPart2);
		Paths.image(pixelShitPart1 + "good" + pixelShitPart2);
		Paths.image(pixelShitPart1 + "bad" + pixelShitPart2);
		Paths.image(pixelShitPart1 + "shit" + pixelShitPart2);
		Paths.image(pixelShitPart1 + "combo" + pixelShitPart2);
		
		for (i in 0...10) {
			Paths.image(pixelShitPart1 + 'num' + i + pixelShitPart2);
		}
	}

	private function popUpScore(note:Note = null):Void
	{
		var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);
		//trace(noteDiff, ' ' + Math.abs(note.strumTime - Conductor.songPosition));

		// boyfriend.playAnim('hey');
		vocals.volume = 1;

		var placement:String = Std.string(combo);

		var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
		coolText.screenCenter();
		coolText.x = FlxG.width * 0.35;
		//

		var rating:FlxSprite = new FlxSprite();
		var score:Int = 450;

		//tryna do MS based judgment due to popular demand
		var daRating:Rating = Conductor.judgeNote(note, noteDiff / playbackRate);

		totalNotesHit += daRating.ratingMod;
		note.ratingMod = daRating.ratingMod;
		if(!note.ratingDisabled) daRating.increase();
		note.rating = daRating.name;
		score = daRating.score;

		if(!cpuControlled) {
			songScore += score;
			if(!note.ratingDisabled)
			{
				songHits++;
				totalPlayed++;
				RecalculateRating(false);
			}
		}

		var pixelShitPart1:String = "";
		var pixelShitPart2:String = '';

		if (PlayState.isPixelStage)
		{
			pixelShitPart1 = 'pixelUI/';
			pixelShitPart2 = '-pixel';
		}
	}

	public var strumsBlocked:Array<Bool> = [];
	private function onKeyPress(event:KeyboardEvent):Void
	{
		var eventKey:FlxKey = event.keyCode;
		var key:Int = getKeyFromEvent(eventKey);
		//trace('Pressed: ' + eventKey);

		if (!cpuControlled && startedCountdown && !paused && key > -1 && (FlxG.keys.checkStatus(eventKey, JUST_PRESSED) || ClientPrefs.controllerMode))
		{
			if(!boyfriend.stunned && generatedMusic && !endingSong)
			{
				//more accurate hit time for the ratings?
				var lastTime:Float = Conductor.songPosition;
				Conductor.songPosition = FlxG.sound.music.time;

				var canMiss:Bool = !ClientPrefs.ghostTapping;

				// heavily based on my own code LOL if it aint broke dont fix it
				var pressNotes:Array<Note> = [];
				//var notesDatas:Array<Int> = [];
				var notesStopped:Bool = false;

				var sortedNotesList:Array<Note> = [];
				notes.forEachAlive(function(daNote:Note)
				{
					if (strumsBlocked[daNote.noteData] != true && daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.isSustainNote && !daNote.blockHit)
					{
						if(daNote.noteData == key)
						{
							sortedNotesList.push(daNote);
							//notesDatas.push(daNote.noteData);
						}
						canMiss = true;
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
				else{
					callOnScripts('onGhostTap', [key]);
					if (canMiss) {
						noteMissPress(key);
					}
				}

				// I dunno what you need this for but here you go
				//									- Shubs

				// Shubs, this is for the "Just the Two of Us" achievement lol
				//									- Shadow Mario
				keysPressed[key] = true;

				//more accurate hit time for the ratings? part 2 (Now that the calculations are done, go back to the time it was before for not causing a note stutter)
				Conductor.songPosition = lastTime;
			}

			var spr:StrumNote = playerStrums.members[key];
			if(strumsBlocked[key] != true && spr != null && spr.animation.curAnim.name != 'confirm')
			{
				spr.playAnim('pressed');
				spr.resetAnim = 0;
			}
			if(controlsPlayer2){
				var spr:StrumNote = opponentStrums.members[key];
				if(spr != null)
				{
					spr.playAnim('pressed');
					spr.resetAnim = 0;
				}
			}
			callOnScripts('onKeyPress', [key]);
		}
		//trace('pressed: ' + controlArray);
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
		if(!cpuControlled && startedCountdown && !paused && key > -1)
		{
			var spr:StrumNote = playerStrums.members[key];
			if(spr != null)
			{
				spr.playAnim('static');
				spr.resetAnim = 0;
			}
			if(controlsPlayer2){
				var spr:StrumNote = opponentStrums.members[key];
				if(spr != null)
				{
					spr.playAnim('static');
					spr.resetAnim = 0;
				}
			}
			callOnScripts('onKeyRelease', [key]);
		}
		//trace('released: ' + controlArray);
	}

	private function getKeyFromEvent(key:FlxKey):Int
	{
		if (key != NONE)
		{
			for (i in 0...keysArray.length)
			{
				for (j in 0...keysArray[i].length)
				{
					if (key == keysArray[i][j])
					{
						return i;
					}
				}
			}
		}
		return -1;
	}

	// Hold notes
	private function keyShit():Void
	{
		// HOLDING
		var parsedHoldArray:Array<Bool> = parseKeys();

		// TO DO: Find a better way to handle controller inputs, this should work for now
		if(ClientPrefs.controllerMode)
		{
			var parsedArray:Array<Bool> = parseKeys('_P');
			if(parsedArray.contains(true))
			{
				for (i in 0...parsedArray.length)
				{
					if(parsedArray[i] && strumsBlocked[i] != true)
						onKeyPress(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, true, -1, keysArray[i][0]));
				}
			}
		}

		// FlxG.watch.addQuick('asdfa', upP);
		if (startedCountdown && !boyfriend.stunned && generatedMusic)
		{
			// rewritten inputs???
			notes.forEachAlive(function(daNote:Note)
			{
				// hold note functions
				if (strumsBlocked[daNote.noteData] != true && daNote.isSustainNote && parsedHoldArray[daNote.noteData] && daNote.canBeHit
					&& daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.blockHit) {
						goodNoteHit(daNote);
				}
				if (strumsBlocked[daNote.noteData] != true && daNote.isSustainNote && parsedHoldArray[daNote.noteData] && daNote.canBeHit && !daNote.hitByOpponent
					&& daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.blockHit) {
						opponentNoteHit(daNote);
					}
			});
			if (!parsedHoldArray.contains(true) || endingSong)
				playerDance();
		}

		// TO DO: Find a better way to handle controller inputs, this should work for now
		if(ClientPrefs.controllerMode || strumsBlocked.contains(true))
		{
			var parsedArray:Array<Bool> = parseKeys('_R');
			if(parsedArray.contains(true))
			{
				for (i in 0...parsedArray.length)
				{
					if(parsedArray[i] || strumsBlocked[i] == true)
						onKeyRelease(new KeyboardEvent(KeyboardEvent.KEY_UP, true, true, -1, keysArray[i][0]));
				}
			}
		}
	}

	private function parseKeys(?suffix:String = ''):Array<Bool>
	{
		var ret:Array<Bool> = [];
		for (i in 0...controlArray.length)
		{
			ret[i] = Reflect.getProperty(controls, controlArray[i] + suffix);
		}
		return ret;
	}

	function noteMiss(daNote:Note):Void { //You didn't hit the key and let it go offscreen, also used by Hurt Notes
		//Dupe note remove
		notes.forEachAlive(function(note:Note) {
			if (daNote != note && daNote.mustPress && daNote.noteData == note.noteData && daNote.isSustainNote == note.isSustainNote && Math.abs(daNote.strumTime - note.strumTime) < 1) {
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		});

		if (!isDead){
			switch (daNote.noteType){
				case '':
					deathVariableTXT = 'Notes';
				case 'HD Note':
					deathVariableTXT = 'HD';
			}
		}

		combo = 0;
		if (!ClientPrefs.casualMode){
			if (!Note.edwhakIsPlayer){
				if (daNote.isSustainNote){
					health -= daNote.missHealth * healthLoss;
				}else if(!daNote.isSustainNote){
					health -= daNote.missHealth * healthLoss;
				}
			}else if(Note.edwhakIsPlayer){
				if (daNote.isSustainNote){
					health -= daNote.missHealth * healthLoss;
				}else if(!daNote.isSustainNote){
					health -= daNote.missHealth * healthLoss;
				}
			}
		}else if(ClientPrefs.casualMode){
			if (!Note.edwhakIsPlayer){
				if (daNote.isSustainNote){
					health -= (daNote.missHealth-0.0825) * healthLoss;
				}else if(!daNote.isSustainNote){
					health -= (daNote.missHealth-0.0525) * healthLoss;
				}
			}else if(Note.edwhakIsPlayer){
				if (daNote.isSustainNote){
					health -= (daNote.missHealth-0.05) * healthLoss;
				}else if(!daNote.isSustainNote){
					health -= (daNote.missHealth-0.03) * healthLoss;
				}
			}
		}
		
		if(instakillOnMiss)
		{
			vocals.volume = 0;
			doDeathCheck(true);
			health = 0;
		}

		//For testing purposes
		//trace(daNote.missHealth);
		//deathVariableTXT = 0;
		if (!daNote.isSustainNote){
			hitmansHUD.ratingsBumpScale();
			hitmansHUD.ratings.animation.play("miss");
			if (!edwhakIsEnemy && !SONG.bossFight){
				hitmansHUD.ratingsBumpScaleOP();
				hitmansHUD.ratingsOP.animation.play("miss");
			}
			songMisses++;
		}
		vocals.volume = 0;
		// if(!practiceMode) 
		songScore -= 10;

		totalPlayed++;
		RecalculateRating(true);

		var char:Character = boyfriend;
		if(daNote.gfNote) {
			char = gf;
		}

		if(char != null && !daNote.noMissAnimation && char.hasMissAnimations)
		{
			var animToPlay:String = singAnimations[Std.int(Math.abs(daNote.noteData))] + 'miss' + daNote.animSuffix;
			char.playAnim(animToPlay, true);
		}

		var result:Dynamic = callOnLuas('noteMiss', [notes.members.indexOf(daNote), daNote.noteData, daNote.noteType, daNote.isSustainNote]);
		if(result != FunkinLua.Function_Stop && result != FunkinLua.Function_StopHScript && result != FunkinLua.Function_StopAll) callOnHScript('noteMiss', [daNote]);
	}

	function noteMissPress(direction:Int = 1):Void //You pressed a key when there was no notes to press for this key
	{
		if(ClientPrefs.ghostTapping) return; //fuck it

		if (!boyfriend.stunned)
		{
			if(ClientPrefs.casualMode){
				health -= 0.03 * healthLoss;
			}else if (!ClientPrefs.casualMode){
				health -= 0.06 * healthLoss;
			}
			if (!edwhakIsEnemy && !SONG.bossFight){
				hitmansHUD.ratingsBumpScaleOP();
				hitmansHUD.ratingsOP.animation.play("miss");
			}
			hitmansHUD.ratings.animation.play("miss");
			hitmansHUD.ratingsBumpScale();
			if(instakillOnMiss)
			{
				vocals.volume = 0;
				doDeathCheck(true);
				health = 0;
			}

			if (combo > 5 && gf != null && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;

			// if(!practiceMode) 
			songScore -= 10;
			if(!endingSong) {
				songMisses++;
			}
			totalPlayed++;
			RecalculateRating(true);

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');

			/*boyfriend.stunned = true;

			// get stunned for 1/60 of a second, makes you able to
			new FlxTimer().start(1 / 60, function(tmr:FlxTimer)
			{
				boyfriend.stunned = false;
			});*/

			if(boyfriend.hasMissAnimations) {
				boyfriend.playAnim(singAnimations[Std.int(Math.abs(direction))] + 'miss', true);
			}
			vocals.volume = 0;
		}
		callOnLuas('noteMissPress', [direction]);
	}

	function opponentNoteHit(note:Note):Void
	{
		edwhakDrain = note.hitHealth+0.007; //force game to make this be 0.007 higher than player (so basically 0.03 drain)
		// if (Paths.formatToSongPath(SONG.song) != 'tutorial')
		//Edwhak HealthDrain but in source so people can't nerf how his songs works!
		if (SONG.bossFight || edwhakIsEnemy){
			if (!note.isSustainNote){
				hitmansHUD.ratingsBumpScaleOP();
				hitmansHUD.setRatingImageOP(0);
				comboOp +=1;
				separateCombo = true;
				allowEnemyDrain = true;
			}
		}
		var sustainDivider:Float = 5;
		if (allowEnemyDrain){
			switch (!ClientPrefs.casualMode){
				case true:
					if (edwhakIsEnemy){
						if(health - edwhakDrain - 0.17 > maxHealth){
							if (Note.instakill){
								health -= ((edwhakDrain+0.02) * healthGain) / (note.isSustainNote ? sustainDivider : 1); //idfk if this even works LMAO
							}else if (Note.tlove){
								health -= ((edwhakDrain+0.03) * healthGain) / (note.isSustainNote ? sustainDivider : 1); //Same as up
							}else{
								health -= ((edwhakDrain+0.005) * healthGain) / (note.isSustainNote ? sustainDivider : 1); //Added both because if i added only one it don't do shit idk why lmao
							}
						}
					}else{
						if(health - note.hitHealth - 0.05 > maxHealth){
							if (!Note.instakill){
								health -= (note.hitHealth * healthGain) / (note.isSustainNote ? sustainDivider : 1);			
							}
						}
					}
				case false:
					if (edwhakIsEnemy){
						if(health - edwhakDrain - 0.17 > maxHealth){
							if (Note.instakill){
								health -= ((edwhakDrain+0.01) * healthGain) / (note.isSustainNote ? sustainDivider : 1); //Same as up
							}else if (Note.tlove){
								health -= ((edwhakDrain+0.02) * healthGain) / (note.isSustainNote ? sustainDivider : 1); //Same as up
							}else{
								health -= ((edwhakDrain+0.005) * healthGain) / (note.isSustainNote ? sustainDivider : 1); //Added both because if i added only one it don't do shit idk why lmao
							}
						}
					}else{
						if(health - note.hitHealth - 0.05 > maxHealth){
							if (!Note.instakill){
								health -= (note.hitHealth * healthGain) / (note.isSustainNote ? sustainDivider : 1);
							}
						}
					}		
			}
		}
		if(note.noteType == 'Hey!' && dad.animOffsets.exists('hey')) {
			dad.playAnim('hey', true);
			dad.specialAnim = true;
			dad.heyTimer = 0.6;
		} else if(!note.noAnimation) {
			var altAnim:String = note.animSuffix;

			if (SONG.notes[curSection] != null)
			{
				if (SONG.notes[curSection].altAnim && !SONG.notes[curSection].gfSection) {
					altAnim = '-alt';
				}
			}

			var char:Character = dad;
			var animToPlay:String = singAnimations[Std.int(Math.abs(note.noteData))] + altAnim;
			if(note.gfNote) {
				char = gf;
			}

			if(char != null)
			{
				char.playAnim(animToPlay, true);
				char.holdTimer = 0;
			}
		}

		if (SONG.needsVoices)
			vocals.volume = 1;

		var time:Float = 0.15;
		if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end')) {
			time = 0.3;
		}
		StrumPlayAnim(true, Std.int(Math.abs(note.noteData)), time);
		// if(!controlsPlayer2 || cpuControlled){
		// 	if(!note.ignoreNote && !note.hitCausesMiss){
		// 		if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end')) {
		// 			time += 0.15;
		// 		}
		// 		StrumPlayAnim(true, Std.int(Math.abs(note.noteData)), time);
		// 	}
		// }
		note.hitByOpponent = true;

		callOnLuas('opponentNoteHit', [notes.members.indexOf(note), Math.abs(note.noteData), note.noteType, note.isSustainNote]);
		opponentStrums.members[note.noteData].rgbShader.r = note.rgbShader.r;
		opponentStrums.members[note.noteData].rgbShader.b = note.rgbShader.b;

		if (!note.isSustainNote)
		{
			if (ClientPrefs.splashSkin != 'disabled'){
				createNoteEffect(note, opponentStrums.members[Math.round(Math.abs(note.noteData))], false);
			}
			note.kill();
			notes.remove(note, true);
			note.destroy();
		}
		if (note.isSustainNote){
			if (ClientPrefs.splashSkin != 'disabled'){
				createNoteEffect(note, opponentStrums.members[Math.round(Math.abs(note.noteData))], true);
			}
		}
	}

	function goodNoteHit(note:Note):Void
	{
		if (!note.wasGoodHit)
		{
			if(cpuControlled && (note.ignoreNote || note.hitCausesMiss)) return;

			if (ClientPrefs.hitsoundVolume > 0 && !note.hitsoundDisabled)
			{
				FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.hitsoundVolume);
			}

			if(note.hitCausesMiss) {
				noteMiss(note);

				if(!note.noMissAnimation)
				{
					switch(note.noteType) {
						case 'Hurt Note' | 'HurtAgressive': //Hurt note
						if (!gameOver)
							{
							if(boyfriend.animation.getByName('hurt') != null) {
								boyfriend.playAnim('hurt', true);
								boyfriend.specialAnim = true;
							}
							deathVariableTXT = 'Hurts';
						}
						case 'Invisible Hurt Note' : //what you can't see but still damages you
						if (!gameOver)
							{
							if(boyfriend.animation.getByName('hurt') != null) {
								boyfriend.playAnim('hurt', true);
								boyfriend.specialAnim = true;
							}
							deathVariableTXT = 'InvisibleHurts';
						}
						case 'Mimic Note': //hurts but similar to notes
						if (!gameOver)
							{
							if(boyfriend.animation.getByName('hurt') != null) {
								boyfriend.playAnim('hurt', true);
								boyfriend.specialAnim = true;
							}
							deathVariableTXT = 'Mimics';
						}
					}
				}

				note.wasGoodHit = true;
				if (!note.isSustainNote)
				{
					note.kill();
					notes.remove(note, true);
					note.destroy();
				}
				return;
			}
			if (!note.hitCausesMiss){
				switch(note.noteType) {
					case 'Instakill Note': //Hurt note
					if (!gameOver)
					{
						deathVariableTXT = 'Instakill';
					}
					case 'Mine Note': //what you can't see but it still damage you lmao
					if (!gameOver)
					{
						deathVariableTXT = 'Mine';
						FlxG.sound.play(Paths.sound('Edwhak/Mine'));
						hitmansHUD.ratingsBumpScale();
						if (!edwhakIsEnemy && !SONG.bossFight){
							hitmansHUD.ratingsBumpScaleOP();
							hitmansHUD.ratingsOP.animation.play("miss");
						}
						hitmansHUD.ratings.animation.play("miss");
						songMisses++;
						vocals.volume = 0;
						// if(!practiceMode) 
						songScore -= 10;
						combo = 0;
						health = health-0.8;
					}
					case 'Love Note': //agressive hurts that cause more damage
					if (!gameOver)
					{
						if (Note.edwhakIsPlayer){
							drain = true;
							deathVariableTXT = 'Love';
						}else{
							drain = false;
						}
					}
					case 'Fire Note': //agressive hurts that cause more damage
					if (!gameOver)
					{
						if (Note.edwhakIsPlayer){
							deathVariableTXT = 'Fire';
						}
						gain = Note.edwhakIsPlayer ? false : true;
					}
					case 'True Love Note': //agressive hurts that cause more damage
					if (!gameOver)
					{
						if (Note.edwhakIsPlayer){
							tgain = true;
							deathVariableTXT = 'Tlove';
						}
					}
				}
			}
			//IT WILL WORK FINALLY!?
			if (!note.isSustainNote && !note.isHoldEnd)
			{
				hitmansHUD.ratingsBumpScale();
				setRatingImage(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);
				if (!edwhakIsEnemy && !SONG.bossFight){
					hitmansHUD.ratingsBumpScaleOP();
					hitmansHUD.setRatingImageOP(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);
				}
				combo += 1;
				if(combo > 9999) combo = 9999;
				if (combo > maxCombo) maxCombo = combo;
				popUpScore(note);
			}

			var sustainDivider:Float = 5;

			switch(ClientPrefs.casualMode){
				case false:
					health += Note.edwhakIsPlayer ? ((note.hitHealth+0.012) * healthGain)/(note.isSustainNote ? sustainDivider : 1) : (note.hitHealth * healthGain)/(note.isSustainNote ? sustainDivider : 1); //now sustains gets 10 times less gain but still gain
				case true:
					health += Note.edwhakIsPlayer ? ((note.hitHealth+0.012) * healthGain)/(note.isSustainNote ? sustainDivider : 1) : ((note.hitHealth+0.007) * healthGain)/(note.isSustainNote ? sustainDivider : 1); //now sustains gets 10 times less gain but still gain
			}

			if(!note.noAnimation) {
				var animToPlay:String = singAnimations[Std.int(Math.abs(note.noteData))];

				if(note.gfNote)
				{
					if(gf != null)
					{
						gf.playAnim(animToPlay + note.animSuffix, true);
						gf.holdTimer = 0;
					}
				}
				else
				{
					boyfriend.playAnim(animToPlay + note.animSuffix, true);
					boyfriend.holdTimer = 0;
				}

				if(note.noteType == 'Hey!') {
					if(boyfriend.animOffsets.exists('hey')) {
						boyfriend.playAnim('hey', true);
						boyfriend.specialAnim = true;
						boyfriend.heyTimer = 0.6;
					}

					if(gf != null && gf.animOffsets.exists('cheer')) {
						gf.playAnim('cheer', true);
						gf.specialAnim = true;
						gf.heyTimer = 0.6;
					}
				}
			}

			if(cpuControlled) {
				var time:Float = 0.15;
				if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end')) {
					time = 0.3;
				}
				StrumPlayAnim(false, Std.int(Math.abs(note.noteData)), time);
			} else {
				var spr = playerStrums.members[note.noteData];
				if(spr != null)
				{
					spr.playAnim('confirm', true);
				}
			}
			note.wasGoodHit = true;
			vocals.volume = 1;

			var isSus:Bool = note.isSustainNote; //GET OUT OF MY HEAD, GET OUT OF MY HEAD, GET OUT OF MY HEAD
			var leData:Int = Math.round(Math.abs(note.noteData));
			var leType:String = note.noteType;
			var result:Dynamic = callOnLuas('goodNoteHit', [notes.members.indexOf(note),  Math.abs(note.noteData), note.noteType, note.isSustainNote]);
			if(result != FunkinLua.Function_Stop && result != FunkinLua.Function_StopHScript && result != FunkinLua.Function_StopAll) callOnHScript('goodNoteHitPost', [note]);
			playerStrums.members[leData].rgbShader.r = note.rgbShader.r;
			playerStrums.members[leData].rgbShader.b = note.rgbShader.b;

			var ratingDetect = note.rating;
			if (!note.isSustainNote)
			{
				if (ClientPrefs.splashSkin != 'disabled'){
					if (ratingDetect == "marvelous") {
						createNoteEffect(note, playerStrums.members[leData], false);
					}
				}
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
			if (note.isSustainNote){
				if (ClientPrefs.splashSkin != 'disabled'){
					createNoteEffect(note, playerStrums.members[leData], true);
				}
			}
		}
	}

	public function setRatingImage(rat:Float){
		if (rat >= 0){
			if (rat <= ClientPrefs.marvelousWindow){
				hitmansHUD.setRatingAnimation(rat);
				fantastics += 1;
			} else if (rat <= ClientPrefs.sickWindow){
				hitmansHUD.setRatingAnimation(rat);
				excelents += 1;
			}else if (rat >= ClientPrefs.sickWindow && rat <= ClientPrefs.goodWindow){
				hitmansHUD.setRatingAnimation(rat);
				greats += 1;
			}else if (rat >= ClientPrefs.goodWindow && rat <= ClientPrefs.badWindow){
				hitmansHUD.setRatingAnimation(rat);
				decents += 1;
			}else if (rat >= ClientPrefs.badWindow){
				hitmansHUD.setRatingAnimation(rat);
				wayoffs += 1;
			}
		} else {
			if (rat >= ClientPrefs.marvelousWindow * -1){
				hitmansHUD.setRatingAnimation(rat);
				fantastics += 1;
			} else if (rat >= ClientPrefs.sickWindow * -1){
				hitmansHUD.setRatingAnimation(rat);
				excelents += 1;
			}else if (rat <= ClientPrefs.sickWindow * -1 && rat >= ClientPrefs.goodWindow * -1){
				hitmansHUD.setRatingAnimation(rat);
				greats += 1;
			}else if (rat <= ClientPrefs.goodWindow * -1 && rat >= ClientPrefs.badWindow * -1){
				hitmansHUD.setRatingAnimation(rat);
				decents += 1;
			}else if (rat <= ClientPrefs.badWindow * -1){
				hitmansHUD.setRatingAnimation(rat);
				wayoffs += 1;
			}
		}
	}
		
	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.y = FlxG.random.int(140, 250);
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	var carTimer:FlxTimer;
	function fastCarDrive()
	{
		//trace('Car drive');
		FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		carTimer = new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			resetFastCar();
			carTimer = null;
		});
	}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			if (gf != null)
			{
				gf.playAnim('hairBlow');
				gf.specialAnim = true;
			}
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset();
		}
	}

	function trainReset():Void
	{
		if(gf != null)
		{
			gf.danced = false; //Sets head to the correct position once the animation ends
			gf.playAnim('hairFall');
			gf.specialAnim = true;
		}
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		if(!ClientPrefs.lowQuality) halloweenBG.animation.play('halloweem bg lightning strike');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		if(boyfriend.animOffsets.exists('scared')) {
			boyfriend.playAnim('scared', true);
		}

		if(gf != null && gf.animOffsets.exists('scared')) {
			gf.playAnim('scared', true);
		}

		if(ClientPrefs.camZooms) {
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;

			if(!camZooming) { //Just a way for preventing it to be permanently zoomed until Skid & Pump hits a note
				FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.5);
				FlxTween.tween(camHUD, {zoom: 1}, 0.5);
			}
		}

		if(ClientPrefs.flashing) {
			halloweenWhite.alpha = 0.4;
			FlxTween.tween(halloweenWhite, {alpha: 0.5}, 0.075);
			FlxTween.tween(halloweenWhite, {alpha: 0}, 0.25, {startDelay: 0.15});
		}
	}

	function killHenchmen():Void
	{
		if(!ClientPrefs.lowQuality && ClientPrefs.violence && curStage == 'limo') {
			if(limoKillingState < 1) {
				limoMetalPole.x = -400;
				limoMetalPole.visible = true;
				limoLight.visible = true;
				limoCorpse.visible = false;
				limoCorpseTwo.visible = false;
				limoKillingState = 1;
			}
		}
	}

	function resetLimoKill():Void
	{
		if(curStage == 'limo') {
			limoMetalPole.x = -500;
			limoMetalPole.visible = false;
			limoLight.x = -500;
			limoLight.visible = false;
			limoCorpse.x = -500;
			limoCorpse.visible = false;
			limoCorpseTwo.x = -500;
			limoCorpseTwo.visible = false;
		}
	}

	var tankX:Float = 400;
	var tankSpeed:Float = FlxG.random.float(5, 7);
	var tankAngle:Float = FlxG.random.int(-90, 45);

	function moveTank(?elapsed:Float = 0):Void
	{
		if(!inCutscene)
		{
			tankAngle += elapsed * tankSpeed;
			tankGround.angle = tankAngle - 90 + 15;
			tankGround.x = tankX + 1500 * Math.cos(Math.PI / 180 * (1 * tankAngle + 180));
			tankGround.y = 1300 + 1100 * Math.sin(Math.PI / 180 * (1 * tankAngle + 180));
		}
	}

	private function cleanManagers()
	{
		timerManager.clear();

		tweenManager.clear();
	}

	override function destroy() {
		for (lua in luaArray) {
			lua.call('onDestroy', []);
			lua.stop();
		}
		luaArray = [];
		FunkinLua.killShaders();

		#if hscript
		if(FunkinLua.hscript != null) FunkinLua.hscript = null;
		#end

		#if HSCRIPT_ALLOWED
		for (script in scripts.scripts)
			if (script != null)
			{
				script.call('onDestroy');
				script.destroy();
			}
		while (scripts.scripts.length > 0)
			scripts.scripts.pop();
		
		remove(scripts);
		scripts.destroy();
		scripts = null;
		#end

		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		FlxAnimationController.globalSpeed = 1;
		FlxG.sound.music.pitch = 1;
		cleanManagers();
		super.destroy();
	}

	public static function cancelMusicFadeTween() {
		if(FlxG.sound.music.fadeTween != null) {
			FlxG.sound.music.fadeTween.cancel();
		}
		FlxG.sound.music.fadeTween = null;
	}

	var animSkins:Array<String> = ['ITHIT', 'MANIAHIT', 'STEPMANIA', 'NOTITG'];

	var lastStepHit:Int = -1;
	override function stepHit()
	{
		super.stepHit();
		if (Math.abs(FlxG.sound.music.time - (Conductor.songPosition - Conductor.offset)) > (20 * playbackRate)
			|| (SONG.needsVoices && Math.abs(vocals.time - (Conductor.songPosition - Conductor.offset)) > (20 * playbackRate)))
		{
			resyncVocals();
		}

		if(curStep == lastStepHit) {
			return;
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
		lastStepHit = curStep;

		setOnScripts('curStep', curStep);
		callOnScripts('stepHit', [curStep]);
		callOnScripts('onStepHit', [curStep]);
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	var lastBeatHit:Int = -1;

	override function beatHit()
	{
		super.beatHit();

		if(lastBeatHit >= curBeat) {
			//trace('BEAT HIT: ' + curBeat + ', LAST HIT: ' + lastBeatHit);
			return;
		}

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, ClientPrefs.downScroll ? FlxSort.ASCENDING : FlxSort.DESCENDING);
		}

		hitmansHUD.beatHit();

		characterBopper(curBeat);

		lastBeatHit = curBeat;

		setOnScripts('curBeat', curBeat);
		setOnScripts('curAccBeat', curBeat2);
		callOnScripts('beatHit', [curBeat]);
		callOnScripts('onBeatHit', [curBeat]);
	}

	public function characterBopper(beat:Int):Void
	{
		if (gf != null && beat % Math.round(gfSpeed * gf.danceEveryNumBeats) == 0 && !gf.getAnimationName().startsWith('sing') && !gf.stunned)
			gf.dance();
		if (boyfriend != null && beat % boyfriend.danceEveryNumBeats == 0 && !boyfriend.getAnimationName().startsWith('sing') && !boyfriend.stunned)
			boyfriend.dance();
		if (dad != null && beat % dad.danceEveryNumBeats == 0 && !dad.getAnimationName().startsWith('sing') && !dad.stunned)
			dad.dance();
	}

	public function playerDance():Void
	{
		var anim:String = boyfriend.getAnimationName();
		if(boyfriend.holdTimer > Conductor.stepCrochet * (0.0011 #if FLX_PITCH / FlxG.sound.music.pitch #end) * boyfriend.singDuration && anim.startsWith('sing') && !anim.endsWith('miss'))
			boyfriend.dance();
	}

	override function sectionHit()
	{
		super.sectionHit();

		if (SONG.notes[curSection] != null)
		{
			if (generatedMusic && !endingSong && !isCameraOnForcedPos)
			{
				moveCameraSection();
			}

			if (camZooming && FlxG.camera.zoom < 1.35 && ClientPrefs.camZooms  && autoCamZoom) //need auto cam zoom to make this works :b
			{
				FlxG.camera.zoom += 0.015 * camZoomingMult;
				camHUD.zoom += 0.03 * camZoomingMult;
			}

			if (SONG.notes[curSection].changeBPM)
			{
				Conductor.bpm = SONG.notes[curSection].bpm;
				setOnScripts('curBpm', Conductor.bpm);
				setOnScripts('crochet', Conductor.crochet);
				setOnScripts('stepCrochet', Conductor.stepCrochet);
			}
			setOnScripts('mustHitSection', SONG.notes[curSection].mustHitSection);
			setOnScripts('altAnim', SONG.notes[curSection].altAnim);
			setOnScripts('gfSection', SONG.notes[curSection].gfSection);
		}
		
		setOnScripts('curSection', curSection);
		callOnScripts('sectionHit', [curSection]);
		callOnScripts('onSectionHit', [curSection]);
	}

	#if LUA_ALLOWED
	public function startLuasNamed(luaFile:String, ?isStageLua:Bool = false, ?preloading:Bool = false)
	{
		#if MODS_ALLOWED
		var luaToLoad:String = Paths.modFolders(luaFile);
		if(!FileSystem.exists(luaToLoad))
			luaToLoad = Paths.getPreloadPath(luaFile);
		
		if(FileSystem.exists(luaToLoad))
		#elseif sys
		var luaToLoad:String = Paths.getPreloadPath(luaFile);
		if(OpenFlAssets.exists(luaToLoad))
		#end
		{
			for (script in luaArray)
				if(script.scriptName == luaToLoad) return false;
	
			luaArray.push(new FunkinLua(luaToLoad));
			return true;
		}
		return false;
	}
	#end

	#if HSCRIPT_ALLOWED
	public function startHScriptsNamed(scriptFile:String)
	{
		#if MODS_ALLOWED
		var scriptToLoad:String = Paths.modFolders(scriptFile);
		if(!FileSystem.exists(scriptToLoad))
			scriptToLoad = Paths.getPreloadPath(scriptFile);
		#else
		var scriptToLoad:String = Paths.getPreloadPath(scriptFile);
		#end

		if(FileSystem.exists(scriptToLoad))
		{
			if (SScript.global.exists(scriptToLoad)) return false;

			initHScript(scriptToLoad);
			return true;
		}
		return false;
	}

	public function initHScript(file:String)
	{
		try
		{
			var times:Float = Date.now().getTime();
			addScript(file);
			trace('initialized hscript-improved interp successfully: $file (${Std.int(Date.now().getTime() - times)}ms)');
		}
		catch(e)
		{
			trace('Error on loading Script!' + e);
		}
	}
	#end

	public function callOnScripts(funcToCall:String, args:Array<Dynamic> = null, ignoreStops = false, exclusions:Array<String> = null, excludeValues:Array<Dynamic> = null):Dynamic {
		var returnVal:Dynamic = FunkinLua.Function_Continue;

		if(args == null) args = [];
		if(exclusions == null) exclusions = [];
		if(excludeValues == null) excludeValues = [FunkinLua.Function_Continue];

		var result:Dynamic = callOnLuas(funcToCall, args, ignoreStops, exclusions, excludeValues);
		if(result == null || excludeValues.contains(result)) result = callOnHScript(funcToCall, args, ignoreStops, exclusions, excludeValues);
		return result;
	}

	public function callOnLuas(funcToCall:String, args:Array<Dynamic> = null, ignoreStops = false, exclusions:Array<String> = null, excludeValues:Array<Dynamic> = null):Dynamic {
		var returnVal:Dynamic = FunkinLua.Function_Continue;
		#if LUA_ALLOWED
		if(args == null) args = [];
		if(exclusions == null) exclusions = [];
		if(excludeValues == null) excludeValues = [FunkinLua.Function_Continue];

		var arr:Array<FunkinLua> = [];
		for (script in luaArray)
		{
			if(script.closed)
			{
				arr.push(script);
				continue;
			}

			if(exclusions.contains(script.scriptName))
				continue;

			var myValue:Dynamic = script.call(funcToCall, args);
			if((myValue == FunkinLua.Function_StopLua || myValue == FunkinLua.Function_StopAll) && !excludeValues.contains(myValue) && !ignoreStops)
			{
				returnVal = myValue;
				break;
			}
			
			if(myValue != null && !excludeValues.contains(myValue))
				returnVal = myValue;

			if(script.closed) arr.push(script);
		}

		if(arr.length > 0)
			for (script in arr)
				luaArray.remove(script);
		#end
		return returnVal;
	}

	public function callOnHScript(funcToCall:String, args:Array<Dynamic> = null, ?ignoreStops:Bool = false, exclusions:Array<String> = null, excludeValues:Array<Dynamic> = null):Dynamic {
		var returnVal:Dynamic = FunkinLua.Function_Continue;

		#if (HSCRIPT_ALLOWED && HScriptImproved)
		if(args == null) args = [];
		if(exclusions == null) exclusions = [];
		if(excludeValues == null) excludeValues = [FunkinLua.Function_Continue];

		var myValue:Dynamic = scripts.call(funcToCall, args);
		if((myValue == FunkinLua.Function_StopLua || myValue == FunkinLua.Function_StopAll) && !excludeValues.contains(myValue) && !ignoreStops)
		{
			returnVal = myValue;
			return returnVal;
		}
		
		if(myValue != null && !excludeValues.contains(myValue))
			returnVal = myValue;
		#end

		return returnVal;
	}

	public function setOnScripts(variable:String, arg:Dynamic, exclusions:Array<String> = null) 
	{
		if(exclusions == null) exclusions = [];
		setOnLuas(variable, arg, exclusions);
		setOnHScript(variable, arg, exclusions);
	}

	public function setOnLuas(variable:String, arg:Dynamic, exclusions:Array<String> = null) {
		#if LUA_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in luaArray) {
			if(exclusions.contains(script.scriptName))
				continue;

			script.set(variable, arg);
		}
		#end
	}

	public function setOnHScript(variable:String, arg:Dynamic, exclusions:Array<String> = null) {
		#if HSCRIPT_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in scripts.scripts) {
			if(exclusions.contains(script.fileName))
				continue;

			if(!instancesExclude.contains(variable))
				instancesExclude.push(variable);

			script.set(variable, arg);
		}
		#end
	}

	public function getOnScripts(variable:String, arg:String, exclusions:Array<String> = null)
	{
		if(exclusions == null) exclusions = [];
		getOnLuas(variable, arg, exclusions);
		getOnHScript(variable, exclusions);
	}

	public function getOnLuas(variable:String, arg:String, exclusions:Array<String> = null)
	{
		#if LUA_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in luaArray) {
			if(exclusions.contains(script.scriptName))
				continue;

			script.get(variable, arg);
		}
		#end
	}

	public function getOnHScript(variable:String, exclusions:Array<String> = null)
	{
		#if HSCRIPT_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in scripts.scripts) {
			if(exclusions.contains(script.fileName))
				continue;

			script.get(variable);
		}
		#end
	}

	function StrumPlayAnim(isDad:Bool, id:Int, time:Float) {
		var spr:StrumNote = null;
		if(isDad) {
			spr = opponentStrums.members[id];
		} else {
			spr = playerStrums.members[id];
		}

		if(spr != null) {
			spr.playAnim('confirm', true);
			spr.resetAnim = time;
		}
	}

	public var ratingName:String = '?';
	public var ratingPercent:Float;
	public var ratingFC:String;
	public function RecalculateRating(badHit:Bool = false) {
		setOnScripts('score', songScore);
		setOnScripts('misses', songMisses);
		setOnScripts('hits', songHits);

		var ret:Dynamic = callOnLuas('onRecalculateRating', [], false);
		if(ret != FunkinLua.Function_Stop)
		{
			if(totalPlayed < 1) //Prevent divide by 0
				ratingName = '?';
			else
			{
				// Rating Percent
				ratingPercent = Math.min(1, Math.max(0, totalNotesHit / totalPlayed));
				//trace((totalNotesHit / totalPlayed) + ', Total: ' + totalPlayed + ', notes hit: ' + totalNotesHit);

				// Rating Name
				if(ratingPercent >= 1)
				{
					ratingName = ratingStuff[ratingStuff.length-1][0]; //Uses last string
				}
				else
				{
					for (i in 0...ratingStuff.length-1)
					{
						if(ratingPercent < ratingStuff[i][1])
						{
							ratingName = ratingStuff[i][0];
							break;
						}
					}
				}
			}

			// Rating FC
			ratingFC = "";
			if (marvelouss > 0) ratingFC = "MFC";
			if (sicks > 0) ratingFC = "PFC";
			if (goods > 0) ratingFC = "GFC";
			if (bads > 0 || shits > 0) ratingFC = "FC";
			if (songMisses > 0 && songMisses < 10) ratingFC = "GC";
			else if (songMisses >= 10) ratingFC = "Clear";
		}
		updateScore(badHit); // score will only update after rating is calculated, if it's a badHit, it shouldn't bounce -Ghost
		setOnScripts('rating', ratingPercent);
		setOnScripts('ratingName', ratingName);
		setOnScripts('ratingFC', ratingFC);
	}

	#if ACHIEVEMENTS_ALLOWED
	private function checkForAchievement(achievesToCheck:Array<String> = null)
	{
		if(chartingMode) return;

		var usedPractice:Bool = (practiceMode || cpuControlled || !notITGMod || ClientPrefs.casualMode);

		for (name in achievesToCheck) {
			if(!Achievements.exists(name)) continue;

			var unlock:Bool = false;
			if (name != WeekData.getWeekFileName() + '_nomiss') // common achievements
			{
				switch(name)
				{
					case 'massacred':
						unlock = (ratingPercent < 0.2 && !usedPractice);
					case 'hitman':
						unlock = (ratingPercent >= 1 && !usedPractice);
					case 'massochist':
						unlock = (chaosDifficulty >= 3 && chaosMod && !usedPractice);
					case 'headache':
						unlock = (playbackRate >= 1.5 && !usedPractice);
					case 'top':
						unlock = (chaosDifficulty == 5 && chaosMod && !usedPractice);
					case 'practice':
						unlock = (usedPractice && !cpuControlled); //idk how but it works LMAO
					// case 'inmortal':
					// 	if(Achievements.totalDeaths >= 100) {
					// 		unlock = true;
					// 	}
				}
			}
			else // any FC achievements, name should be "weekFileName_nomiss", e.g: "week3_nomiss";
			{
				if(isStoryMode && campaignMisses + songMisses < 1 && CoolUtil.difficultyString() == 'HARD'
					&& storyPlaylist.length <= 1 && !changedDifficulty && !usedPractice)
					unlock = true;
			}

			if(unlock) Achievements.unlock(name);
		}
	}
	#end

	var curLight:Int = -1;
	var curLightEvent:Int = -1;

	private function round(num:Float, numDecimalPlaces:Int){
		var mult = 10^numDecimalPlaces;
		return Math.floor(num * mult + 0.5) / mult;
	}

	function createNoteEffect(note:Note, strum:StrumNote, isSustain:Bool){
		//var suffix = game.isPixelStage;
		var sustain = isSustain;
		var animOffset:Array<Float> = [10, 10];
		var ef = new StrumNote(strum.x + animOffset[0], strum.y + animOffset[1], strum.noteData, note.mustPress ? 1 : 0);
		add(ef);
		ef.reloadNote();
		if (!sustain){
			ef.rgbShader.r = strum.rgbShader.r;
			ef.rgbShader.g = strum.rgbShader.g;
			ef.rgbShader.b = strum.rgbShader.b;
		}else{
			ef.rgbShader.r = 0xFFFFFF00;
			ef.rgbShader.g = strum.rgbShader.g;
			ef.rgbShader.b = 0xFF7F7F00;
		}
		ef.alpha -= 0.3;
		ef.angle = strum.angle;
		ef.skew.x = strum.skew.x;
		ef.skew.y = strum.skew.y;
		ef.playAnim("confirm", true);
		// ef.offset.set(ef.offset.x + animOffset[0], ef.offset.y + animOffset[1]);
		ef.cameras = [camHUD];
		// if (!settings.get("highlight")) {
		ef.scale.set(strum.scale.x / 1.5, strum.scale.y / 1.5);
		ef.updateHitbox();
		FlxTween.tween(ef.scale, {x: strum.scale.x + 0.2, y: strum.scale.y + 0.2}, 0.15 / playbackRate - 0.01, {ease: FlxEase.quadOut});
		// ef.blend = 0;
		// } else if (settings.get("unholy")) ef.blend = 0;

		FlxTween.tween(ef, {alpha: 0}, 0.15 / playbackRate + 0.1, {ease: FlxEase.quadOut, startDelay: 0.1, onComplete: function (twn) {
			ef.destroy();
		}});
	}

	public var currentShaders:Array<FlxRuntimeShader> = [];

	private function setShaders(obj:Dynamic, shaders:Array<FNFShader>)
	{
		#if (!flash && sys)
		var filters = [];

		for (shader in shaders)
		{
			filters.push(new ShaderFilter(shader));

			if (!Std.isOfType(obj, FlxCamera))
			{
				obj.shader = shader;

				return true;
			}

			currentShaders.push(shader);
		}
		if (Std.isOfType(obj, FlxCamera))
			obj.setFilters(filters);

		return true;
		#end
	}

	private function removeShaders(obj:Dynamic)
	{
		#if (!flash && sys)
		var filters = [];

		for (shader in currentShaders)
		{
			currentShaders.remove(shader);
		}

		if (!Std.isOfType(obj, FlxCamera))
		{
			obj.shader = null;

			return true;
		}

		if (Std.isOfType(obj, FlxCamera))
			obj.setFilters(filters);

		return true;
		#end
	}

	public function addScript(file:String) {
		#if (HSCRIPT_ALLOWED && HScriptImproved)
		if (haxe.io.Path.extension(file).toLowerCase().contains('hx')){
			trace('INITIALIZED');
			var script = HScriptCode.create(file);
			if (!(script is codenameengine.scripting.DummyScript))
			{
				scripts.add(script);

				if (!file.contains('stages')){
					//Set the things first
					script.set("SONG", SONG);
				}else{
					script.set("game", PlayState.instance);
				}

				//Then CALL SCRIPT
				script.load();
				script.call('onCreate');
			}
		}
		#end
	}

	var checkpointQueueTimesArray:Array<Float> = [];
	//The song length is unknown at this current moment in time... soooooooo we wait until the song length is generated and THEN place the checkpoints.
	function markCheckpointQueue(time:Float, hidden:Bool=false){
		if(!hidden){ //Is it hidden? Don't create the marker in the first place then lol
			trace("Marking Checkpoint!");
			checkpointQueueTimesArray.push(time);
		}
	}

	public function onCheckPoint(strumTime:Float, hideTell:Bool = false, manual:Bool = false){
		
		var previousCheckpointTime:Float = 0;
		if(PlayState.checkpointHistory.length > 0){
			previousCheckpointTime = PlayState.checkpointHistory[PlayState.checkpointHistory.length-1].time;
		}
		
		if(strumTime > previousCheckpointTime){
			var newCheckpoint:CheckpointData = new CheckpointData();
			

			newCheckpoint.time = strumTime;
			trace("Checkpoint set to: " + newCheckpoint.time);

			newCheckpoint.BPM = Conductor.bpm;

			// newCheckpoint.hitTimeDiff = hitTimesDiff;
			// newCheckpoint.hitTimesTime = hitTimesTime;
			// newCheckpoint.hitTimesJudge = hitTimesJudge;
			// newCheckpoint.healthSamples = healthSamples;
			newCheckpoint.totalPlayed = totalPlayed;
			newCheckpoint.totalNotesHit = totalNotesHit;

			newCheckpoint.marvelouss = marvelouss;
			newCheckpoint.sicks = sicks;
			newCheckpoint.goods = goods;
			newCheckpoint.bads = bads;
			newCheckpoint.shits = shits;
			newCheckpoint.highestCombo = maxCombo;
			newCheckpoint.songScore = songScore;
			newCheckpoint.songHits = songHits;
			newCheckpoint.songMisses = songMisses;
			//trace("Checkpoint memory set!");
			//trace("Test for sicks: " + PlayState.checkpointMemory_sicks);

			PlayState.checkpointHistory.push(newCheckpoint);

			if(!hideTell){
				modchartTweenCancel("checkpoint!");
				modchartTweens.set("checkpoint!", FlxTween.tween(checkpointSprite, {alpha : 0.275}, 0.1, {ease: FlxEase.linear,
					onComplete: function(twn:FlxTween) {
						modchartTweens.remove("checkpoint!");
						modchartTweens.set("checkpoint!", FlxTween.tween(checkpointSprite, {alpha : 0.0}, 0.45, {ease: FlxEase.linear,
							onComplete: function(twn:FlxTween) {
								modchartTweens.remove("checkpoint!");
							}
						}));
					}
				}));
			}
		}
	}
	
	// var checkpointMarkersOnTimebar:Array<AttachedSprite> = [];
	// function markCheckpointOnTimebar(time:Float, hidden:Bool = false){
	// 	if(!hidden){ //Is it hidden? Don't create the marker in the first place then lol
	// 		var marker:AttachedSprite = new AttachedSprite('checkPoint');
	// 		marker.sprTracker = hitmansHUD.timeBar;
	// 		marker.scrollFactor.set();
	// 		marker.visible = true;
	// 		marker.cameras = [camInterfaz];

	// 		marker.color = FlxColor.RED;

	// 		//calculate percent where checkpoint is
	// 		var songLengthDummy = getSongLengthFake();
			
	// 		var curTime:Float = time;

	// 		if(curTime < 0) curTime = 0;
	// 		var whatPercent:Float = (curTime / songLengthDummy);

	// 		trace("Checkpoint at percent " + whatPercent);

	// 		//placing checkpoint on bar
	// 		var timebarWidth:Float = hitmansHUD.timeBar.width;
	// 		marker.xAdd = (timebarWidth*whatPercent)-2;
	// 		marker.yAdd = -5;
	// 		add(marker);
	// 		checkpointMarkersOnTimebar.push(marker);
	// 	}
	// }

	// function getSongLengthFake():Float{
	// 	var songLengthDummy = songLength;

	// 	return songLengthDummy;
	// }

	function modchartTweenCancel(tag:String){
		if(modchartTweens.exists(tag)){
			modchartTweens.get(tag).cancel();
			modchartTweens.remove(tag);
		}
	}
}
