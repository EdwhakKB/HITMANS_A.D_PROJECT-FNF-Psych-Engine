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
import Note;

import textbox.*;
import flixel.system.FlxAssets;
//make more than one wasn't that easy but i like the idea lmao -Ed

class NewHitmansGameOver extends MusicBeatSubstate
{
	public static var deathSoundName:String = 'Edwhak/death';
	public static var loopSoundName:String = 'Edwhak/gameOverNew';
	public static var endSoundName:String = 'inhuman_gameOverEnd';
    public static var characterName = 'Enemy';  //Character = (SONG.player2);

    //WOOOOOO THE TEXT BOX!
	var dacursor:TextBoxCursor;
	var cursorTween:FlxTween;

    //some settings that will make all text go easier ig?
    var settingsTbox:Settings = new Settings(
        Paths.font("kremlin.ttf"),
        30,
        Std.int(FlxG.width * 0.6),
        FlxColor.WHITE,
        3,
        18
    );
    //for small stuff in textBox (such as killed by and died to)
    var settingsTbox2:Settings = new Settings
    (
        Paths.font("kremlin.ttf"),
        45,
        Std.int(FlxG.width * 0.6),
        FlxColor.RED,
        3,
        24
    );
    
    var camHUD:FlxCamera;
    var retry:FlxSprite;
    var youdied:FlxText;
    var tvStatic:FlxSprite;
    var tvEffect:FlxSprite;
    var vignette:FlxSprite;
    var panel:FlxSprite;
    var blackFade:FlxSprite;
    var youdiedFading:Bool = false;
	var musicplaying:Bool = false;
    public static var taunt:FlxText;

    public var diedToAnote:Textbox;
    public var killedByCharacter:Textbox;
    public static var deathCounter:Int = 0;
    public static var deathVariable:String = 'notes';
    //help MEEEEEEE! -Ed
    //added a lot since now game loads every Helper as different shits so...  yeah!

    //global so i can set the "Show all deaths" shit
    public var text1:Textbox;
    public var text2:Textbox;
    public var text3:Textbox;
    public var text4:Textbox;
    public var text5:Textbox;

    public var tauntNum:Int = 0;

    public var deathSprite:Note;
    public var imageDeath:FlxSprite;
    public var noteWhoKilled:String = 'NOTE';
    public var killedByANote:Bool = true;

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

        switch (deathVariable){
            case 'Notes':
                noteWhoKilled = 'Note';
            case 'Hurts':
                noteWhoKilled = 'HurtAgressive';
            case 'InvisibleHurts':
                noteWhoKilled = 'HurtInvisible';
            case 'Mimics':
                noteWhoKilled = 'Mimic Note';
            case 'Instakill':
                noteWhoKilled = 'Instakill Note';
            case 'Mine':
                noteWhoKilled = 'Mine Note';
            case 'Love':
                noteWhoKilled = 'Love Note';
            case 'HD':
                noteWhoKilled = 'HD Note';
            case 'Fire':
                noteWhoKilled = 'Fire Note';
            case 'TV':
                killedByANote = false;
            case 'ALERTS':
                killedByANote = false;
            case 'VISION':
                killedByANote = false;
        }

        trace("Character: ",characterName);

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;
        camHUD = new FlxCamera();
        FlxG.cameras.add(camHUD);
        FlxCamera.defaultCameras = [camHUD];

        deathSprite = new Note(0, 0, false, true);
        if (killedByANote && deathVariable != 'InvisibleHurts') deathSprite.noteType = deathVariable == 'Notes' ? '' : noteWhoKilled;
        if (killedByANote && deathVariable == 'InvisibleHurts') deathSprite.noteType = 'HurtAgressive'; //lmao
        
        deathSprite.setPosition(830,0);
        deathSprite.animation.addByPrefix('note', 'green0', 24, true);
        deathSprite.animation.play('note');
        deathSprite.scale.y = 1.5;
        deathSprite.scale.x = 1.5;
        deathSprite.angle = 7.5564;
        deathSprite.screenCenter(Y);
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

        diedToAnote = new Textbox(80, 150, settingsTbox2);
		diedToAnote.alpha = 1;
		add(diedToAnote);

        killedByCharacter = new Textbox(80, 550, settingsTbox2);
		killedByCharacter.alpha = 1;
		add(killedByCharacter);

