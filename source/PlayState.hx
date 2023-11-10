package;

import flixel.graphics.FlxGraphic;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
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
import Achievements;
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

using StringTools;

class PlayState extends MusicBeatState
{
	var hitmansSongs:Array<String> = ['c18h27no3-demo', 'forgotten', 'icebeat', 'hernameis', 'duality', 'hallucination', 'operating']; // Anti cheat system goes brrrrr
	
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

	#if (haxe >= "4.0.0")
	public var boyfriendMap:Map<String, Boyfriend> = new Map();
	public var dadMap:Map<String, Character> = new Map();
	public var gfMap:Map<String, Character> = new Map();
	public var variables:Map<String, Dynamic> = new Map();
	public var modchartTweens:Map<String, FlxTween> = new Map<String, FlxTween>();
	public var modchartSprites:Map<String, ModchartSprite> = new Map<String, ModchartSprite>();
	public var modchartTimers:Map<String, FlxTimer> = new Map<String, FlxTimer>();
	public var modchartSounds:Map<String, FlxSound> = new Map<String, FlxSound>();
	public var modchartTexts:Map<String, ModchartText> = new Map<String, ModchartText>();
	public var modchartSaves:Map<String, FlxSave> = new Map<String, FlxSave>();
	public var modchartCameras:Map<String, FlxCamera> = new Map<String, FlxCamera>(); // FUCK!!!
	public var modchartSkewedSprite:Map<String, FlxSkewedSprite> = new Map<String, FlxSkewedSprite>();
	#else
	public var boyfriendMap:Map<String, Boyfriend> = new Map<String, Boyfriend>();
	public var dadMap:Map<String, Character> = new Map<String, Character>();
	public var gfMap:Map<String, Character> = new Map<String, Character>();
	public var variables:Map<String, Dynamic> = new Map<String, Dynamic>();
	public var modchartTweens:Map<String, FlxTween> = new Map();
	public var modchartSprites:Map<String, ModchartSprite> = new Map();
	public var modchartTimers:Map<String, FlxTimer> = new Map();
	public var modchartSounds:Map<String, FlxSound> = new Map();
	public var modchartTexts:Map<String, ModchartText> = new Map();
	public var modchartSaves:Map<String, FlxSave> = new Map();
	public var modchartCameras:Map<String, FlxCamera> = new Map(); // FUCK!!!
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
	public static var prefixMiddleScroll:Bool = false;
	public static var prefixRightScroll:Bool = false; //so if someone force the scroll in chart and clientPrefs are the other option it will be autoLoaded again
	public static var savePrefixScrollM:Bool = false;
	public static var savePrefixScrollR:Bool = false;
	var edwhakDrain:Float = 0.03;
	var edwhakIsEnemy:Bool = false;
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
	public var canChange:Bool = true; //simple shit to allow or disable death screen variables when a special note was hit/miss
	public var drain:Bool = false;
	public var gain:Bool = false;

	public var tgain:Bool = false;

	//I must add hardcoded shaders! -PastEd

	//and you did man, you did... -Ed

	//Of course, i always don't know how to make better code lmao, but well, this is made to make people have way more fair time doing modcharts with lua so, it is worthy -Ed

	//I HATE DOING THIS STUPID SHIT MANUALLY AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

	public var spawnTime:Float = 2000;

	public var vocals:FlxSound;

	public var dad:Character = null;
	public var gf:Character = null;
	public var boyfriend:Boyfriend = null;

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

	public var camZooming:Bool = false;
	public var camZoomingMult:Float = 1;
	public var camZoomingDecay:Float = 1;
	private var curSong:String = "";

	public var gfSpeed:Int = 1;
	public var health:Float = 1;
	public var maxHealth:Float = 0; //Totally not stolen from Lullaby lol
	public var combo:Int = 0;
	public var comboOp:Int = 0;
	private var maxCombo:Int = 0;

	private var healthBarBG:AttachedSprite;
	private var healthBarHit:AttachedSprite;
	public var healthBar:FlxBar;
	public var healthHitBar:FlxBar;
	var songPercent:Float = 0;

	private var timeBarBG:AttachedSprite;
	public var timeBar:FlxBar;

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

	public var botplaySine:Float = 0;
	public var botplayTxt:FlxText;

	public var iconP1:HealthIcon;
	public var iconP2:HealthIcon;
	public var camHUD:FlxCamera;
	public var camInterfaz:FlxCamera;
	public var camGame:FlxCamera;
	public var camOther:FlxCamera;
	public var camRate:FlxCamera;
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
	var wiggleShit:WiggleEffect = new WiggleEffect();
	var bgGhouls:BGSprite;

	var tankWatchtower:BGSprite;
	var tankGround:BGSprite;
	var tankmanRun:FlxTypedGroup<TankmenBG>;
	var foregroundSprites:FlxTypedGroup<BGSprite>;

	public var songScore:Int = 0;
	public var songHits:Int = 0;
	public var songMisses:Int = 0;
	public var scoreTxt:FlxText;
	public var scoreTxtHit:FlxText;
	var timeTxt:FlxText;
	var scoreTxtTween:FlxTween;
	var scoreTxtHitTween:FlxTween;

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
	var songLength:Float = 0;

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

	//made these 2 for Player and Enemy (usually both plays at the same time but when its vs Ed he usually play enemy so...)
	public var ratings:FlxSprite;
	var ratingsBumpTween:FlxTween;
	var ratingsBumpTween2:FlxTween;
	var ratingsBumpTimer:FlxTimer;

	public var ratingsOP:FlxSprite;
	var ratingsOPBumpTween:FlxTween;
	var ratingsOPBumpTween2:FlxTween;
	var ratingsOPBumpTimer:FlxTimer;

	var noteScore:FlxText;
	var noteScoreOp:FlxText;
	public var noteRatingTween:FlxTween;
	public var noteRatingTweenOp:FlxTween;

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
	var quantcolord:Array<FlxColor> = ClientPrefs.arrowRQuantize;
	var quantcolord2:Array<FlxColor> = ClientPrefs.arrowBQuantize;
	var col:Int = 0xFFFFD700;
	var col2:Int = 0xFFFFD700;

	public static var timeToStart:Float = 0;

	override public function create()
	{
		//trace('Playback Rate: ' + playbackRate);

		tweenManager = new FlxTweenManager();
		timerManager = new FlxTimerManager();

		Paths.clearStoredMemory();

		// for lua
		instance = this;

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

		//Hitmans Ratings (Kinda Better LOL, sorry if separated i can't use array due keyboard bug)
		//570 x and 200 y (just in case)
		ratings = new FlxSprite(850, 230);
		ratings.frames = Paths.getSparrowAtlas('judgements');
		ratings.animation.addByPrefix('fantastic', 'Fantastic', 1, true);
		ratings.animation.addByPrefix('excellent Late', 'Excellent late', 1, true);
		ratings.animation.addByPrefix('excellent Early', 'Excellent early', 1, true);
		ratings.animation.addByPrefix('great Early', 'Great early', 1, true);
		ratings.animation.addByPrefix('great Late', 'Great late', 1, true);
		ratings.animation.addByPrefix('decent Early', 'Decent early', 1, true);
        ratings.animation.addByPrefix('decent Late', 'Decent late', 1, true);
        ratings.animation.addByPrefix('way Off Early', 'Way off early', 1, true);
        ratings.animation.addByPrefix('way Off Late', 'Way off late', 1, true);
		ratings.animation.addByPrefix('miss', 'Miss', 1, true);
		ratings.antialiasing = true;
		ratings.updateHitbox();
		ratings.scrollFactor.set();
		ratings.visible = false;
		add(ratings);

		ratingsOP = new FlxSprite(180, 230);
		ratingsOP.frames = Paths.getSparrowAtlas('judgements');
		ratingsOP.animation.addByPrefix('fantastic', 'Fantastic', 1, true);
		ratingsOP.animation.addByPrefix('excellent Late', 'Excellent late', 1, true);
		ratingsOP.animation.addByPrefix('excellent Early', 'Excellent early', 1, true);
		ratingsOP.animation.addByPrefix('great Early', 'Great early', 1, true);
		ratingsOP.animation.addByPrefix('great Late', 'Great late', 1, true);
		ratingsOP.animation.addByPrefix('decent Early', 'Decent early', 1, true);
        ratingsOP.animation.addByPrefix('decent Late', 'Decent late', 1, true);
        ratingsOP.animation.addByPrefix('way Off Early', 'Way off early', 1, true);
        ratingsOP.animation.addByPrefix('way Off Late', 'Way off late', 1, true);
		ratingsOP.animation.addByPrefix('miss', 'Miss', 1, true);
		ratingsOP.antialiasing = true;
		ratingsOP.updateHitbox();
		ratingsOP.scrollFactor.set();
		ratingsOP.visible = false;
		add(ratingsOP);

		noteScoreOp = new FlxText(ratingsOP.x, 0, FlxG.width, '', 36);
		noteScoreOp.setFormat(Paths.font("pixel.otf"), 36, 0xff000000, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		noteScoreOp.borderSize = 2;
		noteScoreOp.scrollFactor.set();
		noteScoreOp.visible = false;
		add(noteScoreOp);

		noteScore = new FlxText(ratings.x, 0, FlxG.width, '', 36);
		noteScore.setFormat(Paths.font("pixel.otf"), 36, 0xff000000, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		noteScore.borderSize = 2;
		noteScore.scrollFactor.set();
		noteScore.visible = false;
		add(noteScore);

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

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camInterfaz = new FlxCamera();
		camOther = new FlxCamera();
		camRate = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camInterfaz.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;
		camRate.bgColor.alpha = 0;
		noteCameras0 = new FlxCamera();
		noteCameras0.bgColor.alpha = 0;
		noteCameras0.visible = false;
		noteCameras1 = new FlxCamera();
		noteCameras1.bgColor.alpha = 0;
		noteCameras1.visible = false;
		// noteCameras2 = new FlxCamera();
		// noteCameras2.bgColor.alpha = 0;
		// noteCameras2.visible = false;
		// noteCameras3 = new FlxCamera();
		// noteCameras3.bgColor.alpha = 0;
		// noteCameras3.visible = false;
		// noteCameras4 = new FlxCamera();
		// noteCameras4.bgColor.alpha = 0;
		// noteCameras4.visible = false;
		// noteCameras5 = new FlxCamera();
		// noteCameras5.bgColor.alpha = 0;
		// noteCameras5.visible = false;
		// noteCameras6 = new FlxCamera();
		// noteCameras6.bgColor.alpha = 0;
		// noteCameras6.visible = false;
		// noteCameras7 = new FlxCamera();
		// noteCameras7.bgColor.alpha = 0;
		// noteCameras7.visible = false;
		// noteCameras8 = new FlxCamera();
		// noteCameras8.bgColor.alpha = 0;
		// noteCameras8.visible = false;
		// noteCameras9 = new FlxCamera();
		// noteCameras9.bgColor.alpha = 0;
		// noteCameras9.visible = false;
		// noteCameras10 = new FlxCamera();
		// noteCameras10.bgColor.alpha = 0;
		// noteCameras10.visible = false;
		// noteCameras11 = new FlxCamera();
		// noteCameras11.bgColor.alpha = 0;
		// noteCameras11.visible = false;
		// noteCameras12 = new FlxCamera();
		// noteCameras12.bgColor.alpha = 0;
		// noteCameras12.visible = false;
		// noteCameras13 = new FlxCamera();
		// noteCameras13.bgColor.alpha = 0;
		// noteCameras13.visible = false;
		// noteCameras14 = new FlxCamera();
		// noteCameras14.bgColor.alpha = 0;
		// noteCameras14.visible = false;
		// noteCameras15 = new FlxCamera();
		// noteCameras15.bgColor.alpha = 0;
		// noteCameras15.visible = false;
		// noteCameras16 = new FlxCamera();
		// noteCameras16.bgColor.alpha = 0;
		// noteCameras16.visible = false;
		// noteCameras17 = new FlxCamera();
		// noteCameras17.bgColor.alpha = 0;
		// noteCameras17.visible = false;
		// noteCameras18 = new FlxCamera();
		// noteCameras18.bgColor.alpha = 0;
		// noteCameras18.visible = false;
		// noteCameras19 = new FlxCamera();
		// noteCameras19.bgColor.alpha = 0;
		// noteCameras19.visible = false;
		// noteCameras20 = new FlxCamera();
		// noteCameras20.bgColor.alpha = 0;
		// noteCameras20.visible = false;
		// noteCameras21 = new FlxCamera();
		// noteCameras21.visible = false;
		// noteCameras21.bgColor.alpha = 0;
		// noteCameras22 = new FlxCamera();
		// noteCameras22.bgColor.alpha = 0;
		// noteCameras22.visible = false;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camInterfaz, false);
		FlxG.cameras.add(camHUD, false);

		FlxG.cameras.add(noteCameras0, false);
		FlxG.cameras.add(noteCameras1, false);
		// FlxG.cameras.add(noteCameras2, false);
		// FlxG.cameras.add(noteCameras3, false);
		// FlxG.cameras.add(noteCameras4, false);
		// FlxG.cameras.add(noteCameras5, false);
		// FlxG.cameras.add(noteCameras6, false);
		// FlxG.cameras.add(noteCameras7, false);
		// FlxG.cameras.add(noteCameras8, false);
		// FlxG.cameras.add(noteCameras9, false);
		// FlxG.cameras.add(noteCameras10, false);
		// FlxG.cameras.add(noteCameras11, false);
		// FlxG.cameras.add(noteCameras12, false);
		// FlxG.cameras.add(noteCameras13, false);
		// FlxG.cameras.add(noteCameras14, false);
		// FlxG.cameras.add(noteCameras15, false);
		// FlxG.cameras.add(noteCameras16, false);
		// FlxG.cameras.add(noteCameras17, false);
		// FlxG.cameras.add(noteCameras18, false);
		// FlxG.cameras.add(noteCameras19, false);
		// FlxG.cameras.add(noteCameras20, false);
		// FlxG.cameras.add(noteCameras21, false);
		// FlxG.cameras.add(noteCameras22, false);
		FlxG.cameras.add(camOther, false);
		FlxG.cameras.add(camRate, false);

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
		HitmansGameOverSubstate.resetVariables();
		NewHitmansGameOver.resetVariables();
		var songName:String = Paths.formatToSongPath(SONG.song);

		if (ClientPrefs.middleScroll){
			prefixMiddleScroll = true;
			prefixRightScroll = false;
		}else if (!ClientPrefs.middleScroll){
			prefixRightScroll = true;
			prefixMiddleScroll = false;
		}

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

		switch (curStage)
		{
			case 'stage': //Week 1
				var bg:BGSprite = new BGSprite('DefaultBackGround', -605, -150, 0.5, 0.5);
				bg.scale.x = 0.7;
				bg.scale.y = 0.7;
				bg.screenCenter(Y);
				add(bg);
		}

		if(isPixelStage) {
			introSoundsSuffix = '-pixel';
		}

		add(gfGroup); //Needed for blammed lights
		add(dadGroup);
		add(boyfriendGroup);

		// useModchart = modchartedSongs.contains(SONG.song.toLowerCase());
		// generateSong(SONG.song);

		#if LUA_ALLOWED
		luaDebugGroup = new FlxTypedGroup<DebugLuaText>();
		luaDebugGroup.cameras = [camOther];
		add(luaDebugGroup);
		#end

		// "GLOBAL" SCRIPTS
		#if LUA_ALLOWED
		var filesPushed:Array<String> = [];
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('scripts/')];

		#if MODS_ALLOWED
		foldersToCheck.insert(0, Paths.mods('scripts/'));
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/scripts/'));

		for(mod in Paths.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/scripts/'));
		#end

		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if(file.endsWith('.lua') && !filesPushed.contains(file))
					{
						luaArray.push(new FunkinLua(folder + file));
						filesPushed.push(file);
					}
				}
			}
		}
		#end


