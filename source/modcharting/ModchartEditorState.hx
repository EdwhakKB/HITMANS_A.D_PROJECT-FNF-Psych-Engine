package modcharting;

import lime.utils.Assets;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.util.FlxAxes;
import flixel.math.FlxPoint;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.Anchor;
import flixel.tweens.FlxEase;
import haxe.Json;
import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import flixel.graphics.FlxGraphic;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.FlxSprite;
import flixel.util.FlxSort;
#if (flixel < "5.3.0")
import flixel.system.FlxSound;
#else
import flixel.sound.FlxSound;
#end
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUISlider;
import flixel.addons.ui.FlxUITabMenu;
import flixel.util.FlxDestroyUtil;
import flixel.addons.transition.FlxTransitionableState;

import Section.SwagSection;
import Song;
import MusicBeatSubstate;

import modcharting.*;
import modcharting.PlayfieldRenderer.StrumNoteType;
import modcharting.Modifier;
import modcharting.ModchartFile;

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

class ModchartEditorEvent extends FlxSprite
{
    public var data:Array<Dynamic>;
    public function new (data:Array<Dynamic>)
    {
        this.data = data;
        super(-300, 0);
        frames = Paths.getSparrowAtlas('eventArrowModchart', 'shared');
        animation.addByPrefix('note', 'idle0');
        //makeGraphic(48, 48);
        
        
        animation.play('note');
        setGraphicSize(ModchartEditorState.gridSize, ModchartEditorState.gridSize);
        updateHitbox();
        antialiasing = true;
    }
    public function getBeatTime():Float { return data[ModchartFile.EVENT_DATA][ModchartFile.EVENT_TIME]; }
}
class ModchartEditorState extends MusicBeatState
{
    var hasUnsavedChanges:Bool = false;
    override function closeSubState() 
    {
		persistentUpdate = true;
		super.closeSubState();
	}

    public static function getBPMFromSeconds(time:Float){
        return Conductor.getBPMFromSeconds(time);
	}

    //pain
    //tried using a macro but idk how to use them lol
    public static var modifierList:Array<Class<Modifier>> = [
        //Basic Modifiers with no curpos math
        XModifier, YModifier, YDModifier, ZModifier, 
        ConfusionModifier, MiniModifier,
        ScaleModifier, ScaleXModifier, ScaleYModifier, 
        SkewModifier, SkewXModifier, SkewYModifier,
        //Modifiers with curpos math!!!
        //Drunk Modifiers
        DrunkXModifier, DrunkYModifier, DrunkZModifier, DrunkAngleModifier,
        TanDrunkXModifier, TanDrunkYModifier, TanDrunkZModifier, TanDrunkAngleModifier,
        CosecantXModifier, CosecantYModifier, CosecantZModifier,
        //Tipsy Modifiers
        TipsyXModifier, TipsyYModifier, TipsyZModifier,
        //Wave Modifiers
        WaveXModifier, WaveYModifier, WaveZModifier, WaveAngleModifier,
        TanWaveXModifier, TanWaveYModifier, TanWaveZModifier, TanWaveAngleModifier,
        //Scroll Modifiers
        ReverseModifier, CrossModifier, SplitModifier, AlternateModifier,
        SpeedModifier, BoostModifier, BrakeModifier, BoomerangModifier, WaveingModifier,
        TwirlModifier, RollModifier,
        //Stealth Modifiers
        StealthModifier, NoteStealthModifier, LaneStealthModifier,
        SuddenModifier, HiddenModifier, VanishModifier, BlinkModifier,
        //Path Modifiers
        IncomingAngleModifier, InvertSineModifier, DizzyModifier, TordnadoModifier,
        EaseCurveModifier, EaseCurveXModifier, EaseCurveYModifier, EaseCurveZModifier, EaseCurveAngleModifier,
        BounceXModifier, BounceYModifier, BounceZModifier, BumpyModifier, BeatXModifier, BeatYModifier, BeatZModifier, 
        ShrinkModifier,
        //Target Modifiers
        RotateModifier, StrumLineRotateModifier, JumpTargetModifier,
        LanesModifier,
        //Notes Modifiers
        TimeStopModifier, JumpNotesModifier,
        NotesModifier,
        //Misc Modifiers
        StrumsModifier, InvertModifier, FlipModifier, JumpModifier,
        StrumAngleModifier, EaseXModifier, EaseYModifier, EaseZModifier,
        ShakyNotesModifier,
        ArrowPath
    ];
    public static var easeList:Array<String> = [
        "backIn",
        "backInOut",
        "backOut",
        "bounceIn",
        "bounceInOut",
        "bounceOut",
        "circIn",
        "circInOut",
        "circOut",
        "cubeIn",
        "cubeInOut",
        "cubeOut",
        "elasticIn",
        "elasticInOut",
        "elasticOut",
        "expoIn",
        "expoInOut",
        "expoOut",
        "linear",
        "quadIn",
        "quadInOut",
        "quadOut",
        "quartIn",
        "quartInOut",
        "quartOut",
        "quintIn",
        "quintInOut",
        "quintOut",
        "sineIn",
        "sineInOut",
        "sineOut",
        "smoothStepIn",
        "smoothStepInOut",
        "smoothStepOut",
        "smootherStepIn",
        "smootherStepInOut",
        "smootherStepOut",
    ];
    
    //used for indexing
    public static var MOD_NAME = ModchartFile.MOD_NAME; //the modifier name
    public static var MOD_CLASS = ModchartFile.MOD_CLASS; //the class/custom mod it uses
    public static var MOD_TYPE = ModchartFile.MOD_TYPE; //the type, which changes if its for the player, opponent, a specific lane or all
    public static var MOD_PF = ModchartFile.MOD_PF; //the playfield that mod uses
    public static var MOD_LANE = ModchartFile.MOD_LANE; //the lane the mod uses

    public static var EVENT_TYPE = ModchartFile.EVENT_TYPE; //event type (set or ease)
    public static var EVENT_DATA = ModchartFile.EVENT_DATA; //event data
    public static var EVENT_REPEAT = ModchartFile.EVENT_REPEAT; //event repeat data

    public static var EVENT_TIME = ModchartFile.EVENT_TIME; //event time (in beats)
    public static var EVENT_SETDATA = ModchartFile.EVENT_SETDATA; //event data (for sets)
    public static var EVENT_EASETIME = ModchartFile.EVENT_EASETIME; //event ease time
    public static var EVENT_EASE = ModchartFile.EVENT_EASE; //event ease
    public static var EVENT_EASEDATA = ModchartFile.EVENT_EASEDATA; //event data (for eases)

    public static var EVENT_REPEATBOOL = ModchartFile.EVENT_REPEATBOOL; //if event should repeat
    public static var EVENT_REPEATCOUNT = ModchartFile.EVENT_REPEATCOUNT; //how many times it repeats
    public static var EVENT_REPEATBEATGAP = ModchartFile.EVENT_REPEATBEATGAP; //how many beats in between each repeat

    public var camHUD:FlxCamera;
	public var camGame:FlxCamera;
    public var notes:FlxTypedGroup<Note>;
    private var strumLine:FlxSprite;
    public var strumLineNotes:FlxTypedGroup<StrumNoteType>;
	public var opponentStrums:FlxTypedGroup<StrumNoteType>;
	public var playerStrums:FlxTypedGroup<StrumNoteType>;
	public var unspawnNotes:Array<Note> = [];
    public var loadedNotes:Array<Note> = []; //stored notes from the chart that unspawnNotes can copy from
    public var vocals:FlxSound;
    var generatedMusic:Bool = false;
    

    private var grid:FlxBackdrop;
    private var line:FlxSprite;
    var beatTexts:Array<FlxText> = [];
    public var eventSprites:FlxTypedGroup<ModchartEditorEvent>;
    public static var gridSize:Int = 64;
    public var highlight:FlxSprite;
    public var debugText:FlxText;
    var highlightedEvent:Array<Dynamic> = null;
    var stackedHighlightedEvents:Array<Array<Dynamic>> = [];

    var UI_box:FlxUITabMenu;

    var textBlockers:Array<TextField> = [];
    var scrollBlockers:Array<DropDown> = [];
    var stepperBlockers:Array<NumberStepper> = [];

    var playbackSpeed:Float = 1;

    var activeModifiersText:Label = new Label();
    var selectedEventBox:FlxSprite;

    var col:FlxColor = 0xFFFFD700;
	var col2:FlxColor = 0xFFFFD700;
	
	var beat:Float = 0;
	var dataStuff:Float = 0;

    var inst:FlxSound;

    var ui:TabView;

    var box:ContinuousHBox;
    var box2:ContinuousHBox;
    var box3:HBox;
    var box4:ContinuousHBox;

        //Editors stuff
    var sliderRate:HorizontalSlider = new HorizontalSlider();

    //Events Stuff
    var eventTimeStepper:NumberStepper = new NumberStepper();
    var eventModInputText:TextField = new TextField();
    var eventValueInputText:TextField = new TextField();
    var eventDataInputText:TextField = new TextField();
    var eventModifierDropDown:DropDown = new DropDown();
    var eventTypeDropDown:DropDown = new DropDown();
    var eventEaseInputText:TextField = new TextField();
    var eventTimeInputText:TextField = new TextField();
    var selectedEventDataStepper:NumberStepper = new NumberStepper();
    var repeatCheckbox:CheckBox = new CheckBox();
    var repeatBeatGapStepper:NumberStepper = new NumberStepper();
    var repeatCountStepper:NumberStepper = new NumberStepper();
    var easeDropDown:DropDown = new DropDown();
    var subModDropDown:DropDown = new DropDown();
    var builtInModDropDown:DropDown = new DropDown();
    var stackedEventStepper:NumberStepper = new NumberStepper();

    //Modifiers stuff
    var currentModifier:Array<Dynamic> = null;
    var modNameInputText:TextField = new TextField();
    var modClassInputText:TextField = new TextField();
    var explainText:Label = new Label();
    var modTypeInputText:TextField = new TextField();
    var playfieldStepper:NumberStepper = new NumberStepper();
    var targetLaneStepper:NumberStepper = new NumberStepper();
    var modifierDropDown:DropDown = new DropDown();
    var mods:Array<String> = [];
    var subMods:Array<String> = [""];

    //Playfields stuff
    var playfieldCountStepper:NumberStepper = new NumberStepper();

    override public function new()
    {
        super();
    }
    override public function create()
    {	
        Paths.clearStoredMemory();
        Paths.clearUnusedMemory();
        camGame = new FlxCamera();
        camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

        FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);

        FlxG.cameras.setDefaultDrawTarget(camGame, true);

		persistentUpdate = true;
		persistentDraw = true;

        var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat'));
        bg.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
        add(bg);

        if (PlayState.isPixelStage) //Skew Kills Pixel Notes (How are you going to stretch already pixelated bit by bit notes?)
        {
            modifierList.remove(SkewModifier);
            modifierList.remove(SkewXModifier);
            modifierList.remove(SkewYModifier);
        }

		if (PlayState.SONG == null) PlayState.SONG = Song.loadFromJson('tutorial');
		Conductor.mapBPMChanges(PlayState.SONG);
        Conductor.bpm = PlayState.SONG.bpm;