        text1 = new Textbox(80, 250, settingsTbox);
		text1.alpha = 1;
		add(text1);

        text2 = new Textbox(80, 300, settingsTbox);
		text2.alpha = 1;
		add(text2);

        text3 = new Textbox(80, 350, settingsTbox);
		text3.alpha = 1;
		add(text3);

        text4 = new Textbox(80, 400, settingsTbox);
		text4.alpha = 1;
		add(text4);

        text5 = new Textbox(80, 450, settingsTbox);
		text5.alpha = 1;
		add(text5);

        dacursor = new TextBoxCursor(0, 0);
        dacursor.alpha = 0;
		add(dacursor);

        retry = new FlxSprite();
        retry.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/newGameOver/retry');
		retry.animation.addByPrefix('empty', "gameover-retry-introEMPTY.png", 24, true);
        retry.animation.addByPrefix('start', "gameover-retry-start", 12, false);
        retry.animation.addByPrefix('idle', "gameover-retry-loop", 2, true);
        retry.setGraphicSize(Std.int(retry.width * 0.375));
		retry.screenCenter();
		retry.x = 380;
		retry.y = 570;
		retry.antialiasing = ClientPrefs.globalAntialiasing;
        add(retry);
		retry.alpha=0;
		retry.animation.play('empty');

        blackFade = new FlxSprite();
		blackFade.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
        blackFade.alpha = 1;
		add(blackFade);

        imageDeath = new FlxSprite();
        imageDeath.loadGraphic(Paths.image('hitmans/death/' + characterName.toLowerCase()));
        if(imageDeath.graphic == null) //if no graphic was loaded, then load the placeholder
            imageDeath.loadGraphic(Paths.image('hitmans/death/dawperKill'));
        imageDeath.screenCenter(XY);
        imageDeath.scale.set(0.62,0.62);
        imageDeath.alpha = 0;
        imageDeath.antialiasing = ClientPrefs.globalAntialiasing;
        add(imageDeath);

        youdied = new FlxText(0, 450, Std.int(FlxG.width*1.5), "CONNECTION TERMINATED", 120);
        youdied.setFormat(Paths.font("kremlin.ttf"), 120, 0xff5a5858, CENTER);
        youdied.screenCenter();
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

