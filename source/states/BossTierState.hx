package states;

import flixel.input.gamepad.FlxGamepad;
import states.subs.PauseSubState;
import flixel.graphics.FlxGraphic;
import states.SystemOptions;

class BossTierState extends MusicBeatState
{
	private var camBoss:FlxCamera;

    public static var bossLevel:Float = 0.0;
	public static var bossCharacter:String = 'default';

	public static var instance:BossTierState = null;

    public var continueText:FlxText;

	#if SScript
	public var bossScript:ScriptHandler = null;
	#end

    override public function create()
    {
		camBoss = new FlxCamera();
		FlxG.cameras.reset(camBoss);
		FlxG.cameras.setDefaultDrawTarget(camBoss, true);

		persistentUpdate = true;
		persistentDraw = true;

		var loadEnemy = "none";
		switch(bossCharacter.toLowerCase()){
			case 'edwhak', 'he', 'edwhakbroken', 'edkbmassacre':
				loadEnemy = "edwhak";
			default:
				loadEnemy = bossCharacter;
		}

		#if SScript
		bossScript = new ScriptHandler(Paths.getFilePath('$loadEnemy.hx', 'data/boss'));

		if (bossScript.disabled){
			trace('boss script is null, using in source version');
		} else{
			bossScript.setVar('BossTierState', this);
			bossScript.setVar('add', add);
			bossScript.setVar('insert', insert);
			bossScript.setVar('members', members);
			bossScript.setVar('remove', remove);

			bossScript.callFunc('onCreate', []);
		}
		#end

        super.create();

        continueText = new FlxText((FlxG.width/2) +(FlxG.width/4), FlxG.height-25-30, 0, "PRESS ENTER TO CONTINUE");
		continueText.setFormat(Paths.font("DEADLY KILLERS.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		continueText.alpha = 1;
		continueText.visible = false;
		add(continueText);


		#if SScript
		if (!bossScript.disabled) {
			bossScript.callFunc('onCreatePost', []);
	    } else {
			new FlxTimer().start(1, function(twn:FlxTimer) {
				setupBossFight();
				setupIntro(true);
			});
		}	
		#end
    }

	override public function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if (controls.ACCEPT)
			LoadingState.loadAndSwitchState(new PlayState(), false);

		#if SScript
		if(!bossScript.disabled){
			bossScript.callFunc('onUpdate', [elapsed]);
			bossScript.callFunc('onUpdatePost', [elapsed]);
		}
		#end
		super.update(elapsed);
	}

	function setupBossFight(){
		#if SScript
		if(!bossScript.disabled)
			bossScript.callFunc('setupBossFight', []);
		#end

		var theEnemy = "none";
		switch(bossCharacter.toLowerCase()){
			case 'edwhak', 'he', 'edwhakbroken', 'edkbmassacre':
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
        vsCharacter.antialiasing = ClientPrefs.data.antialiasing;

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
		#if SScript
		if(!bossScript.disabled)
			bossScript.callFunc('setupIntro', [enter]);
		#end

		var blackFade = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, CustomFlxColor.BLACK);
		blackFade.alpha = enter ? 1 : 0;
		add(blackFade);
		FlxTween.tween(blackFade, {alpha: enter ? 0 : 1}, 1, {ease: FlxEase.quadInOut});
	}

	override public function beatHit()
	{
		super.beatHit();

		#if SScript
		if(!bossScript.disabled){
			bossScript.setVar('curBeat', [curBeat]);
			bossScript.callFunc('onBeatHit', [curBeat]);
		}
		#end
	}

	override public function stepHit()
	{
		super.stepHit();

		#if SScript
		if(!bossScript.disabled){
			bossScript.setVar('curStep', [curStep]);
			bossScript.callFunc('onStepHit', [curStep]);
		}
		#end
	}

	override public function destroy()
	{
		#if SScript
		if(!bossScript.disabled){
			bossScript.callFunc('onDestroy', []);
			bossScript.destroy();
		}
		#end
		super.destroy();
	}
}
