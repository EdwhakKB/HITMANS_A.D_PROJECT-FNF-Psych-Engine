package;

import flixel.addons.display.FlxBackdrop;
import Shaders.GlitchyChromaticShader;
import openfl.filters.ShaderFilter;
import lime.app.Promise;
import lime.app.Future;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;

import haxe.io.Path;

using StringTools;

class AsyncAssetPreloader
{
	var characters:Array<String> = [];
	var audio:Array<String> = [];

	var onComplete:Void->Void = null;

	public var percent(get, default):Float = 0;
	private function get_percent()
	{
		if (totalLoadCount > 0)
		{
			percent = loadedCount/totalLoadCount;
		}

		return percent;
	}
	public var totalLoadCount:Int = 0;
	public var loadedCount:Int = 0;

	public function new(onComplete:Void->Void)
	{
		this.onComplete = onComplete;
		generatePreloadList();
	}

	private function generatePreloadList()
	{
		if (PlayState.SONG != null){
			characters.push(PlayState.SONG.player1);
			characters.push(PlayState.SONG.player2);
			characters.push(PlayState.SONG.gfVersion);

			audio.push(Paths.inst(PlayState.SONG.song));
			audio.push(Paths.voices(PlayState.SONG.song));

			var events:Array<Dynamic> = [];
            var eventStr:String = '';
            var eventNoticed:String = '';

            if(PlayState.SONG.events.length > 0)
            {
                for(event in PlayState.SONG.events)
                {
                    for (i in 0...event[1].length)
                        {
                            eventStr = event[1][i][0].toLowerCase();
                            eventNoticed = event[1][i][2];
                        }
                    events.push(event);
                }
            }

			totalLoadCount = audio.length + characters.length-1; //do -1 because it will be behind at the end when theres a small freeze
		}
	}

	public function load(async:Bool = true)
	{
		if (async)
		{
			trace('loading async');

		
			var multi:Bool = false;

			if (multi) //sometimes faster, sometimes slower, wont bother using it
			{
				setupFuture(function()
				{
					loadAudio();
					return true;
				});
				setupFuture(function()
				{
					loadCharacters();
					return true;
				});
			}
			else 
			{
				setupFuture(function()
				{
					loadAudio();
					loadCharacters();	
					return true;
				});
			}


		}
		else 
		{
			loadAudio();
			loadCharacters();
			finish();
		}
	}
	function setupFuture(func:Void->Bool)
	{
		var fut:Future<Bool> = new Future(func, true);
		fut.onComplete(function(ashgfjkasdfhkjl) {
			finish();
		});
		fut.onError(function(_) {
			finish(); //just continue anyway who cares
		});
		totalFinishes++;
	}
	var totalFinishes:Int = 0;
	var finshCount:Int = 0;
	private function finish()
	{
		finshCount++;
		if (finshCount < totalFinishes)
			return;

		if (onComplete != null)
			onComplete();
	}
	public function loadAudio()
	{
		for (i in audio)
		{
			loadedCount++;
			new FlxSound().loadEmbedded(i);
		}
		trace('loaded audio');
	}
	public function loadCharacters()
	{
		for (i in characters)
		{
			loadedCount++;
			new Character(0,0, i);
		}
		trace('loaded characters');
	}



}

class LoadingState extends MusicBeatState
{
	inline static var MIN_TIME = 1.0;

	// Browsers will load create(), you can make your song load a custom directory there
	// If you're compiling to desktop (or something that doesn't use NO_PRELOAD_ALL), search for getNextState instead
	// I'd recommend doing it on both actually lol
	
	// TO DO: Make this easier
	
	public static var bossLevel:Float = 0.0;
	public static var bossCharacter:String = 'default';
	var continueInput:Bool = false;
	var continueTween:FlxTween;
	
	var isBoss:Bool = false;
	var target:FlxState;
	var stopMusic = false;
	var directory:String;
	var callbacks:MultiCallback;

	var loader:AsyncAssetPreloader = null;
	var lerpedPercent:Float = 0;
	var loadTime:Float = 0;
	var loadingText:FlxText;

	var continueText:FlxText;

	var targetShit:Float = 0;

	var vcrShader = new GlitchyChromaticShader();
	var iTime:Float = 0.0;

	public var loaderStuff:Array<Dynamic> = [false, 0.7];

	public function new(target:FlxState, stopMusic:Bool, directory:String, ?isBoss:Bool = false, ?isBlack:Bool = false, ?time:Float = 0.7)
	{
		super();
		this.target = target;
		this.stopMusic = stopMusic;
		this.directory = directory;
		this.isBoss = isBoss;

		loaderStuff[0] = isBlack;
		loaderStuff[1] = time;
	}

