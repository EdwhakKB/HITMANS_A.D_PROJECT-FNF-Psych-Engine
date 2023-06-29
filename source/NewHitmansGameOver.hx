package;

import flixel.FlxBasic;
import flixel.text.FlxText;
import flixel.system.scaleModes.BaseScaleMode;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSave;
import flixel.FlxCamera;
import flixel.FlxSprite;
import Song.SwagSong;

//make more than one wasn't that easy but i like the idea lmao -Ed

class NewHitmansGameOver extends MusicBeatSubstate
{
	public static var deathSoundName:String = 'Edwhak/death';
	public static var loopSoundName:String = 'Edwhak/gameOverNew';
	public static var endSoundName:String = 'inhuman_gameOverEnd';
    public static var characterName = 'Enemy';  //Character = (SONG.player2);

    var camHUD:FlxCamera;
    var retry:FlxSprite;
    var youdied:FlxSprite;
    var staticDeath:FlxSprite;
    var tvStatic:FlxSprite;
    var tvEffect:FlxSprite;
    var vignette:FlxSprite;
    var panel:FlxSprite;
    var offEffect:FlxSprite;
    var youdiedFading:Bool = false;
	var musicplaying:Bool = false;
    var tauntPanel:FlxSprite;
    public static var taunt:FlxText;

    var skiped:Bool = false; //to enable player see the end part lol
    var enableRestart:Bool = false;

    public var diedToAnote:FlxText;
    public var killedByCharacter:FlxText;
    public static var deathCounter:Int = 0;
    public static var deathVariable:String = 'notes';
    //help MEEEEEEE! -Ed
    //added a lot since now game loads every Helper as different shits so...  yeah!

    //global so i can set the "Show all deaths" shit
    public var text1:FlxText;
    public var text2:FlxText;
    public var text3:FlxText;
    public var text4:FlxText;
    public var text5:FlxText;
    //Separated since yeah idk a fucking better way to do this -Ed
    var runTimer1:Bool = false;


    var moveTimer:Bool = false;
    var moveTimer2:Bool = false;
    var moveTimery:Bool = false;
    var moveTimer2y:Bool = false;

    public var tauntNum:Int = 0;

    public var deathSprite:FlxSprite;
    public var noteWhoKilled:String = 'NOTE';
    public var killedByANote:Bool = true;
    public var yOffset:Int = 0;

	public static var instance:NewHitmansGameOver;

	public static function resetVariables() {
        deathSoundName = 'Edwhak/death';
        loopSoundName = 'Edwhak/gameOverNew';
        endSoundName = 'inhuman_gameOverEnd';
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
        deathSoundName = 'Edwhak/death';
        loopSoundName = 'Edwhak/gameOverNew';
        endSoundName = 'inhuman_gameOverEnd';
	}

