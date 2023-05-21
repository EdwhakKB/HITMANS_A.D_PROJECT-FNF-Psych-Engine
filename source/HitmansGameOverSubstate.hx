package;

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

//Simple and Complex at the same time -Ed
//why TF it was easy in Lua AAAAAAAAA -Ed
//ed you are hazard/aslhey/amelia/cinder/yama simp, aren't you. Say yes if yes and yes if no. -Anby
//Si :trollface: -Ed

class HitmansGameOverSubstate extends MusicBeatSubstate
{
	public static var deathSoundName:String = 'Edwhak/death';
	public static var loopSoundName:String = 'Edwhak/deathmusic';
	public static var endSoundName:String = 'inhuman_gameOverEnd';
    public static var characterName = 'Enemy';  //Character = (SONG.player2);

    var camHUD:FlxCamera;
    var retry:FlxSprite;
    var youdied:FlxSprite;
    var staticDeath:FlxSprite;
    var vignette:FlxSprite;
    var panel:FlxSprite;
    var offEffect:FlxSprite;
    var youdiedFading:Bool = false;
	var musicplaying:Bool = false;

    var skiped:Bool = false; //to enable player see the end part lol
    var enableRestart:Bool = false;

    public var deathTexts:FlxText; //omg port this was very fun! -Ed
    public var diedToAnote:FlxText;
    public var killedByCharacter:FlxText;
    public static var deathVariable:String = 'notes'; //game loads default if you die with default shit (also to avoid a crash lol)
    public static var globalCounter:Int = 0; //well code this will take a lot of time i guess lmao
    //added this so each character have their own death var
    public static var deathCounter:Int = 0;
    public static var curiousCounter:Int = 0;
    public static var flirtyCounter:Int = 0;
    public static var masterCounter:Int = 0;
    public static var repeatDeath:String = 'notes'; //simple to make all variables get this again, made mainly for double death to the same note
    //help MEEEEEEE! -Ed
    //added a lot since now game loads every Helper as different shits so...  yeah!

    //global so i can set the "Show all deaths" shit
    public static var instakillDead:Int = 0;
    public static var normalDead:Int = 0;
    public static var hurtDead:Int = 0;
    public static var hdDead:Int = 0;
    public static var mineDead:Int = 0;
    public static var frostDead:Int = 0;
    public static var loveDead:Int = 0;
    public static var fireDead:Int = 0;
    public static var tvDead:Int = 0;
    public static var sawbladesDead:Int = 0;
    public static var lessVisionDead:Int = 0;

    //Guiding Ed
    public static var instakillDeaths:Int = 0;
    public static var normalDeaths:Int = 0;
    public static var hurtDeaths:Int = 0;
    public static var hdDeaths:Int = 0;
    public static var mineDeaths:Int = 0;
    public static var frostDeaths:Int = 0;

    //Curious Tails
    public static var greyDeaths:Int = 0;
    public static var noteDeaths:Int = 0;
    public static var redDeaths:Int = 0;
    public static var blueDeaths:Int = 0;
    public static var circleDeaths:Int = 0;

    //Master Anby
    public static var basicDeaths:Int = 0;
    public static var damageDeaths:Int = 0;
    public static var alertsDeaths:Int = 0;
    public static var detonateDeaths:Int = 0;
    public static var loveDeaths:Int = 0;
    public static var fireDeaths:Int = 0;

    //Flirty Arrow
    public static var tvDeaths:Int = 0;
    public static var sawbladesDeaths:Int = 0;
    public static var lessVisionDeaths:Int = 0;

    //Separated since yeah idk a fucking better way to do this -Ed
    var runTimer1:Bool = false;
    var runTimer2:Bool = false;
    var runTimer3:Bool = false;
    var runTimer4:Bool = false;
    var runTimer5:Bool = false;
    var runTimer6:Bool = false;
    var runTimer7:Bool = false;
    var runTimer8:Bool = false;
    var runTimer9:Bool = false;

    var moveTimer:Bool = false;
    var moveTimer2:Bool = false;
    var moveTimery:Bool = false;
    var moveTimer2y:Bool = false;

    //People who help and their variables (for gameOver lol)
    public static var guidingEdwhak:Bool = true; //so game load this as default lmao
    public static var curiousTails:Bool = false;
    public static var flirtyArrow:Bool = false;
    public static var masterAnby:Bool = false;

    /*
        Fast explain thing
        
        This is made based in ROBLOX DOORS! so this is to clarify everything
        this code enables a counter that say you every time you die what to do
        it loads the first time you die to that note and make a text about it
        else if you already died and died again then it tell you something different and things
        the variables load different things
        one its for count all deaths, no matter if restart or not
        the other its for every time you die again so it loads different message
        logically if you die in one song with Hurts, it loads that you already died to that notes and tell you what to do again
    */

	public static var instance:HitmansGameOverSubstate;

	public static function resetVariables() {
        if (curiousTails){
            deathSoundName = 'Edwhak/death';
            loopSoundName = 'Edwhak/curiousDeath';
            endSoundName = 'inhuman_gameOverEnd';
        } else if (guidingEdwhak){
            deathSoundName = 'Edwhak/death';
            loopSoundName = 'Edwhak/deathmusic';
            endSoundName = 'inhuman_gameOverEnd';
        } else if (flirtyArrow){
            deathSoundName = 'Edwhak/death';
            loopSoundName = 'Edwhak/curiousDeath';
            endSoundName = 'inhuman_gameOverEnd';
        } else if (masterAnby){
            deathSoundName = 'Edwhak/death';
            loopSoundName = 'Edwhak/deathmusic';
            endSoundName = 'inhuman_gameOverEnd';
        }
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
        if (curiousTails){
            deathSoundName = 'Edwhak/death';
            loopSoundName = 'Edwhak/curiousDeath';
            endSoundName = 'inhuman_gameOverEnd';
        } else if (guidingEdwhak){
            deathSoundName = 'Edwhak/death';
            loopSoundName = 'Edwhak/deathmusic';
            endSoundName = 'inhuman_gameOverEnd';
        } else if (flirtyArrow){
            deathSoundName = 'Edwhak/death';
            loopSoundName = 'Edwhak/curiousDeath';
            endSoundName = 'inhuman_gameOverEnd';
        } else if (masterAnby){
            deathSoundName = 'Edwhak/death';
            loopSoundName = 'Edwhak/masterDeath';
            endSoundName = 'inhuman_gameOverEnd';
        }
	}