	    if(FlxG.sound.music != null) FlxG.sound.music.stop();
        FlxG.mouse.visible = true;

        strumLine = new FlxSprite(0, 100).makeGraphic(FlxG.width, 10);
        if(ModchartUtil.getDownscroll(this)) strumLine.y = FlxG.height - 150;
		strumLine.scrollFactor.set();

        strumLineNotes = new FlxTypedGroup<StrumNoteType>();
		add(strumLineNotes);

		opponentStrums = new FlxTypedGroup<StrumNoteType>();
		playerStrums = new FlxTypedGroup<StrumNoteType>();

		generateSong(PlayState.SONG);

		playfieldRenderer = new PlayfieldRenderer(strumLineNotes, notes, this);
		playfieldRenderer.cameras = [camHUD];
        playfieldRenderer.inEditor = true;
		add(playfieldRenderer);

        //strumLineNotes.cameras = [camHUD];
		//notes.cameras = [camHUD];

        #if ("flixel-addons" >= "3.0.0")
        grid = new FlxBackdrop(FlxGraphic.fromBitmapData(createGrid(gridSize, gridSize, FlxG.width, gridSize)), FlxAxes.X, 0, 0);
        #else 
        grid = new FlxBackdrop(FlxGraphic.fromBitmapData(createGrid(gridSize, gridSize, FlxG.width, gridSize)), 0, 0, true, false);
        #end

        // #if ("flixel-addons" >= "3.0.0")
        // grid = new FlxBackdrop(FlxGraphic.fromBitmapData(createGrid(gridSize, gridSize, Std.int(gridSize*48), gridSize)), FlxAxes.X, 0, 0);
        // #else 
        // grid = new FlxBackdrop(FlxGraphic.fromBitmapData(createGrid(gridSize, gridSize, Std.int(gridSize*48), gridSize)), 0, 0, true, false);
        // #end
        
        add(grid);
        
        for (i in 0...12)
        {
            var beatText = new FlxText(-50, gridSize, 0, i+"", 32);
            add(beatText);
            beatTexts.push(beatText);
        }

        eventSprites = new FlxTypedGroup<ModchartEditorEvent>();
        add(eventSprites);

        highlight = new FlxSprite().makeGraphic(gridSize,gridSize);
        highlight.alpha = 0.5;
        add(highlight);

        selectedEventBox = new FlxSprite().makeGraphic(32,32);
        selectedEventBox.y = gridSize*0.5;
        selectedEventBox.visible = false;
        add(selectedEventBox);

        updateEventSprites();

        line = new FlxSprite().makeGraphic(10, gridSize);
        line.color = FlxColor.BLACK;
        add(line);

        generateStaticArrows(0);
        generateStaticArrows(1);
        NoteMovement.getDefaultStrumPosEditor(this);

        //gridGap = FlxMath.remapToRange(Conductor.stepCrochet, 0, Conductor.stepCrochet, 0, gridSize); //idk why i even thought this was how i do it
        //trace(gridGap);

        debugText = new FlxText(0, gridSize*2, 0, "", 16);
        debugText.alignment = FlxTextAlign.LEFT;
        add(debugText);

		ui = new TabView();
		ui.text = "huh";
		ui.draggable = true;
		ui.x = 400;
		ui.y = 120;
		ui.height = 600;
		ui.width = 900;

        addTabs();

        setupModifierUI();
        setupEventUI();
        setupEditorUI();
        setupPlayfieldUI();

        add(ui);

        if (ClientPrefs.quantization && !PlayState.SONG.disableNoteRGB) setUpNoteQuant();