		// STAGE SCRIPTS
		#if (MODS_ALLOWED && LUA_ALLOWED)
		var doPush:Bool = false;
		var luaFile:String = 'stages/' + curStage + '.lua';
		if(FileSystem.exists(Paths.modFolders(luaFile))) {
			luaFile = Paths.modFolders(luaFile);
			doPush = true;
		} else {
			luaFile = Paths.getPreloadPath(luaFile);
			if(FileSystem.exists(luaFile)) {
				doPush = true;
			}
		}

		if(doPush)
			luaArray.push(new FunkinLua(luaFile));
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
			startCharacterLua(gf.curCharacter);

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
		startCharacterLua(dad.curCharacter);

		boyfriend = new Boyfriend(0, 0, SONG.player1);
		startCharacterPos(boyfriend);
		boyfriendGroup.add(boyfriend);
		startCharacterLua(boyfriend.curCharacter);

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
		if (boyfriend.curCharacter == 'Edwhak'){
			Note.canDamagePlayer = false;
			Note.edwhakIsPlayer = true;
			HitmansGameOverSubstate.guidingEdwhak = false;
			HitmansGameOverSubstate.curiousTails = false;
			HitmansGameOverSubstate.flirtyArrow = false;
			HitmansGameOverSubstate.masterAnby = true;
			HitmansGameOverSubstate.loopSoundName = 'Edwhak/masterDeath';
		} else if (boyfriend.curCharacter =='he'){
			Note.canDamagePlayer = false;
			Note.edwhakIsPlayer = true;
			HitmansGameOverSubstate.guidingEdwhak = false;
			HitmansGameOverSubstate.curiousTails = false;
			HitmansGameOverSubstate.flirtyArrow = false;
			HitmansGameOverSubstate.masterAnby = true;
			HitmansGameOverSubstate.loopSoundName = 'Edwhak/masterDeath';
		} else if (boyfriend.curCharacter =='edwhakBroken'){
			Note.canDamagePlayer = false;
			Note.edwhakIsPlayer = true;
			HitmansGameOverSubstate.guidingEdwhak = false;
			HitmansGameOverSubstate.curiousTails = false;
			HitmansGameOverSubstate.flirtyArrow = false;
			HitmansGameOverSubstate.masterAnby = true;
			HitmansGameOverSubstate.loopSoundName = 'Edwhak/masterDeath';
		} else if (boyfriend.curCharacter =='edkbmassacre'){
			Note.canDamagePlayer = false;
			Note.edwhakIsPlayer = true;
			HitmansGameOverSubstate.guidingEdwhak = false;
			HitmansGameOverSubstate.curiousTails = false;
			HitmansGameOverSubstate.flirtyArrow = false;
			HitmansGameOverSubstate.masterAnby = true;
			HitmansGameOverSubstate.loopSoundName = 'Edwhak/masterDeath';
		} else if (boyfriend.curCharacter =='medy'){
			Note.canDamagePlayer = false;
			Note.edwhakIsPlayer = true;
			HitmansGameOverSubstate.guidingEdwhak = true;
			HitmansGameOverSubstate.curiousTails = false;
			HitmansGameOverSubstate.flirtyArrow = false;
			HitmansGameOverSubstate.masterAnby = false;
			HitmansGameOverSubstate.loopSoundName = 'Edwhak/deathmusic';
		} else {
			Note.canDamagePlayer = true;
			Note.edwhakIsPlayer = false;
		}
				// i can't die to my own notes u dumb
				// also my GF can't die too because i fucking love her

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
			if (dad.curCharacter == 'Edwhak'){
				edwhakIsEnemy = true;
				HitmansGameOverSubstate.guidingEdwhak = false;
				HitmansGameOverSubstate.curiousTails = true;
				HitmansGameOverSubstate.flirtyArrow = false;
				HitmansGameOverSubstate.masterAnby = false;
				HitmansGameOverSubstate.loopSoundName = 'Edwhak/curiousDeath';
			} else if (dad.curCharacter =='he'){
				edwhakIsEnemy = true;
				HitmansGameOverSubstate.guidingEdwhak = false;
				HitmansGameOverSubstate.curiousTails = true;
				HitmansGameOverSubstate.flirtyArrow = false;
				HitmansGameOverSubstate.masterAnby = false;
				HitmansGameOverSubstate.loopSoundName = 'Edwhak/curiousDeath';
			} else if (dad.curCharacter =='edwhakBroken'){
				edwhakIsEnemy = true;
				HitmansGameOverSubstate.guidingEdwhak = false;
				HitmansGameOverSubstate.curiousTails = true;
				HitmansGameOverSubstate.flirtyArrow = false;
				HitmansGameOverSubstate.masterAnby = false;
				HitmansGameOverSubstate.loopSoundName = 'Edwhak/curiousDeath';
			} else if (dad.curCharacter =='edkbmassacre'){
				edwhakIsEnemy = true;
				HitmansGameOverSubstate.guidingEdwhak = false;
				HitmansGameOverSubstate.curiousTails = true;
				HitmansGameOverSubstate.flirtyArrow = false;
				HitmansGameOverSubstate.masterAnby = false;
				HitmansGameOverSubstate.loopSoundName = 'Edwhak/curiousDeath';
			} else if (dad.curCharacter =='medy'){
				if (!Note.edwhakIsPlayer){
					edwhakIsEnemy = false;
					HitmansGameOverSubstate.guidingEdwhak = false;
					HitmansGameOverSubstate.curiousTails = true;
					HitmansGameOverSubstate.flirtyArrow = false;
					HitmansGameOverSubstate.masterAnby = false;
					HitmansGameOverSubstate.loopSoundName = 'Edwhak/curiousDeath';
				} else {
					edwhakIsEnemy = false;
					HitmansGameOverSubstate.guidingEdwhak = false;
					HitmansGameOverSubstate.curiousTails = false;
					HitmansGameOverSubstate.flirtyArrow = false;
					HitmansGameOverSubstate.masterAnby = true;	
					HitmansGameOverSubstate.loopSoundName = 'Edwhak/masterDeath';
				}
			} else {
				edwhakIsEnemy = false;
				HitmansGameOverSubstate.guidingEdwhak = true;
				HitmansGameOverSubstate.curiousTails = false;
				HitmansGameOverSubstate.flirtyArrow = false;
				HitmansGameOverSubstate.masterAnby = false;
				HitmansGameOverSubstate.loopSoundName = 'Edwhak/deathmusic';
				}
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