	public function new(diedTo:String, state:PlayState)
	{
        super();

        trace("Died To ",diedTo);
        deathVariable = diedTo;
        repeatDeath = diedTo;
		musicplaying=false;

        globalCounter += 1;
        if (guidingEdwhak){
            deathCounter += 1;
        }else if (curiousTails){
            curiousCounter += 1;
        }else if (masterAnby){
            masterCounter += 1;
        }else if (flirtyArrow){
            flirtyCounter += 1;
        }
        if(deathVariable == 'Notes' ){
            normalDead += 1;
        }else if(deathVariable == 'Hurts' ){
            hurtDead += 1;
        }else if(deathVariable == 'Instakill' ){
            instakillDead += 1;
        }else if(deathVariable == 'Mine' ){
            mineDead += 1;
        }else if(deathVariable == 'Ice' ){
            frostDead += 1;
        }else if(deathVariable == 'Love' ){
            loveDead += 1;
        }else if(deathVariable == 'Corrupted' ){
            fireDead += 1;
        }else if(deathVariable == 'HD' ){
            hdDead += 1;
        }else if(deathVariable == 'TV' ){
            tvDead += 1;
        }else if(deathVariable == 'ALERTS' ){
            sawbladesDead += 1;
        }else if(deathVariable == 'VISION' ){
            lessVisionDead += 1;
        }
        if (guidingEdwhak){
            if(deathVariable == 'Notes' ){
                normalDeaths += 1;
            }else if(deathVariable == 'Hurts' ){
                hurtDeaths += 1;
            }else if(deathVariable == 'Instakill' ){
                instakillDeaths += 1;
            }else if(deathVariable == 'Mine' ){
                mineDeaths += 1;
            }else if(deathVariable == 'Ice' ){
                frostDeaths += 1;
            }else if(deathVariable == 'Glitch' ){
                //deathTexts.text = "Died Due Glitch Notes";
            }else if(deathVariable == 'Corrupted' ){
                //deathTexts.text = "Died Due Corrupted Notes";
            }else if(deathVariable == 'HD' ){
                hdDeaths += 1;
            }
        }else if (curiousTails){
            if(deathVariable == 'Notes' ){
                noteDeaths += 1;
            }else if(deathVariable == 'Hurts' ){
                redDeaths += 1;
            }else if(deathVariable == 'Instakill' ){
                greyDeaths += 1;
            }else if(deathVariable == 'Mine' ){
                circleDeaths += 1;
            }else if(deathVariable == 'HD' ){
                blueDeaths += 1;
            }
        }else if (masterAnby){
            if(deathVariable == 'Notes' ){
                basicDeaths += 1;
            }else if(deathVariable == 'Hurts' ){
                damageDeaths += 1;
            }else if(deathVariable == 'Love' ){
                loveDeaths += 1;
            }else if(deathVariable == 'Fire' ){
                fireDeaths += 1;
            }else if(deathVariable == 'Mine' ){
                detonateDeaths += 1;
            }else if(deathVariable == 'HD' ){
                alertsDeaths += 1;
            }
        }else if (flirtyArrow){
            if(deathVariable == 'TV' ){
                tvDeaths += 1;
            }else if(deathVariable == 'ALERTS' ){
                sawbladesDeaths += 1;
            }else if(deathVariable == 'VISION' ){
                lessVisionDeaths += 1;
            }
        }
        trace('deathNumAmount', globalCounter);

        trace("Character: ",characterName);

        trace("InstaKillAmount: ",instakillDead);
        trace("HurtAmount: ",hurtDead);
        trace("NormalAmount: ",normalDead);
        trace("HDAmount: ",hdDead);
        trace("MineAmount: ",mineDead);
        trace("IceAmount: ",frostDead);
        trace("LoveAmount: ",loveDead);
        trace("FireAmount: ",fireDead);

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;
        camHUD = new FlxCamera();
        FlxG.cameras.add(camHUD);
        FlxCamera.defaultCameras = [camHUD];

        panel = new FlxSprite(240, 140).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/gameOver/DeathPanel.png', IMAGE));
        panel.screenCenter();
        panel.scale.y = 1;
        panel.scale.x = 1;
        panel.antialiasing = ClientPrefs.globalAntialiasing;
        add(panel);

        diedToAnote = new FlxText(280, 250, Std.int(FlxG.width * 0.6), "Died with", 60);
        diedToAnote.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        diedToAnote.borderSize = 2;
		diedToAnote.alpha = 1;
		add(diedToAnote);

        killedByCharacter = new FlxText(280, 180, Std.int(FlxG.width * 0.6), "Killed By", 60);
        killedByCharacter.setFormat(Paths.font("DEADLY KILLERS.ttf"), 60, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        killedByCharacter.borderSize = 2;
		killedByCharacter.alpha = 1;
		add(killedByCharacter);

        retry = new FlxSprite();
        retry.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/gameOver/retry');
		retry.animation.addByPrefix('empty', "gameover-retry-introEMPTY.png", 24, true);
        retry.animation.addByPrefix('start', "gameover-retry-start", 12, false);
        retry.animation.addByPrefix('idle', "gameover-retry-loop", 8, true);
        retry.setGraphicSize(Std.int(retry.width * 0.375));
		retry.screenCenter();
		retry.x = 270;
		retry.y = 440;
		retry.antialiasing = ClientPrefs.globalAntialiasing;
        add(retry);
		retry.alpha=0;
		retry.animation.play('empty');

        staticDeath = new FlxSprite();
        staticDeath.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/gameOver/deathStatic');
        staticDeath.animation.addByPrefix('idle', 'noise', 48, true);	
        staticDeath.antialiasing = ClientPrefs.globalAntialiasing;
        staticDeath.color = 0xff06b100;
        staticDeath.scale.y = 2;
        staticDeath.scale.x = 2;				
        staticDeath.screenCenter();
        staticDeath.alpha = 1;
        staticDeath.animation.play("idle");
        add(staticDeath);

        deathTexts = new FlxText(0, 80, Std.int(FlxG.width * 0.6), "Died Due", 90);
        deathTexts.setFormat(Paths.font("DEADLY KILLERS.ttf"), 90, 0xff035700, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        deathTexts.screenCenter();
        deathTexts.borderSize = 2;
        //deathTexts.x += 105;
		deathTexts.alpha = 0;
		add(deathTexts);

		youdied = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/gameOver/youdied.png', IMAGE));
        youdied.screenCenter();
        youdied.scale.y = 2;
        youdied.scale.x = 2;
        youdied.antialiasing = ClientPrefs.globalAntialiasing;
        add(youdied);

        vignette = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/gameOver/vignette.png', IMAGE));
        vignette.screenCenter();
        vignette.scale.y = 0.53;
        vignette.scale.x = 0.53;
        vignette.antialiasing = ClientPrefs.globalAntialiasing;
        add(vignette);

        offEffect = new FlxSprite();
        offEffect.frames = Paths.getSparrowAtlas('Edwhak/Hitmans/gameOver/tv-effect');
        offEffect.animation.addByPrefix('play', 'shutdown', 24, false);
        offEffect.screenCenter();
        offEffect.scale.y = 1;
        offEffect.scale.x = 1;
        offEffect.alpha = 0;
        offEffect.antialiasing = ClientPrefs.globalAntialiasing;
        add(offEffect);

		FlxG.sound.play(Paths.sound(deathSoundName));
        FlxTween.tween(youdied.scale, {x: 1}, 1, {ease:FlxEase.elasticOut});
        FlxTween.tween(youdied.scale, {y: 1}, 1, {ease:FlxEase.elasticOut});
        // offEffect.animation.play('play');
        // new FlxTimer().start(1, function(tmr:FlxTimer){
        //     FlxTween.tween(offEffect, {alpha: 0}, 1, {ease:FlxEase.smoothStepIn});
        // });
		Conductor.changeBPM(115);

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
            moveTimer2 = true;
            moveTimer2y = true;
			FlxG.sound.play(Paths.sound(loopSoundName));
            if (guidingEdwhak){
                switch (deathCounter)
                {
                    case 1:
                        deathTexts.text = "Oh... Hello there";
                    case 2:
                        deathTexts.text = "hmm? Hello again";
                    default:
                        deathTexts.text = "Welcome back";
                }
            }else if (curiousTails){
                switch (curiousCounter)
                {
                    case 1:
                        deathTexts.text = "Oh, another person";
                    case 2:
                        deathTexts.text = "Welcome back";
                    default:
                        deathTexts.text = "Died again...";
                } 
            }else if (masterAnby){
                switch (masterCounter)
                {
                    case 1:
                        deathTexts.text = "Uhmm... Hello? Who are you?";
                    case 2:
                        deathTexts.text = "Hello, again. Welcome back!";
                    default:
                        deathTexts.text = "Greetings. You are here again!";
                }
            }else if (flirtyArrow){
                switch (flirtyCounter)
                {
                    case 1:
                        deathTexts.text = "Hellooo!";
                    case 2:
                        deathTexts.text = "Oh! Welcome back, chu~!";
                    default:
                        deathTexts.text = "Awh..chu died again..";
                }
            }
            FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.quadIn});
			musicplaying=true;
            runTimer1 = true;
		});
	}
    var elapsedTime:Float = 0;
    var characterFor:Int = 0;
	override function update(elapsed:Float)
	{
        super.update(elapsed);
        
        switch (characterFor)
        {
            case 1:
                staticDeath.color = 0xffff9100;
                deathTexts.color = 0xffffc400;
            case 2:
                staticDeath.color = 0xff06b100;
                deathTexts.color = 0xff035700;
            case 3:
                staticDeath.color = 0xffbb008c;
                deathTexts.color = 0xffff00bf;
            case 4:
                staticDeath.color = 0xff0064c2;
                deathTexts.color = 0xff0084ff;
        }

        if (curiousTails){
            characterFor = 1;
        } else if (guidingEdwhak){
            characterFor = 2;
        } else if (flirtyArrow){
            characterFor = 3;
        } else if (masterAnby){
            characterFor = 4;
        }

		if (musicplaying && FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.25 * FlxG.elapsed;
		}

        diedToAnote.text = "Died To a " + deathVariable + " Note";
        killedByCharacter.text = "Killed by " + characterName;

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
        elapsedTime += elapsed;

        if (moveTimer2){
            moveTimer2 = false;
            FlxTween.tween(deathTexts, {x: 280}, 4, {ease:FlxEase.quadInOut});
            new FlxTimer().start(4, function(subtmr2:FlxTimer){
                moveTimer = true;
            });
        }
        if (moveTimer){
            moveTimer = false;
            FlxTween.tween(deathTexts, {x: 220}, 4, {ease:FlxEase.quadInOut});
            new FlxTimer().start(4, function(subtmr2:FlxTimer){
                moveTimer2 = true;
            });
        }
        if (moveTimer2y){
            moveTimer2y = false;
            FlxTween.tween(deathTexts, {y: 280}, 2, {ease:FlxEase.quadInOut});
            new FlxTimer().start(2, function(subtmr2:FlxTimer){
                moveTimery = true;
            });
        }
        if (moveTimery){
            moveTimery = false;
            FlxTween.tween(deathTexts, {y: 300}, 2, {ease:FlxEase.quadInOut});
            new FlxTimer().start(2, function(subtmr2:FlxTimer){
                moveTimer2y = true;
            });
        }
        if (skiped){
            skiped = false;
            runTimer1 = false;
            runTimer2 = false;
            runTimer3 = false;
            runTimer4 = false;
            runTimer5 = false;
            runTimer6 = false;
            runTimer7 = false;
            runTimer8 = false;
            runTimer9 = false;
            FlxG.sound.music.time = 550;
            enableRestart = true;
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
            deathTexts.visible = false;
            FlxTween.tween(staticDeath, {alpha: 0.5}, 3, {ease:FlxEase.quadOut});
            retry.animation.play('start');
            retry.alpha=0.8;
        }
        // deathTexts.y += Math.sin(elapsedTime);
    //HELP HELP HELP AAAAAAAAAAAAA im fine -Ed
    if (!skiped){
    if (runTimer1){
        runTimer1 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
        new FlxTimer().start(6, function(subtmr2:FlxTimer)
            {
                FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.smoothStepIn});
                if (guidingEdwhak){
                    switch (deathCounter)
                    {
                        case 1:
                            deathTexts.text = "First Death, Right?";
                        case 2:
                            deathTexts.text = "Second Death, isn't it?";
                        default:
                            deathTexts.text = "What killed you this time?";
                    }
                }else if (curiousTails){
                    switch (deathCounter)
                    {
                        case 1:
                            deathTexts.text = "Welcome to the… afterlife?";
                        case 2:
                            deathTexts.text = "I see you died again";
                        default:
                            deathTexts.text = "Your opponent is strong so don't feel discouraged";
                    } 
                }else if (masterAnby){
                    switch (deathCounter)
                    {
                        case 1:
                            deathTexts.text = "Sorry, it's not heaven. And not hell.";
                        case 2:
                            deathTexts.text = "Keep it up and soon will see heaven! Or hell?";
                        default:
                            deathTexts.text = "Dude, do you really like talking to me?";
                    }
                }else if (flirtyArrow){
                    switch (deathCounter)
                    {
                        case 1:
                            deathTexts.text = "First Death, Right?";
                        case 2:
                            deathTexts.text = "Second Death, isn't it?";
                        default:
                            deathTexts.text = "What killed you this time?";
                    }
                }
                runTimer2 = true;
            });
    }
    if (runTimer2){
        runTimer2 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
        new FlxTimer().start(6, function(subtmr2:FlxTimer)
            {
                FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.smoothStepIn});
                if (guidingEdwhak){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (normalDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'Hurts':
                        switch (hurtDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'Instakill':
                        switch (instakillDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    case 'Mine':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "Mine notes killed you";
                            case 2:
                                deathTexts.text = "Again Mine notes...";
                            default:
                                deathTexts.text = "Mine note again...";
                        }
                    case 'Ice':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "Ice notes killed you";
                            case 2:
                                deathTexts.text = "Ice notes right?";
                            default:
                                deathTexts.text = "So... Ice notes are a problem";
                        }
                     case 'Glitch':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "What are these notes?";
                            case 2:
                                deathTexts.text = "Ice notes right?";
                            default:
                                deathTexts.text = "So... Ice notes are a problem";
                        }
                    case 'Corrupted':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "Corrupted notes....";
                            case 2:
                                deathTexts.text = "Corrupted notes again...?";
                            default:
                                deathTexts.text = "...";
                        }
                    case 'HD':
                        switch (hdDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hd note killed you";
                            case 2:
                                deathTexts.text = "Again Hd note";
                            default:
                                deathTexts.text = "So HD notes give you problems";
                        }
                        
                }
            }else if (curiousTails){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (basicDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'Hurts':
                        switch (redDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'Instakill':
                        switch (greyDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    case 'Mine':
                        switch (circleDeaths)
                        {
                            case 1:
                                deathTexts.text = "Mine notes killed you";
                            case 2:
                                deathTexts.text = "Again Mine notes...";
                            default:
                                deathTexts.text = "Mine note again...";
                        }
                    case 'HD':
                        switch (blueDeaths)
                        {
                            case 1:
                                deathTexts.text = "Ice notes killed you";
                            case 2:
                                deathTexts.text = "Ice notes right?";
                            default:
                                deathTexts.text = "So... Ice notes are a problem";
                        }
                }
            }else if (masterAnby){
                switch (deathVariable)
                {
                case 'Notes':
                    switch (basicDeaths)
                    {
                        case 1:
                            deathTexts.text = "Welp, you died from missing Usual Notes.";
                        case 2:
                            deathTexts.text = "Seems you died from missing Usual Notes again.";
                        default:
                            deathTexts.text = "Died from missing Usual Notes. Again.";
                    }
                case 'Hurts':
                    switch (damageDeaths)
                    {
                        case 1:
                            deathTexts.text = "Seems you died from hitting Hurt Notes.";
                        case 2:
                            deathTexts.text = "You got too much damage by Hurt Notes.";
                        default:
                            deathTexts.text = "Died from Hurt Notes. Again.";
                    }
                case 'HD':
                    switch (alertsDeaths)
                    {
                        case 1:
                            deathTexts.text = "You pressed an Instakill note.";
                        case 2:
                            deathTexts.text = "You pressed an Instakill note again.";
                        default:
                            deathTexts.text = "Damn it, it's instakill note again!";
                    }
                case 'Mine':
                    switch (detonateDeaths)
                    {
                        case 1:
                            deathTexts.text = "You hitted a Mine Note.";
                        case 2:
                            deathTexts.text = "Died due hitting a Mine Note.";
                        default:
                            deathTexts.text = "Died from Mine Notes again!";
                    }
                case 'Love':
                    switch (loveDeaths)
                    {
                        case 1:
                            deathTexts.text = "Died to pressing an... Instakill note?";
                        case 2:
                            deathTexts.text = "Died to pressing an Unknown Note.";
                        default:
                            deathTexts.text = "You hitted a note, which you shouldn't have pressed.";
                    }
                 case 'Fire':
                    switch (fireDeaths)
                    {
                        case 1:
                            deathTexts.text = "Died due hitting a Fire Note.";
                        case 2:
                            deathTexts.text = "Fire notes are too hot for you.";
                        default:
                            deathTexts.text = "Welp. Fire Notes got you again!";
                    }
                }
            }else if (flirtyArrow){
                switch (deathVariable)
                {
                    case 'TV':
                        switch (tvDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'ALERT':
                        switch (sawbladesDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'VISION':
                        switch (lessVisionDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    }
            }
                runTimer3 = true;
            });
    }
    if (runTimer3){
        runTimer3 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
        new FlxTimer().start(6, function(subtmr2:FlxTimer)
            {
                FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.smoothStepIn});
                if (guidingEdwhak){

                switch (deathVariable)
                {
                    case 'Notes':
                        switch (normalDeaths)
                        {
                            case 1:
                                deathTexts.text = "Well they are the most common notes";
                            case 2:
                                deathTexts.text = "They are the rhythm, try hit them!";
                            default:
                                deathTexts.text = "So the problem it's your skill";
                        }
                    case 'Hurts':
                        switch (hurtDeaths)
                        {
                            case 1:
                                deathTexts.text = "They have 3 variations";
                            case 2:
                                deathTexts.text = "Try identify the skin that it's the hurt!";
                            default:
                                deathTexts.text = "Remember they drain ur life!";
                        }
                    case 'Instakill':
                        switch (instakillDeaths)
                        {
                            case 1:
                                deathTexts.text = "The name itself tell you what it do";
                            case 2:
                                deathTexts.text = "They usually show with a special texture";
                            default:
                                deathTexts.text = "Don't hit any note of them!!";
                        }
                    case 'Mine':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "They looks like a circle";
                            case 2:
                                deathTexts.text = "They have a animation that alert you";
                            default:
                                deathTexts.text = "Remember they make a sound if you hit to alert you!";
                        }
                    case 'Ice':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "They appear in Anby song";
                            case 2:
                                deathTexts.text = "Remember they looks like ice";
                            default:
                                deathTexts.text = "Usually they aren't spammed";
                        }
                    case 'Glitch':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "They are very..Glitchy";
                            case 2:
                                deathTexts.text = "Again Glitchy Notes";
                            default:
                                deathTexts.text = "Be careful with these notes";
                        }
                    case 'Corrupted':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "...";
                            case 2:
                                deathTexts.text = "Be a lot more careful..?";
                            default:
                                deathTexts.text = "So...Corrupted Again...";
                        }
                    case 'HD':
                        switch (hdDeaths)
                        {
                            case 1:
                                deathTexts.text = "You need Hit them!";
                            case 2:
                                deathTexts.text = "Remember they drain ur life if you miss";
                            default:
                                deathTexts.text = "Try hit them no matter what";
                        }
                        
                }
            }else if (curiousTails){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (basicDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'Hurts':
                        switch (redDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'Instakill':
                        switch (greyDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    case 'Mine':
                        switch (circleDeaths)
                        {
                            case 1:
                                deathTexts.text = "Mine notes killed you";
                            case 2:
                                deathTexts.text = "Again Mine notes...";
                            default:
                                deathTexts.text = "Mine note again...";
                        }
                    case 'HD':
                        switch (blueDeaths)
                        {
                            case 1:
                                deathTexts.text = "Ice notes killed you";
                            case 2:
                                deathTexts.text = "Ice notes right?";
                            default:
                                deathTexts.text = "So... Ice notes are a problem";
                        }
                }
            }else if (masterAnby){
                switch (deathVariable)
                {
                case 'Notes':
                    switch (basicDeaths)
                    {
                        case 1:
                            deathTexts.text = "Seems you having trouble with the chart?";
                        case 2:
                            deathTexts.text = "You just need to focus more on the notes!";
                        default:
                            deathTexts.text = "Let me look at the chart...";
                    }
                case 'Hurts':
                    switch (damageDeaths)
                    {
                        case 1:
                            deathTexts.text = "Hurt Notes are not usual notes.";
                        case 2:
                            deathTexts.text = "Remember about Hurt Notes!";
                        default:
                            deathTexts.text = "Try to not press them them again!";
                    }
                case 'HD':
                    switch (alertsDeaths)
                    {
                        case 1:
                            deathTexts.text = "These notes are insta-killing you!";
                        case 2:
                            deathTexts.text = "Remember, you have to avoid them!";
                        default:
                            deathTexts.text = "Do not hit them in any cost!";
                    }
                case 'Mine':
                    switch (detonateDeaths)
                    {
                        case 1:
                            deathTexts.text = "Mine Notes are similar to Hurt Notes.";
                        case 2:
                            deathTexts.text = "Just remember, it's Hurt Note!";
                        default:
                            deathTexts.text = "I hope you didn't break your keyboard.";
                    }
                case 'Love':
                    switch (loveDeaths)
                    {
                        case 1:
                            deathTexts.text = "Uhhh... Idk about this type of note.";
                        case 2:
                            deathTexts.text = "I don't have any information about this type of note.";
                        default:
                            deathTexts.text = "I think it's similar to insta-killing note.";
                    }
                 case 'Fire':
                    switch (fireDeaths)
                    {
                        case 1:
                            deathTexts.text = "Fire Notes are similar to Hurt Notes.";
                        case 2:
                            deathTexts.text = "Maybe you need to drink something? Ha!";
                        default:
                            deathTexts.text = "Remember about Fire Notes!";
                    }
                }
            }else if (flirtyArrow){
                switch (deathVariable)
                {
                    case 'TV':
                        switch (tvDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'ALERT':
                        switch (sawbladesDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'VISION':
                        switch (lessVisionDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    }
            }
                runTimer4 = true;
            });
    }
    if (runTimer4){
        runTimer4 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
        new FlxTimer().start(6, function(subtmr2:FlxTimer)
            {
                FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.smoothStepIn});
                if (guidingEdwhak){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (normalDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hit them to gain life!";
                            case 2:
                                deathTexts.text = "Don't miss any like them";
                            default:
                                deathTexts.text = "Try practice more and more";
                        }
                    case 'Hurts':
                        switch (hurtDeaths)
                        {
                            case 1:
                                deathTexts.text = "Normal, Agressives, Invisibles and Mimics";
                            case 2:
                                deathTexts.text = "Usually they can be Red!, or copy your notes but darker!";
                            default:
                                deathTexts.text = "And that they appear in all songs";
                        }
                    case 'Instakill':
                        switch (instakillDeaths)
                        {
                            case 1:
                                deathTexts.text = "Usually they only appear in hard songs";
                            case 2:
                                deathTexts.text = "Use that as you Advantage";
                            default:
                                deathTexts.text = "They end your run quite easily";
                        }
                    case 'Mine':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "And they appear in almost all songs";
                            case 2:
                                deathTexts.text = "Pay attention to them";
                            default:
                                deathTexts.text = "that's all i can really tell to help you";
                        }
                    case 'Ice':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "And disable ur strums to hit notes";
                            case 2:
                                deathTexts.text = "And they aren't that healty";
                            default:
                                deathTexts.text = "But they are lethal";
                        }
                    case 'Glitch':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "Changes Happening";
                            case 2:
                                deathTexts.text = "Again Changing Hits";
                            default:
                                deathTexts.text = "Chaning stuff.., be more careful";
                        }
                    case 'Corrupted':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "They make it darker..";
                            case 2:
                                deathTexts.text = "Darker Yet Darker";
                            default:
                                deathTexts.text = "These notes are darker...";
                        }
                    case 'HD':
                        switch (hdDeaths)
                        {
                            case 1:
                                deathTexts.text = "Else you'll lose half life";
                            case 2:
                                deathTexts.text = "So stay alert to them";
                            default:
                                deathTexts.text = "Unless a instakill note it's next to them";
                        }
                        
                }
            }else if (curiousTails){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (basicDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'Hurts':
                        switch (redDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'Instakill':
                        switch (greyDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    case 'Mine':
                        switch (circleDeaths)
                        {
                            case 1:
                                deathTexts.text = "Mine notes killed you";
                            case 2:
                                deathTexts.text = "Again Mine notes...";
                            default:
                                deathTexts.text = "Mine note again...";
                        }
                    case 'HD':
                        switch (blueDeaths)
                        {
                            case 1:
                                deathTexts.text = "Ice notes killed you";
                            case 2:
                                deathTexts.text = "Ice notes right?";
                            default:
                                deathTexts.text = "So... Ice notes are a problem";
                        }
                }
            }else if (masterAnby){
                switch (deathVariable)
                {
                case 'Notes':
                    switch (basicDeaths)
                    {
                        case 1:
                            deathTexts.text = "Just focus more on the notes!";
                        case 2:
                            deathTexts.text = "Yeah, it can be hard!";
                        default:
                            deathTexts.text = "OH MY GOD, WHO MADE THIS CHART?!";
                    }
                case 'Hurts':
                    switch (damageDeaths)
                    {
                        case 1:
                            deathTexts.text = "They hurt you instead of Usual Notes.";
                        case 2:
                            deathTexts.text = "They do not heal you!";
                        default:
                            deathTexts.text = "You just need to remember that!";
                    }
                case 'HD':
                    switch (alertsDeaths)
                    {
                        case 1:
                            deathTexts.text = "Means if you press them again, you will lose again!";
                        case 2:
                            deathTexts.text = "Just remember that!";
                        default:
                            deathTexts.text = "I know these notes can be unfair, but keep trying!";
                    }
                case 'Mine':
                    switch (detonateDeaths)
                    {
                        case 1:
                            deathTexts.text = "They damage you!";
                        case 2:
                            deathTexts.text = "Just avoid them too!";
                        default:
                            deathTexts.text = "Just keep trying!";
                    }
                case 'Love':
                    switch (loveDeaths)
                    {
                        case 1:
                            deathTexts.text = "Just avoid it?";
                        case 2:
                            deathTexts.text = "Try to figure out by yourself!";
                        default:
                            deathTexts.text = "Just ignore it!";
                    }
                 case 'Fire':
                    switch (fireDeaths)
                    {
                        case 1:
                            deathTexts.text = "Do not press them again!";
                        case 2:
                            deathTexts.text = "Okay, okay. Jokes aside.";
                        default:
                            deathTexts.text = "They hurt you like Hurt Notes!";
                    }
                }
            }else if (flirtyArrow){
                switch (deathVariable)
                {
                    case 'TV':
                        switch (tvDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'ALERT':
                        switch (sawbladesDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'VISION':
                        switch (lessVisionDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    }
            }

                runTimer5 = true;
            });
    }
    if (runTimer5){
        runTimer5 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
        new FlxTimer().start(6, function(subtmr2:FlxTimer)
            {
                FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.smoothStepIn});
                if (guidingEdwhak){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (normalDeaths)
                        {
                            case 1:
                                deathTexts.text = "And don't spam!";
                            case 2:
                                deathTexts.text = "if you spam that can happen";
                            default:
                                deathTexts.text = "Practice makes perfect!";
                        }
                    case 'Hurts':
                        switch (hurtDeaths)
                        {
                            case 1:
                                deathTexts.text = "All of them with special damage amount";
                            case 2:
                                deathTexts.text = "So guide from the color it have!";
                            default:
                                deathTexts.text = "So stay always alert";
                        }
                    case 'Instakill':
                        switch (instakillDeaths)
                        {
                            case 1:
                                deathTexts.text = "But not in hard parts";
                            case 2:
                                deathTexts.text = "If you do then you'll do it!";
                            default:
                                deathTexts.text = "So remember how they looks to dodge them";
                        }
                    case 'Mine':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "If it's hard try practice";
                            case 2:
                                deathTexts.text = "If you do, it will be easy";
                            default:
                                deathTexts.text = "Just focus and don't forget";
                        }
                    case 'Ice':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "So try don't hit them";
                            case 2:
                                deathTexts.text = "They can be unfair, i know that...";
                            default:
                                deathTexts.text = "so... use what you learned with Hurts!";
                        }
                    case 'Glitch':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "These notes appear?";
                            case 2:
                                deathTexts.text = "Again with these notes?";
                            default:
                                deathTexts.text = "So... They called glitch notes";
                        }
                    case 'Corrupted':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "Notes of darkness";
                            case 2:
                                deathTexts.text = "Yet more of them...";
                            default:
                                deathTexts.text = "So... They are still making it darker..";
                        }
                    case 'HD':
                        switch (hdDeaths)
                        {
                            case 1:
                                deathTexts.text = "So that make them very lethal";
                            case 2:
                                deathTexts.text = "And hit when you see them";
                            default:
                                deathTexts.text = "But only if you have more than half life";
                        }
                        
                }
            }else if (curiousTails){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (basicDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'Hurts':
                        switch (redDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'Instakill':
                        switch (greyDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    case 'Mine':
                        switch (circleDeaths)
                        {
                            case 1:
                                deathTexts.text = "Mine notes killed you";
                            case 2:
                                deathTexts.text = "Again Mine notes...";
                            default:
                                deathTexts.text = "Mine note again...";
                        }
                    case 'HD':
                        switch (blueDeaths)
                        {
                            case 1:
                                deathTexts.text = "Ice notes killed you";
                            case 2:
                                deathTexts.text = "Ice notes right?";
                            default:
                                deathTexts.text = "So... Ice notes are a problem";
                        }
                }
            }else if (masterAnby){
                switch (deathVariable)
                {
                case 'Notes':
                    switch (basicDeaths)
                    {
                        case 1:
                            deathTexts.text = "Yeah, it can be hard at first.";
                        case 2:
                            deathTexts.text = "But you are determined, right?";
                        default:
                            deathTexts.text = "Oh right... That's me, lol.";
                    }
                case 'Hurts':
                    switch (damageDeaths)
                    {
                        case 1:
                            deathTexts.text = "Understood?";
                        case 2:
                            deathTexts.text = "I hope you understand now.";
                        default:
                            deathTexts.text = "Anyway you can try again!";
                    }
                case 'HD':
                    switch (alertsDeaths)
                    {
                        case 1:
                            deathTexts.text = "Just remember that!";
                        case 2:
                            deathTexts.text = "If you forget again, i'll remind you!";
                        default:
                            deathTexts.text = "I believe in you!";
                    }
                case 'Mine':
                    switch (detonateDeaths)
                    {
                        case 1:
                            deathTexts.text = "Remember that!";
                        case 2:
                            deathTexts.text = "Like the Hurt Notes!";
                        default:
                            deathTexts.text = "And you will make it!";
                    }
                case 'Love':
                    switch (loveDeaths)
                    {
                        case 1:
                            deathTexts.text = "Yeah, probably like that.";
                        case 2:
                            deathTexts.text = "And inform me about that!";
                        default:
                            deathTexts.text = "I think...";
                    }
                 case 'Fire':
                    switch (fireDeaths)
                    {
                        case 1:
                            deathTexts.text = "Else will get here again!";
                        case 2:
                            deathTexts.text = "Just do not press them again.";
                        default:
                            deathTexts.text = "Understood?";
                    }
                }
            }else if (flirtyArrow){
                switch (deathVariable)
                {
                    case 'TV':
                        switch (tvDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'ALERT':
                        switch (sawbladesDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'VISION':
                        switch (lessVisionDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    }
            }
                runTimer6 = true;
            });
    }
    if (runTimer6){
        runTimer6 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
        new FlxTimer().start(6, function(subtmr2:FlxTimer)
            {
                FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.smoothStepIn});
                if (guidingEdwhak){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (normalDeaths)
                        {
                            case 1:
                                deathTexts.text = "That drain ur life too";
                            case 2:
                                deathTexts.text = "So better don't spam";
                            default:
                                deathTexts.text = "So, never give up!";
                        }
                    case 'Hurts':
                        switch (hurtDeaths)
                        {
                            case 1:
                                deathTexts.text = "But don't worry";
                            case 2:
                                deathTexts.text = "I believe you!";
                            default:
                                deathTexts.text = "That helps a lot";
                        }
                    case 'Instakill':
                        switch (instakillDeaths)
                        {
                            case 1:
                                deathTexts.text = "And, don't get nervous";
                            case 2:
                                deathTexts.text = "Dodge them its very easy!";
                            default:
                                deathTexts.text = "And then beat this song!";
                        }
                    case 'Mine':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "With a good practice you'll do it!";
                            case 2:
                                deathTexts.text = "Trust me";
                            default:
                                deathTexts.text = "You can do it!";
                        }
                    case 'Ice':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "And you'll be safe";
                            case 2:
                                deathTexts.text = "But you can dodge them easily";
                            default:
                                deathTexts.text = "And that will be all";
                        }
                    case 'Glitch':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "Glitching out";
                            case 2:
                                deathTexts.text = "Glitching hits, careful";
                            default:
                                deathTexts.text = "Just, be more careful tho";
                        }
                    case 'Corrupted':
                        switch (mineDeaths)
                        {
                            case 1:
                                deathTexts.text = "Darkness..";
                            case 2:
                                deathTexts.text = "More Darker they get";
                            default:
                                deathTexts.text = "Making It darker...";
                        }
                    case 'HD':
                        switch (hdDeaths)
                        {
                            case 1:
                                deathTexts.text = "I recommend get used to their texture";
                            case 2:
                                deathTexts.text = "Remember their texture!";
                            default:
                                deathTexts.text = "So you don't die";
                        }
                        
                }
            }else if (curiousTails){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (basicDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'Hurts':
                        switch (redDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'Instakill':
                        switch (greyDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    case 'Mine':
                        switch (circleDeaths)
                        {
                            case 1:
                                deathTexts.text = "Mine notes killed you";
                            case 2:
                                deathTexts.text = "Again Mine notes...";
                            default:
                                deathTexts.text = "Mine note again...";
                        }
                    case 'HD':
                        switch (blueDeaths)
                        {
                            case 1:
                                deathTexts.text = "Ice notes killed you";
                            case 2:
                                deathTexts.text = "Ice notes right?";
                            default:
                                deathTexts.text = "So... Ice notes are a problem";
                        }
                }
            }else if (masterAnby){
                switch (deathVariable)
                {
                    case 'Notes':
                        switch (basicDeaths)
                        {
                            case 1:
                                deathTexts.text = "But we have to try again!";
                            case 2:
                                deathTexts.text = "So are you ready?";
                            default:
                                deathTexts.text = "Welp... Try again!";
                        }
                    case 'Hurts':
                        switch (damageDeaths)
                        {
                            case 1:
                                deathTexts.text = "I hope you understood!";
                            case 2:
                                deathTexts.text = "Anyway we have to go!";
                            default:
                                deathTexts.text = "Try again!";
                        }
                    case 'HD':
                        switch (alertsDeaths)
                        {
                            case 1:
                                deathTexts.text = "Don't worry!";
                            case 2:
                                deathTexts.text = "Keep going!";
                            default:
                                deathTexts.text = "You can do it!";
                        }
                    case 'Mine':
                        switch (detonateDeaths)
                        {
                            case 1:
                                deathTexts.text = "Anyway...";
                            case 2:
                                deathTexts.text = "Understood?";
                            default:
                                deathTexts.text = "Are you ready to try again?";
                        }
                    case 'Love':
                        switch (loveDeaths)
                        {
                            case 1:
                                deathTexts.text = "Anyway let's try again!";
                            case 2:
                                deathTexts.text = "Anyway it's time.";
                            default:
                                deathTexts.text = "Anyway...";
                        }
                     case 'Fire':
                        switch (fireDeaths)
                        {
                            case 1:
                                deathTexts.text = "It's time to try again.";
                            case 2:
                                deathTexts.text = "Okay, let's try again!";
                            default:
                                deathTexts.text = "That's great!";
                        }
                    }
            }else if (flirtyArrow){
                switch (deathVariable)
                {
                    case 'TV':
                        switch (tvDeaths)
                        {
                            case 1:
                                deathTexts.text = "So, you died due Missing Notes";
                            case 2:
                                deathTexts.text = "hmmm, you died again due Missing Notes";
                            default:
                                deathTexts.text = "It seems you're having problems with Notes";
                        }
                    case 'ALERT':
                        switch (sawbladesDeaths)
                        {
                            case 1:
                                deathTexts.text = "Hmm... you died to Hurt notes";
                            case 2:
                                deathTexts.text = "oh.. you died again to Hurt Notes";
                            default:
                                deathTexts.text = "Hurt notes again right?";
                        }
                    case 'VISION':
                        switch (lessVisionDeaths)
                        {
                            case 1:
                                deathTexts.text = "oh, you died to Instakill notes...";
                            case 2:
                                deathTexts.text = "you died again to Instakill notes";
                            default:
                                deathTexts.text = "Instakill killed you again...";
                        }
                    }
            }
                runTimer7 = true;
            });
    }
    if (runTimer7){
        runTimer7 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
        new FlxTimer().start(6, function(subtmr2:FlxTimer)
            {
                FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.smoothStepIn});
                if (guidingEdwhak){
                switch (deathVariable)
                {
                    case 'Notes':
                        deathTexts.text = "Trust me, YOU CAN!";
                    case 'Hurts':
                        deathTexts.text = "Evade them!";
                    case 'Instakill':
                        deathTexts.text = "Just focus in the notes!";
                    case 'Mine':
                        deathTexts.text = "Just, never give up!";
                    case 'Ice':
                        deathTexts.text = "Use your skill to do it!";
                    case 'Glitch':
                        deathTexts.text = "That always work!";
                    case 'Corrupted':
                        deathTexts.text = "And ignore them like if they didn't exist!";
                    case 'HD':
                        deathTexts.text = "I wish you luck in that!"; 
                }
            }else if (curiousTails){

            }else if (masterAnby){
                switch (deathVariable)
                {
                    case 'Notes':
                        deathTexts.text = "Keep trying and you will beat the song!";
                    case 'Hurts':
                        deathTexts.text = "Keep going! And you will beat the song!";
                    case 'HD':
                        deathTexts.text = "You have to keep going!";
                    case 'Mine':
                        deathTexts.text = "Try again and beat the song!";
                    case 'Love':
                        deathTexts.text = "Just keep trying!";
                    case 'Fire':
                        deathTexts.text = "Keep trying! You will do this!";
                }

            }else if (flirtyArrow){

            }
                runTimer8 = true;
            });
    }
    if (runTimer8){
        runTimer8 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
        new FlxTimer().start(6, function(subtmr2:FlxTimer)
            {
                FlxTween.tween(deathTexts, {alpha: 1}, 0.5, {ease:FlxEase.smoothStepIn});
                if (guidingEdwhak){
                    deathTexts.text = "Let's try again and beat this song!";
                }else if (curiousTails){
                    deathTexts.text = "Let's try again and beat this song!";
                }else if (masterAnby){
                    deathTexts.text = "Don't give up yet!";
                }else if (flirtyArrow){
                    deathTexts.text = "Let's try again and beat this song!";
                }
                //deathTexts.x = 250;
                runTimer9 = true;
            });
    }
    if (runTimer9){
        runTimer9 = false;
        new FlxTimer().start(4, function(subtmr:FlxTimer)
        {
            FlxTween.tween(deathTexts, {alpha: 0}, 0.5, {ease:FlxEase.smoothStepIn});
        });
    }

        if(!youdiedFading){
            youdiedFading = true;
            new FlxTimer().start(1, function(tmr2:FlxTimer)
            {
                FlxTween.tween(youdied, {alpha: 0}, 1, {ease:FlxEase.quadOut});
                FlxTween.tween(youdied.scale, {y: 3}, 5, {ease:FlxEase.quadOut});
                FlxTween.tween(youdied.scale, {x: 3}, 5, {ease:FlxEase.quadOut});
            });

			new FlxTimer().start(54, function(tmr3:FlxTimer)
			{
                if (!skiped){
                    FlxTween.tween(staticDeath, {alpha: 0.5}, 3, {ease:FlxEase.quadOut});
				    retry.animation.play('start');
				    retry.alpha=0.8;
                    enableRestart = true;
                    skiped = true;
                }
			});
        }
    }

        if (retry.animation.curAnim.name == 'start' && retry.animation.curAnim.finished) {
            retry.animation.play('idle');
        }

		if (controls.ACCEPT)
		{
            if (enableRestart){
			    endBullshit();
            }
            if (!skiped){
                skiped = true;
                FlxG.sound.music.time = 550;
            }
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
                offEffect.alpha = 1;
                offEffect.animation.play('play');
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