        super.create(); //do here because tooltips be dumb
        
    }

    var dirtyUpdateNotes:Bool = false;
    var dirtyUpdateEvents:Bool = false;
    var dirtyUpdateModifiers:Bool = false;
    var totalElapsed:Float = 0;
    override public function update(elapsed:Float)
    {
        songRateLabel.text = "Song Time: " + Std.string(Conductor.songPosition);
        // songRate.pos = Conductor.songPosition;
        if (finishedSetUpQuantStuff)
        {
            if (ClientPrefs.quantization && !PlayState.SONG.disableNoteRGB)
            {
                var group:FlxTypedGroup<StrumNote> = playerStrums;
                for (this2 in group){
                    if (this2.animation.curAnim.name == 'static'){
                        this2.rgbShader.r = 0xFFFFFFFF;
                        this2.rgbShader.b = 0xFF808080;
                    }
                }
            }
        }
        totalElapsed += elapsed;
        highlight.alpha = 0.8+Math.sin(totalElapsed*5)*0.15;
        super.update(elapsed);
        if(inst.time < 0) {
			inst.pause();
			inst.time = 0;
		}
		else if(inst.time > inst.length) {
			inst.pause();
			inst.time = 0;
		}
        Conductor.songPosition = inst.time;

        var songPosPixelPos = (((Conductor.songPosition/Conductor.stepCrochet)%4)*gridSize);
        grid.x = -curDecStep*gridSize;
        line.x = gridSize*4;

        for (i in 0...beatTexts.length)
        {
            beatTexts[i].x = -songPosPixelPos + (gridSize*4*(i+1)) - 16;
            beatTexts[i].text = ""+ (Math.floor(Conductor.songPosition/Conductor.crochet)+i);
        }
        var eventIsSelected:Bool = false;
        for (i in 0...eventSprites.members.length)
        {
            var pos = grid.x + (eventSprites.members[i].getBeatTime()*gridSize*4)+(gridSize*4);
            //var dec = eventSprites.members[i].beatTime-Math.floor(eventSprites.members[i].beatTime);
            eventSprites.members[i].x = pos; //+ (dec*4*gridSize);
            if (highlightedEvent != null)
                if (eventSprites.members[i].data == highlightedEvent)
                {
                    eventIsSelected = true;
                    selectedEventBox.x = pos;
                }
                    
        }
        selectedEventBox.visible = eventIsSelected;

        var blockInput = false;
        if (!blockInput)
        {
            for (i in textBlockers)
            {
                if (i.focus)
                {
                    blockInput = true;
                    FlxG.sound.muteKeys = [];
                    FlxG.sound.volumeDownKeys = [];
                    FlxG.sound.volumeUpKeys = [];
                    break;
                }
            }       
            for (i in stepperBlockers)
            {
                if (i.focus)
                {
                    blockInput = true;
                    FlxG.sound.muteKeys = [];
                    FlxG.sound.volumeDownKeys = [];
                    FlxG.sound.volumeUpKeys = [];
                    break;
                }
            }       
            for (i in scrollBlockers)
            {
                if (i.dropDownOpen)
                {
                    blockInput = true;
                    break;
                }
            }
        }
        

        if (!blockInput)
        {
            FlxG.sound.muteKeys = TitleState.muteKeys;
			FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
			FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
            if (FlxG.keys.justPressed.SPACE)
            {
                if (inst.playing)
                {
                    inst.pause();
                    if(vocals != null) vocals.pause();
                    playfieldRenderer.editorPaused = true;
                }
                else
                {
                    if(vocals != null) {
                        vocals.play();
                        vocals.pause();
                        vocals.time = inst.time;
                        vocals.play();
                    }
                    inst.play();
                    playfieldRenderer.editorPaused = false;
                    dirtyUpdateNotes = true;
                    dirtyUpdateEvents = true;
                }
            }
            var shiftThing:Int = 1;
            if (FlxG.keys.pressed.SHIFT)
                shiftThing = 4;
            if (FlxG.mouse.wheel != 0)
            {
                inst.pause();
                if(vocals != null) vocals.pause();
                inst.time += (FlxG.mouse.wheel * Conductor.stepCrochet*0.8*shiftThing);
                if(vocals != null) {
                    vocals.pause();
                    vocals.time = inst.time;
                }
                playfieldRenderer.editorPaused = true;
                dirtyUpdateNotes = true;
                dirtyUpdateEvents = true;
            }
    
            if (FlxG.keys.justPressed.D || FlxG.keys.justPressed.RIGHT)
            {
                inst.pause();
                if(vocals != null) vocals.pause();
                inst.time += (Conductor.crochet*4*shiftThing);
                dirtyUpdateNotes = true;
                dirtyUpdateEvents = true;
            }
            if (FlxG.keys.justPressed.A || FlxG.keys.justPressed.LEFT) 
            {
                inst.pause();
                if(vocals != null) vocals.pause();
                inst.time -= (Conductor.crochet*4*shiftThing);
                dirtyUpdateNotes = true;
                dirtyUpdateEvents = true;
            }
            var holdingShift = FlxG.keys.pressed.SHIFT;
            var holdingLB = FlxG.keys.pressed.LBRACKET;
            var holdingRB = FlxG.keys.pressed.RBRACKET;
            var pressedLB = FlxG.keys.justPressed.LBRACKET;
            var pressedRB = FlxG.keys.justPressed.RBRACKET;

            var curSpeed = playbackSpeed;
    
            if (!holdingShift && pressedLB || holdingShift && holdingLB)
                playbackSpeed -= 0.01;
            if (!holdingShift && pressedRB || holdingShift && holdingRB)
                playbackSpeed += 0.01;
            if (FlxG.keys.pressed.ALT && (pressedLB || pressedRB || holdingLB || holdingRB))
                playbackSpeed = 1;
            //
            if (curSpeed != playbackSpeed)
                dirtyUpdateEvents = true;
        }
            
        if (playbackSpeed <= 0.5)
            playbackSpeed = 0.5;
        if (playbackSpeed >= 3)
            playbackSpeed = 3;

        playfieldRenderer.speed = playbackSpeed; //adjust the speed of tweens
        #if FLX_PITCH
        inst.pitch = playbackSpeed;
        vocals.pitch = playbackSpeed;
        #end
        

        if (unspawnNotes[0] != null)
        {
            var time:Float = 2000;
            if(PlayState.SONG.speed < 1) time /= PlayState.SONG.speed;

            while (unspawnNotes.length > 0 && unspawnNotes[0].strumTime - Conductor.songPosition < time)
            {
                var dunceNote:Note = unspawnNotes[0];
                notes.insert(0, dunceNote);
                dunceNote.spawned=true;
                var index:Int = unspawnNotes.indexOf(dunceNote);
                unspawnNotes.splice(index, 1);
            }
        }

        var noteKillOffset = 350 / PlayState.SONG.speed;

        notes.forEachAlive(function(daNote:Note) {
            if (Conductor.songPosition >= daNote.strumTime)
            {
                daNote.wasGoodHit = true;
                var spr:StrumNoteType = null;
                if(!daNote.mustPress) {
                    spr = opponentStrums.members[daNote.noteData];
                } else {
                    spr = playerStrums.members[daNote.noteData];
                }
                spr.playAnim("confirm", true);
                spr.resetAnim = Conductor.stepCrochet * 1.25 / 1000 / playbackSpeed;
                spr.rgbShader.r = daNote.rgbShader.r;
                spr.rgbShader.b = daNote.rgbShader.b;
                if (!daNote.isSustainNote)
                {
                    //daNote.kill();
                    notes.remove(daNote, true);
                    //daNote.destroy();
                }
            }

            if (Conductor.songPosition > noteKillOffset + daNote.strumTime)
            {
                daNote.active = false;
                daNote.visible = false;

                //daNote.kill();
                notes.remove(daNote, true);
                //daNote.destroy();
            }
        });

        if (FlxG.mouse.y < grid.y+grid.height && FlxG.mouse.y > grid.y) //not using overlap because the grid would go out of world bounds
        {
            if (FlxG.keys.pressed.SHIFT)
                highlight.x = FlxG.mouse.x;
            else
                highlight.x = (Math.floor((FlxG.mouse.x-(grid.x%gridSize))/gridSize)*gridSize)+(grid.x%gridSize);
            if (FlxG.mouse.overlaps(eventSprites))
            {
                if (FlxG.mouse.justPressed)
                {
                    stackedHighlightedEvents = []; //reset stacked events
                }
                eventSprites.forEachAlive(function(event:ModchartEditorEvent)
                {
                    if (FlxG.mouse.overlaps(event))
                    {
                        if (FlxG.mouse.justPressed)
                        {
                            highlightedEvent = event.data;
                            stackedHighlightedEvents.push(event.data);
                            onSelectEvent();
                            //trace(stackedHighlightedEvents);
                        }   
                        if (FlxG.keys.justPressed.BACKSPACE)
                            deleteEvent();
                    }
                });
                if (FlxG.mouse.justPressed)
                {
                    updateStackedEventDataStepper();
                }
            }
            else 
            {
                if (FlxG.mouse.justPressed)
                {
                    var timeFromMouse = ((highlight.x-grid.x)/gridSize/4)-1;
                    //trace(timeFromMouse);
                    var event = addNewEvent(timeFromMouse);
                    highlightedEvent = event;
                    onSelectEvent();
                    updateEventSprites();
                    dirtyUpdateEvents = true;
                }
            }
        }

        if (dirtyUpdateNotes)
        {
            clearNotesAfter(Conductor.songPosition+2000); //so scrolling back doesnt lag shit
            unspawnNotes = loadedNotes.copy();
            clearNotesBefore(Conductor.songPosition);
            dirtyUpdateNotes = false;
        }
        if (dirtyUpdateModifiers)
        {
            playfieldRenderer.modifierTable.clear();
            playfieldRenderer.modchart.loadModifiers();
            dirtyUpdateEvents = true;
            dirtyUpdateModifiers = false;
        }
        if (dirtyUpdateEvents)
        {
            playfieldRenderer.tweenManager.completeAll();
            playfieldRenderer.eventManager.clearEvents();
            playfieldRenderer.modifierTable.resetMods();
            playfieldRenderer.modchart.loadEvents();
            dirtyUpdateEvents = false;
            playfieldRenderer.update(0);
            updateEventSprites();
        }

        if (playfieldRenderer.modchart.data.playfields != playfieldCountStepper.pos)
        {
            playfieldRenderer.modchart.data.playfields = Std.int(playfieldCountStepper.pos);
            playfieldRenderer.modchart.loadPlayfields();
        }


        if (FlxG.keys.justPressed.ESCAPE)
        {
            var exitFunc = function()
            {
                FlxG.sound.muteKeys = TitleState.muteKeys;
                FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
                FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
                FlxG.mouse.visible = false;
                inst.stop();
                if(vocals != null) vocals.stop();
                StageData.loadDirectory(PlayState.SONG);
                LoadingState.loadAndSwitchState(new PlayState());
            };
            if (hasUnsavedChanges)
            {
                persistentUpdate = false;
                openSubState(new ModchartEditorExitSubstate(exitFunc));
            }
            else 
                exitFunc();

        }

        var curBpmChange = getBPMFromSeconds(Conductor.songPosition);
        if (curBpmChange.songTime <= 0)
        {
            curBpmChange.bpm = PlayState.SONG.bpm; //start bpm
        }
        if (curBpmChange.bpm != Conductor.bpm)
        {
            //trace('changed bpm to ' + curBpmChange.bpm);
            Conductor.bpm = curBpmChange.bpm;
        }

        debugText.text = Std.string(FlxMath.roundDecimal(Conductor.songPosition / 1000, 2)) + " / " + Std.string(FlxMath.roundDecimal(inst.length / 1000, 2)) +
		"\nBeat: " + Std.string(curDecBeat).substring(0,4) +
		"\nStep: " + curStep + "\n";

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

        activeModifiersText.text = leText;
    }

    function addNewEvent(time:Float)
    {
        var event:Array<Dynamic> = ['ease', [time, 1, 'cubeInOut', ','], [false, 1, 1]];
        if (highlightedEvent != null) //copy over current event data (without acting as a reference)
        {
            event[EVENT_TYPE] = highlightedEvent[EVENT_TYPE];
            if (event[EVENT_TYPE] == 'ease')
            {
                event[EVENT_DATA][EVENT_EASETIME] = highlightedEvent[EVENT_DATA][EVENT_EASETIME];
                event[EVENT_DATA][EVENT_EASE] = highlightedEvent[EVENT_DATA][EVENT_EASE];
                event[EVENT_DATA][EVENT_EASEDATA] = highlightedEvent[EVENT_DATA][EVENT_EASEDATA];
            }
            else 
            {
                event[EVENT_DATA][EVENT_SETDATA] = highlightedEvent[EVENT_TYPE][EVENT_SETDATA];
            }
            event[EVENT_REPEAT][EVENT_REPEATBOOL] = highlightedEvent[EVENT_REPEAT][EVENT_REPEATBOOL];
            event[EVENT_REPEAT][EVENT_REPEATCOUNT] = highlightedEvent[EVENT_REPEAT][EVENT_REPEATCOUNT];
            event[EVENT_REPEAT][EVENT_REPEATBEATGAP] = highlightedEvent[EVENT_REPEAT][EVENT_REPEATBEATGAP];
        
        }
        playfieldRenderer.modchart.data.events.push(event);
        hasUnsavedChanges = true;
        return event;
    }

    function updateEventSprites()
    {
        // var i = eventSprites.length - 1;
        // while (i >= 0) {
        //     var daEvent:ModchartEditorEvent = eventSprites.members[i];
        //     var beat:Float = playfieldRenderer.modchart.data.events[i][1][0];
        //     if(curBeat < beat-4 && curBeat > beat+16)
        //     {
        //         daEvent.active = false;
        //         daEvent.visible = false;
        //         daEvent.alpha = 0;
        //         eventSprites.remove(daEvent, true);
        //         trace(daEvent.getBeatTime());
        //         trace("removed event sprite "+ daEvent.getBeatTime());
        //     }
        //     --i;
        // }
        eventSprites.clear();
        for (i in 0...playfieldRenderer.modchart.data.events.length)
        {
            var beat:Float = playfieldRenderer.modchart.data.events[i][1][0];
            if (curBeat > beat-5  && curBeat < beat+5)
            {
                var daEvent:ModchartEditorEvent = new ModchartEditorEvent(playfieldRenderer.modchart.data.events[i]);
                eventSprites.add(daEvent);
                //trace("added event sprite "+beat);
            }
        }
    }

    function deleteEvent()
    {
        if (highlightedEvent == null)
            return;
        for (i in 0...playfieldRenderer.modchart.data.events.length)
        {
            if (highlightedEvent == playfieldRenderer.modchart.data.events[i])
            {
                playfieldRenderer.modchart.data.events.remove(playfieldRenderer.modchart.data.events[i]);
                dirtyUpdateEvents = true;
                break;
            }
        }
        updateEventSprites();
    }

    override public function beatHit()
    {
        updateEventSprites();
        //trace("beat hit");
        super.beatHit();
    }

    override public function draw()
    {

        super.draw();
    }

    public function clearNotesBefore(time:Float)
    {
        var i:Int = unspawnNotes.length - 1;
        while (i >= 0) {
            var daNote:Note = unspawnNotes[i];
            if(daNote.strumTime+350 < time)
            {
                daNote.active = false;
                daNote.visible = false;
                //daNote.ignoreNote = true;

                //daNote.kill();
                unspawnNotes.remove(daNote);
                //daNote.destroy();
            }
            --i;
        }

        i = notes.length - 1;
        while (i >= 0) {
            var daNote:Note = notes.members[i];
            if(daNote.strumTime+350 < time)
            {
                daNote.active = false;
                daNote.visible = false;
                //daNote.ignoreNote = true;

                //daNote.kill();
                notes.remove(daNote, true);
                //daNote.destroy();
            }
            --i;
        }
    }
    public function clearNotesAfter(time:Float)
    {
        var i = notes.length - 1;
        while (i >= 0) {
            var daNote:Note = notes.members[i];
            if(daNote.strumTime > time)
            {
                daNote.active = false;
                daNote.visible = false;
                //daNote.ignoreNote = true;

                //daNote.kill();
                notes.remove(daNote, true);
                //daNote.destroy();
            }
            --i;
        }
    }


    public function generateSong(songData:SwagSong):Void
    {
        var songData = PlayState.SONG;
        Conductor.bpm = songData.bpm;

        vocals = new FlxSound();
        try {
            if (PlayState.SONG.needsVoices){
                vocals.loadEmbedded(Paths.voices(PlayState.SONG.song));
            }
        }
		catch(e:Dynamic) {}

        FlxG.sound.list.add(vocals);
        //vocals.pitch = playbackRate;

        inst = new FlxSound();
        try {
            inst.loadEmbedded(Paths.inst(PlayState.SONG.song));
		}
		catch(e:Dynamic) {}
        FlxG.sound.list.add(inst);

        inst.onComplete = function()
        {
            inst.pause();
            Conductor.songPosition = 0;
            if(vocals != null) {
                vocals.pause();
                vocals.time = 0;
            }
        };

        notes = new FlxTypedGroup<Note>();
        add(notes);

        var noteData:Array<SwagSection>;

        // NEW SHIT
        noteData = songData.notes;

        var playerCounter:Int = 0;

        var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped

        //var songName:String = Paths.formatToSongPath(PlayState.SONG.song);

        for (section in noteData)
        {
            for (songNotes in section.sectionNotes)
            {
                var daStrumTime:Float = songNotes[0];
                var daNoteData:Int = Std.int(songNotes[1] % 4);
                var gottaHitNote:Bool = section.mustHitSection;
                if (songNotes[1] > 3)
                    gottaHitNote = !section.mustHitSection;

                var oldNote:Note;
                if (unspawnNotes.length > 0)
                    oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
                else
                    oldNote = null;


                var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, false);
                swagNote.sustainLength = songNotes[2];
                swagNote.mustPress = gottaHitNote;
                swagNote.gfNote = (section.gfSection && (songNotes[1]<4));
                swagNote.noteType = songNotes[3];
                if(!Std.isOfType(songNotes[3], String)) swagNote.noteType = editors.ChartingState.noteTypeList[songNotes[3]]; //Backward compatibility + compatibility with Week 7 charts

                swagNote.scrollFactor.set();

                unspawnNotes.push(swagNote);

                final susLength:Float = swagNote.sustainLength / Conductor.stepCrochet;
				final floorSus:Int = Math.floor(susLength);

				if(floorSus > 0) {
					for (susNote in 0...floorSus + 1)
					{
						oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

						var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote), daNoteData, oldNote, true);
                        sustainNote.mustPress = gottaHitNote;
                        sustainNote.gfNote = (section.gfSection && (songNotes[1]<4));
                        sustainNote.noteType = swagNote.noteType;
                        swagNote.tail.push(sustainNote);
                        sustainNote.parent = swagNote;
                        sustainNote.scrollFactor.set();
                        unspawnNotes.push(sustainNote);

                        if (sustainNote.mustPress) sustainNote.x += FlxG.width / 2; // general offset
                        else if(ClientPrefs.middleScroll)
                        {
                            sustainNote.x += 310;
                            if(daNoteData > 1) //Up and Right
                                sustainNote.x += FlxG.width / 2 + 25;
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
                        swagNote.x += FlxG.width / 2 + 25;
                }
            }

            daBeats += 1;
        }

        unspawnNotes.sort(sortByTime);
        loadedNotes = unspawnNotes.copy();
        generatedMusic = true;
    }
    function sortByTime(Obj1:Dynamic, Obj2:Dynamic):Int
    {
        return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
    }

    private function generateStaticArrows(player:Int):Void
    {
        var usedKeyCount = 4;

        var strumLineX:Float =  ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X;

		var TRUE_STRUM_X:Float = strumLineX;

        for (i in 0...usedKeyCount)
        {
            // FlxG.log.add(i);
            var targetAlpha:Float = 1;
            if (player < 1)
            {
                if(ClientPrefs.middleScroll) targetAlpha = 0.35;
            }
            var babyArrow:StrumNote = new StrumNote(ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X, strumLine.y, i, player);
            babyArrow.downScroll = ClientPrefs.downScroll;
            babyArrow.alpha = targetAlpha;

            var middleScroll:Bool = false;
            middleScroll = ClientPrefs.middleScroll;

            if (player == 1)
            {
                playerStrums.add(babyArrow);
            }
            else
            {
                if(middleScroll)
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

	private function round(num:Float, numDecimalPlaces:Int){
		var mult = 10^(numDecimalPlaces > 0 ? numDecimalPlaces : 0);
		return Math.floor(num * mult + 0.5) / mult;
	}

 	public function setUpNoteQuant()
	{
		var bpmChanges = Conductor.bpmChangeMap;
		var strumTime:Float = 0;
		var currentBPM:Float = PlayState.SONG.bpm;
		var newTime:Float = 0;
		for (note in unspawnNotes) 
		{
			strumTime = note.strumTime;
			newTime = strumTime;
			for (i in 0...bpmChanges.length)
				if (strumTime > bpmChanges[i].songTime){
					currentBPM = bpmChanges[i].bpm;
					newTime = strumTime - bpmChanges[i].songTime;
				}
			if (note.rgbShader.enabled){
				dataStuff = ((currentBPM * (newTime - ClientPrefs.noteOffset)) / 1000 / 60);
				beat = round(dataStuff * 48, 0);
				
				if (!note.isSustainNote)
				{
					if(beat%(192/4)==0){
						col = ClientPrefs.arrowRGBQuantize[0][0];
						col2 = ClientPrefs.arrowRGBQuantize[0][2];
					}
					else if(beat%(192/8)==0){
						col = ClientPrefs.arrowRGBQuantize[1][0];
						col2 = ClientPrefs.arrowRGBQuantize[1][2];
					}
					else if(beat%(192/12)==0){
						col = ClientPrefs.arrowRGBQuantize[2][0];
						col2 = ClientPrefs.arrowRGBQuantize[2][2];
					}
					else if(beat%(192/16)==0){
						col = ClientPrefs.arrowRGBQuantize[3][0];
						col2 = ClientPrefs.arrowRGBQuantize[3][2];
					}
					else if(beat%(192/24)==0){
						col = ClientPrefs.arrowRGBQuantize[4][0];
						col2 = ClientPrefs.arrowRGBQuantize[4][2];
					}
					else if(beat%(192/32)==0){
						col = ClientPrefs.arrowRGBQuantize[5][0];
						col2 = ClientPrefs.arrowRGBQuantize[5][2];
					}
					else if(beat%(192/48)==0){
						col = ClientPrefs.arrowRGBQuantize[6][0];
						col2 = ClientPrefs.arrowRGBQuantize[6][2];
					}
					else if(beat%(192/64)==0){
						col = ClientPrefs.arrowRGBQuantize[7][0];
						col2 = ClientPrefs.arrowRGBQuantize[7][2];
					}else{
						col = 0xFF7C7C7C;
						col2 = 0xFF3A3A3A;
					}
					note.rgbShader.r = col;
					note.rgbShader.g = ClientPrefs.arrowRGBQuantize[0][1];
					note.rgbShader.b = col2;
			
				}else{
					note.rgbShader.r = note.prevNote.rgbShader.r;
					note.rgbShader.g = note.prevNote.rgbShader.g;
					note.rgbShader.b = note.prevNote.rgbShader.b;  
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
		finishedSetUpQuantStuff = true;
	}

	var finishedSetUpQuantStuff = false;

    var animSkins:Array<String> = ['ITHIT', 'MANIAHIT', 'STEPMANIA', 'NOTITG'];

    var lastStepHit:Int = -1;
    override function stepHit()
    {
        super.stepHit();

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
    }
   
    public static function createGrid(CellWidth:Int, CellHeight:Int, Width:Int, Height:Int):BitmapData
    {
        // How many cells can we fit into the width/height? (round it UP if not even, then trim back)
        var Color1 = FlxColor.GRAY; //quant colors!!!
        var Color2 = FlxColor.WHITE;
        // var Color3 = FlxColor.LIME;
        var rowColor:Int = Color1;
        var lastColor:Int = Color1;
        var grid:BitmapData = new BitmapData(Width, Height, true);

        // grid.lock();

        // FlxDestroyUtil.dispose(grid);

        // grid = null;

        // If there aren't an even number of cells in a row then we need to swap the lastColor value
        var y:Int = 0;
        var timesFilled:Int = 0;
        while (y <= Height)
        {

            var x:Int = 0;
            while (x <= Width)
            {
                if (timesFilled % 2 == 0)
                    lastColor = Color1;
                else if (timesFilled % 2 == 1)
                    lastColor = Color2;
                grid.fillRect(new Rectangle(x, y, CellWidth, CellHeight), lastColor);
                // grid.unlock();
                timesFilled++;

                x += CellWidth;
            }

            y += CellHeight;
        }

        return grid;
    }

    function findCorrectModData(data:Array<Dynamic>) //the data is stored at different indexes based on the type (maybe should have kept them the same)
    {
        switch(data[EVENT_TYPE])
        {
            case "ease": 
                return data[EVENT_DATA][EVENT_EASEDATA]; 
            case "set": 
                return data[EVENT_DATA][EVENT_SETDATA];
        }
        return null;
    }
    function setCorrectModData(data:Array<Dynamic>, dataStr:String)
    {
        switch(data[EVENT_TYPE])
        {
            case "ease": 
                data[EVENT_DATA][EVENT_EASEDATA] = dataStr;
            case "set": 
                data[EVENT_DATA][EVENT_SETDATA] = dataStr;
        }
        return data;
    }
    //TODO: fix this shit
    function convertModData(data:Array<Dynamic>, newType:String)
    {
        switch(data[EVENT_TYPE]) //convert stuff over i guess
        {
            case "ease": 
                if (newType == 'set')
                {
                    trace('converting ease to set');
                    var temp:Array<Dynamic> = [newType, [
                        data[EVENT_DATA][EVENT_TIME],
                        data[EVENT_DATA][EVENT_EASEDATA],
                    ], data[EVENT_REPEAT]];
                    data = temp.copy();
                }
            case "set": 
                if (newType == 'ease')
                {
                    trace('converting set to ease');
                    var temp:Array<Dynamic> = [newType, [
                        data[EVENT_DATA][EVENT_TIME],
                        1,
                        "linear",
                        data[EVENT_DATA][EVENT_SETDATA],
                    ], data[EVENT_REPEAT]];
                    trace(temp);
                    data = temp.copy();
                }
        } 
        //trace(data);
        return data;
    }

    function updateEventModData(shitToUpdate:String, isMod:Bool)
    {
        var data = getCurrentEventInData();
        if (data != null)
        {
            var dataStr:String = findCorrectModData(data);
            var dataSplit = dataStr.split(',');
            //the way the data works is it goes "value,mod,value,mod,....." and goes on forever, so it has to deconstruct and reconstruct to edit it and shit

            dataSplit[(getEventModIndex()*2)+(isMod ? 1 : 0)] = shitToUpdate;
            dataStr = stringifyEventModData(dataSplit);
            data = setCorrectModData(data, dataStr);
        }
    }
    function getEventModData(isMod:Bool) : String
    {
        var data = getCurrentEventInData();
        if (data != null)
        {
            var dataStr:String = findCorrectModData(data);
            var dataSplit = dataStr.split(',');
            return dataSplit[(getEventModIndex()*2)+(isMod ? 1 : 0)];
        }
        return "";
    }
    function stringifyEventModData(dataSplit:Array<String>) : String
    {
        var dataStr = "";
        for (i in 0...dataSplit.length)
        {
            dataStr += dataSplit[i];
            if (i < dataSplit.length-1)
                dataStr += ',';
        }
        return dataStr;
    }
    function addNewModData()
    {
        var data = getCurrentEventInData();
        if (data != null)
        {
            var dataStr:String = findCorrectModData(data);
            dataStr += ",,"; //just how it works lol
            data = setCorrectModData(data, dataStr);
        }
        return data;
    }
    function removeModData()
    {
        var data = getCurrentEventInData();
        if (data != null)
        {
            if (selectedEventDataStepper.max > 0) //dont remove if theres only 1
            {
                var dataStr:String = findCorrectModData(data);
                var dataSplit = dataStr.split(',');
                dataSplit.resize(dataSplit.length-2); //remove last 2 things
                dataStr = stringifyEventModData(dataSplit);
                data = setCorrectModData(data, dataStr);
            }
        }
        return data;
    }

    inline function addTabs()
	{
		box = new ContinuousHBox();
		box.padding = 5;
		box.width = 700;
		box.text = "Editor";

		box2 = new ContinuousHBox();
		box2.width = 700;
		box2.padding = 5;
		box2.text = "Events";

		box3 = new HBox();
		box3.width = 700;
		box3.padding = 5;
		box3.text = "Modifiers";

		box4 = new ContinuousHBox();
		box4.width = 700;
		box4.padding = 5;
		box4.text = "Playfields";

		ui.addComponent(box);
		ui.addComponent(box2);
		ui.addComponent(box3);
		ui.addComponent(box4);
	}

    var songRateLabel:Label = new Label();
    var songRate:HorizontalSlider = new HorizontalSlider();

    inline function setupEditorUI()
    {
        var vbox:VBox = new VBox();
        var grid:Grid = new Grid();
        grid.columns = 4;

        var sliderRateLabel:Label = new Label();
        sliderRateLabel.text = 'Playback Speed: 1.0';
        sliderRateLabel.verticalAlign = "center";

        sliderRate.min = 0.1;
        sliderRate.max = 3;
        sliderRate.step = 0.1;
        sliderRate.pos = playbackSpeed;
        sliderRate.onDrag = function(e)
        {
            playbackSpeed = sliderRate.pos;
            sliderRateLabel.text = 'Playback Speed: ' + Std.string(sliderRate.pos);
        }

        songRateLabel.text = 'Song Time: ' + Std.string(inst.time);
        songRateLabel.verticalAlign = "center";

        songRate.min = 0;
        songRate.max = inst.length;
        songRate.pos = inst.time;
        songRate.onDrag = function(e)
        {
            inst.time = songRate.pos;
			vocals.time = songRate.pos;
			Conductor.songPosition = songRate.pos;
            songRateLabel.text = 'Song Time: ' + Std.string(songRate.pos);
            dirtyUpdateEvents = true;
            dirtyUpdateNotes = true;
        }

        var check_mute_inst = new CheckBox();
        check_mute_inst.text = "Mute Instrumental (in editor)";
		check_mute_inst.selected = false;
		check_mute_inst.onClick = function(e)
		{
			var vol:Float = 1;
			if (check_mute_inst.selected) vol = 0;
			inst.volume = vol;
		}
        var check_mute_vocals = new CheckBox();
        check_mute_vocals.text =  "Mute Main Vocals (in editor)";
		check_mute_vocals.selected = false;
		check_mute_vocals.onClick = function(e)
		{
			var vol:Float = 1;
			if (check_mute_vocals.selected) vol = 0;
			if (vocals != null) vocals.volume = vol;
		}

        var resetSpeed:Button = new Button();
        resetSpeed.text = 'Reset playbackSpeed'; 
        resetSpeed.onClick = function(e)
        {
            playbackSpeed = 1.0;
        }

        var resetSpeedLabel:Label = new Label();
        resetSpeedLabel.text = "Resets playback speed to 1";
        resetSpeedLabel.verticalAlign = "center";

        var saveJson:Button = new Button();
        saveJson.text = 'Save Modchart';
        saveJson.onClick = function(e)
        {
            saveModchartJson(this);
        };

        var saveJsonLabel:Label = new Label();
        saveJsonLabel.text = "Saves the modchart to a .json file which can be stored and loaded later.";
        saveJsonLabel.verticalAlign = "center";

        var hideNotes:Button = new Button();
        hideNotes.text = "Show / Hide Notes";
        hideNotes.onClick = function(e)
        {
            playfieldRenderer.visible = !playfieldRenderer.visible;
        }

        var helpButton:Button = new Button();
        helpButton.text = "Help";
        helpButton.color = FlxColor.YELLOW;
        helpButton.onClick = function(e)
        {
            CoolUtil.browserLoad('https://docs.google.com/document/d/12i7Ci7ISfbx34Gh8btIDNQqNV8x4WLMCaOYeU2I-nEU/edit?usp=sharing');
        }

        vbox.addComponent(sliderRateLabel);
        vbox.addComponent(sliderRate);
        vbox.addComponent(songRateLabel);
        vbox.addComponent(songRate);
        vbox.addComponent(check_mute_inst);
        vbox.addComponent(check_mute_vocals);
        vbox.addComponent(saveJsonLabel);
        vbox.addComponent(saveJson);
        vbox.addComponent(resetSpeedLabel);
        vbox.addComponent(resetSpeed);
        vbox.addComponent(hideNotes);
        vbox.addComponent(helpButton);

        grid.addComponent(vbox);
        box.addComponent(grid);
    }

    inline function setupEventUI()
    {
        var vbox1:VBox = new VBox();
        var vbox2:VBox = new VBox();
        var vbox3:VBox = new VBox();

        var grid:Grid = new Grid();
        var grid2:Grid = new Grid();

        eventEaseInputText.text = "";
        eventEaseInputText.onChange = function(e)
        {
            var data = getCurrentEventInData();
            if (data != null)
            {
                if (data[EVENT_TYPE] == 'ease')
                    data[EVENT_DATA][EVENT_EASE] = eventEaseInputText.text;
            }
            dirtyUpdateEvents = true;
            hasUnsavedChanges = true;
        }

        eventTimeInputText.text = "";
        eventTimeInputText.onChange = function(e)
        {
            var data = getCurrentEventInData();
            if (data != null)
            {
                if (data[EVENT_TYPE] == 'ease')
                    data[EVENT_DATA][EVENT_EASETIME] = eventTimeInputText.text;
            }
            dirtyUpdateEvents = true;
            hasUnsavedChanges = true;
        }

        eventDataInputText.text = "";
        eventDataInputText.onChange = function(e)
        {
            var data = getCurrentEventInData();
            if (data != null)
            {
                data[EVENT_DATA][EVENT_EASEDATA] = eventDataInputText.text;
                highlightedEvent = data; 
                dirtyUpdateEvents = true;
                hasUnsavedChanges = true;
            }
        }

        eventModInputText.text = "";
        eventModInputText.onChange = function(e)
        {
            updateEventModData(eventModInputText.text, true);
            var data = getCurrentEventInData();
            if (data != null)
            {
                highlightedEvent = data; 
                eventDataInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASEDATA];
                dirtyUpdateEvents = true;
                hasUnsavedChanges = true;
            }
        }

        var subModDropList = new ArrayDataSource<Dynamic>();
		for (subMod in 0...subMods.length)
		{
			subModDropList.add(subMods[subMod]);
		}
        
        subModDropDown.width = 140;
        subModDropDown.dataSource = subModDropList;
        subModDropDown.selectedIndex = 0;
        subModDropDown.onChange = function(e)
        {
            var modName = subMods[subModDropDown.selectedIndex];
            var splitShit = eventModInputText.text.split(":"); //use to get the normal mod
            if (modName == "") eventModInputText.text = splitShit[0]; //remove the sub mod
            else eventModInputText.text = splitShit[0] + ":" + modName;
            updateEventInputsOnChange();
            hasUnsavedChanges = true;
        }
       
        eventTimeStepper.min = 0;
        eventTimeStepper.max = 9999;
        eventTimeStepper.step = 0.25;
        eventTimeStepper.pos = 0;
        eventTimeStepper.precision = 3;
        eventTimeStepper.decimalSeparator = ".";

        repeatCheckbox.text = "Repeat Event?";
        repeatCheckbox.selected = false;
        repeatCheckbox.onClick = function(e)
        {
            var data = getCurrentEventInData();
            if (data != null)
            {
                data[EVENT_REPEAT][EVENT_REPEATBOOL] = repeatCheckbox.selected;
                highlightedEvent = data;
                dirtyUpdateEvents = true;
                hasUnsavedChanges = true;
            }
        }

        repeatBeatGapStepper.min = 0;
        repeatBeatGapStepper.max = 9999;
        repeatBeatGapStepper.step = 0.25;
        repeatBeatGapStepper.pos = 0;
        repeatBeatGapStepper.precision = 1;
        repeatBeatGapStepper.decimalSeparator = ".";
        repeatBeatGapStepper.onChange = function(e)
        {
            var data = getCurrentEventInData();
            if (data != null)
            {
                data[EVENT_REPEAT][EVENT_REPEATBEATGAP] = repeatBeatGapStepper.pos;
                highlightedEvent = data;
                hasUnsavedChanges = true;
                dirtyUpdateEvents = true;
            }
        }

        repeatCountStepper.min = 1;
        repeatCountStepper.max = 9999;
        repeatCountStepper.step = 1;
        repeatCountStepper.pos = 1;
        repeatCountStepper.precision = 1;
        repeatCountStepper.decimalSeparator = ".";
        repeatCountStepper.onChange = function(e)
        {
            var data = getCurrentEventInData();
            if (data != null)
            {
                data[EVENT_REPEAT][EVENT_REPEATCOUNT] = repeatCountStepper.pos;
                highlightedEvent = data;
                hasUnsavedChanges = true;
                dirtyUpdateEvents = true;
            }
        }

        eventValueInputText.text = "";
        eventValueInputText.onChange = function(e)
        {
            updateEventModData(eventValueInputText.text, false);
            var data = getCurrentEventInData();
            if (data != null)
            {
                highlightedEvent = data; 
                eventDataInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASEDATA];
                dirtyUpdateEvents = true;
                hasUnsavedChanges = true;
            }
        }

        selectedEventDataStepper.min = 0;
        selectedEventDataStepper.max = 0;
        selectedEventDataStepper.step = 1;
        selectedEventDataStepper.pos = 0;
        selectedEventDataStepper.onChange = function(e)
        {
            if (highlightedEvent != null)
            {
                eventDataInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASEDATA];
                eventModInputText.text = getEventModData(true);
                eventValueInputText.text = getEventModData(false);
            }
        }

        var eventTypesList = new ArrayDataSource<Dynamic>();
		for (type in 0...eventTypes.length)
		{
			eventTypesList.add(eventTypes[type]);
		}

        eventTypeDropDown.width = 100;
        eventTypeDropDown.dataSource = eventTypesList;
        eventTypeDropDown.selectedIndex = 0;
        eventTypeDropDown.onChange = function(e)
        {
            var et = eventTypes[eventTypeDropDown.selectedIndex];
            trace(et);
            var data = getCurrentEventInData();
            if (data != null)
            {
                //if (data[EVENT_TYPE] != et)
                data = convertModData(data, et);
                highlightedEvent = data;
                trace(highlightedEvent);
            }
            dirtyUpdateEvents = true;
            hasUnsavedChanges = true;
        }

        var easeDropList = new ArrayDataSource<Dynamic>();
		for (ease in 0...easeList.length)
		{
			easeDropList.add(easeList[ease]);
		}

        easeDropDown.dataSource = easeDropList;
        easeDropDown.selectedIndex = 0;
        easeDropDown.onChange = function(e)
        {
            var easeStr = easeList[easeDropDown.selectedIndex];
            eventEaseInputText.text = easeStr;
            updateEventInputsOnChange(); //make sure it updates
            hasUnsavedChanges = true;
        }

        var modsDropList = new ArrayDataSource<Dynamic>();
		for (mod in 0...mods.length)
		{
			modsDropList.add(mods[mod]);
		}

        eventModifierDropDown.width = 140;
        eventModifierDropDown.dataSource = modsDropList;
        eventModifierDropDown.selectedIndex = 0;
        eventModifierDropDown.onChange = function(e)
        {
            var modName = mods[eventModifierDropDown.selectedIndex];
            eventModInputText.text = modName;
            updateSubModList(modName);
            updateEventInputsOnChange();
            hasUnsavedChanges = true;
        }

        stackedEventStepper.min = 0;
        stackedEventStepper.max = 0;
        stackedEventStepper.pos = 0;
        stackedEventStepper.step = 1;
        stackedEventStepper.onChange = function(e)
        {
            if (highlightedEvent != null)
            {
                //trace(stackedHighlightedEvents);
                highlightedEvent = stackedHighlightedEvents[Std.int(stackedEventStepper.pos)];
                onSelectEvent(true);
            }
        }

        var addStacked:Button = new Button();
        addStacked.text = 'Add New Stacked Event';
        addStacked.onClick = function(e)
        {
            var data = getCurrentEventInData();
            if (data != null)
            {
                var event = addNewEvent(data[EVENT_DATA][EVENT_TIME]);
                highlightedEvent = event;
                onSelectEvent();
                updateEventSprites();
                dirtyUpdateEvents = true;
            } 
        }

        var addEventButton:Button = new Button();
        addEventButton.text = 'Add Event';
        addEventButton.onClick = function(e)
        {
            var data = addNewModData();
            if (data != null)
            {
                highlightedEvent = data; 
                updateSelectedEventDataStepper();
                eventDataInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASEDATA];
                eventModInputText.text = getEventModData(true);
                eventValueInputText.text = getEventModData(false);
                dirtyUpdateEvents = true;
                hasUnsavedChanges = true;
            }
        }
        var removeEventButton:Button = new Button();
        removeEventButton.text = 'Remove Event';
        removeEventButton.onClick = function(e)
        {
            var data = removeModData();
            if (data != null)
            {
                highlightedEvent = data; 
                updateSelectedEventDataStepper();
                eventDataInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASEDATA];
                eventModInputText.text = getEventModData(true);
                eventValueInputText.text = getEventModData(false);
                dirtyUpdateEvents = true;
                hasUnsavedChanges = true;
            }
        }

        //Labels
        var addStackedLabel:Label = new Label();
        addStackedLabel.text = "Add New Stacked Event";
        addStackedLabel.verticalAlign = "center";

        var eventDataLabel:Label = new Label();
        eventDataLabel.text = "The raw data used in the event, you wont really need to use this.";
        eventDataLabel.verticalAlign = "center";

        var stackedEventLabel:Label = new Label();
        stackedEventLabel.text = "Allows you to find/switch to stacked events.";
        stackedEventLabel.verticalAlign = "center";

        var stackedEventDoes = new Label();
        stackedEventDoes.text = "Stacked Events Index";
        stackedEventDoes.verticalAlign = "left";

        var eventValueLabel = new Label();
        eventValueLabel.text = "The value that the modifier will change to.";
        eventValueLabel.verticalAlign = "center";

        var eventModLabel = new Label();
        eventModLabel.text = "The name of the modifier used in the event.";
        eventModLabel.verticalAlign = "center";
        
        var repeatBeatGapLabel:Label = new Label();
        repeatBeatGapLabel.text = "repeatBeatGap";
        repeatBeatGapLabel.verticalAlign = "center";

        var repeatCheckLabel:Label = new Label();
        repeatCheckLabel.text = "Check the box if you want the event to repeat.";
        repeatCheckLabel.verticalAlign = "center";

        var repeatBeatDoes:Label = new Label();
        repeatBeatDoes.text = "How many beats in between\neach repeat?";
        repeatBeatDoes.verticalAlign = "left";

        var repeatCountLabel:Label = new Label();
        repeatCountLabel.text = "repeatCount";
        repeatCountLabel.verticalAlign = "center";

        var repeatCountDoes:Label = new Label();
        repeatCountDoes.text = "How many times to repeat?";
        repeatCountDoes.verticalAlign = "left";

        var eventEaseLabel:Label = new Label();
        eventEaseLabel.text = 'The easing function used by the event (only for "ease" type).';
        eventEaseLabel.verticalAlign = "center";

        var eventEaseDoes:Label = new Label();
        eventEaseDoes.text = "Event Ease";
        eventEaseDoes.verticalAlign = "left";

        var eventTimeLabel:Label = new Label();
        eventTimeLabel.text = 'How long the tween takes to finish in beats (only for "ease" type).';
        eventTimeLabel.verticalAlign = "center";

        var eventTimeDoes:Label = new Label();
        eventTimeDoes.text = "Event Ease Time (in Beats)";
        eventTimeDoes.verticalAlign = "left";

        var eventTimeStepLabel:Label = new Label();
        eventTimeStepLabel.text = 'The beat that the event occurs on.';
        eventTimeStepLabel.verticalAlign = "left";

        var selectedEventLabel:Label = new Label();
        selectedEventLabel.text = 'Which modifier event is selected within the event.';
        selectedEventLabel.verticalAlign = "center";

        var subModDropLabel:Label = new Label();
        subModDropLabel.text = 'Drop down for sub mods on the currently selected modifier, not all mods have them.';
        subModDropLabel.verticalAlign = "center";

        var eventModDropLabel:Label = new Label();
        eventModDropLabel.text = 'Drop down for stored modifiers.';
        eventModDropLabel.verticalAlign = "center";

        var eventTypeDropLabel:Label = new Label();
        eventTypeDropLabel.text = 'Drop down to switch the event type, in "set" an event is instant, in "ease", event is smooth with time.';
        eventTypeDropLabel.verticalAlign = "center";

        var eventTypeDropDoes:Label = new Label();
        eventTypeDropDoes.text = "Event Type";
        eventTypeDropDoes.verticalAlign = "left";

        var easeDropLabel:Label = new Label();
        easeDropLabel.text = 'Drop down that stores all the built-in easing functions.';
        easeDropLabel.verticalAlign = "center";

        //Blockers
        var textNeedsBlock:Array<TextField> = [eventDataInputText, eventValueInputText, eventModInputText, eventEaseInputText, eventTimeInputText];
        for (blockedText in 0...textNeedsBlock.length) textBlockers.push(textNeedsBlock[blockedText]);

        var dropDownNeedsBlock:Array<DropDown> = [subModDropDown, eventModifierDropDown, eventTypeDropDown, easeDropDown];
        for (blockedMenu in 0...dropDownNeedsBlock.length) scrollBlockers.push(dropDownNeedsBlock[blockedMenu]);

        var stepperNeedsBlock:Array<NumberStepper> = [stackedEventStepper, repeatBeatGapStepper, repeatCountStepper, eventTimeStepper, 
        selectedEventDataStepper];
        for (blockedStep in 0...stepperNeedsBlock.length) stepperBlockers.push(stepperNeedsBlock[blockedStep]);
        
        //Components
        vbox1.addComponent(addStackedLabel);
        vbox1.addComponent(addStacked);
        vbox1.addComponent(eventDataLabel);
        vbox1.addComponent(eventDataInputText);
        vbox1.addComponent(stackedEventLabel);
        vbox1.addComponent(stackedEventStepper);
        vbox1.addComponent(stackedEventDoes);
        vbox1.addComponent(eventValueLabel);
        vbox1.addComponent(eventValueInputText);
        vbox1.addComponent(eventModLabel);
        vbox1.addComponent(eventModInputText);
        vbox1.addComponent(selectedEventLabel);
        vbox1.addComponent(selectedEventDataStepper);
        vbox1.addComponent(subModDropLabel);
        vbox1.addComponent(subModDropDown);
        vbox1.addComponent(eventModDropLabel);
        vbox1.addComponent(eventModifierDropDown);
        vbox1.addComponent(eventTypeDropLabel);
        vbox1.addComponent(eventTypeDropDown);
        vbox1.addComponent(eventTypeDropDoes);
        vbox1.addComponent(easeDropLabel);
        vbox1.addComponent(easeDropDown);
        vbox2.addComponent(addEventButton);
        vbox2.addComponent(removeEventButton);
        vbox2.addComponent(repeatBeatGapLabel);
        vbox2.addComponent(repeatBeatGapStepper);
        vbox2.addComponent(repeatBeatDoes);
        vbox2.addComponent(repeatCheckLabel);
        vbox2.addComponent(repeatCheckbox);
        vbox2.addComponent(repeatCountLabel);
        vbox2.addComponent(repeatCountStepper);
        vbox2.addComponent(repeatCountDoes);
        vbox2.addComponent(eventEaseLabel);
        vbox2.addComponent(eventEaseInputText);
        vbox2.addComponent(eventEaseDoes);
        vbox2.addComponent(eventTimeLabel);
        vbox2.addComponent(eventTimeInputText);
        vbox2.addComponent(eventTimeDoes);
        vbox2.addComponent(eventTimeStepLabel);
        vbox2.addComponent(eventTimeStepper);

        grid.addComponent(vbox1);
        grid.addComponent(vbox2);
        //grid2.addComponent(vbox3);
        box2.addComponent(grid);
       // box2.addComponent(grid2);
    }

    inline function updateEventInputsOnChange()
    {
        updateEventModData(eventModInputText.text, true);
        var data = getCurrentEventInData();
        if (data != null)
        {
            highlightedEvent = data; 
            eventDataInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASEDATA];
            dirtyUpdateEvents = true;
            hasUnsavedChanges = true;
        }
    }

    inline function updateModList()
    {
        mods = [];
        for (i in 0...playfieldRenderer.modchart.data.modifiers.length) mods.push(playfieldRenderer.modchart.data.modifiers[i][MOD_NAME]);
        if (mods.length == 0) mods.push('');

        var newModsList = new ArrayDataSource<Dynamic>();
        for (mod in 0...mods.length)
        {
            newModsList.add(mods[mod]);
        }
        if (modifierDropDown != null) modifierDropDown.dataSource = newModsList;
        if (eventModifierDropDown != null) eventModifierDropDown.dataSource = newModsList;

    }
    inline function updateSubModList(modName:String)
    {
        subMods = [""];
        if (playfieldRenderer.modifierTable.modifiers.exists(modName))
        {
            for (subModName => subMod in playfieldRenderer.modifierTable.modifiers.get(modName).subValues)
            {
                subMods.push(subModName);
            }
        }
        var newSubModsList = new ArrayDataSource<Dynamic>();
        for (subMod in 0...subMods.length)
        {
            newSubModsList.add(subMods[subMod]);
        }
        if (subModDropDown != null) subModDropDown.dataSource = newSubModsList;
    }
    inline function setupModifierUI()
    {
        var vbox1:VBox = new VBox();
        var vbox2:VBox = new VBox();

        var grid:Grid = new Grid();

        for (i in 0...playfieldRenderer.modchart.data.modifiers.length) mods.push(playfieldRenderer.modchart.data.modifiers[i][MOD_NAME]);
        if (mods.length == 0) mods.push('');

        modClassInputText.onChange = function(e)
        {
            if (modClassInputText.text != '')
                explainText.text = ('Current Modifier: ${modClassInputText.text}, Explaination: ' + modifierExplain(modClassInputText.text));
        }

        playfieldStepper.min = -1;
        playfieldStepper.max = 100;
        playfieldStepper.step = 1;
        playfieldStepper.pos = -1;
        targetLaneStepper.min = -1;
        targetLaneStepper.max = 100;
        targetLaneStepper.step = 1;
        targetLaneStepper.pos = -1;

        var modsList = new ArrayDataSource<Dynamic>();
        for (mod in 0...mods.length)
        {
            modsList.add(mods[mod]);
        }

        modifierDropDown.text = "";
        modifierDropDown.width = 140;
        modifierDropDown.dataSource = modsList;
        modifierDropDown.selectedIndex = 0;
        modifierDropDown.onChange = function(e)
        {
            var modName = mods[modifierDropDown.selectedIndex];
            for (i in 0...playfieldRenderer.modchart.data.modifiers.length)
                if (playfieldRenderer.modchart.data.modifiers[i][MOD_NAME] == modName)
                    currentModifier = playfieldRenderer.modchart.data.modifiers[i];

            if (currentModifier != null)
            {
                //trace(currentModifier);
                modNameInputText.text = currentModifier[MOD_NAME];
                modClassInputText.text = currentModifier[MOD_CLASS];
                modTypeInputText.text = currentModifier[MOD_TYPE];
                playfieldStepper.pos = currentModifier[MOD_PF];
                if (currentModifier[MOD_LANE] != null)
                    targetLaneStepper.pos = currentModifier[MOD_LANE];
            }   
        }

        var refreshModifiers:Button = new Button();
        refreshModifiers.text = 'Refresh Modifiers';
        refreshModifiers.onClick = function(e)
        {
            updateModList();
        }

        var saveModifier:Button = new Button();
        saveModifier.text = 'Save Modifier';
        saveModifier.onClick = function(e)
        {
            var alreadyExists = false;
            for (i in 0...playfieldRenderer.modchart.data.modifiers.length)
                if (playfieldRenderer.modchart.data.modifiers[i][MOD_NAME] == modNameInputText.text)
                {
                    playfieldRenderer.modchart.data.modifiers[i] = [modNameInputText.text, modClassInputText.text, 
                        modTypeInputText.text, playfieldStepper.pos, targetLaneStepper.pos];
                    alreadyExists = true;
                }

            if (!alreadyExists)
            {
                playfieldRenderer.modchart.data.modifiers.push([modNameInputText.text, modClassInputText.text, 
                modTypeInputText.text, playfieldStepper.pos, targetLaneStepper.pos]);
            }
            dirtyUpdateModifiers = true;
            updateModList();
            hasUnsavedChanges = true;
        }

        var removeModifier:Button = new Button();
        removeModifier.text = 'Remove Modifier';
        removeModifier.onClick = function(e)
        {
            for (i in 0...playfieldRenderer.modchart.data.modifiers.length)
                if (playfieldRenderer.modchart.data.modifiers[i][MOD_NAME] == modNameInputText.text)
                {
                    playfieldRenderer.modchart.data.modifiers.remove(playfieldRenderer.modchart.data.modifiers[i]);
                }
            dirtyUpdateModifiers = true;
            updateModList();
            hasUnsavedChanges = true;
        }

        var modClassList:Array<String> = [];
        for (i in 0...modifierList.length)
        {
            modClassList.push(Std.string(modifierList[i]).replace("modcharting.", ""));
        }

        var modClassDropList = new ArrayDataSource<Dynamic>();
        for (mod in 0...modClassList.length)
        {
            modClassDropList.add(modClassList[mod]);
        }
            
        var modClassDropDown = new DropDown();
        modClassDropDown.text = "";
        modClassDropDown.width = 140;
        modClassDropDown.dataSource = modClassDropList;
        modClassDropDown.selectedIndex = 0;
        modClassDropDown.onChange = function(e)
        {
            modClassInputText.text = modClassList[modClassDropDown.selectedIndex];
        }

        var modTypeList = ["All", "Player", "Opponent", "Lane"];

        var modTypeDropList = new ArrayDataSource<Dynamic>();
        for (type in 0...modTypeList.length)
        {
            modTypeDropList.add(modTypeList[type]);
        }
        var modTypeDropDown = new DropDown();
        modTypeDropDown.text = "";
        modTypeDropDown.width = 80;
        modTypeDropDown.dataSource = modTypeDropList;
        modTypeDropDown.selectedIndex = 0;
        modTypeDropDown.onChange = function(e)
        {
            modTypeInputText.text = modTypeList[modTypeDropDown.selectedIndex];
        }

        var modNameLabel:Label = new Label();
        modNameLabel.text = "Modifier Name";
        modNameLabel.verticalAlign = "center";

        var modClassLabel:Label = new Label();
        modClassLabel.text = "Modifier Class";
        modClassLabel.verticalAlign = "center";

        var modTypeLabel:Label = new Label();
        modTypeLabel.text = "Modifier Type";
        modTypeLabel.verticalAlign = "center";

        var playfieldLabel:Label = new Label();
        playfieldLabel.text = "Playfield (-1 = all)";
        playfieldLabel.verticalAlign = "center";

        var playfieldLabel2:Label = new Label();
        playfieldLabel2.text = "Playfield number starts at 0!";
        playfieldLabel2.verticalAlign = "left";

        var targetLaneLabel:Label = new Label();
        targetLaneLabel.text = "Target Lane (only for Lane mods!)";
        targetLaneLabel.verticalAlign = "center";

        var textNeedsBlock:Array<TextField> = [modNameInputText, modClassInputText, modTypeInputText];
        for (blockedText in 0...textNeedsBlock.length) textBlockers.push(textNeedsBlock[blockedText]);

        var dropDownNeedsBlock:Array<DropDown> = [modifierDropDown, modClassDropDown, modTypeDropDown];
        for (blockedMenu in 0...dropDownNeedsBlock.length) scrollBlockers.push(dropDownNeedsBlock[blockedMenu]);

        var stepperNeedsBlock:Array<NumberStepper> = [playfieldStepper, targetLaneStepper];
        for (blockedStep in 0...stepperNeedsBlock.length) stepperBlockers.push(stepperNeedsBlock[blockedStep]);

        vbox1.addComponent(explainText);

        vbox1.addComponent(modNameLabel);
        vbox1.addComponent(modNameInputText);
        vbox1.addComponent(modClassLabel);
        vbox1.addComponent(modClassInputText);
        vbox1.addComponent(modTypeLabel);
        vbox1.addComponent(modTypeInputText);
        vbox1.addComponent(playfieldLabel);
        vbox1.addComponent(playfieldStepper);
        vbox1.addComponent(playfieldLabel2);
        vbox1.addComponent(targetLaneLabel);
        vbox1.addComponent(targetLaneStepper);

        vbox1.addComponent(refreshModifiers);
        vbox1.addComponent(saveModifier);
        vbox1.addComponent(removeModifier);
        vbox1.addComponent(activeModifiersText);

        vbox2.addComponent(modifierDropDown);
        vbox2.addComponent(modClassDropDown);
        vbox2.addComponent(modTypeDropDown);

        grid.addComponent(vbox1);
        grid.addComponent(vbox2);
        box3.addComponent(grid);
    }

    //Thanks to glowsoony for the idea lol
    function modifierExplain(modifiersName:String):String
    {
        var explainString:String = '';

        switch modifiersName
        {
            case 'DrunkXModifier':
		        explainString = "Modifier used to do a wave at X poss of the notes and targets";
            case 'DrunkYModifier':
		        explainString = "Modifier used to do a wave at Y poss of the notes and targets";
            case 'DrunkZModifier':
		        explainString = "Modifier used to do a wave at Z (Far, Close) poss of the notes and targets";
            case 'TipsyXModifier':
		        explainString = "Modifier similar to DrunkX but don't affect notes poss";
            case 'TipsyYModifier':
		        explainString = "Modifier similar to DrunkY but don't affect notes poss";
            case 'TipsyZModifier':
		        explainString = "Modifier similar to DrunkZ but don't affect notes poss";
            case 'ReverseModifier':
		        explainString = "Flip the scroll type (Upscroll/Downscroll)";
            case 'SplitModifier':
		        explainString = "Flip the scroll type (HalfUpscroll/HalfDownscroll)";
            case 'CrossModifier':
		        explainString = "Flip the scroll type (Upscroll/Downscroll/Downscroll/Upscroll)";
            case 'AlternateModifier':
		        explainString = "Flip the scroll type (Upscroll/Downscroll/Upscroll/Downscroll)";
            case 'IncomingAngleModifier':
		        explainString = "Modifier that changes how notes come to the target (if X and Y aplied it will use Z)";
            case 'RotateModifier': 
		        explainString = "Modifier used to rotate the lanes poss between a value aplied with rotatePoint (can be used with Y and X)";
            case 'StrumLineRotateModifier':
		        explainString = "Modifier similar to RotateModifier but this one doesn't need a extra value (can be used with Y, X and Z)";
            case 'BumpyModifier':
		        explainString = "Modifier used to make notes jump a bit in their own Perspective poss";
            case 'XModifier':
		        explainString = "Moves notes and targets X";
            case 'YModifier':
		        explainString = "Moves notes and targets Y";
            case 'YDModifier':
                explainString = "Moves notes and targets Y (Automatically reverses in downscroll)";
            case 'ZModifier':
		        explainString = "Moves notes and targets Z (Far, Close)";
            case 'ConfusionModifier':
		        explainString = "Changes notes and targets angle";
            case 'DizzyModifier':
                explainString = "Changes notes angle making a visual on them";
            case 'ScaleModifier':
		        explainString = "Modifier used to make notes and targets bigger or smaller";
            case 'ScaleXModifier':
		        explainString = "Modifier used to make notes and targets bigger or smaller (Only in X)";
            case 'ScaleYModifier':
		        explainString = "Modifier used to make notes and targets bigger or smaller (Only in Y)";
            case 'SpeedModifier':
		        explainString = "Modifier used to make notes be faster or slower";
            case 'StealthModifier':
		        explainString = "Modifier used to change notes and targets alpha";
            case 'NoteStealthModifier':
		        explainString = "Modifier used to change notes alpha";
            case 'LaneStealthModifier':
		        explainString = "Modifier used to change targets alpha";
            case 'InvertModifier':
		        explainString = "Modifier used to invert notes and targets X poss (down/left/right/up)";
            case 'FlipModifier':
		        explainString = "Modifier used to flip notes and targets X poss (right/up/down/left)";
            case 'MiniModifier':
		        explainString = "Modifier similar to ScaleModifier but this one does Z perspective";
            case 'ShrinkModifier':
		        explainString = "Modifier used to add a boost of the notes (the more value the less scale it will be at the start)";
            case 'BeatXModifier':
		        explainString = "Modifier used to move notes and targets X with a small jump effect";
            case 'BeatYModifier':
		        explainString = "Modifier used to move notes and targets Y with a small jump effect";
            case 'BeatZModifier':
		        explainString = "Modifier used to move notes and targets Z with a small jump effect";
            case 'BounceXModifier':
		        explainString = "Modifier similar to beatX but it only affect notes X with a jump effect";
            case 'BounceYModifier':
		        explainString = "Modifier similar to beatY but it only affect notes Y with a jump effect";
            case 'BounceZModifier':
		        explainString = "Modifier similar to beatZ but it only affect notes Z with a jump effect";
            case 'EaseCurveModifier':
		        explainString = "This enables the EaseModifiers";
            case 'EaseCurveXModifier':
		        explainString = "Modifier similar to IncomingAngleMod (X), it will make notes come faster at X poss";
            case 'EaseCurveYModifier':
		        explainString = "Modifier similar to IncomingAngleMod (Y), it will make notes come faster at Y poss";
            case 'EaseCurveZModifier':
		        explainString = "Modifier similar to IncomingAngleMod (X+Y), it will make notes come faster at Z perspective";
            case 'EaseCurveScaleModifier':
		        explainString = "Modifier similar to All easeCurve, it will make notes scale change, usually next to target";
            case 'EaseCurveAngleModifier':
		        explainString = "Modifier similar to All easeCurve, it will make notes angle change, usually next to target";
            case 'InvertSineModifier':
		        explainString = "Modifier used to do a curve in the notes it will be different for notes (Down and Right / Left and Up)";
            case 'BoostModifier':
		        explainString = "Modifier used to make notes come faster to target";
            case 'BrakeModifier':
		        explainString = "Modifier used to make notes come slower to target";
            case 'BoomerangModifier':
		        explainString = "Modifier used to make notes come in reverse to target";
            case 'WaveingModifier':
		        explainString = "Modifier used to make notes come faster and slower to target";
            case 'JumpModifier':
		        explainString = "Modifier used to make notes and target jump";
            case 'WaveXModifier':
		        explainString = "Modifier similar to drunkX but this one will simulate a true wave in X (don't affect the notes)";
            case 'WaveYModifier':
		        explainString = "Modifier similar to drunkY but this one will simulate a true wave in Y (don't affect the notes)";
            case 'WaveZModifier':
		        explainString = "Modifier similar to drunkZ but this one will simulate a true wave in Z (don't affect the notes)";
            case 'TimeStopModifier':
		        explainString = "Modifier used to stop the notes at the top/bottom part of your screen to make it hard to read";
            case 'StrumAngleModifier':
		        explainString = "Modifier combined between strumRotate, Confusion, IncomingAngleY, making a rotation easily";
            case 'JumpTargetModifier':
		        explainString = "Modifier similar to jump but only target aplied";
            case 'JumpNotesModifier':
		        explainString = "Modifier similar to jump but only notes aplied";
            case 'EaseXModifier':
		        explainString = "Modifier used to make notes go left to right on the screen";
            case 'EaseYModifier':
		        explainString = "Modifier used to make notes go up to down on the screen";
            case 'EaseZModifier':
		        explainString = "Modifier used to make notes go far to near right on the screen";
            case 'HiddenModifier':
                explainString = "Modifier used to make an alpha boost on notes";
            case 'SuddenModifier':
                explainString = "Modifier used to make an alpha brake on notes";
            case 'VanishModifier':
                explainString = "Modifier fushion between sudden and hidden";
            case 'SkewModifier':
                explainString = "Modifier used to make note effects (skew)";
            case 'SkewXModifier':
                explainString = "Modifier based from SkewModifier but only in X";
            case 'SkewYModifier':
                explainString = "Modifier based from SkewModifier but only in Y";
            case 'NotesModifier':
                explainString = "Modifier based from other modifiers but only affects notes and no targets";
            case 'LanesModifier':
                explainString = "Modifier based from other modifiers but only affects targets and no notes";
            case 'StrumsModifier':
                explainString = "Modifier based from other modifiers but affects targets and notes";
            case 'TanDrunkXModifier':
                explainString = "Modifier similar to drunk but uses tan instead of sin in X";
            case 'TanDrunkYModifier':
                explainString = "Modifier similar to drunk but uses tan instead of sin in Y";
            case 'TanDrunkZModifier':
                explainString = "Modifier similar to drunk but uses tan instead of sin in Z";
            case 'TanWaveXModifier':
                explainString = "Modifier similar to wave but uses tan instead of sin in X";
            case 'TanWaveYModifier':
                explainString = "Modifier similar to wave but uses tan instead of sin in Y";
            case 'TanWaveZModifier':
                explainString = "Modifier similar to wave but uses tan instead of sin in Z";
            case 'TwirlModifier':
                explainString = "Modifier that makes the notes incoming rotating in a circle in X";
            case 'RollModifier':
                explainString = "Modifier that makes the notes incoming rotating in a circle in Y";
            case 'BlinkModifier':
                explainString = "Modifier that makes the notes alpha go to 0 and go back to 1 constantly";
            case 'CosecantXModifier':
                explainString = "Modifier similar to TanDrunk but uses cosecant instead of tan in X";
            case 'CosecantYModifier':
                explainString = "Modifier similar to TanDrunk but uses cosecant instead of tan in Y";
            case 'CosecantZModifier':
                explainString = "Modifier similar to TanDrunk but uses cosecant instead of tan in Z";
            case 'TanDrunkAngleModifier':
                explainString = "Modifier similar to TanDrunk but in angle";
            case 'DrunkAngleModifier':
                explainString = "Modifier similar to Drunk but in angle";
            case 'WaveAngleModifier':
                explainString = "Modifier similar to Wave but in angle";
            case 'TanWaveAngleModifier':
                explainString = "Modifier similar to TanWave but in angle";
            case 'ShakyNotesModifier':
                explainString = "Modifier used to make notes shake in their on possition";
            case 'TordnadoModifier':
                explainString = "Modifier similar to invertSine, but notes will do their own path instead";
            case 'ArrowPath':
                explainString = "This modifier its able to make custom paths for the mods so this should be a very helpful tool";
        }

       return explainString;
    }

    function setupPlayfieldUI()
    {
        var vbox1:VBox = new VBox();

        playfieldCountStepper.min = 1;
        playfieldCountStepper.max = 100;
        playfieldCountStepper.step = 1;
        playfieldCountStepper.pos = playfieldRenderer.modchart.data.playfields;

        var playfieldLabel:Label = new Label();
        playfieldLabel.text = "Don't add too many or the game will lag!!!";
        playfieldLabel.verticalAlign = "center";

        var playfieldDoes:Label = new Label();
        playfieldDoes.text = "Playfield Count";
        playfieldDoes.verticalAlign = "center";

        stepperBlockers.push(playfieldCountStepper);

        vbox1.addComponent(playfieldDoes);
        vbox1.addComponent(playfieldCountStepper);
        vbox1.addComponent(playfieldLabel);
        box4.addComponent(vbox1);
    }

    function getCurrentEventInData() //find stored data to match with highlighted event
    {
        if (highlightedEvent == null)
            return null;
        for (i in 0...playfieldRenderer.modchart.data.events.length)
        {
            if (playfieldRenderer.modchart.data.events[i] == highlightedEvent)
            {
                return playfieldRenderer.modchart.data.events[i];
            }
        }

        return null;
    }
    function getMaxEventModDataLength() //used for the stepper so it doesnt go over max and break something
    {
        var data = getCurrentEventInData();
        if (data != null)
        {
            var dataStr:String = findCorrectModData(data);
            var dataSplit = dataStr.split(',');
            return Math.floor((dataSplit.length/2)-1);
        }
        return 0;
    }
    function updateSelectedEventDataStepper() //update the stepper
    {
        selectedEventDataStepper.max = getMaxEventModDataLength();
        if (selectedEventDataStepper.pos > selectedEventDataStepper.max) selectedEventDataStepper.pos = 0;
    }
    function updateStackedEventDataStepper() //update the stepper
    {
        stackedEventStepper.max = stackedHighlightedEvents.length-1;
        stackedEventStepper.pos = stackedEventStepper.max; //when you select an event, if theres stacked events it should be the one at the end of the list so just set it to the end
    }
    function getEventModIndex() { return Math.floor(selectedEventDataStepper.pos); }
    var eventTypes:Array<String> = ["ease", "set"];

    /**
     * Has things that need to init first than others
     * SelectedEventStepper, eventTimeIT, EDIT, ETDD, EMIT, EVIT, RBGS. RCS, RCB, StackedEventStepper
     * @param fromStackedEventStepper = false 
     */
    function onSelectEvent(fromStackedEventStepper = false)
    {
        //update texts and stuff
        updateSelectedEventDataStepper();
        eventTimeStepper.pos = highlightedEvent[EVENT_DATA][EVENT_TIME];
        eventDataInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASEDATA];

        if (highlightedEvent[EVENT_TYPE] == 'ease')
        {
            eventEaseInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASE];
            eventTimeInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASETIME];
        }
        eventTypeDropDown.selectedItem = highlightedEvent[EVENT_TYPE];
        eventModInputText.text = getEventModData(true);
        eventValueInputText.text = getEventModData(false);
        repeatBeatGapStepper.pos = highlightedEvent[EVENT_REPEAT][EVENT_REPEATBEATGAP];
        repeatCountStepper.pos = highlightedEvent[EVENT_REPEAT][EVENT_REPEATCOUNT];
        repeatCheckbox.selected = highlightedEvent[EVENT_REPEAT][EVENT_REPEATBOOL];
        if (!fromStackedEventStepper) stackedEventStepper.pos = 0;
        dirtyUpdateEvents = true;
    }

    var _file:FileReference;
    public function saveModchartJson(?instance:ModchartMusicBeatState = null) : Void
    {
        if (instance == null)
            instance = PlayState.instance;

		var data:String = Json.stringify(instance.playfieldRenderer.modchart.data, "\t");
        //data = data.replace("\n", "");
        //data = data.replace(" ", "");
        #if sys
        //sys.io.File.saveContent("modchart.json", data.trim()); 
		if ((data != null) && (data.length > 0))
        {
            _file = new FileReference();
            _file.addEventListener(#if desktop openfl.events.Event.SELECT #else openfl.events.Event.COMPLETE #end, onSaveComplete);
            _file.addEventListener(openfl.events.Event.CANCEL, onSaveCancel);
            _file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
            _file.save(data.trim(), "modchart.json");
        }
        #end

        hasUnsavedChanges = false;
        
    }
    function onSaveComplete(_):Void
    {
        _file.removeEventListener(#if desktop openfl.events.Event.SELECT #else openfl.events.Event.COMPLETE #end, onSaveComplete);
        _file.removeEventListener(openfl.events.Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
    }

    /**
     * Called when the save file dialog is cancelled.
     */
    function onSaveCancel(_):Void
    {
        _file.removeEventListener(#if desktop openfl.events.Event.SELECT #else openfl.events.Event.COMPLETE #end, onSaveComplete);
        _file.removeEventListener(openfl.events.Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
    }

    /**
     * Called if there is an error while saving the gameplay recording.
     */
    function onSaveError(_):Void
    {
        _file.removeEventListener(#if desktop openfl.events.Event.SELECT #else openfl.events.Event.COMPLETE #end, onSaveComplete);
        _file.removeEventListener(openfl.events.Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
    }   
}
class ModchartEditorExitSubstate extends MusicBeatSubstate
{
    var exitFunc:Void->Void;
    override public function new(funcOnExit:Void->Void)
    {
        exitFunc = funcOnExit;
        super();
    }
    
    override public function create()
    {
        super.create();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);
        FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});


        var warning:FlxText = new FlxText(0, 0, 0, 'You have unsaved changes!\nAre you sure you want to exit?', 48);
        warning.alignment = CENTER;
        warning.screenCenter();
        warning.y -= 150;
        add(warning);

        var goBackButton:FlxUIButton = new FlxUIButton(0, 500, 'Go Back', function()
        {
            close();
        });
        goBackButton.scale.set(2.5, 2.5);
        goBackButton.updateHitbox();
        goBackButton.label.size = 12;
        goBackButton.autoCenterLabel();
        goBackButton.x = (FlxG.width*0.3)-(goBackButton.width*0.5);
        add(goBackButton);
        
        var exit:FlxUIButton = new FlxUIButton(0, 500, 'Exit without saving', function()
        {
            exitFunc();
        });
        exit.scale.set(2.5, 2.5);
        exit.updateHitbox();
        exit.label.size = 12;
        exit.label.fieldWidth = exit.width;
        exit.autoCenterLabel();
        
        exit.x = (FlxG.width*0.7)-(exit.width*0.5);
        add(exit);

        cameras = [FlxG.cameras.list[FlxG.cameras.list.length-1]];
    }
}