	public function new(diedTo:String, state:PlayState)
	{
        super();

        trace("Died To ",diedTo);
        deathVariable = diedTo;
		musicplaying=false;

        tauntNum = FlxG.random.int(1,3);

        if(deathVariable == 'Notes' ){
            noteWhoKilled = 'NOTE';
        }else if(deathVariable == 'Hurts' ){
            noteWhoKilled = 'HURTNOTE';
        }else if(deathVariable == 'Instakill' ){
            noteWhoKilled = 'INSTAKILLNOTE';
            yOffset -= 80;
        }else if(deathVariable == 'Mine' ){
            noteWhoKilled = 'MINENOTE';
        }else if(deathVariable == 'Ice' ){
            noteWhoKilled = 'ICENOTE';
        }else if(deathVariable == 'Love' ){
            noteWhoKilled = 'LOVENOTE';
            yOffset -= 80;
        }else if(deathVariable == 'Corrupted' ){
            noteWhoKilled = 'GLITCHNOTE';
        }else if(deathVariable == 'HD' ){
            noteWhoKilled = 'HDNOTE';
            yOffset -= 80;
        }else if(deathVariable == 'TV' ){
            killedByANote = false;
        }else if(deathVariable == 'ALERTS' ){
            killedByANote = false;
        }else if(deathVariable == 'VISION' ){
            killedByANote = false;
        }

        trace("Character: ",characterName);

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;
        camHUD = new FlxCamera();
        FlxG.cameras.add(camHUD);
        FlxCamera.defaultCameras = [camHUD];

        deathSprite = new FlxSprite(770,0);
        deathSprite.frames = Paths.getSparrowAtlas('Skins/Notes/'+ClientPrefs.noteSkin+'/'+noteWhoKilled+'_assets', 'shared');
        deathSprite.animation.addByPrefix('note', 'green0', 24, true);
        deathSprite.animation.play('note');
        deathSprite.scale.y = 1.5;
        deathSprite.scale.x = 1.5;
        deathSprite.angle = 6;
        deathSprite.screenCenter(Y);
        deathSprite.y += yOffset;
        if (!killedByANote){
            deathSprite.alpha = 0;
        }
        add(deathSprite);

        tvStatic = new FlxSprite(500,0);
        tvStatic.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/newGameOver/deathStatic');
        tvStatic.animation.addByPrefix('idle', 'noise', 48, true);	
        tvStatic.antialiasing = ClientPrefs.globalAntialiasing;
        tvStatic.angle = 6;
        tvStatic.scale.y = 0.7;
        tvStatic.scale.x = 0.65;				
        tvStatic.screenCenter(Y);
        tvStatic.alpha = 0.5;
        tvStatic.animation.play("idle");
        add(tvStatic);

        tvEffect = new FlxSprite(600,0);
        tvEffect.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/newGameOver/PC');
        tvEffect.animation.addByPrefix('ON', 'PC On', 48, false);
        tvEffect.animation.addByPrefix('OFF', 'PC Off', 24, false);
        tvEffect.animation.play('OFF');
        tvEffect.angle = 6;
        tvEffect.scale.y = 1;
        tvEffect.scale.x = 0.8;
        tvEffect.screenCenter(Y);
        tvEffect.alpha = 1;
        tvEffect.antialiasing = ClientPrefs.globalAntialiasing;
        add(tvEffect);

        panel = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/newGameOver/pcthing.png', IMAGE));
        panel.screenCenter();
        panel.scale.y = 1;
        panel.scale.x = 1;
        panel.antialiasing = ClientPrefs.globalAntialiasing;
        add(panel);

        diedToAnote = new FlxText(80, 150, Std.int(FlxG.width * 0.6), "", 90);
        diedToAnote.setFormat(Paths.font("DEADLY KILLERS.ttf"), 90, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        diedToAnote.borderSize = 2;
		diedToAnote.alpha = 1;
		add(diedToAnote);

        killedByCharacter = new FlxText(80, 550, Std.int(FlxG.width * 0.6), "Killed By", 60);
        killedByCharacter.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        killedByCharacter.borderSize = 2;
		killedByCharacter.alpha = 1;
		add(killedByCharacter);

        text1 = new FlxText(80, 250, Std.int(FlxG.width * 0.6), "-", 60);
        text1.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text1.borderSize = 2;
		text1.alpha = 1;
		add(text1);

        text2 = new FlxText(80, 300, Std.int(FlxG.width * 0.6), "-", 60);
        text2.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text2.borderSize = 2;
		text2.alpha = 1;
		add(text2);

        text3 = new FlxText(80, 350, Std.int(FlxG.width * 0.6), "-", 60);
        text3.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text3.borderSize = 2;
		text3.alpha = 1;
		add(text3);

        text4 = new FlxText(80, 400, Std.int(FlxG.width * 0.6), "-", 60);
        text4.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text4.borderSize = 2;
		text4.alpha = 1;
		add(text4);

        text5 = new FlxText(80, 450, Std.int(FlxG.width * 0.6), "-", 60);
        text5.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text5.borderSize = 2;
		text5.alpha = 1;
		add(text5);

        tauntPanel = new FlxSprite(300, 380).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/newGameOver/DeathPanel.png', IMAGE));
        tauntPanel.scale.y = 0.4;
        tauntPanel.scale.x = 0.4;
        tauntPanel.antialiasing = ClientPrefs.globalAntialiasing;
        add(tauntPanel);

        retry = new FlxSprite();
        retry.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/newGameOver/retry');
		retry.animation.addByPrefix('empty', "gameover-retry-introEMPTY.png", 24, true);
        retry.animation.addByPrefix('start', "gameover-retry-start", 12, false);
        retry.animation.addByPrefix('idle', "gameover-retry-loop", 2, true);
        retry.setGraphicSize(Std.int(retry.width * 0.375));
		retry.screenCenter();
		retry.x = 560;
		retry.y = 540;
		retry.antialiasing = ClientPrefs.globalAntialiasing;
        add(retry);
		retry.alpha=0;
		retry.animation.play('empty');

        staticDeath = new FlxSprite();
        staticDeath.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/newGameOver/Static');
        staticDeath.animation.addByPrefix('idle', 'Static Animated', 48, true);	
        staticDeath.antialiasing = ClientPrefs.globalAntialiasing;
        staticDeath.scale.y = 3;
        staticDeath.scale.x = 3;				
        staticDeath.screenCenter();
        staticDeath.alpha = 1;
        staticDeath.animation.play("idle");
        add(staticDeath);

        offEffect = new FlxSprite();
        offEffect.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/newGameOver/tv-effect');
        offEffect.animation.addByPrefix('play', 'shutdown', 24, false);
        offEffect.screenCenter();
        offEffect.scale.y = 1;
        offEffect.scale.x = 1;
        offEffect.alpha = 0;
        offEffect.antialiasing = ClientPrefs.globalAntialiasing;
        add(offEffect);

        youdied = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/newGameOver/youdied.png', IMAGE));
        youdied.screenCenter();
        youdied.scale.y = 2;
        youdied.scale.x = 2;
        youdied.alpha = 0;
        youdied.antialiasing = ClientPrefs.globalAntialiasing;
        add(youdied);

        taunt = new FlxText(0, 450, Std.int(FlxG.width * 0.6), "Game over player!", 60);
        taunt.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        taunt.screenCenter(X);
        taunt.borderSize = 2;
		taunt.alpha = 0;
		add(taunt);

        vignette = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/newGameOver/vignette.png', IMAGE));
        vignette.screenCenter();
        vignette.scale.y = 0.53;
        vignette.scale.x = 0.53;
        vignette.antialiasing = ClientPrefs.globalAntialiasing;
        add(vignette);

		FlxG.sound.play(Paths.sound(deathSoundName));
        FlxTween.tween(youdied.scale, {x: 0.5}, 1, {ease:FlxEase.elasticOut});
        FlxTween.tween(youdied.scale, {y: 0.5}, 1, {ease:FlxEase.elasticOut});
        // offEffect.animation.play('play');
        // new FlxTimer().start(1, function(tmr:FlxTimer){
        //     FlxTween.tween(offEffect, {alpha: 0}, 1, {ease:FlxEase.smoothStepIn});
        // });
		Conductor.changeBPM(115);

		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.sound(loopSoundName));
			musicplaying=true;
            runTimer1 = true;
		});
        new FlxTimer().start(6, function(tmr4:FlxTimer)
        {
            tvEffect.animation.play('ON');
            new FlxTimer().start(0.5, function(tmr5:FlxTimer)
            {
                FlxTween.tween(tvEffect, {alpha: 0}, 0.3, {ease:FlxEase.smoothStepIn});
            });
        });
	}
    var elapsedTime:Float = 0;
    var characterFor:Int = 0;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (musicplaying && FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.25 * FlxG.elapsed;
		}

        diedToAnote.text = deathVariable;
        killedByCharacter.text = "Killed by " + characterName;

        switch (deathVariable)
        {
            case 'Notes':
                text1.text = "-The usual notes";
                text2.text = "-Hit them to gain life";
                text3.text = "-Don't miss them";
                text4.text = "-They appear in all songs";
                text5.text = "-Good luck next time";
            case 'Hurts':
                text1.text = "-The Damage Notes";
                text2.text = "-DO NOT hit them";
                text3.text = "-They're skin its mostly red";
                text4.text = "-They only appears in easy chart songs";
                text5.text = "-You got this, try again";
            case 'Instakill':
                text1.text = "-The Killbot notes";
                text2.text = "-DO NOT TOUCH";
                text3.text = "-Any hit of those notes will kill";
                text4.text = "-Mostly appears in Edwhak songs";
                text5.text = "-Don't get distracted, you can do it";
            case 'Mine':
                text1.text = "-The Boom Notes";
                text2.text = "-Hit them will cause a lot of damage";
                text3.text = "-Evade the most as possible";
                text4.text = "-They only appears in hard charts";
                text5.text = "-Focus, concentrate";
            case 'Ice':
                text1.text = "-The Frost notes";
                text2.text = "-Any hit disables your strums";
                text3.text = "-Lethal when hard charts";
                text4.text = "-They appear in all Anby songs";
                text5.text = "-You can beat this, try again";
            case 'Love':
                text1.text = "-The Lovely note";
                text2.text = "-If you aren't santyax they damage";
                text3.text = "-Miss them in that case";
                text4.text = "-Mainly used to help santyax";
                text5.text = "-Do not fail in that false notes again";
            case 'Corrupted':
                text1.text = "-The Weird ones";
                text2.text = "-More than 5 hits kills you";
                text3.text = "-every hit change something";
                text4.text = "-They appear in virus sections";
                text5.text = "-Don't feel scared, you are strong";
            case 'HD':
                text1.text = "-The Alert Notes";
                text2.text = "-You need hit them";
                text3.text = "-Any miss can be lethal";
                text4.text = "-They appear in all songs";
                text5.text = "-Be pattient, you'll get it soon";
            case 'TV':
                text1.text = "-The Tv";
                text2.text = "-You need follow the patern";
                text3.text = "-you can fail 5 times";
                text4.text = "-Used by Anby mainly";
                text5.text = "-Never give up and you'll get it";
            case 'ALERTS':
                text1.text = "-The Ding Ding";
                text2.text = "-Dodge when its needed";
                text3.text = "-Be ultra carefull";
                text4.text = "-Used by Edwhak mainly";
                text5.text = "-Don't get nervous";
            case 'VISION':
                text1.text = "-The Less vision";
                text2.text = "-Will make your screen less visible";
                text3.text = "-Remember focus in the notes";
                text4.text = "-It can appear in Ak song mainly";
                text5.text = "-Do not be scare of what you see";
        }

        switch (characterName)
        {
            case 'Edwhak':
                switch (tauntNum){
                    case 1:
                        taunt.text = "That's all what you got!?";
                    case 2:
                        taunt.text = "Target Exterminated";
                    case 3:
                        taunt.text = "I expected you to last more time, dissapointing";
                }
                taunt.color = 0xff007500;
            case 'anby':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Another day, another death, your time was choosen, by me";
                    case 2:
                        taunt.text = "Seems you're having problems. That's good.";
                    case 3:
                        taunt.text = "I'm sure you can do better, much better than that.";
                }
                taunt.color = 0xff0058aa;
            case 'ladyB':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Is that your best sweetHeart?";
                    case 2:
                        taunt.text = "It seems that you can't handle dance with a true lady";
                    case 3:
                        taunt.text = "I expected more of you dear...";
                }
                taunt.color = 0xffff00d4;
            case 'lady':
                switch (tauntNum){
                    case 1:
                        taunt.text = "My movements distract you?";
                    case 2:
                        taunt.text = "I wasn't even trying to kill you...";
                    case 3:
                        taunt.text = "Oh dear... did you really thinked you got a chance to beat me?";
                }
                taunt.color = 0xff00a300;
            case 'medy':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Try harder next time buddy, but the outcome will still be a fail";
                    case 2:
                        taunt.text = "Was it hard enough for chu...?";
                    case 3:
                        taunt.text = "Do chu want me two nerf this?";
                }
                taunt.color = 0xffff31ee;
            case 'mary':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Objective was succesfully exterminated";
                    case 2:
                        taunt.text = "Destroyed";
                    case 3:
                        taunt.text = "Enemy is no longer alive";
                }
                taunt.color = 0xff00ffdd;
            case 'johan':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Didn't you watch that!?";
                    case 2:
                        taunt.text = "Your eyes are too slow for my attacks!";
                    case 3:
                        taunt.text = "That was your best try!?";
                }
                taunt.color = 0xff9e0000;
            case 'mia':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Cmon it's not like 6 me vs you";
                    case 2:
                        taunt.text = "and you died, how amazing";
                    case 3:
                        taunt.text = "You sure it's not skill issue?";
                }
                taunt.color = 0xff9e009e;
            case 'vanessa':
                switch (tauntNum){
                    case 1:
                        taunt.text = "As an angel i can wellcome you to the heaven";
                    case 2:
                        taunt.text = "You wasn't worthy to escape an angel";
                    case 3:
                        taunt.text = "Poor you... i'll make sure you get a better live in heaven";
                }
                taunt.color = 0xff7eff5d;
            case 'violette':
                switch (tauntNum){
                    case 1:
                        taunt.text = "You are no worthy to a true fight";
                    case 2:
                        taunt.text = "Did you know i wasn't even trying?";
                    case 3:
                        taunt.text = "Disappointing";
                }
                taunt.color = 0xffd341d3;
            case 'virus':
                switch (tauntNum){
                    case 1:
                        taunt.text = "SYSTEM 32 HAS BEEN DELETED";
                    case 2:
                        taunt.text = "Too slow to delete a virus";
                    case 3:
                        taunt.text = "print('haha skill issue');";
                }
                taunt.color = 0xffffffff;
            case 'demency':
                switch (tauntNum){
                    case 1:
                        taunt.text = "USELESS PIECE OF SHIT WAS DEFEATED!";
                    case 2:
                        taunt.text = "Even the system password gave me a harder battle";
                    case 3:
                        taunt.text = "HAHAHAHAHAHAHAHHAHAAH, skill issue";
                }
                taunt.color = 0xff5a0000;
            case 'chip':
                switch (tauntNum){
                    case 1:
                        taunt.text = "I expected a true fight, not a kids game";
                    case 2:
                        taunt.text = "Accept it, you'll never beat me";
                    case 3:
                        taunt.text = "are you even trying?";
                }
                taunt.color = 0xff868686;
            case 'alice':
                switch (tauntNum){
                    case 1:
                        taunt.text = "So you died huh?, i really expected that";
                    case 2:
                        taunt.text = "And the player died, yet again";
                    case 3:
                        taunt.text = "Should i make baby difficulty for you?";
                }
                taunt.color = 0xffff82ea;
            case 'andrea':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Game over Edwhak you are not as strong as you presume";
                    case 2:
                        taunt.text = "Just like a kid game!, i ended dominating";
                    case 3:
                        taunt.text = "Even the gods can be defeated, like you right now";
                }
                taunt.color = 0xff7a296d;
            case 'santyax':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Just like the ring, I ended up dominating the battle";
                    case 2:
                        taunt.text = "KNOCK OUT!";
                    case 3:
                        taunt.text = "Do you know why I am the boxing champion? I never lost a fight";
                }
                taunt.color = 0xffff8800;
            case 'enemy':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Game over";
                    case 2:
                        taunt.text = "END OF THE GAME";
                    case 3:
                        taunt.text = "Try again?";
                }
                taunt.color = 0xff2d2a58;
            default:
                switch (tauntNum){
                    case 1:
                        taunt.text = "CONNECTION LOST";
                    case 2:
                        taunt.text = "SYSTEM 32 STOPED WORKING";
                    case 3:
                        taunt.text = "END OF THE REPORT";
                }
        }

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
        elapsedTime += elapsed;

        if(!youdiedFading){
            youdiedFading = true;
            new FlxTimer().start(1, function(tmr2:FlxTimer)
            {
                staticDeath.alpha = 0;
                offEffect.alpha = 1;
                offEffect.animation.play('play');
            });
            new FlxTimer().start(3, function(tmr3:FlxTimer)
            {
                FlxTween.tween(youdied, {alpha: 1}, 1, {ease:FlxEase.smoothStepIn});
                FlxTween.tween(taunt, {alpha: 1}, 1, {ease:FlxEase.smoothStepIn});
            });
            new FlxTimer().start(5, function(tmr4:FlxTimer)
            {
                FlxTween.tween(youdied, {y: 5}, 1, {ease:FlxEase.smoothStepIn});
                FlxTween.tween(taunt, {alpha: 0}, 0.3, {ease:FlxEase.smoothStepIn});
                FlxTween.tween(offEffect, {alpha: 0}, 1, {ease:FlxEase.smoothStepIn});
                retry.animation.play('start');
                retry.alpha = 0.5;
            });
        }

        if (retry.animation.curAnim.name == 'start' && retry.animation.curAnim.finished) {
            retry.animation.play('idle');
        }

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;

			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new MainMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();

		//FlxG.log.add('beat');
	}

	override function stepHit()
	{
		super.stepHit();
		//FlxG.log.add('step');
		//trace("Y of the dumb screen thing:", screenScanBar.y);
	}

	var isEnding:Bool = false;

	function endBullshit():Void
    {
        if (!isEnding)
        {
			remove(retry);
            isEnding = true;
            FlxG.sound.music.stop();
            FlxG.sound.play(Paths.music(endSoundName));
            new FlxTimer().start(0.7, function(tmr:FlxTimer)
            {
                camHUD.fade(FlxColor.BLACK, 2, false, function()
                {
                    MusicBeatState.resetState();
                });
            });
            PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
        }
    }
}