		// FlxG.sound.play(Paths.sound(deathSoundName));
        FlxTween.tween(youdied.scale, {x: 0.5}, 1, {ease:FlxEase.elasticOut});
        FlxTween.tween(youdied.scale, {y: 0.5}, 1, {ease:FlxEase.elasticOut});
		Conductor.bpm = 148;

		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			FlxG.sound.playMusic(Paths.sound(loopSoundName), 0, false);
            FlxG.sound.music.fadeIn(16, 0, 0.8);
			musicplaying=true;
		});
        new FlxTimer().start(6, function(tmr4:FlxTimer)
        {
            tvEffect.animation.play('ON');
            new FlxTimer().start(0.5, function(tmr5:FlxTimer)
            {
                FlxTween.tween(tvEffect, {alpha: 0}, 0.3, {ease:FlxEase.smoothStepIn});
            });
        });

        diedToAnote.setText(deathVariable);
        killedByCharacter.setText("Killed by " + characterName.toUpperCase());

        switch (diedTo)
        {
            case 'Notes':
                text1.setText("-The usual notes");
                text2.setText("-Hit them to gain life");
                text3.setText("-Don't miss them");
                text4.setText("-They appear in all songs");
                text5.setText("-Good luck next time");
            case 'Hurts':
                text1.setText("-The Damage Notes");
                text2.setText("-DO NOT hit them");
                text3.setText("-They're skin its mostly red");
                text4.setText("-They only appears in easy chart songs");
                text5.setText("-You got this, try again");
            case 'InvisibleHurts':
                text1.setText("-The Invisible Notes");
                text2.setText("-They prevent you from spamming");
                text3.setText("-Quiet but mortal");
                text4.setText("-They appear in any song");
                text5.setText("-Next attempt will be victory");
            case 'Mimics':
                text1.setText("-The Doppelganger Notes");
                text2.setText("-Avoid hit any of those notes");
                text3.setText("-They looks exactly like your notes");
                text4.setText("-Usually appears in BOSS Tiers songs");
                text5.setText("-Watch your steps, you can do it");
            case 'Instakill':
                text1.setText("-The Killbot notes");
                text2.setText("-DO NOT TOUCH");
                text3.setText("-Any hit of those notes will kill");
                text4.setText("-Mostly appears in Edwhak songs");
                text5.setText("-Don't get distracted, you can do it");
            case 'Mine':
                text1.setText("-The Boom Notes");
                text2.setText("-Hit them will cause a lot of damage");
                text3.setText("-Evade the most as possible");
                text4.setText("-They only appears in hard charts");
                text5.setText("-Focus, concentrate");
            case 'Fire':
                text1.setText("-The Fire notes");
                text2.setText("-Any hit drains your life");
                text3.setText("-Lethal when easy charts");
                text4.setText("-They appear only vs santyax songs");
                text5.setText("-Better stay cold next time");
            case 'Love':
                text1.setText("-The Lovely note");
                text2.setText("-If you aren't santyax they damage");
                text3.setText("-Miss them in that case");
                text4.setText("-Mainly used to help santyax");
                text5.setText("-Do not fail in that false notes again");
            case 'HD':
                text1.setText("-The Alert Notes");
                text2.setText("-You need hit them");
                text3.setText("-Any miss can be lethal");
                text4.setText("-They appear in all songs");
                text5.setText("-Be pattient, you'll get it soon");
            case 'TV':
                text1.setText("-The Tv");
                text2.setText("-You need follow the patern");
                text3.setText("-you can fail 5 times");
                text4.setText("-Used by Anby mainly");
                text5.setText("-Never give up and you'll get it");
            case 'ALERTS':
                text1.setText("-The Ding Ding");
                text2.setText("-Dodge when its needed");
                text3.setText("-Be ultra carefull");
                text4.setText("-Used by Edwhak mainly");
                text5.setText("-Don't get nervous");
            case 'VISION':
                text1.setText("-The Less vision");
                text2.setText("-Will make your screen less visible");
                text3.setText("-Remember focus in the notes");
                text4.setText("-It can appear in Ak song mainly");
                text5.setText("-Do not be scare of what you see");
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
            case 'drake':
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
                        taunt.text = "Do my movements distract you?";
                    case 2:
                        taunt.text = "I wasn't even trying to kill you...";
                    case 3:
                        taunt.text = "Oh dear... did you really think you had a chance to beat me?";
                }
                taunt.color = 0xff00a300;
            case 'dawper':
                switch (tauntNum){
                    case 1:
                        taunt.text = "Try harder next time bro, but i always win";
                    case 2:
                        taunt.text = "Was it hard enough for you...?";
                    case 3:
                        taunt.text = "Do you want me two nerf this?";
                }
                taunt.color = 0xff8d3800;
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
                        taunt.text = "Too slow to erase me";
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
	}
    var elapsedTime:Float = 0;
    var characterFor:Int = 0;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music != null && musicplaying)
			Conductor.songPosition = FlxG.sound.music.time;

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
        elapsedTime = elapsed;

        if(!youdiedFading){
            youdiedFading = true;
            new FlxTimer().start(3, function(tmr3:FlxTimer)
            {
                FlxTween.tween(youdied, {alpha: 1}, 1, {ease:FlxEase.smoothStepIn});
                FlxTween.tween(imageDeath, {alpha: 0.5}, 1, {ease:FlxEase.smoothStepIn});
                FlxTween.tween(taunt, {alpha: 1}, 1, {ease:FlxEase.smoothStepIn});
            });
            new FlxTimer().start(5, function(tmr4:FlxTimer)
            {
                FlxTween.tween(youdied, {y: 5}, 1, {ease:FlxEase.backOut});
                FlxTween.tween(taunt, {alpha: 0}, 0.3, {ease:FlxEase.smoothStepOut});
                FlxTween.tween(imageDeath, {alpha: 0}, 0.3, {ease:FlxEase.smoothStepOut});
                FlxTween.tween(blackFade, {alpha: 0}, 1, {ease:FlxEase.smoothStepOut});
            });
            new FlxTimer().start(6, function(tmr5:FlxTimer)
            {
                summongDeathTexts();
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
            if (FlxG.sound.music != null)
			    FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;

			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new MainMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('bloodstained'));
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
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


    function summongDeathTexts()
    {
        diedToAnote.bring();
        dacursor.alpha = 1;
		dacursor.attachToTextbox(diedToAnote);
        killedByCharacter.statusChangeCallbacks.push(function(s:Textbox.Status):Void
        {
            if (s == Textbox.Status.DONE)
            {
                cursorTween = FlxTween.color(dacursor, 0.3, dacursor.color, FlxColor.TRANSPARENT,
                    {
                        type: FlxTweenType.PINGPONG,
                        ease: FlxEase.cubeInOut
                    }
                );
                retry.animation.play('start');
                retry.alpha = 1;
            }
        });


        diedToAnote.statusChangeCallbacks.push(function (newStatus:Textbox.Status):Void
        {
            if (newStatus == Textbox.Status.FULL)
            {
                diedToAnote.continueWriting();
            }
            else if(newStatus == Textbox.Status.DONE)
            {
                dacursor.detachFromTextbox(diedToAnote);
                dacursor.attachToTextbox(text1);
                text1.bring();
            }
        });
        text1.statusChangeCallbacks.push(function (newStatus:Textbox.Status):Void
        {
            if (newStatus == Textbox.Status.FULL)
            {
                text1.continueWriting();
            }
            else if(newStatus == Textbox.Status.DONE)
            {
                dacursor.detachFromTextbox(text1);
                dacursor.attachToTextbox(text2);
                text2.bring();
            }
        });
        text2.statusChangeCallbacks.push(function (newStatus:Textbox.Status):Void
        {
            if (newStatus == Textbox.Status.FULL)
            {
                text2.continueWriting();
            }
            else if(newStatus == Textbox.Status.DONE)
            {
                dacursor.detachFromTextbox(text2);
                dacursor.attachToTextbox(text3);
                text3.bring();
            }
        });
        text3.statusChangeCallbacks.push(function (newStatus:Textbox.Status):Void
        {
            if (newStatus == Textbox.Status.FULL)
            {
                text3.continueWriting();
            }
            else if(newStatus == Textbox.Status.DONE)
            {
                dacursor.detachFromTextbox(text3);
                dacursor.attachToTextbox(text4);
                text4.bring();
            }
        });
        text4.statusChangeCallbacks.push(function (newStatus:Textbox.Status):Void
        {
            if (newStatus == Textbox.Status.FULL)
            {
                text4.continueWriting();
            }
            else if(newStatus == Textbox.Status.DONE)
            {
                dacursor.detachFromTextbox(text4);
                dacursor.attachToTextbox(text5);
                text5.bring();
            }
        });
        text5.statusChangeCallbacks.push(function (newStatus:Textbox.Status):Void
        {
            if (newStatus == Textbox.Status.FULL)
            {
                text5.continueWriting();
            }
            else if(newStatus == Textbox.Status.DONE)
            {
                dacursor.detachFromTextbox(text5);
                dacursor.attachToTextbox(killedByCharacter);
                killedByCharacter.bring();
            }
        });
    }


	function endBullshit():Void
    {
        if (!isEnding)
        {
			remove(retry);
            isEnding = true;
            if (FlxG.sound.music != null)
                FlxG.sound.music.stop();
            // FlxG.sound.play(Paths.music(endSoundName));
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

class TextBoxCursor extends FlxSprite
{
	public override function new(X:Float, Y:Float)
	{
		super(X, Y);
		makeGraphic(16, 8);

		ownCharacterCallback = function(character:textbox.Text)
		{
			characterCallbackInternal(character);
		};
	}


	public function attachToTextbox(textbox:Textbox)
	{
		textbox.characterDisplayCallbacks.push(ownCharacterCallback);
	}

	public function detachFromTextbox(textbox:Textbox)
	{
		textbox.characterDisplayCallbacks.remove(ownCharacterCallback);
	}

	private function characterCallbackInternal(character:textbox.Text)
	{
		x = character.x + character.width + 2;

		// I noted an issue : the character height is 0 if targetting javascript.
		if (character.text != " ")
		{
			y = character.y + character.height - 4;
		}
		color = character.color;
	}

	private var ownCharacterCallback:textbox.Text->Void = null;
}