	var funkay:FlxSprite;
	var loadingBar:FlxBar;
	override public function create()
	{
		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0x00caff4d);
		add(bg);
		funkay = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/funkay.png', IMAGE));
		funkay.setGraphicSize(0, FlxG.height);
		funkay.updateHitbox();
		funkay.antialiasing = ClientPrefs.globalAntialiasing;
		add(funkay);
		funkay.scrollFactor.set();
		funkay.screenCenter();

		if (isBoss){
			FlxG.sound.playMusic(Paths.sound('Edwhak/bosstier'), 0, true);
			FlxG.sound.music.fadeIn(6, 0, 1);
			new FlxTimer().start(12, function(tmr:FlxTimer) {
				addShader();
			});
		}

		continueText = new FlxText((FlxG.width/2) +(FlxG.width/4), FlxG.height-25-30, 0, "PRESS ENTER TO CONTINUE");
		continueText.setFormat(Paths.font("DEADLY KILLERS.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		continueText.alpha = 1;
		continueText.visible = isBoss;
		add(continueText);

		loader = new AsyncAssetPreloader(function()
		{
			trace("Load time: " + loadTime);

			if (!isBoss){
				new FlxTimer().start(0.5, function(tmr:FlxTimer) {
					onLoad();
				});
			}else{
				continueInput = true;
			}
			trace("continueInput: " + continueInput);
		});
		loader.load(true);

		loadingBar = new FlxBar(0, FlxG.height-25, LEFT_TO_RIGHT, FlxG.width, 25, this, 'lerpedPercent', 0, 1);
		loadingBar.scrollFactor.set();
		loadingBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
		add(loadingBar);

		loadingText = new FlxText(2, FlxG.height-25-30, 0, "Loading...");
		loadingText.setFormat(Paths.font("DEADLY KILLERS.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(loadingText);

		if (!isBoss){
			initSongsManifest().onComplete
			(
				function (lib)
				{
					callbacks = new MultiCallback(()->{});
					var introComplete = callbacks.add("introComplete");
					/*if (PlayState.SONG != null) {
						checkLoadSong(getSongPath());
						if (PlayState.SONG.needsVoices)
							checkLoadSong(getVocalPath());
					}*/
					checkLibrary("shared");
					if(directory != null && directory.length > 0 && directory != 'shared') {
						checkLibrary(directory);
					}

					var fadeTime = 0.5;
					new FlxTimer().start(fadeTime + MIN_TIME, function(_) introComplete());
				}
			);
		}
	}
	
	function checkLoadSong(path:String)
	{
		if (!Assets.cache.hasSound(path))
		{
			var library = Assets.getLibrary("songs");
			final symbolPath = path.split(":").pop();
			// @:privateAccess
			// library.types.set(symbolPath, SOUND);
			// @:privateAccess
			// library.pathGroups.set(symbolPath, [library.__cacheBreak(symbolPath)]);
			var callback = callbacks.add("song:" + path);
			Assets.loadSound(path).onComplete(function (_) { callback(); });
		}
	}
	
	function checkLibrary(library:String) {
		trace(Assets.hasLibrary(library));
		if (Assets.getLibrary(library) == null)
		{
			@:privateAccess
			if (!LimeAssets.libraryPaths.exists(library))
				throw "Missing library: " + library;

			var callback = callbacks.add("library:" + library);
			Assets.loadLibrary(library).onComplete(function (_) { callback(); });
		}
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (isBoss){
		 	iTime += elapsed;
			vcrShader.iTime.value = [iTime];
		}

		if (loader != null)
		{
			loadTime += elapsed;
			lerpedPercent = FlxMath.lerp(lerpedPercent, loader.percent, elapsed*8);
			loadingText.text = "Loading... (" + loader.loadedCount + "/" + (loader.totalLoadCount+1) + ")";
		}
		if (continueInput)
		{
			if (!isBoss)
			{
				if (controls.ACCEPT)
				{
					onLoad();
					continueInput = false;
				}
			}else{
				if (controls.ACCEPT)
				{
					new FlxTimer().start(5, function(tmr:FlxTimer) {
						onLoad();
					});
					continueInput = false;
				}
			}
		}
	}
	
	function onLoad()
	{
		if (stopMusic && FlxG.sound.music != null)
			FlxG.sound.music.stop();
		
		MusicBeatState.switchState(target, loaderStuff[0], loaderStuff[1]);
	}
	
	static function getSongPath()
	{
		return Paths.inst(PlayState.SONG.song);
	}
	
	static function getVocalPath()
	{
		return Paths.voices(PlayState.SONG.song);
	}
	
	inline static public function loadAndSwitchState(target:FlxState, stopMusic = false, ?isBlack:Bool = false, ?time:Float = 0.7, ?isBoss:Bool = false)
	{
		MusicBeatState.switchState(getNextState(target, stopMusic, isBoss, isBlack, time), isBlack, time);
	}
	
	static function getNextState(target:FlxState, stopMusic = false, ?isBoss:Bool = false, ?isBlack:Bool = false, ?time:Float = 0.7):FlxState
	{
		var directory:String = 'shared';
		var weekDir:String = StageData.forceNextDirectory;
		StageData.forceNextDirectory = null;

		if(weekDir != null && weekDir.length > 0 && weekDir != '') directory = weekDir;

		Paths.setCurrentLevel(directory);
		trace('Setting asset folder to ' + directory);

		
		var loaded:Bool = false;
		if (PlayState.SONG != null) {
			loaded = isSoundLoaded(getSongPath()) && (!PlayState.SONG.needsVoices || isSoundLoaded(getVocalPath())) && isLibraryLoaded("shared") && isLibraryLoaded(directory);
		}
		
		if (!loaded)
			return new LoadingState(target, stopMusic, directory, isBoss, isBlack, time);

		if (stopMusic && FlxG.sound.music != null)
			FlxG.sound.music.stop();
		
		return target;
	}
	
	static function isSoundLoaded(path:String):Bool
	{
		return Assets.cache.hasSound(path);
	}
	
	static function isLibraryLoaded(library:String):Bool
	{
		return Assets.getLibrary(library) != null;
	}
	
	override function destroy()
	{
		super.destroy();
		
		callbacks = null;
	}
	
	static function initSongsManifest()
	{
		var id = "songs";
		var promise = new Promise<AssetLibrary>();

		var library = LimeAssets.getLibrary(id);

		if (library != null)
		{
			return Future.withValue(library);
		}

		var path = id;
		var rootPath = null;

		@:privateAccess
		var libraryPaths = LimeAssets.libraryPaths;
		if (libraryPaths.exists(id))
		{
			path = libraryPaths[id];
			rootPath = Path.directory(path);
		}
		else
		{
			if (StringTools.endsWith(path, ".bundle"))
			{
				rootPath = path;
				path += "/library.json";
			}
			else
			{
				rootPath = Path.directory(path);
			}
			@:privateAccess
			path = LimeAssets.__cacheBreak(path);
		}

		AssetManifest.loadFromFile(path, rootPath).onComplete(function(manifest)
		{
			if (manifest == null)
			{
				promise.error("Cannot parse asset manifest for library \"" + id + "\"");
				return;
			}

			var library = AssetLibrary.fromManifest(manifest);

			if (library == null)
			{
				promise.error("Cannot open library \"" + id + "\"");
			}
			else
			{
				@:privateAccess
				LimeAssets.libraries.set(id, library);
				library.onChange.add(LimeAssets.onChange.dispatch);
				promise.completeWith(Future.withValue(library));
			}
		}).onError(function(_)
		{
			promise.error("There is no asset library with an ID of \"" + id + "\"");
		});

		return promise.future;
	}

	function addShader(){
		FlxG.camera.setFilters([new ShaderFilter(vcrShader)]);
		vcrShader.GLITCH.value = [0.4];
		new FlxTimer().start(2, function(tmr:FlxTimer) {
			setupIntro(true);
		});
		new FlxTimer().start(4, function(tmr:FlxTimer) {
			FlxG.camera.setFilters([]);
			setupBossIntro(true);
		});
		new FlxTimer().start(20, function(tmr:FlxTimer) {
			setupBossFight();
			setupIntro(false);
		});
	}

	function setupBossFight(){
		var theEnemy = "none";
		switch(bossCharacter.toLowerCase()){
			case 'edwhak':
				theEnemy = "edwhak";
			case 'he':
				theEnemy = "edwhak";
			case 'edwhakbroken':
				theEnemy = "edwhak";
			case 'edkbmassacre':
				theEnemy = "edwhak";
			default:
				theEnemy = bossCharacter.toLowerCase();
		}
		trace("Boss: " + theEnemy);
		var vsCharacter = new FlxSprite(0, 0).loadGraphic(Paths.image('hitmans/vs/' + theEnemy));
		if(vsCharacter.graphic == null) //if no graphic was loaded, then load the placeholder
            vsCharacter.loadGraphic(Paths.image('hitmans/vs/placeHolder'));
		vsCharacter.x = (FlxG.width - vsCharacter.width/2);
		vsCharacter.y = (FlxG.height - vsCharacter.height/2);
		vsCharacter.alpha = 0;
		vsCharacter.color = 0x000000;

		var vsText = new FlxText(0, 0, "VERSUS", 88).setFormat(Paths.font("DEADLY KILLERS.ttf"), 88, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		vsText.x = (FlxG.width/2 - vsText.width/2);
		vsText.y = (FlxG.height/2 - vsText.height/2);

		var vsBarBg = new FlxSprite(0, 0).loadGraphic(Paths.image('SimplyLoveHud/HealthBG'));
		vsBarBg.x = (FlxG.width/2 - (vsBarBg.width/2) -100);
		vsBarBg.y = (FlxG.height/2 - vsBarBg.height/2);

		var vsBar = new FlxSprite(vsBarBg.x+4, vsBarBg.y+4).makeGraphic(280, 29, FlxColor.RED);
		vsBar.origin.x = 0;
		vsBar.scale.x = 0;

		var vsBackGround = new FlxSprite(0, 0).loadGraphic(Paths.image('rating/background'));
		vsBackGround.setGraphicSize(FlxG.width, FlxG.height);
		vsBackGround.screenCenter();
		vsBackGround.alpha = 0.25;

		var vsBlackBG = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

		add(vsBlackBG);
		add(vsBackGround);
		add(vsCharacter);
		add(vsText);
		add(vsBarBg);
		add(vsBar);
	}

	function setupIntro(enter:Bool = false){		
		if(!enter){
			var whiteFade = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
			whiteFade.alpha = 1;
			add(whiteFade);
			FlxTween.tween(whiteFade, {alpha: 0}, 1, {ease: FlxEase.backInOut});
		}else{
			var blackFade = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			blackFade.alpha = 0;
			add(blackFade);

			FlxTween.tween(blackFade, {alpha: 1 }, 2, {ease: FlxEase.quartOut});
		}
	}

	function setupBossIntro(enter:Bool = false)
	{
		if(enter){
			var bgBackDrop = new FlxBackdrop(Paths.image('bossCinematic/metal'));
			bgBackDrop.screenCenter();
			bgBackDrop.velocity.set(200,100);
			bgBackDrop.alpha = 0;
			add(bgBackDrop);

			var tapeBackdrop = new FlxBackdrop(Paths.image('bossCinematic/tape'), X);
			tapeBackdrop.screenCenter();
			tapeBackdrop.velocity.x = 200;
			tapeBackdrop.alpha = 0;
			add(tapeBackdrop);

			var alertVignette = new FlxSprite(0, 0).loadGraphic(Paths.image('bossCinematic/alert-vignette'));
			alertVignette.setGraphicSize(FlxG.width, FlxG.height);
			alertVignette.screenCenter();
			alertVignette.alpha = 0;
			add(alertVignette);

			FlxTween.tween(bgBackDrop, {alpha: 0.35}, 4, 
				{
					type: FlxTweenType.PINGPONG,
					ease: FlxEase.cubeInOut
				}
			);

			FlxTween.tween(alertVignette, {alpha: 0.4}, 2, 
				{
					type: FlxTweenType.PINGPONG,
					ease: FlxEase.cubeInOut
				}
			);


			tapeBackdrop.y = (FlxG.height/2) - (tapeBackdrop.height/2);
			FlxTween.tween(tapeBackdrop, {alpha: 1}, 2, {ease: FlxEase.cubeInOut});
		}
	}
}

class MultiCallback
{
	public var callback:Void->Void;
	public var logId:String = null;
	public var length(default, null) = 0;
	public var numRemaining(default, null) = 0;
	
	var unfired = new Map<String, Void->Void>();
	var fired = new Array<String>();
	
	public function new (callback:Void->Void, logId:String = null)
	{
		this.callback = callback;
		this.logId = logId;
	}
	
	public function add(id = "untitled")
	{
		id = '$length:$id';
		length++;
		numRemaining++;
		var func:Void->Void = null;
		func = function ()
		{
			if (unfired.exists(id))
			{
				unfired.remove(id);
				fired.push(id);
				numRemaining--;
				
				if (logId != null)
					log('fired $id, $numRemaining remaining');
				
				if (numRemaining == 0)
				{
					if (logId != null)
						log('all callbacks fired');
					callback();
				}
			}
			else
				log('already fired $id');
		}
		unfired[id] = func;
		return func;
	}
	
	inline function log(msg):Void
	{
		if (logId != null)
			trace('$logId: $msg');
	}
	
	public function getFired() return fired.copy();
	public function getUnfired() return [for (id in unfired.keys()) id];
}