		Conductor.songPosition = -5000 / Conductor.songPosition;

		
		if (SONG.middleScroll && !ClientPrefs.middleScroll){
			forceMiddleScroll = true;
			forceRightScroll = false;
			ClientPrefs.middleScroll = true;
		}else if (SONG.rightScroll && ClientPrefs.middleScroll){
			forceMiddleScroll = false;
			forceRightScroll = true;
			ClientPrefs.middleScroll = false;
		}

		if (forceMiddleScroll && !ClientPrefs.middleScroll){
			savePrefixScrollR = true;
		}else if (forceRightScroll && ClientPrefs.middleScroll){
			savePrefixScrollM = true;
		}

		strumLine = new FlxSprite(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, 50).makeGraphic(FlxG.width, 10);
		if(ClientPrefs.downScroll) strumLine.y = FlxG.height - 150;
		strumLine.scrollFactor.set();

		var showTime:Bool = (ClientPrefs.timeBarType != 'Disabled');
		timeTxt = new FlxText(STRUM_X + (FlxG.width / 2) - 248, 19, 400, "", 32);
		timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeTxt.scrollFactor.set();
		timeTxt.alpha = 0;
		timeTxt.borderSize = 2;
		timeTxt.visible = showTime;
		if(ClientPrefs.downScroll) timeTxt.y = FlxG.height - 44;

		if(ClientPrefs.timeBarType == 'Song Name')
		{
			timeTxt.text = SONG.song;
		}
		updateTime = showTime;

		timeBarBG = new AttachedSprite('timeBar');
		timeBarBG.x = timeTxt.x;
		timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
		timeBarBG.scrollFactor.set();
		timeBarBG.alpha = 0;
		timeBarBG.visible = showTime;
		timeBarBG.color = FlxColor.BLACK;
		timeBarBG.xAdd = -4;
		timeBarBG.yAdd = -4;
		add(timeBarBG);

		timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), this,
			'songPercent', 0, 1);
		timeBar.scrollFactor.set();
		timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
		timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
		timeBar.alpha = 0;
		timeBar.visible = showTime;
		add(timeBar);
		add(timeTxt);
		timeBarBG.sprTracker = timeBar;

		strumLineNotes = new FlxTypedGroup<StrumNote>();
		add(strumLineNotes);

		if(ClientPrefs.timeBarType == 'Song Name')
		{
			timeTxt.size = 24;
			timeTxt.y += 3;
		}

		opponentStrums = new FlxTypedGroup<StrumNote>();
		playerStrums = new FlxTypedGroup<StrumNote>();

		// startCountdown();

		generateSong(SONG.song);

		// After all characters being loaded, it makes then invisible 0.01s later so that the player won't freeze when you change characters
		// add(strumLine);
		if (SONG.notITG && notITGMod){
			playfieldRenderer = new PlayfieldRenderer(strumLineNotes, notes, this);
			playfieldRenderer.cameras = [camHUD, noteCameras0, noteCameras1/*, noteCameras2, noteCameras3, noteCameras4, noteCameras5, noteCameras6, noteCameras7, noteCameras8,
				noteCameras9, noteCameras10, noteCameras11, noteCameras12, noteCameras13, noteCameras14, noteCameras15, noteCameras16, noteCameras17, noteCameras18, noteCameras19,
			noteCameras20, noteCameras21, noteCameras22*/];
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
		healthBarBG = new AttachedSprite('healthBar');
		healthBarBG.y = FlxG.height * 0.89;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		healthBarBG.visible = !ClientPrefs.hideHud;
		healthBarBG.xAdd = -4;
		healthBarBG.yAdd = -4;
		add(healthBarBG);
		if (ClientPrefs.hudStyle == 'HITMANS'){
			healthBarBG.visible = false;
		}

		if(ClientPrefs.downScroll) healthBarBG.y = 0.11 * FlxG.height;

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		// healthBar
		healthBar.visible = !ClientPrefs.hideHud;
		healthBar.alpha = ClientPrefs.healthBarAlpha;
		add(healthBar);
		if (ClientPrefs.hudStyle == 'HITMANS'){
			healthBar.visible = false;
		}
		healthBarBG.sprTracker = healthBar;

		healthBarHit = new AttachedSprite('healthBarHit');
		if(!ClientPrefs.downScroll) healthBarHit.y = FlxG.height * 0.9;
		if(ClientPrefs.downScroll) healthBarHit.y = 0 * FlxG.height;
		healthBarHit.screenCenter(X);
		healthBarHit.visible = !ClientPrefs.hideHud;
		healthBarHit.alpha = ClientPrefs.healthBarAlpha;
		healthBarHit.flipY = false;
		if (!ClientPrefs.downScroll){
			healthBarHit.flipY = true;
		}
		healthHitBar = new FlxBar(350, healthBarHit.y + 15, RIGHT_TO_LEFT, Std.int(healthBarHit.width - 120), Std.int(healthBarHit.height - 30), this,
			'health', 0, 2);
		// healthBar
		healthHitBar.visible = !ClientPrefs.hideHud;
		healthHitBar.alpha = ClientPrefs.healthBarAlpha;
		add(healthHitBar);
		add(healthBarHit);
		if (ClientPrefs.hudStyle == 'Classic'){
			healthHitBar.visible = false;
			healthBarHit.visible = false;
		}

		iconP1 = new HealthIcon(boyfriend.healthIcon, true);
		iconP1.y = healthBar.y - 75;
		iconP1.visible = !ClientPrefs.hideHud;
		iconP1.alpha = ClientPrefs.healthBarAlpha;
		add(iconP1);

		iconP2 = new HealthIcon(dad.healthIcon, false);
		iconP2.y = healthBar.y - 75;
		iconP2.visible = !ClientPrefs.hideHud;
		iconP2.alpha = ClientPrefs.healthBarAlpha;
		add(iconP2);
		reloadHealthBarColors();

		scoreTxt = new FlxText(0, healthBarBG.y + 36, FlxG.width, "", 20);
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		scoreTxt.borderSize = 1.25;
		scoreTxt.visible = !ClientPrefs.hideHud;
		if (ClientPrefs.hudStyle == 'Classic'){
		add(scoreTxt);
		}

		scoreTxtHit = new FlxText(0, 0, FlxG.width, "", 20);
		scoreTxtHit.setFormat(Paths.font("DEADLY KILLERS.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		if(!ClientPrefs.downScroll) scoreTxtHit.y = healthBarHit.y - 33;
		if(ClientPrefs.downScroll) scoreTxtHit.y = healthBarHit.y + 66;
		scoreTxtHit.scrollFactor.set();
		scoreTxtHit.borderSize = 1.25;
		scoreTxtHit.visible = !ClientPrefs.hideHud;
		if (ClientPrefs.hudStyle == 'HITMANS'){
		add(scoreTxtHit);
		}

		botplayTxt = new FlxText(400, timeBarBG.y + 55, FlxG.width - 800, "BOTPLAY", 32);
		botplayTxt.setFormat(Paths.font("DEADLY KILLERS.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		botplayTxt.scrollFactor.set();
		botplayTxt.borderSize = 1.25;
		botplayTxt.visible = cpuControlled;
		add(botplayTxt);
		if(ClientPrefs.downScroll) {
			botplayTxt.y = timeBarBG.y - 78;
		}

		strumLineNotes.cameras = [
			camHUD, noteCameras0, noteCameras1/*, noteCameras2, noteCameras3, noteCameras4, noteCameras5, noteCameras6, noteCameras7, noteCameras8,
			noteCameras9, noteCameras10, noteCameras11, noteCameras12, noteCameras13, noteCameras14, noteCameras15, noteCameras16, noteCameras17, noteCameras18, noteCameras19,
		noteCameras20, noteCameras21, noteCameras22*/
		];
		notes.cameras = [
			camHUD, noteCameras0, noteCameras1/*, noteCameras2, noteCameras3, noteCameras4, noteCameras5, noteCameras6, noteCameras7, noteCameras8,
			noteCameras9, noteCameras10, noteCameras11, noteCameras12, noteCameras13, noteCameras14, noteCameras15, noteCameras16, noteCameras17, noteCameras18, noteCameras19,
		noteCameras20, noteCameras21, noteCameras22*/
		];
		healthBar.cameras = [camInterfaz];
		healthBarBG.cameras = [camInterfaz];
		healthBarHit.cameras = [camOther];
		healthHitBar.cameras = [camOther];
		ratings.cameras = [camOther];
		ratingsOP.cameras = [camOther];
		noteScore.cameras = [camOther];
		noteScoreOp.cameras = [camOther];
		if (ClientPrefs.hudStyle == 'HITMANS'){
			iconP1.cameras = [camOther];
			iconP2.cameras = [camOther];	
		}else if (ClientPrefs.hudStyle == 'Classic'){
			iconP1.cameras = [camInterfaz];
			iconP2.cameras = [camInterfaz];
		}
		scoreTxt.cameras = [camInterfaz];
		scoreTxtHit.cameras = [camOther];
		botplayTxt.cameras = [camOther];
		timeBar.cameras = [camInterfaz];
		timeBarBG.cameras = [camInterfaz];
		timeTxt.cameras = [camInterfaz];
		doof.cameras = [camInterfaz];

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;
		
		#if LUA_ALLOWED
		for (notetype in noteTypeMap.keys())
		{
			#if MODS_ALLOWED
			var luaToLoad:String = Paths.modFolders('custom_notetypes/' + notetype + '.lua');
			if(FileSystem.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			else
			{
				luaToLoad = Paths.getPreloadPath('custom_notetypes/' + notetype + '.lua');
				if(FileSystem.exists(luaToLoad))
				{
					luaArray.push(new FunkinLua(luaToLoad));
				}
			}
			#elseif sys
			var luaToLoad:String = Paths.getPreloadPath('custom_notetypes/' + notetype + '.lua');
			if(OpenFlAssets.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			#end
		}
		for (event in eventPushedMap.keys())
		{
			#if MODS_ALLOWED
			var luaToLoad:String = Paths.modFolders('custom_events/' + event + '.lua');
			if(FileSystem.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			else
			{
				luaToLoad = Paths.getPreloadPath('custom_events/' + event + '.lua');
				if(FileSystem.exists(luaToLoad))
				{
					luaArray.push(new FunkinLua(luaToLoad));
				}
			}
			#elseif sys
			var luaToLoad:String = Paths.getPreloadPath('custom_events/' + event + '.lua');
			if(OpenFlAssets.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			#end
		}
		#end
		noteTypeMap.clear();
		noteTypeMap = null;
		eventPushedMap.clear();
		eventPushedMap = null;

		// SONG SPECIFIC SCRIPTS
		#if LUA_ALLOWED
		var filesPushed:Array<String> = [];
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('data/' + Paths.formatToSongPath(SONG.song) + '/')];

		#if MODS_ALLOWED
		foldersToCheck.insert(0, Paths.mods('data/' + Paths.formatToSongPath(SONG.song) + '/'));
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/data/' + Paths.formatToSongPath(SONG.song) + '/'));

		for(mod in Paths.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/data/' + Paths.formatToSongPath(SONG.song) + '/' ));// using push instead of insert because these should run after everything else
		#end

		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if(file.endsWith('.lua') && !filesPushed.contains(file))
					{
						luaArray.push(new FunkinLua(folder + file));
						filesPushed.push(file);
					}
				}
			}
		}
		#end

		var daSong:String = Paths.formatToSongPath(curSong);
		if (isStoryMode && !seenCutscene)
		{
			switch (daSong)
			{
				default:
					startCountdown();
			}
			seenCutscene = true;
		}
		else
		{
			startCountdown();
		}
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
			DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
		}
		#end

		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}

		if (notITGMod && SONG.notITG)
			ModchartFuncs.loadLuaFunctions();

		callOnLuas('onCreatePost', []);

		// camHUD.height = 1300; //some modcharts compatibility (need fix some stuff such as Y poss for camera but oh well)

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
	}

	public function doNoteQuant()
	{
		var bpmChanges = Conductor.bpmChangeMap;
		var strumTime:Float = 0;
		var currentBPM = PlayState.SONG.bpm;
		for (note in unspawnNotes) {
			strumTime = note.strumTime;
			var newTime = strumTime;
			for (i in 1...bpmChanges.length)
				if (strumTime > bpmChanges[i].songTime){
					currentBPM = bpmChanges[i].bpm;
					newTime = strumTime - bpmChanges[i].songTime;
				}
			if (note.rgbShader.enabled && !note.hurtNote){
				dataStuff = ((currentBPM * (newTime - ClientPrefs.noteOffset)) / 1000 / 60);
				beat = round(dataStuff * 48, 0);
				if (!note.isSustainNote){
					if(beat%(192/4)==0){
						col = ClientPrefs.arrowRQuantize[0];
						col2 = ClientPrefs.arrowBQuantize[0];
					}
					else if(beat%(192/6)==0){
						col = ClientPrefs.arrowRQuantize[1];
						col2 = ClientPrefs.arrowBQuantize[1];
					}
					else if(beat%(192/8)==0){
						col = ClientPrefs.arrowRQuantize[2];
						col2 = ClientPrefs.arrowBQuantize[2];
					}
					else if(beat%(192/12)==0){
						col = ClientPrefs.arrowRQuantize[3];
						col2 = ClientPrefs.arrowBQuantize[3];
					}
					else if(beat%(192/16)==0){
						col = ClientPrefs.arrowRQuantize[4];
						col2 = ClientPrefs.arrowBQuantize[4];
					}
					else if(beat%(192/24)==0){
						col = ClientPrefs.arrowRQuantize[5];
						col2 = ClientPrefs.arrowBQuantize[5];
					}
					else if(beat%(192/32)==0){
						col = ClientPrefs.arrowRQuantize[6];
						col2 = ClientPrefs.arrowBQuantize[6];
					}
					else{
						col = ClientPrefs.arrowRQuantize[7];
						col2 = ClientPrefs.arrowBQuantize[7];
					}
					note.rgbShader.r = col;
					note.rgbShader.b = col2;
			
				}else{
					note.rgbShader.r = note.prevNote.rgbShader.r;
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

		var foldersToCheck:Array<String> = [Paths.mods('shaders/')];
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/shaders/'));

		for(mod in Paths.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/shaders/'));
		
		for (folder in foldersToCheck)
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
		trace('Anim speed: ' + FlxAnimationController.globalSpeed);
		Conductor.safeZoneOffset = (ClientPrefs.safeFrames / 60) * 1000 * value;
		setOnLuas('playbackRate', playbackRate);
		return value;
	}

	// public function addCameras(from:Dynamic,to:Dynamic){
	// 	var min:Int = 1;
	// 	var max:Int = 22;
	// 	if (from >= 1){
	// 		min = from;
	// 	}
	// 	if (to <= 22){
	// 		max = to;
	// 	}
	// 	for (i in min...max){
	// 		FlxG.cameras.add(noteCameras0, false);
	// 		FlxG.cameras.add(noteCameras+i, false);
	// 	}

	// 	callOnLuas('addCameras', from, to);
	// }
	// public function removeCameras(valorMin:Dynamic, valorMax:Dynamic){
	// 	for (i in valorMin...valorMax)
	// 		FlxG.cameras.remove(noteCameras+i);

	// 	callOnLuas('RemoveCameras', valorMin, valorMax);
	// }


	public function addTextToDebug(text:String, color:FlxColor) {
		#if LUA_ALLOWED
		luaDebugGroup.forEachAlive(function(spr:DebugLuaText) {
			spr.y += 20;
		});

		if(luaDebugGroup.members.length > 34) {
			var blah = luaDebugGroup.members[34];
			blah.destroy();
			luaDebugGroup.remove(blah);
		}
		luaDebugGroup.insert(0, new DebugLuaText(text, luaDebugGroup, color));
		#end
	}

	public function reloadHealthBarColors() {
		healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
			FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));

		healthBar.updateBar();
		healthHitBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
			FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));

		healthHitBar.updateBar();
	}

	public function addCharacterToList(newCharacter:String, type:Int) {
		switch(type) {
			case 0:
				if(!boyfriendMap.exists(newCharacter)) {
					var newBoyfriend:Boyfriend = new Boyfriend(0, 0, newCharacter);
					boyfriendMap.set(newCharacter, newBoyfriend);
					boyfriendGroup.add(newBoyfriend);
					startCharacterPos(newBoyfriend);
					newBoyfriend.alpha = 0.00001;
					startCharacterLua(newBoyfriend.curCharacter);
				}

			case 1:
				if(!dadMap.exists(newCharacter)) {
					var newDad:Character = new Character(0, 0, newCharacter);
					dadMap.set(newCharacter, newDad);
					dadGroup.add(newDad);
					startCharacterPos(newDad, true);
					newDad.alpha = 0.00001;
					startCharacterLua(newDad.curCharacter);
				}

			case 2:
				if(gf != null && !gfMap.exists(newCharacter)) {
					var newGf:Character = new Character(0, 0, newCharacter);
					newGf.scrollFactor.set(0.95, 0.95);
					gfMap.set(newCharacter, newGf);
					gfGroup.add(newGf);
					startCharacterPos(newGf);
					newGf.alpha = 0.00001;
					startCharacterLua(newGf.curCharacter);
				}
		}
	}

	function startCharacterLua(name:String)
	{
		#if LUA_ALLOWED
		var doPush:Bool = false;
		var luaFile:String = 'characters/' + name + '.lua';
		#if MODS_ALLOWED
		if(FileSystem.exists(Paths.modFolders(luaFile))) {
			luaFile = Paths.modFolders(luaFile);
			doPush = true;
		} else {
			luaFile = Paths.getPreloadPath(luaFile);
			if(FileSystem.exists(luaFile)) {
				doPush = true;
			}
		}
		#else
		luaFile = Paths.getPreloadPath(luaFile);
		if(Assets.exists(luaFile)) {
			doPush = true;
		}
		#end

		if(doPush)
		{
			for (script in luaArray)
			{
				if(script.scriptName == luaFile) return;
			}
			luaArray.push(new FunkinLua(luaFile));
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
			setOnLuas('defaultPlayerStrumX' + i, playerStrums.members[i].x);
			setOnLuas('defaultPlayerStrumY' + i, playerStrums.members[i].y);
		}
		for (i in 0...opponentStrums.length) {
			setOnLuas('defaultOpponentStrumX' + i, opponentStrums.members[i].x);
			setOnLuas('defaultOpponentStrumY' + i, opponentStrums.members[i].y);
			//if(ClientPrefs.middleScroll) opponentStrums.members[i].visible = false;
		}

		// for (i in 0...strumLineNotes.length)
		// {
		// 	var member = PlayState.instance.strumLineNotes.members[i];
		// 	setOnLuas("defaultStrum" + i + "X", Math.floor(member.x));
		// 	setOnLuas("defaultStrum" + i + "Y", Math.floor(member.y));
		// 	setOnLuas("defaultStrum" + i + "Angle", Math.floor(member.angle));
		// 	setOnLuas("defaultStrum" + i + "Alpha", Math.floor(member.alpha));
		// }
	}

	public function startCountdown():Void
	{
		if(startedCountdown) {
			callOnLuas('onStartCountdown', []);
			return;
		}

		inCutscene = false;
		var ret:Dynamic = callOnLuas('onStartCountdown', [], false);
		if(ret != FunkinLua.Function_Stop) {
			if (skipCountdown || startOnTime > 0) skipArrowStartTween = true;

			generateStaticArrows(0);
			generateStaticArrows(1);

			//add after generating strums
			NoteMovement.getDefaultStrumPos(this);
			
			updateLuaDefaultPos();

			startedCountdown = true;
			Conductor.songPosition = -Conductor.crochet * 5;
			setOnLuas('startedCountdown', true);
			callOnLuas('onCountdownStarted', []);

			var swagCounter:Int = 0;

			if(startOnTime < 0) startOnTime = 0;

			if (startOnTime > 0) {
				clearNotesBefore(startOnTime);
				setSongTime(startOnTime - 350);
				return;
			}
			else if (skipCountdown)
			{
				setSongTime(0);
				return;
			}

			startTimer = new FlxTimer().start(Conductor.crochet / 1000 / playbackRate, function(tmr:FlxTimer)
			{
				if (gf != null && tmr.loopsLeft % Math.round(gfSpeed * gf.danceEveryNumBeats) == 0 && gf.animation.curAnim != null && !gf.animation.curAnim.name.startsWith("sing") && !gf.stunned)
				{
					gf.dance();
				}
				if (tmr.loopsLeft % boyfriend.danceEveryNumBeats == 0 && boyfriend.animation.curAnim != null && !boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.stunned)
				{
					boyfriend.dance();
				}
				if (tmr.loopsLeft % dad.danceEveryNumBeats == 0 && dad.animation.curAnim != null && !dad.animation.curAnim.name.startsWith('sing') && !dad.stunned)
				{
					dad.dance();
				}

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
						if(ClientPrefs.middleScroll && !note.mustPress) {
							note.alpha *= 0.35;
						}
					}
				});
				callOnLuas('onCountdownTick', [swagCounter]);

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
		scoreTxt.text = 'Score: ' + songScore
		+ ' | Misses: ' + songMisses
		+ ' | Rating: ' + ratingName
		+ (ratingName != '?' ? ' (${Highscore.floorDecimal(ratingPercent * 100, 2)}%) - $ratingFC' : '');

		if(ClientPrefs.scoreZoom && !miss && !cpuControlled)
		{
			if(scoreTxtTween != null) {
				scoreTxtTween.cancel();
			}
			scoreTxt.scale.x = 1.075;
			scoreTxt.scale.y = 1.075;
			scoreTxtTween = FlxTween.tween(scoreTxt.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					scoreTxtTween = null;
				}
			});
		}
		scoreTxtHit.text = 'Score: ' + songScore
		+ ' | Misses: ' + songMisses
		+ ' | Rating: ' + ratingName
		+ (ratingName != '?' ? ' (${Highscore.floorDecimal(ratingPercent * 100, 2)}%) - $ratingFC' : '');

		if(ClientPrefs.scoreZoom && !miss && !cpuControlled)
		{
			if(scoreTxtHitTween != null) {
				scoreTxtHitTween.cancel();
			}
			scoreTxtHit.scale.x = 1.075;
			scoreTxtHit.scale.y = 1.075;
			scoreTxtHitTween = FlxTween.tween(scoreTxtHit.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					scoreTxtHitTween = null;
				}
			});
		}
		callOnLuas('onUpdateScore', [miss]);
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
		callOnLuas('onNextDialogue', [dialogueCount]);
	}

	function skipDialogue() {
		callOnLuas('onSkipDialogue', [dialogueCount]);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	public var songStarted = false;

	function startSong():Void
	{
		startingSong = false;
		songStarted = true;

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

		HitmansGameOverSubstate.characterName = dad.curCharacter;
		NewHitmansGameOver.characterName = dad.curCharacter;
		
		switch (SONG.song.toLowerCase())
		{
			case "fatal error":
				HitmansGameOverSubstate.characterName = 'Edwhak';
				NewHitmansGameOver.characterName = 'Edwhak';
				controlsPlayer2 = false;
			case "killer instinct":
				HitmansGameOverSubstate.characterName = 'Edwhak';
				NewHitmansGameOver.characterName = 'Edwhak';
				controlsPlayer2 = false;
			case "annihilate":
				HitmansGameOverSubstate.characterName = 'Edwhak';
				NewHitmansGameOver.characterName = 'Edwhak';
				controlsPlayer2 = false;
			case "c18h27no3-demo":
				HitmansGameOverSubstate.characterName = 'Edwhak';
				NewHitmansGameOver.characterName = 'Edwhak';
				controlsPlayer2 = false;
			case "c18h27no3":
				HitmansGameOverSubstate.characterName = 'Edwhak';
				NewHitmansGameOver.characterName = 'Edwhak';
				controlsPlayer2 = false;
			case "killbot":
				HitmansGameOverSubstate.characterName = 'Edwhak';
				NewHitmansGameOver.characterName = 'Edwhak';
				controlsPlayer2 = false;
			case "digital massacre":
				HitmansGameOverSubstate.characterName = 'HITMANS';
				NewHitmansGameOver.characterName = 'HITMANS';
				controlsPlayer2 = false;
		}

		if(timeToStart > 0){
			setSongTime(timeToStart);
			timeToStart = 0;
		}

		if(startOnTime > 0)
		{
			setSongTime(startOnTime - 500);
		}
		startOnTime = 0;

		if(paused) {
			//trace('Oopsie doopsie! Paused sound');
			FlxG.sound.music.pause();
			vocals.pause();
		}

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;
		FlxTween.tween(timeBar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

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
			DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter(), true, songLength);
		}
		#end
		setOnLuas('songLength', songLength);
		callOnLuas('onSongStart', []);
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
						else if(ClientPrefs.middleScroll)
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
				else if(ClientPrefs.middleScroll)
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

	function set_chromaIntensity(value:Float):Float {
		throw new haxe.exceptions.NotImplementedException();
	}
}

	function eventPushed(event:EventNote) {
		switch(event.event) {
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
		var returnedValue:Float = callOnLuas('eventEarlyTrigger', [event.event]);
		if(returnedValue != 0) {
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
				else if(ClientPrefs.middleScroll) targetAlpha = 0.35;
			}

			var babyArrow:StrumNote = new StrumNote(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, strumLine.y, i, player);
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
				if(ClientPrefs.middleScroll)
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

			var chars:Array<Character> = [boyfriend, gf, dad];
			for (char in chars) {
				if(char != null && char.colorTween != null) {
					char.colorTween.active = false;
				}
			}

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
			MusicBeatState.switchState(new options.OptionsState(true)); // isInPause yes!
		}else if (paused){
				
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

			var chars:Array<Character> = [boyfriend, gf, dad];
			for (char in chars) {
				if(char != null && char.colorTween != null) {
					char.colorTween.active = true;
				}
			}

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
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter(), true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
				}
				else
				{
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
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
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter(), true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
				}
				else
				{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
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
				DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
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
	var canPause:Bool = true;
	var limoSpeed:Float = 0;
	var lastSection:Int = 0;
	public var camDisplaceX:Float = 0;
	public var camDisplaceY:Float = 0;
	var fakeCrochet:Float = 5000;
	var pisslets:Float = 0;

	public function getXPosition(diff:Float, direction:Int, player:Int):Float
		{
			var x:Float = (FlxG.width / 2) - Note.swagWidth - 54 + Note.swagWidth * direction;
			if (!ClientPrefs.middleScroll)
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
	override public function update(elapsed:Float)
	{
		/*if (FlxG.keys.justPressed.NINE)
		{
			iconP1.swapOldIcon();
		}*/
		callOnLuas('onUpdate', [elapsed]);
		if (notITGMod && SONG.notITG)
			playfieldRenderer.speed = playbackRate; //LMAO IT LOOKS SOO GOOFY AS FUCK

		switch (modChartEffect){
			case 4:
				for (i in 0...playerStrums.length) {
					playerStrums.members[i].x = FlxMath.lerp(
						modChartDefaultStrumX[i+4], 
						modChartDefaultStrumX[i+4] + (Math.sin((Conductor.songPosition/(Conductor.crochet*16))*Math.PI) * -200), 
						modChartVariable1
						);
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

		if (health <= 0 && practiceMode) health = 0;
		
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

		setOnLuas('curDecStep', curDecStep);
		setOnLuas('curDecBeat', curDecBeat);

		if(botplayTxt.visible) {
			botplaySine += 180 * elapsed;
			botplayTxt.alpha = 1 - Math.sin((Math.PI * botplaySine) / 180);
		}

		if (controls.PAUSE || !Main.focused && startedCountdown && canPause && !inResultsScreen)
		{
			var ret:Dynamic = callOnLuas('onPause', [], false);
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
					DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
				#end
			}
		}

		if (FlxG.keys.anyJustPressed(debugKeysChart) && !endingSong && !inCutscene)
		{
			if (hitmansSongs.contains(SONG.song.toLowerCase()) && !ClientPrefs.edwhakMode && !ClientPrefs.developerMode){
				antiCheat();
				// openChartEditor();
			}else{
				openChartEditor();
			}
		}

		if (FlxG.keys.anyJustPressed(debugKeysModchart) && !endingSong && !inCutscene)
		{
			if (hitmansSongs.contains(SONG.song.toLowerCase()) && !ClientPrefs.edwhakMode && !ClientPrefs.developerMode){
				antiCheat();
				// openModchartEditor();
			}else{
				openModchartEditor();
			}
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		var mult:Float = FlxMath.lerp(1, iconP1.scale.x, CoolUtil.boundTo(1 - (elapsed * 9 * playbackRate), 0, 1));
		iconP1.scale.set(mult, mult);
		iconP1.updateHitbox();

		var mult:Float = FlxMath.lerp(1, iconP2.scale.x, CoolUtil.boundTo(1 - (elapsed * 9 * playbackRate), 0, 1));
		iconP2.scale.set(mult, mult);
		iconP2.updateHitbox();

		var iconOffset:Int = 26;
		if (ClientPrefs.hudStyle == 'HITMANS'){
			iconP1.x = (FlxG.width - 160);
			iconP2.x = (0);
		}
		if (ClientPrefs.hudStyle == 'Classic'){
			iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) + (150 * iconP1.scale.x - 150) / 2 - iconOffset;
		    iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (150 * iconP2.scale.x) / 2 - iconOffset * 2;
		}
		if (ClientPrefs.hudStyle == 'Classic'){
		if (health > 2)
			health = 2;

		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;
	    }

		if (ClientPrefs.hudStyle == 'HITMANS'){
			if (health > 2)
				health = 2;
	
			if (healthHitBar.percent < 20)
				iconP1.animation.curAnim.curFrame = 1;
			else
				iconP1.animation.curAnim.curFrame = 0;
	
			if (healthHitBar.percent > 80)
				iconP2.animation.curAnim.curFrame = 1;
			else
				iconP2.animation.curAnim.curFrame = 0;
			}
		if (FlxG.keys.anyJustPressed(debugKeysCharacter) && !endingSong && !inCutscene) {
			persistentUpdate = false;
			paused = true;
			cancelMusicFadeTween();
			#if desktop DiscordClient.resetClientID(); #end
			MusicBeatState.switchState(new CharacterEditorState(SONG.player2));
		}
		
		if (startedCountdown)
		{
			Conductor.songPosition += FlxG.elapsed * 1000 * playbackRate;
		}

		if (startingSong)
		{
			if (startedCountdown && Conductor.songPosition >= 0)
				startSong();
			else if(!startedCountdown)
				Conductor.songPosition = -Conductor.crochet * 5;
		}
		else
		{
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

					var songCalc:Float = (songLength - curTime);
					if(ClientPrefs.timeBarType == 'Time Elapsed') songCalc = curTime;

					var secondsTotal:Int = Math.floor(songCalc / 1000);
					if(secondsTotal < 0) secondsTotal = 0;

					if(ClientPrefs.timeBarType != 'Song Name')
						timeTxt.text = FlxStringUtil.formatTime(secondsTotal, false);
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		//noteRating shit ig but only for x and y LOL
		if (combo == 0)
			noteScore.alpha = 0;
		else
			noteScore.alpha = 1;

		if (comboOp != 0 && edwhakIsEnemy)
			noteScoreOp.alpha = 1;
		else if (combo == 0 && !edwhakIsEnemy)
			noteScoreOp.alpha = 0;
		else if (combo != 0 && !edwhakIsEnemy)
			noteScoreOp.alpha = 1;
		else
			noteScoreOp.alpha = 0;

		noteScore.x = ratings.x-510;
		noteScoreOp.x = ratingsOP.x-510;

		// noteScore.x += ratings.x;
		// noteScoreOp.x += ratingsOP.x;

		noteScore.y = ratings.y+100;
		noteScoreOp.y = ratingsOP.y+100;

		noteScore.text = Std.string(combo);
		if (!edwhakIsEnemy)
			noteScoreOp.text = Std.string(combo);
		else
			noteScoreOp.text = Std.string(comboOp);

		#if desktop
		if (songStarted)
		{
			var shaderThing = FunkinLua.lua_Shaders;

			for(shaderKey in shaderThing.keys())
			{
				if(shaderThing.exists(shaderKey))
					shaderThing.get(shaderKey).update(elapsed);
			}

			var shaderThing2 = FunkinLua.lua_Custom_Shaders;

			for(shaderKey2 in shaderThing2.keys())
			{
				if(shaderThing2.exists(shaderKey2))
					shaderThing2.get(shaderKey2).update(elapsed);
			}
		}
		#end
		
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
				callOnLuas('onSpawnNote', [notes.members.indexOf(dunceNote), dunceNote.noteData, dunceNote.noteType, dunceNote.isSustainNote]);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic && !inCutscene)
		{
			if(!cpuControlled) {
				keyShit();
			} else if(boyfriend.animation.curAnim != null && boyfriend.holdTimer > Conductor.stepCrochet * (0.0011 / FlxG.sound.music.pitch) * boyfriend.singDuration && boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss')) {
				boyfriend.dance();
				//boyfriend.animation.curAnim.finish();
			}

			if(startedCountdown)
			{
				var fakeCrochet:Float = (60 / SONG.bpm) * 1000;
				var rollNote:FlxTimer;
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

					switch (daNote.noteType)
                    {
                        case 'RollNote':
                            if (daNote.isSustainNote)
                            {
                                isHolding = true;
                            }
                            if (daNote.mustPress && daNote.canBeHit)
                            {
                                daNote.isSustainNote = true;
                                isHolding = false;
                            }
                            else if (daNote.mustPress && daNote.isSustainNote && daNote.canBeHit && !isHolding)
                            {
                                if (rollNote != null)
                                    rollNote.cancel();
                                rollNote = new FlxTimer().start(0.1, function(tmr){
                                    daNote.isSustainNote = false;
                                    daNote.active = false;
                                });
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
		setOnLuas('cameraX', camFollowPos.x);
		setOnLuas('cameraY', camFollowPos.y);
		setOnLuas('botPlay', cpuControlled);

		if (shaderUpdates != [])
			{
				for (i in shaderUpdates){
					i(elapsed);
				}
			}

		callOnLuas('onUpdatePost', [elapsed]);
		if (ClientPrefs.quantization)
			noteQuantUpdatePost();
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
		if (!inResultsScreen){
			DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
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

	function openChartEditor()
	{
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

	function openModchartEditor()
	{
		persistentUpdate = false;
		paused = true;
		cancelMusicFadeTween();
		MusicBeatState.switchState(new modcharting.ModchartEditorState());
		chartingMode = true;
		if (!instance.notITGMod)
			{
				instance.notITGMod = true;
				// do nothing lamoo
			}
		
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
			var ret:Dynamic = callOnLuas('onGameOver', [], false);
			if(ret != FunkinLua.Function_Stop) {
				boyfriend.stunned = true;
				deathCounter++;

				paused = true;

				vocals.stop();
				FlxG.sound.music.stop();

				persistentUpdate = false;
				persistentDraw = false;
				for (tween in modchartTweens) {
					tween.active = true;
				}
				for (timer in modchartTimers) {
					timer.active = true;
				}
				if (ClientPrefs.goStyle == 'OLD'){
					openSubState(new HitmansGameOverSubstate(deathVariableTXT,this));
				}else if (ClientPrefs.goStyle == 'NEW'){
					openSubState(new NewHitmansGameOver(deathVariableTXT,this));
				}
				//openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x - boyfriend.positionArray[0], boyfriend.getScreenPosition().y - boyfriend.positionArray[1], camFollowPos.x, camFollowPos.y));

				// MusicBeatState.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

				#if desktop
				// Game Over doesn't get his own variable because it's only used here
				DiscordClient.changePresence("Game Over - " + detailsText, SONG.song + " (" + storyDifficultyText + ")", iconP2.getCharacter());
				#end
				isDead = true;
				return true;
			}
		}else if (((skipHealthCheck && instakillOnMiss) || health <= 0) && practiceMode && !diedPractice){
			diedPractice = true; //bro died in practice mode LMAO
			var youdied:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/newGameOver/youdied.png', IMAGE));
        	youdied.screenCenter();
        	youdied.scale.y = 2;
        	youdied.scale.x = 2;
        	youdied.alpha = 1;
			youdied.cameras = [camOther];
        	youdied.antialiasing = ClientPrefs.globalAntialiasing;
        	add(youdied);
			FlxTween.tween(youdied.scale, {x: 0.5, y: 0.5}, 1, {ease:FlxEase.elasticOut});
			FlxTween.tween(youdied, {alpha: 0}, 2, {ease:FlxEase.expoOut});
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

			triggerEventNote(eventNotes[0].event, value1, value2);
			eventNotes.shift();
		}
	}

	public function getControl(key:String) {
		var pressed:Bool = Reflect.getProperty(controls, key);
		//trace('Control result: ' + pressed);
		return pressed;
	}

	public function triggerEventNote(eventName:String, value1:String, value2:String) {
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
							iconP1.changeIcon(boyfriend.healthIcon);
						}
						setOnLuas('boyfriendName', boyfriend.curCharacter);

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
							iconP2.changeIcon(dad.healthIcon);
						}
						setOnLuas('dadName', dad.curCharacter);

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
							setOnLuas('gfName', gf.curCharacter);
						}
				}
				reloadHealthBarColors();

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
		}
		callOnLuas('onEvent', [eventName, value1, value2]);
	}

	function moveCameraSection():Void {
		if(SONG.notes[curSection] == null) return;

		if (gf != null && SONG.notes[curSection].gfSection)
		{
			camFollow.set(gf.getMidpoint().x, gf.getMidpoint().y);
			camFollow.x += gf.cameraPosition[0] + girlfriendCameraOffset[0];
			camFollow.y += gf.cameraPosition[1] + girlfriendCameraOffset[1];
			tweenCamIn();
			callOnLuas('onMoveCamera', ['gf']);
			return;
		}

		if (!SONG.notes[curSection].mustHitSection)
		{
			moveCamera(true);
			callOnLuas('onMoveCamera', ['dad']);
		}
		else
		{
			moveCamera(false);
			callOnLuas('onMoveCamera', ['boyfriend']);
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

		updateTime = false;
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
		var oldBest:Int = Highscore.getScore(SONG.song, storyDifficulty);

		openSubState(new ResultScreen(Math.round(songScore), oldBest, maxCombo, Highscore.floorDecimal(ratingPercent * 100, 2), fantastics, excelents, greats, decents, wayoffs, songMisses));

		inResultsScreen = true;

		#if desktop
			DiscordClient.changePresence("Results - " + detailsText, SONG.song + " (" + storyDifficultyText +")" + "Score:" + Math.round(songScore), iconP2.getCharacter());
		#end

		var ret:Dynamic = callOnLuas('onRating', [], false);
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

		timeBarBG.visible = false;
		timeBar.visible = false;
		timeTxt.visible = false;
		canPause = false;
		endingSong = true;
		camZooming = false;
		inCutscene = false;
		updateTime = false;

		deathCounter = 0;
		seenCutscene = false;

		#if ACHIEVEMENTS_ALLOWED
		if(achievementObj != null) {
			return;
		} else {
			var achieve:String = checkForAchievement(['week1_nomiss', 'week2_nomiss', 'week3_nomiss', 'week4_nomiss',
				'week5_nomiss', 'week6_nomiss', 'week7_nomiss', 'ur_bad',
				'ur_good', 'hype', 'two_keys', 'toastie', 'debugger']);

			if(achieve != null) {
				startAchievement(achieve);
				return;
			}
		}
		#end

		var ret:Dynamic = callOnLuas('onEndSong', [], false);
		if(ret != FunkinLua.Function_Stop && !transitioning) {
			
			playbackRate = 1;

			var oldBest:Int = Highscore.getScore(SONG.song, storyDifficulty);

			openSubState(new ResultScreen(Math.round(songScore), oldBest, maxCombo, Highscore.floorDecimal(ratingPercent * 100, 2), fantastics, excelents, greats, decents, wayoffs, songMisses));

			inResultsScreen = true;

			#if desktop
				DiscordClient.changePresence("Results - " + detailsText, SONG.song + " (" + storyDifficultyText +")" + "Score:" + Math.round(songScore), iconP2.getCharacter());
			#end

			transitioning = true;

			if (forceMiddleScroll){
				if (savePrefixScrollR && prefixRightScroll){
					ClientPrefs.middleScroll = false;
				}
			}else if (forceRightScroll){
				if (savePrefixScrollM && prefixMiddleScroll){
					ClientPrefs.middleScroll = true;
				}
			}
		}
	
	}

	#if ACHIEVEMENTS_ALLOWED
	var achievementObj:AchievementObject = null;
	function startAchievement(achieve:String) {
		achievementObj = new AchievementObject(achieve, camOther);
		achievementObj.onFinish = achievementEnd;
		add(achievementObj);
		trace('Giving achievement ' + achieve);
	}
	function achievementEnd():Void
	{
		achievementObj = null;
		if(endingSong && !inCutscene) {
			if (!inResultsScreen)
				endSong();
		}
	}
	#end

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
		if (!cpuControlled){
		rating.loadGraphic(Paths.image(pixelShitPart1 + daRating.image + pixelShitPart2));
		rating.cameras = [camInterfaz];
		rating.screenCenter();
		rating.x = coolText.x - 40;
		rating.scale.x = 0.9;
		rating.scale.y = 0.9;
		FlxTween.tween(rating.scale, {x: 0.5}, 0.1, {ease:FlxEase.circIn});
		FlxTween.tween(rating.scale, {y: 0.5}, 0.1, {ease:FlxEase.circIn});
		// rating.y -= 60;
		// rating.acceleration.y = 550 * playbackRate * playbackRate;
		// rating.velocity.y -= FlxG.random.int(140, 175) * playbackRate;
		// rating.velocity.x -= FlxG.random.int(0, 10) * playbackRate;
		rating.visible = (!ClientPrefs.hideHud && showRating && ClientPrefs.hudStyle == 'Classic');
		rating.x += ClientPrefs.comboOffset[0];
		rating.y -= ClientPrefs.comboOffset[1];

		var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
		comboSpr.cameras = [camInterfaz];
		comboSpr.screenCenter();
		comboSpr.x = coolText.x;
		// comboSpr.acceleration.y = FlxG.random.int(200, 300) * playbackRate * playbackRate;
		// comboSpr.velocity.y -= FlxG.random.int(140, 160) * playbackRate;
		comboSpr.visible = (!ClientPrefs.hideHud && showCombo && ClientPrefs.hudStyle == 'Classic');
		comboSpr.x += ClientPrefs.comboOffset[0];
		comboSpr.y -= ClientPrefs.comboOffset[1];
		// comboSpr.y += 60;
		comboSpr.velocity.x += FlxG.random.int(1, 10) * playbackRate;

		insert(members.indexOf(strumLineNotes), rating);
		
		if (lastRating != null) lastRating.kill();
		lastRating = rating;

		if (!PlayState.isPixelStage)
		{
			rating.setGraphicSize(Std.int(rating.width * 0.7));
			rating.antialiasing = ClientPrefs.globalAntialiasing;
			comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
			comboSpr.antialiasing = ClientPrefs.globalAntialiasing;
		}
		else
		{
			rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.85));
			comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.85));
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
		var xThing:Float = 0;
		if (showCombo)
		{
			insert(members.indexOf(strumLineNotes), comboSpr);
		}
		if (lastCombo != null) lastCombo.kill();
		lastCombo = comboSpr;

		if (lastScore != null)
		{
			while (lastScore.length > 0)
			{
				lastScore[0].kill();
				lastScore.remove(lastScore[0]);
			}
		}
		for (i in seperatedScore)
		{
			var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
			numScore.cameras = [camInterfaz];
			numScore.screenCenter();
			numScore.x = coolText.x + (43 * daLoop) - 90;
			numScore.y += 120;

			numScore.x += ClientPrefs.comboOffset[2];
			numScore.y -= ClientPrefs.comboOffset[3];
			
			lastScore.push(numScore);

			if (!PlayState.isPixelStage)
			{
				numScore.antialiasing = ClientPrefs.globalAntialiasing;
				numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			}
			else
			{
				numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
			}
			numScore.updateHitbox();

			numScore.scale.x = 0.5;
			numScore.scale.y = 0.5;
			FlxTween.tween(numScore.scale, {x: 0.4}, 0.1, {ease:FlxEase.circIn});
			FlxTween.tween(numScore.scale, {y: 0.4}, 0.1, {ease:FlxEase.circIn});
			// numScore.acceleration.y = FlxG.random.int(200, 300) * playbackRate * playbackRate;
			// numScore.velocity.y -= FlxG.random.int(140, 160) * playbackRate;
			// numScore.velocity.x = FlxG.random.float(-5, 5) * playbackRate;
			numScore.visible = (!ClientPrefs.hideHud && ClientPrefs.hudStyle == 'Classic');

			//if (combo >= 10 || combo == 0)
			if(showComboNum)
				insert(members.indexOf(strumLineNotes), numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2 / playbackRate, {
				onComplete: function(tween:FlxTween)
				{
					numScore.destroy();
				},
				startDelay: Conductor.crochet * 0.001 / playbackRate
			});

			daLoop++;
			if(numScore.x > xThing) xThing = numScore.x;
		}
		comboSpr.x = xThing + 50;
		/*
			trace(combo);
			trace(seperatedScore);
		 */

		coolText.text = Std.string(seperatedScore);
		// add(coolText);

		FlxTween.tween(rating, {alpha: 0}, 0.2 / playbackRate, {
			startDelay: Conductor.crochet * 0.001 / playbackRate
		});

		FlxTween.tween(comboSpr, {alpha: 0}, 0.2 / playbackRate, {
			onComplete: function(tween:FlxTween)
			{
				coolText.destroy();
				comboSpr.destroy();

				rating.destroy();
			},
			startDelay: Conductor.crochet * 0.001 / playbackRate
		});
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
					callOnLuas('onGhostTap', [key]);
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
			callOnLuas('onKeyPress', [key]);
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
			callOnLuas('onKeyRelease', [key]);
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

			if (parsedHoldArray.contains(true) && !endingSong) {
				#if ACHIEVEMENTS_ALLOWED
				var achieve:String = checkForAchievement(['oversinging']);
				if (achieve != null) {
					startAchievement(achieve);
				}
				#end
			}
			else if (boyfriend.animation.curAnim != null && boyfriend.holdTimer > Conductor.stepCrochet * (0.0011 / FlxG.sound.music.pitch) * boyfriend.singDuration && boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
			{
				boyfriend.dance();
				//boyfriend.animation.curAnim.finish();
			}
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

		switch (daNote.noteType){
			case '':
				deathVariableTXT = 'Notes';
			case 'HD Note':
				deathVariableTXT = 'HD';
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
			ratingsBumpScale();
			ratings.animation.play("miss");
			if (!edwhakIsEnemy){
				ratingsBumpScaleOP();
				ratingsOP.animation.play("miss");
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

		callOnLuas('noteMiss', [notes.members.indexOf(daNote), daNote.noteData, daNote.noteType, daNote.isSustainNote]);
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
			if (!edwhakIsEnemy){
				ratingsBumpScaleOP();
				ratingsOP.animation.play("miss");
			}
			ratings.animation.play("miss");
			ratingsBumpScale();
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
		if (Paths.formatToSongPath(SONG.song) != 'tutorial')
			camZooming = true;
		//Edwhak HealthDrain but in source so people can't nerf how his songs works!
		//I know there is a best way to do this but if it works then i don't fucking care -Ed
		if (edwhakIsEnemy){
			if (!note.isSustainNote){
				ratingsBumpScaleOP();
				setRatingImageOP(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);
				comboOp +=1;
			}
			if (!ClientPrefs.casualMode){
				if(health - edwhakDrain - 0.17 > maxHealth){
					//Health drain
						if (Note.instakill){
							if(note.isSustainNote){
								health -= edwhakDrain+0.02 * healthGain; //Way more drain than normal since these notes are ED special notes!			
							}else if (!note.isSustainNote){
								health -= edwhakDrain+0.02 * healthGain; //Same as up
							}
						}else if (Note.tlove){
							if(note.isSustainNote){
								health -= edwhakDrain+0.03 * healthGain; //Way more drain than normal since these notes are Ed GF ones that help him gain life!			
							}else if (!note.isSustainNote){
								health -= edwhakDrain+0.03 * healthGain; //Same as up
							}
						}else{
							if(note.isSustainNote){
								health -= edwhakDrain+0.005 * healthGain; //Added both because if i added only one it don't do shit idk why lmao			
							}else if (!note.isSustainNote){
								health -= edwhakDrain+0.005 * healthGain; //Added both because if i added only one it don't do shit idk why lmao
							}
						}
				}
			}else if(ClientPrefs.casualMode){
				if(health - edwhakDrain - 0.17 > maxHealth){
					//Health drain
						if (Note.instakill){
							if(note.isSustainNote){
								health -= edwhakDrain+0.01 * healthGain; //Way more drain than normal since these notes are ED special notes!			
							}else if (!note.isSustainNote){
								health -= edwhakDrain+0.01 * healthGain; //Same as up
							}
						}else if (Note.tlove){
							if(note.isSustainNote){
								health -= edwhakDrain+0.02 * healthGain; //Way more drain than normal since these notes are Ed GF ones that help him gain life!			
							}else if (!note.isSustainNote){
								health -= edwhakDrain+0.02 * healthGain; //Same as up
							}
						}else{
							if(note.isSustainNote){
								health -= edwhakDrain+0.005 * healthGain; //Added both because if i added only one it don't do shit idk why lmao			
							}else if (!note.isSustainNote){
								health -= edwhakDrain+0.005 * healthGain; //Added both because if i added only one it don't do shit idk why lmao
							}
						}
					}
			}
		}else{
			if (allowEnemyDrain){
				if (!ClientPrefs.casualMode){
					if(health - note.hitHealth - 0.17 > maxHealth){
						//Health drain
						if (!Note.instakill){
							if(note.isSustainNote){
								health -= note.hitHealth * healthGain; //Added both because if i added only one it don't do shit idk why lmao			
							}else if (!note.isSustainNote){
								health -= note.hitHealth * healthGain; //Added both because if i added only one it don't do shit idk why lmao
							}
						}
					}
				}else if(ClientPrefs.casualMode){
					if(health - note.hitHealth - 0.17 > maxHealth){
						//Health drain
						if (!Note.instakill){
							if(note.isSustainNote){
								health -= note.hitHealth * healthGain; //Added both because if i added only one it don't do shit idk why lmao			
							}else if (!note.isSustainNote){
								health -= note.hitHealth * healthGain; //Added both because if i added only one it don't do shit idk why lmao
							}
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
						case 'Hurt Note': //Hurt note
						if (canChange)
							{
							if(boyfriend.animation.getByName('hurt') != null) {
								boyfriend.playAnim('hurt', true);
								boyfriend.specialAnim = true;
								deathVariableTXT = 'Hurts';
							}
						}
						case 'Invisible Hurt Note': //what you can't see but it still damage you lmao
						if (canChange)
							{
							if(boyfriend.animation.getByName('hurt') != null) {
								boyfriend.playAnim('hurt', true);
								boyfriend.specialAnim = true;
								deathVariableTXT = 'Hurts';
							}
						}
						case 'HurtAgressive': //agressive hurts that cause more damage
						if (canChange)
							{
							if(boyfriend.animation.getByName('hurt') != null) {
								boyfriend.playAnim('hurt', true);
								boyfriend.specialAnim = true;
								deathVariableTXT = 'Hurts';
							}
						}
						case 'Mimic Note': //hurts but similar to notes
						if (canChange)
							{
							if(boyfriend.animation.getByName('hurt') != null) {
								boyfriend.playAnim('hurt', true);
								boyfriend.specialAnim = true;
								deathVariableTXT = 'Hurts';
							}
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
					if (canChange)
						{
							deathVariableTXT = 'Instakill';
					}
					case 'Mine Note': //what you can't see but it still damage you lmao
					if (canChange)
						{
							deathVariableTXT = 'Mine';
							FlxG.sound.play(Paths.sound('Edwhak/Mine'));
							ratingsBumpScale();
							if (!edwhakIsEnemy){
								ratingsBumpScaleOP();
								ratingsOP.animation.play("miss");
							}
							ratings.animation.play("miss");
							songMisses++;
							vocals.volume = 0;
							// if(!practiceMode) 
							songScore -= 10;
							combo = 0;
							health = health-0.8;
					}
					case 'Love Note': //agressive hurts that cause more damage
					if (canChange)
						{
							if (Note.edwhakIsPlayer){
								drain = true;
								deathVariableTXT = 'Love';
							}else{
								drain = false;
							}
					}
					case 'Fire Note': //agressive hurts that cause more damage
					if (canChange)
						{
							if (Note.edwhakIsPlayer){
								gain = false;
								deathVariableTXT = 'Fire';
							}else{
								gain = true;
							}
					}
					case 'True Love Note': //agressive hurts that cause more damage
					if (canChange)
						{
							if (Note.edwhakIsPlayer){
								tgain = true;
								deathVariableTXT = 'Tlove';
							}else{
								tgain = false;
							}
					}
				}
			}
			//IT WILL WORK FINALLY!?
			if (!note.isSustainNote && !note.isHoldEnd)
			{
				ratingsBumpScale();
				setRatingImage(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);
				if (!edwhakIsEnemy){
					ratingsBumpScaleOP();
					setRatingImageOP(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);
				}
				combo += 1;
				if(combo > 9999) combo = 9999;
				if (combo > maxCombo) maxCombo = combo;
				popUpScore(note);
			}

			if (!ClientPrefs.casualMode){
				if (!Note.edwhakIsPlayer){
					health += note.hitHealth * healthGain;
				}else if(Note.edwhakIsPlayer){
					health += (note.hitHealth+0.012) * healthGain;
				}
			}else if(ClientPrefs.casualMode){
				if (!Note.edwhakIsPlayer){
					health += (note.hitHealth+0.007) * healthGain;
				}else if(Note.edwhakIsPlayer){
					health += (note.hitHealth+0.012) * healthGain;
				}	
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
			callOnLuas('goodNoteHit', [notes.members.indexOf(note), leData, leType, isSus]);
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

	public function ratingsBumpScale() {

		if(ratingsBumpTween != null) {
			ratingsBumpTween.cancel();
		}
		if(ratingsBumpTween2 != null) {
			ratingsBumpTween2.cancel();
		}
		if(ratingsBumpTimer != null) {
			ratingsBumpTimer.cancel();
		}
		if(noteRatingTween != null) {
			noteRatingTween.cancel(); // like scoreTxt scale tween
		}
		ratings.scale.x = 1.5;
		ratings.scale.y = 1.5;
		ratingsBumpTween = FlxTween.tween(ratings.scale, {x: 1.3, y: 1.3}, 0.1, {ease:FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				ratingsBumpTween = null;
				ratingsBumpTimer = new FlxTimer().start(1, function(flxTimer:FlxTimer){
						ratingsBumpTween2 = FlxTween.tween(ratings.scale, {x: 0, y: 0}, 0.1, {ease:FlxEase.circIn,
						onComplete: function(twn:FlxTween) {
							ratingsBumpTimer = null;
							ratingsBumpTween2 = null;
						}
					});			
				
				});
			}
		});
		noteScore.scale.x = 1.125;
		noteScore.scale.y = 1.125;
		noteRatingTween = FlxTween.tween(noteScore.scale, {x: 1, y: 1}, 0.1, {ease:FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				noteRatingTween = null;
			}
		});

		// FlxTween.tween(numScoreOp, {alpha: 0}, 0.2 / playbackRate, {
		// 	onComplete: function(tween:FlxTween)
		// 	{
		// 		numScoreOp.destroy();
		// 	},
		// 	startDelay: Conductor.crochet * 0.001 / playbackRate
		// });
		if (ClientPrefs.hudStyle == 'HITMANS'){
			ratings.visible = true;
			noteScore.visible = true;
		}
	}

	public function ratingsBumpScaleOP() {

		if(ratingsOPBumpTween != null) {
			ratingsOPBumpTween.cancel();
		}
		if(ratingsOPBumpTween2 != null) {
			ratingsOPBumpTween2.cancel();
		}
		if(ratingsOPBumpTimer != null) {
			ratingsOPBumpTimer.cancel();
		}
		if(noteRatingTweenOp != null) {
			noteRatingTweenOp.cancel(); // like scoreTxt scale tween
		}
		ratingsOP.scale.x = 1.5;
		ratingsOP.scale.y = 1.5;
		ratingsOPBumpTween = FlxTween.tween(ratingsOP.scale, {x: 1.3, y: 1.3}, 0.1, {ease:FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				ratingsOPBumpTween = null;
				ratingsOPBumpTimer = new FlxTimer().start(1, function(flxTimer:FlxTimer){
						ratingsOPBumpTween2 = FlxTween.tween(ratingsOP.scale, {x: 0, y: 0}, 0.1, {ease:FlxEase.circIn,
						onComplete: function(twn:FlxTween) {
							ratingsOPBumpTimer = null;
							ratingsOPBumpTween2 = null;
						}
					});			
				
				});
			}
		});
		noteScoreOp.scale.x = 1.125;
		noteScoreOp.scale.y = 1.125;
		noteRatingTweenOp = FlxTween.tween(noteScoreOp.scale, {x: 1, y: 1}, 0.1, {ease:FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				noteRatingTweenOp = null;
			}
		});

		// FlxTween.tween(numScoreOp, {alpha: 0}, 0.2 / playbackRate, {
		// 	onComplete: function(tween:FlxTween)
		// 	{
		// 		numScoreOp.destroy();
		// 	},
		// 	startDelay: Conductor.crochet * 0.001 / playbackRate
		// });
		if (ClientPrefs.hudStyle == 'HITMANS'){
			ratingsOP.visible = true;
			noteScoreOp.visible = true;
		}
	}

	public function setRatingImage(rat:Float){
		if (rat >= 0){
			if (rat <= ClientPrefs.marvelousWindow){
				ratings.animation.play("fantastic");
				fantastics += 1;
			} else if (rat <= ClientPrefs.sickWindow){
				ratings.animation.play("excellent Early");
				excelents += 1;
			}else if (rat >= ClientPrefs.sickWindow && rat <= ClientPrefs.goodWindow){
				ratings.animation.play("great Early");
				greats += 1;
			}else if (rat >= ClientPrefs.goodWindow && rat <= ClientPrefs.badWindow){
				ratings.animation.play("decent Early");
				decents += 1;
			}else if (rat >= ClientPrefs.badWindow){
				ratings.animation.play("way Off Early");
				wayoffs += 1;
			}
		} else {
			if (rat >= ClientPrefs.marvelousWindow * -1){
				ratings.animation.play("fantastic");
				fantastics += 1;
			} else if (rat >= ClientPrefs.sickWindow * -1){
				ratings.animation.play("excellent Late");
				excelents += 1;
			}else if (rat <= ClientPrefs.sickWindow * -1 && rat >= ClientPrefs.goodWindow * -1){
				ratings.animation.play("great Late");
				greats += 1;
			}else if (rat <= ClientPrefs.goodWindow * -1 && rat >= ClientPrefs.badWindow * -1){
				ratings.animation.play("decent Late");
				decents += 1;
			}else if (rat <= ClientPrefs.badWindow * -1){
				ratings.animation.play("way Off Late");
				wayoffs += 1;
			}
		}
	}

	public function setRatingImageOP(rat:Float){
		if (rat >= 0){
			if (rat <= ClientPrefs.marvelousWindow){
				ratingsOP.animation.play("fantastic");
			} else if (rat <= ClientPrefs.sickWindow){
				ratingsOP.animation.play("excellent Early");
			}else if (rat >= ClientPrefs.sickWindow && rat <= ClientPrefs.goodWindow){
				ratingsOP.animation.play("great Early");
			}else if (rat >= ClientPrefs.goodWindow && rat <= ClientPrefs.badWindow){
				ratingsOP.animation.play("decent Early");
			}else if (rat >= ClientPrefs.badWindow){
				ratingsOP.animation.play("way Off Early");
			}
		} else {
			if (rat >= ClientPrefs.marvelousWindow * -1){
				ratingsOP.animation.play("fantastic");
			} else if (rat >= ClientPrefs.sickWindow * -1){
				ratingsOP.animation.play("excellent Late");
			}else if (rat <= ClientPrefs.sickWindow * -1 && rat >= ClientPrefs.goodWindow * -1){
				ratingsOP.animation.play("great Late");
			}else if (rat <= ClientPrefs.goodWindow * -1 && rat >= ClientPrefs.badWindow * -1){
				ratingsOP.animation.play("decent Late");
			}else if (rat <= ClientPrefs.badWindow * -1){
				ratingsOP.animation.play("way Off Late");
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

				#if ACHIEVEMENTS_ALLOWED
				Achievements.henchmenDeath++;
				FlxG.save.data.henchmenDeath = Achievements.henchmenDeath;
				var achieve:String = checkForAchievement(['roadkill_enthusiast']);
				if (achieve != null) {
					startAchievement(achieve);
				} else {
					FlxG.save.flush();
				}
				FlxG.log.add('Deaths: ' + Achievements.henchmenDeath);
				#end
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
			if (ClientPrefs.noteSkin.contains(animSkins[i])){
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
		setOnLuas('curStep', curStep);
		callOnLuas('onStepHit', []);
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

		iconP1.scale.set(1.2, 1.2);
		iconP2.scale.set(1.2, 1.2);

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (gf != null && curBeat % Math.round(gfSpeed * gf.danceEveryNumBeats) == 0 && gf.animation.curAnim != null && !gf.animation.curAnim.name.startsWith("sing") && !gf.stunned)
		{
			gf.dance();
		}
		if (curBeat % boyfriend.danceEveryNumBeats == 0 && boyfriend.animation.curAnim != null && !boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.stunned)
		{
			boyfriend.dance();
		}
		if (curBeat % dad.danceEveryNumBeats == 0 && dad.animation.curAnim != null && !dad.animation.curAnim.name.startsWith('sing') && !dad.stunned)
		{
			dad.dance();
		}

		lastBeatHit = curBeat;

		setOnLuas('curBeat', curBeat); //DAWGG?????
		callOnLuas('onBeatHit', []);
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

			if (camZooming && FlxG.camera.zoom < 1.35 && ClientPrefs.camZooms)
			{
				FlxG.camera.zoom += 0.015 * camZoomingMult;
				camHUD.zoom += 0.03 * camZoomingMult;
			}

			if (SONG.notes[curSection].changeBPM)
			{
				Conductor.bpm = SONG.notes[curSection].bpm;
				setOnLuas('curBpm', Conductor.bpm);
				setOnLuas('crochet', Conductor.crochet);
				setOnLuas('stepCrochet', Conductor.stepCrochet);
			}
			setOnLuas('mustHitSection', SONG.notes[curSection].mustHitSection);
			setOnLuas('altAnim', SONG.notes[curSection].altAnim);
			setOnLuas('gfSection', SONG.notes[curSection].gfSection);
		}
		
		setOnLuas('curSection', curSection);
		callOnLuas('onSectionHit', []);
	}

	public function callOnLuas(event:String, args:Array<Dynamic>, ignoreStops = true, exclusions:Array<String> = null):Dynamic {
		var returnVal:Dynamic = FunkinLua.Function_Continue;
		#if LUA_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in luaArray) {
			if(exclusions.contains(script.scriptName))
				continue;

			var ret:Dynamic = script.call(event, args);
			if(ret == FunkinLua.Function_StopLua && !ignoreStops)
				break;
			
			// had to do this because there is a bug in haxe where Stop != Continue doesnt work
			var bool:Bool = ret == FunkinLua.Function_Continue;
			if(!bool && ret != 0) {
				returnVal = cast ret;
			}
		}
		#end
		//trace(event, returnVal);
		return returnVal;
	}

	public function setOnLuas(variable:String, arg:Dynamic) {
		#if LUA_ALLOWED
		for (i in 0...luaArray.length) {
			luaArray[i].set(variable, arg);
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
		setOnLuas('score', songScore);
		setOnLuas('misses', songMisses);
		setOnLuas('hits', songHits);

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
		setOnLuas('rating', ratingPercent);
		setOnLuas('ratingName', ratingName);
		setOnLuas('ratingFC', ratingFC);
	}

	#if ACHIEVEMENTS_ALLOWED
	private function checkForAchievement(achievesToCheck:Array<String> = null):String
	{
		if(chartingMode) return null;

		var usedPractice:Bool = (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false) || ClientPrefs.getGameplaySetting('modchart', false) || ClientPrefs.casualMode);
		for (i in 0...achievesToCheck.length) {
			var achievementName:String = achievesToCheck[i];
			if(!Achievements.isAchievementUnlocked(achievementName) && !cpuControlled) {
				var unlock:Bool = false;
				
				if (achievementName.contains(WeekData.getWeekFileName()) && achievementName.endsWith('nomiss')) // any FC achievements, name should be "weekFileName_nomiss", e.g: "weekd_nomiss";
				{
					if(isStoryMode && campaignMisses + songMisses < 1 && CoolUtil.difficultyString() == 'HARD'
						&& storyPlaylist.length <= 1 && !changedDifficulty && !usedPractice)
						unlock = true;
				}
				switch(achievementName)
				{
					case 'ur_bad':
						if(ratingPercent < 0.2 && !practiceMode) {
							unlock = true;
						}
					case 'ur_good':
						if(ratingPercent >= 1 && !usedPractice) {
							unlock = true;
						}
					case 'roadkill_enthusiast':
						if(Achievements.henchmenDeath >= 100) {
							unlock = true;
						}
					case 'oversinging':
						if(boyfriend.holdTimer >= 10 && !usedPractice) {
							unlock = true;
						}
					case 'hype':
						if(!boyfriendIdled && !usedPractice) {
							unlock = true;
						}
					case 'two_keys':
						if(!usedPractice) {
							var howManyPresses:Int = 0;
							for (j in 0...keysPressed.length) {
								if(keysPressed[j]) howManyPresses++;
							}

							if(howManyPresses <= 2) {
								unlock = true;
							}
						}
					case 'toastie':
						if(/*ClientPrefs.framerate <= 60 &&*/ !ClientPrefs.shaders && ClientPrefs.lowQuality && !ClientPrefs.globalAntialiasing) {
							unlock = true;
						}
					case 'debugger':
						if(Paths.formatToSongPath(SONG.song) == 'test' && !usedPractice) {
							unlock = true;
						}
				}

				if(unlock) {
					Achievements.unlockAchievement(achievementName);
					return achievementName;
				}
			}
		}
		return null;
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
}
