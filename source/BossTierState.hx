package;

import flixel.FlxSubState;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import PauseSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import SystemOptions;
import flixel.FlxG;
import CoolUtil;
import flixel.FlxCamera;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;
#if sys
import sys.FileSystem;
#end

using StringTools;

class BossTierState extends MusicBeatState
{
	private var camBoss:FlxCamera;

    public static var bossLevel:Float = 0.0;
	public static var bossCharacter:String = 'default';

	public static var instance:BossTierState = null;

    public var continueText:FlxText;

	#if HSCRIPT_ALLOWED
	public var hscriptArray:Array<SSHScript> = [];
	public var instancesExclude:Array<String> = [];
	#end

    public function new(enemy:String, lvl:Float)
    {
        super();
       	bossCharacter = enemy;
        bossLevel = lvl;
    }

    override public function create()
    {
		camBoss = new FlxCamera();
        FlxG.cameras.reset(camBoss);
        FlxG.cameras.setDefaultDrawTarget(camBoss, true);

		#if HSCRIPT_ALLOWED
		for (folder in Mods.directoriesWithFile(Paths.getPreloadPath(), 'data/boss/'))
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if(file.toLowerCase().endsWith('.hx') && file.toLowerCase() == '$bossCharacter.hx')
						initHScript(folder + file);
				}
			}
		}
		#end

		callOnHScript('onCreate');
        super.create();
		callOnHScript('onCreatePost');

        continueText = new FlxText((FlxG.width/2) +(FlxG.width/4), FlxG.height-25-30, 0, "PRESS ENTER TO CONTINUE");
		continueText.setFormat(Paths.font("DEADLY KILLERS.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		continueText.alpha = 1;
		continueText.visible = false;
		add(continueText);

        new FlxTimer().start(1, function(twn:FlxTimer) {
            setupBossFight();
            setupIntro(false);
        });
    }

	public function initHScript(file:String)
	{
		try
		{
			var times:Float = Date.now().getTime();
			var newScript:SSHScript = new SSHScript(null, file);
			@:privateAccess
			{
				if(newScript.parsingExceptions != null && newScript.parsingExceptions.length > 0)
				{
					@:privateAccess
					{
						for (e in newScript.parsingExceptions)
							if(e != null)
								trace('ERROR ON LOADING ($file): ${e.message.substr(0, e.message.indexOf('\n'))}', FlxColor.RED);
					}
					newScript.destroy();
					return;
				}
			}

			hscriptArray.push(newScript);
			if(newScript.exists('onCreate'))
			{
				var callValue = newScript.call('onCreate');
				if(!callValue.succeeded)
				{
					for (e in callValue.exceptions)
					{
						if (e != null)
						{
							var len:Int = e.message.indexOf('\n') + 1;
							if(len <= 0) len = e.message.length;
								trace('ERROR ($file: onCreate) - ${e.message.substr(0, len)}', FlxColor.RED);
						}
					}
					newScript.destroy();
					hscriptArray.remove(newScript);
					return;
				}
			}

			trace('initialized sscript interp successfully: $file (${Std.int(Date.now().getTime() - times)}ms)');
		}
		catch(e)
		{
			var newScript:SSHScript = cast (SScript.global.get(file), SSHScript);
			var len:Int = e.message.indexOf('\n') + 1;
			if(len <= 0) len = e.message.length;
			trace('ERROR  - ' + e.message.substr(0, len), FlxColor.RED);

			if(newScript != null)
			{
				newScript.destroy();
				hscriptArray.remove(newScript);
			}
		}
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		callOnHScript('onUpdate');
		callOnHScript('onUpdatePost');
		super.update(elapsed);
	}

	function setupBossFight(){
		// var result:Dynamic = callOnHScript('setupBossFight');
		// if (result != null)
		// 	return;
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
		var vsCharacter = new FlxSprite(0, 0).loadGraphic(Paths.image('hitmans/death/' + theEnemy));
		if(vsCharacter.graphic == null) //if no graphic was loaded, then load the placeholder
            vsCharacter.loadGraphic(Paths.image('hitmans/death/dawperKill'));
        vsCharacter.screenCenter(XY);
        vsCharacter.scale.set(0.62,0.62);
        vsCharacter.alpha = 1;
        vsCharacter.antialiasing = ClientPrefs.globalAntialiasing;

		var vsBarBg = new FlxSprite(50, FlxG.height - 100).loadGraphic(Paths.image('SimplyLoveHud/HealthBG'));

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
		add(vsBarBg);
		add(vsBar);
	}

	function setupIntro(enter:Bool = false){
		// var result:Dynamic = callOnHScript('setupIntro', [enter]);
		// if (result != null)
		// 	return;
        var blackFade = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackFade.alpha = enter ? 0 : 1;
        add(blackFade);
        FlxTween.tween(blackFade, {alpha: enter ? 1 : 0}, 1, {ease: FlxEase.quadInOut});
	}

	function setupBossIntro(boss:String = 'none')
	{

    }

	override public function stepHit()
	{
		super.stepHit();

		callOnHScript('onStepHit');
	}

	public function callOnHScript(funcToCall:String, args:Array<Dynamic> = null, ?ignoreStops:Bool = false, exclusions:Array<String> = null, excludeValues:Array<Dynamic> = null):Dynamic {
		var returnVal:Dynamic = FunkinLua.Function_Continue;

		#if HSCRIPT_ALLOWED
		if(exclusions == null) exclusions = new Array();
		if(excludeValues == null) excludeValues = new Array();
		excludeValues.push(FunkinLua.Function_Continue);

		var len:Int = hscriptArray.length;
		if (len < 1)
			return returnVal;
		for(i in 0...len)
		{
			var script:SSHScript = hscriptArray[i];
			if(script == null || !script.exists(funcToCall) || exclusions.contains(script.origin))
				continue;

			var myValue:Dynamic = null;
			try
			{
				var callValue = script.call(funcToCall, args);
				if(!callValue.succeeded)
				{
					var e = callValue.exceptions[0];
					if(e != null)
					{
						var len:Int = e.message.indexOf('\n') + 1;
						if(len <= 0) len = e.message.length;
						trace('ERROR (${callValue.calledFunction}) - ' + e.message.substr(0, len), FlxColor.RED);
					}
				}
				else
				{
					myValue = callValue.returnValue;
					if((myValue == FunkinLua.Function_StopHScript || myValue == FunkinLua.Function_StopAll) && !excludeValues.contains(myValue) && !ignoreStops)
					{
						returnVal = myValue;
						break;
					}

					if(myValue != null && !excludeValues.contains(myValue))
						returnVal = myValue;
				}
			}
		}
		#end

		return returnVal;
	}
}