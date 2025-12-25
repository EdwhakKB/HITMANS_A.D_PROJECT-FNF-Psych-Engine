package modcharting;

import states.subs.MusicBeatSubstate;
import engine.Song.SwagSection;
import engine.Song;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSort;
import lime.utils.Assets;
import modcharting.*;
import modcharting.ModchartFile;
import modcharting.Modifier;
import modcharting.modifiers.*;
import modcharting.PlayfieldRenderer.StrumNoteType;
import objects.Note;
import objects.StrumNote;
import openfl.display.BitmapData;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.geom.Rectangle;
import openfl.net.FileReference;
import ui.*;
import haxe.rtti.Meta;
import flixel.text.FlxText.FlxTextAlign;

class ModchartEditorEvent extends FlxSprite
{
	public var data:Array<Dynamic>;

	public function new(data:Array<Dynamic>)
	{
		this.data = data;
		super(-300, 0);
		frames = Paths.getSparrowAtlas('eventArrowModchart');
		animation.addByPrefix('note', 'idle0');
		// makeGraphic(48, 48);

		animation.play('note');
		setGraphicSize(ModchartEditorState.gridSize, ModchartEditorState.gridSize);
		updateHitbox();
		antialiasing = true;
	}

	public function getBeatTime():Float
	{
		return data[ModchartFile.EVENT_DATA][ModchartFile.EVENT_TIME];
	}
}

class ModchartEditorState extends MusicBeatState
{
	var hasUnsavedChanges:Bool = false;

	override function closeSubState()
	{
		persistentUpdate = true;
		super.closeSubState();
	}

	public static function getBPMFromSeconds(time:Float)
	{
		return Conductor.getBPMFromSeconds(time);
	}

	// public static var modifierList:Array<Class<Modifier>> = ModchartMacros.getModifierList();
	// getAllClasses output its a haxe.ds.List so thats why im using another loop
	// ALSO, THE LIST IS UNSORTED !!
	// public static var modifierList:Array<Class<Modifier>> = [
	// 	for (cls in CompileTime.getAllClasses('modcharting', true, modcharting.Modifier))
	// 		cls
	// ];
	//public static var modifierList:Array<Class<Modifier>> = [for (cls in CompileTime.getAllClasses('modcharting.modifiers', true, modcharting.Modifier)) cls];
	// public static var modifierList:Array<Class<Modifier>> = (function() {
	// 	var modifiers:Array<Class<Modifier>> = [];
	// 	var packagePath = "modcharting.modifiers";
		
	// 	#if haxe_boot
	// 	var classNames:Array<String> = Reflect.field(Type, "allClassesInPackage").get(packagePath);
	// 	#else
	// 	var classNames:Array<String> = [];
	// 	#end

	// 	for (className in classNames) {
	// 		if (className.indexOf("Modifier") != -1) {
	// 			var cls = Type.resolveClass(packagePath + "." + className);
				
	// 			if (cls != null && Std.is(Type.createEmptyInstance(cls), Modifier)) {
	// 				modifiers.push(cast cls);
	// 			}
	// 		}
	// 	}
	// 	return modifiers;
	// })();

	public static var modifierList:Array<Class<Modifier>> = [
		modcharting.modifiers.Transform.TransformModifier,modcharting.modifiers.Transform.NoteOffsetModifier,modcharting.modifiers.Transform.StrumOffsetModifier,
		modcharting.modifiers.Transform.MoveXModifier,modcharting.modifiers.Transform.MoveYModifier,modcharting.modifiers.Transform.MoveYDModifier,modcharting.modifiers.Transform.MoveZModifier,
		modcharting.modifiers.Transform.XModifier,modcharting.modifiers.Transform.YModifier,modcharting.modifiers.Transform.YDModifier,modcharting.modifiers.Transform.ZModifier,

		modcharting.modifiers.Confusion.AngleModifier,modcharting.modifiers.Confusion.AngleXModifier,modcharting.modifiers.Confusion.AngleYModifier,
		modcharting.modifiers.Confusion.ConfusionModifier,modcharting.modifiers.Confusion.ConfusionXModifier,modcharting.modifiers.Confusion.ConfusionYModifier,
		modcharting.modifiers.Confusion.ConfusionOffsetModifier,modcharting.modifiers.Confusion.ConfusionOffsetXModifier,modcharting.modifiers.Confusion.ConfusionOffsetYModifier,
		modcharting.modifiers.Confusion.DizzyModifier,modcharting.modifiers.Confusion.TwirlModifier,modcharting.modifiers.Confusion.RollModifier,

		modcharting.modifiers.Scale.MiniModifier,modcharting.modifiers.Scale.ShrinkModifier,
		modcharting.modifiers.Scale.TinyModifier,modcharting.modifiers.Scale.TinyXModifier,modcharting.modifiers.Scale.TinyYModifier,
		modcharting.modifiers.Scale.ScaleModifier,modcharting.modifiers.Scale.ScaleXModifier,modcharting.modifiers.Scale.ScaleYModifier,

		modcharting.modifiers.Skew.SkewModifier,modcharting.modifiers.Skew.SkewXModifier,modcharting.modifiers.Skew.SkewYModifier,
		modcharting.modifiers.Skew.SkewFieldXModifier,modcharting.modifiers.Skew.SkewFieldYModifier,

		modcharting.modifiers.Scroll.SpeedModifier,
		modcharting.modifiers.Scroll.BoostModifier,modcharting.modifiers.Scroll.BrakeModifier,modcharting.modifiers.Scroll.BoomerangModifier,modcharting.modifiers.Scroll.WaveModifier,modcharting.modifiers.Scroll.ExpandModifier,
		modcharting.modifiers.Scroll.JumpModifier,modcharting.modifiers.Scroll.JumpStrumsModifier,modcharting.modifiers.Scroll.JumpNotesModifier,modcharting.modifiers.Scroll.DrivenModifier,
		modcharting.modifiers.Scroll.TimeStopModifier,
		modcharting.modifiers.Scroll.ParalysisModifier,
		modcharting.modifiers.Scroll.CenterModifier,modcharting.modifiers.Scroll.Center2Modifier,
		modcharting.modifiers.Scroll.ReceptorScrollModifier,

		modcharting.modifiers.Stealth.AlphaModifier,modcharting.modifiers.Stealth.NoteAlphaModifier,modcharting.modifiers.Stealth.StrumAlphaModifier,
		modcharting.modifiers.Stealth.StealthModifier,modcharting.modifiers.Stealth.DarkModifier,modcharting.modifiers.Stealth.FlashModifier,
		modcharting.modifiers.Stealth.StealthColorModifier,modcharting.modifiers.Stealth.DarkColorModifier,modcharting.modifiers.Stealth.FlashColorModifier,
		modcharting.modifiers.Stealth.SuddenModifier,modcharting.modifiers.Stealth.HiddenModifier,modcharting.modifiers.Stealth.VanishModifier,modcharting.modifiers.Stealth.BlinkModifier,

		modcharting.modifiers.FlipVert.FlipModifier,modcharting.modifiers.FlipVert.InvertModifier,
		modcharting.modifiers.FlipVert.VideoGamesModifier,modcharting.modifiers.FlipVert.RealGamesModifier,
		modcharting.modifiers.FlipVert.InvertSineModifier,modcharting.modifiers.FlipVert.FlipSineModifier,
		modcharting.modifiers.FlipVert.BlackSphereInvertModifier,modcharting.modifiers.FlipVert.BlackSphereFlipModifier,

		modcharting.modifiers.Incoming.EaseXModifier,modcharting.modifiers.Incoming.EaseYModifier,modcharting.modifiers.Incoming.EaseZModifier,
		modcharting.modifiers.Incoming.EaseAngleModifier,
		modcharting.modifiers.Incoming.EaseScaleModifier,modcharting.modifiers.Incoming.EaseScaleXModifier,modcharting.modifiers.Incoming.EaseScaleYModifier,
		modcharting.modifiers.Incoming.EaseSkewModifier,modcharting.modifiers.Incoming.EaseSkewXModifier,modcharting.modifiers.Incoming.EaseSkewYModifier,
		modcharting.modifiers.Incoming.LinearXModifier,modcharting.modifiers.Incoming.LinearYModifier,modcharting.modifiers.Incoming.LinearZModifier,
		modcharting.modifiers.Incoming.LinearScaleModifier,modcharting.modifiers.Incoming.LinearScaleXModifier,modcharting.modifiers.Incoming.LinearScaleYModifier,
		modcharting.modifiers.Incoming.LinearSkewModifier,modcharting.modifiers.Incoming.LinearSkewXModifier,modcharting.modifiers.Incoming.LinearSkewYModifier,
		modcharting.modifiers.Incoming.CircXModifier,modcharting.modifiers.Incoming.CircYModifier,modcharting.modifiers.Incoming.CircZModifier,
		modcharting.modifiers.Incoming.CircAngleModifier,modcharting.modifiers.Incoming.CircAngleXModifier,modcharting.modifiers.Incoming.CircAngleYModifier,
		modcharting.modifiers.Incoming.CircScaleModifier,modcharting.modifiers.Incoming.CircScaleXModifier,modcharting.modifiers.Incoming.CircScaleYModifier,
		modcharting.modifiers.Incoming.CircSkewModifier,modcharting.modifiers.Incoming.CircSkewXModifier,modcharting.modifiers.Incoming.CircSkewYModifier,
		modcharting.modifiers.Incoming.IncomingAngleModifier,

		modcharting.modifiers.Reverse.ReverseModifier,
		modcharting.modifiers.Reverse.SplitModifier,
		modcharting.modifiers.Reverse.CrossModifier,
		modcharting.modifiers.Reverse.AlternateModifier,

		modcharting.modifiers.Rotate.RotateModifier,modcharting.modifiers.Rotate.NoteRotateModifier,modcharting.modifiers.Rotate.StrumRotateModifier,
		modcharting.modifiers.Rotate.RotateFieldsModifier,modcharting.modifiers.Rotate.StrumLineRotateModifier,modcharting.modifiers.Rotate.RotateFields3DModifier,

		modcharting.modifiers.Drunk.DrunkXModifier,modcharting.modifiers.Drunk.DrunkYModifier,modcharting.modifiers.Drunk.DrunkZModifier,
		modcharting.modifiers.Drunk.DrunkAngleModifier,modcharting.modifiers.Drunk.DrunkAngleXModifier,modcharting.modifiers.Drunk.DrunkAngleYModifier,
		modcharting.modifiers.Drunk.DrunkScaleModifier,modcharting.modifiers.Drunk.DrunkScaleXModifier,modcharting.modifiers.Drunk.DrunkScaleYModifier,
		modcharting.modifiers.Drunk.DrunkSkewModifier,modcharting.modifiers.Drunk.DrunkSkewXModifier,modcharting.modifiers.Drunk.DrunkSkewYModifier,
		modcharting.modifiers.Drunk.TanDrunkXModifier,modcharting.modifiers.Drunk.TanDrunkYModifier,modcharting.modifiers.Drunk.TanDrunkZModifier,
		modcharting.modifiers.Drunk.TanDrunkAngleModifier,modcharting.modifiers.Drunk.TanDrunkAngleXModifier,modcharting.modifiers.Drunk.TanDrunkAngleYModifier,
		modcharting.modifiers.Drunk.TanDrunkScaleModifier,modcharting.modifiers.Drunk.TanDrunkScaleXModifier,modcharting.modifiers.Drunk.TanDrunkScaleYModifier,
		modcharting.modifiers.Drunk.TanDrunkSkewModifier,modcharting.modifiers.Drunk.TanDrunkSkewXModifier,modcharting.modifiers.Drunk.TanDrunkSkewYModifier,

		modcharting.modifiers.Tipsy.TipsyXModifier,modcharting.modifiers.Tipsy.TipsyYModifier,modcharting.modifiers.Tipsy.TipsyZModifier,
		modcharting.modifiers.Tipsy.TipsyAngleModifier,
		modcharting.modifiers.Tipsy.TipsyScaleModifier,modcharting.modifiers.Tipsy.TipsyScaleXModifier,modcharting.modifiers.Tipsy.TipsyScaleYModifier,
		modcharting.modifiers.Tipsy.TipsySkewModifier,modcharting.modifiers.Tipsy.TipsySkewXModifier,modcharting.modifiers.Tipsy.TipsySkewYModifier,
		modcharting.modifiers.Tipsy.TanTipsyXModifier,modcharting.modifiers.Tipsy.TanTipsyYModifier,modcharting.modifiers.Tipsy.TanTipsyZModifier,
		modcharting.modifiers.Tipsy.TanTipsyAngleModifier,
		modcharting.modifiers.Tipsy.TanTipsyScaleModifier,modcharting.modifiers.Tipsy.TanTipsyScaleXModifier,modcharting.modifiers.Tipsy.TanTipsyScaleYModifier,
		modcharting.modifiers.Tipsy.TanTipsySkewModifier,modcharting.modifiers.Tipsy.TanTipsySkewXModifier,modcharting.modifiers.Tipsy.TanTipsySkewYModifier,

		modcharting.modifiers.Sine.SineXModifier,modcharting.modifiers.Sine.SineYModifier,modcharting.modifiers.Sine.SineZModifier,
		modcharting.modifiers.Sine.SineAngleModifier,modcharting.modifiers.Sine.SineAngleXModifier,modcharting.modifiers.Sine.SineAngleYModifier,
		modcharting.modifiers.Sine.SineScaleModifier,modcharting.modifiers.Sine.SineScaleXModifier,modcharting.modifiers.Sine.SineScaleYModifier,
		modcharting.modifiers.Sine.SineSkewModifier,modcharting.modifiers.Sine.SineSkewXModifier,modcharting.modifiers.Sine.SineSkewYModifier,

		modcharting.modifiers.Wavy.WavyXModifier,modcharting.modifiers.Wavy.WavyYModifier,modcharting.modifiers.Wavy.WavyZModifier,
		modcharting.modifiers.Wavy.WavyAngleModifier,modcharting.modifiers.Wavy.WavyAngleXModifier,modcharting.modifiers.Wavy.WavyAngleYModifier,
		modcharting.modifiers.Wavy.WavyScaleModifier,modcharting.modifiers.Wavy.WavyScaleXModifier,modcharting.modifiers.Wavy.WavyScaleYModifier,
		modcharting.modifiers.Wavy.WavySkewModifier,modcharting.modifiers.Wavy.WavySkewXModifier,modcharting.modifiers.Wavy.WavySkewYModifier,
		modcharting.modifiers.Wavy.TanWavyXModifier,modcharting.modifiers.Wavy.TanWavyYModifier,modcharting.modifiers.Wavy.TanWavyZModifier,
		modcharting.modifiers.Wavy.TanWavyAngleModifier,modcharting.modifiers.Wavy.TanWavyAngleXModifier,modcharting.modifiers.Wavy.TanWavyAngleYModifier,
		modcharting.modifiers.Wavy.TanWavyScaleModifier,modcharting.modifiers.Wavy.TanWavyScaleXModifier,modcharting.modifiers.Wavy.TanWavyScaleYModifier,
		modcharting.modifiers.Wavy.TanWavySkewModifier,modcharting.modifiers.Wavy.TanWavySkewXModifier,modcharting.modifiers.Wavy.TanWavySkewYModifier,

		modcharting.modifiers.Beat.BeatXModifier,modcharting.modifiers.Beat.BeatYModifier,modcharting.modifiers.Beat.BeatZModifier,
		modcharting.modifiers.Beat.BeatAngleModifier,modcharting.modifiers.Beat.BeatAngleXModifier,modcharting.modifiers.Beat.BeatAngleYModifier,
		modcharting.modifiers.Beat.BeatScaleModifier,modcharting.modifiers.Beat.BeatScaleXModifier,modcharting.modifiers.Beat.BeatScaleYModifier,
		modcharting.modifiers.Beat.BeatSkewModifier,modcharting.modifiers.Beat.BeatSkewXModifier,modcharting.modifiers.Beat.BeatSkewYModifier,

		modcharting.modifiers.Bounce.BounceXModifier,modcharting.modifiers.Bounce.BounceYModifier,modcharting.modifiers.Bounce.BounceZModifier,
		modcharting.modifiers.Bounce.BounceAngleModifier,modcharting.modifiers.Bounce.BounceAngleXModifier,modcharting.modifiers.Bounce.BounceAngleYModifier,
		modcharting.modifiers.Bounce.BounceScaleModifier,modcharting.modifiers.Bounce.BounceScaleXModifier,modcharting.modifiers.Bounce.BounceScaleYModifier,
		modcharting.modifiers.Bounce.BounceSkewModifier,modcharting.modifiers.Bounce.BounceSkewXModifier,modcharting.modifiers.Bounce.BounceSkewYModifier,
		modcharting.modifiers.Bounce.TanBounceXModifier,modcharting.modifiers.Bounce.TanBounceYModifier,modcharting.modifiers.Bounce.TanBounceZModifier,
		modcharting.modifiers.Bounce.TanBounceAngleModifier,modcharting.modifiers.Bounce.TanBounceAngleXModifier,modcharting.modifiers.Bounce.TanBounceAngleYModifier,
		modcharting.modifiers.Bounce.TanBounceScaleModifier,modcharting.modifiers.Bounce.TanBounceScaleXModifier,modcharting.modifiers.Bounce.TanBounceScaleYModifier,
		modcharting.modifiers.Bounce.TanBounceSkewModifier,modcharting.modifiers.Bounce.TanBounceSkewXModifier,modcharting.modifiers.Bounce.TanBounceSkewYModifier,

		modcharting.modifiers.Bumpy.BumpyModifier,modcharting.modifiers.Bumpy.BumpyXModifier,modcharting.modifiers.Bumpy.BumpyYModifier,
		modcharting.modifiers.Bumpy.BumpyAngleModifier,modcharting.modifiers.Bumpy.BumpyAngleXModifier,modcharting.modifiers.Bumpy.BumpyAngleYModifier,
		modcharting.modifiers.Bumpy.BumpyScaleModifier,modcharting.modifiers.Bumpy.BumpyScaleXModifier,modcharting.modifiers.Bumpy.BumpyScaleYModifier,
		modcharting.modifiers.Bumpy.BumpySkewModifier,modcharting.modifiers.Bumpy.BumpySkewXModifier,modcharting.modifiers.Bumpy.BumpySkewYModifier,
		modcharting.modifiers.Bumpy.TanBumpyModifier,modcharting.modifiers.Bumpy.TanBumpyXModifier,modcharting.modifiers.Bumpy.TanBumpyYModifier,
		modcharting.modifiers.Bumpy.TanBumpyAngleModifier,modcharting.modifiers.Bumpy.TanBumpyAngleXModifier,modcharting.modifiers.Bumpy.TanBumpyAngleYModifier,
		modcharting.modifiers.Bumpy.TanBumpyScaleModifier,modcharting.modifiers.Bumpy.TanBumpyScaleXModifier,modcharting.modifiers.Bumpy.TanBumpyScaleYModifier,
		modcharting.modifiers.Bumpy.TanBumpySkewModifier,modcharting.modifiers.Bumpy.TanBumpySkewXModifier,modcharting.modifiers.Bumpy.TanBumpySkewYModifier,

		modcharting.modifiers.Attenuate.AttenuateXModifier,modcharting.modifiers.Attenuate.AttenuateYModifier,modcharting.modifiers.Attenuate.AttenuateZModifier,
		modcharting.modifiers.Attenuate.AttenuateAngleModifier,modcharting.modifiers.Attenuate.AttenuateAngleXModifier,modcharting.modifiers.Attenuate.AttenuateAngleYModifier,
		modcharting.modifiers.Attenuate.AttenuateScaleModifier,modcharting.modifiers.Attenuate.AttenuateScaleXModifier,modcharting.modifiers.Attenuate.AttenuateScaleYModifier,
		modcharting.modifiers.Attenuate.AttenuateSkewModifier,modcharting.modifiers.Attenuate.AttenuateSkewXModifier,modcharting.modifiers.Attenuate.AttenuateSkewYModifier,

		modcharting.modifiers.HourGlass.HourGlassXModifier,modcharting.modifiers.HourGlass.HourGlassYModifier,modcharting.modifiers.HourGlass.HourGlassZModifier,
		modcharting.modifiers.HourGlass.HourGlassAngleModifier,modcharting.modifiers.HourGlass.HourGlassAngleXModifier,modcharting.modifiers.HourGlass.HourGlassAngleYModifier,
		modcharting.modifiers.HourGlass.HourGlassScaleModifier,modcharting.modifiers.HourGlass.HourGlassScaleXModifier,modcharting.modifiers.HourGlass.HourGlassScaleYModifier,
		modcharting.modifiers.HourGlass.HourGlassSkewModifier,modcharting.modifiers.HourGlass.HourGlassSkewXModifier,modcharting.modifiers.HourGlass.HourGlassSkewYModifier,

		modcharting.modifiers.Spiral.SpiralXModifier,modcharting.modifiers.Spiral.SpiralYModifier,modcharting.modifiers.Spiral.SpiralZModifier,
		modcharting.modifiers.Spiral.SpiralAngleModifier,modcharting.modifiers.Spiral.SpiralAngleXModifier,modcharting.modifiers.Spiral.SpiralAngleYModifier,
		modcharting.modifiers.Spiral.SpiralScaleModifier,modcharting.modifiers.Spiral.SpiralScaleXModifier,modcharting.modifiers.Spiral.SpiralScaleYModifier,
		modcharting.modifiers.Spiral.SpiralSkewModifier,modcharting.modifiers.Spiral.SpiralSkewXModifier,modcharting.modifiers.Spiral.SpiralSkewYModifier,

		modcharting.modifiers.SawTooth.SawToothXModifier,modcharting.modifiers.SawTooth.SawToothYModifier,modcharting.modifiers.SawTooth.SawToothZModifier,
		modcharting.modifiers.SawTooth.SawToothAngleModifier,modcharting.modifiers.SawTooth.SawToothAngleXModifier,modcharting.modifiers.SawTooth.SawToothAngleYModifier,
		modcharting.modifiers.SawTooth.SawToothScaleModifier,modcharting.modifiers.SawTooth.SawToothScaleXModifier,modcharting.modifiers.SawTooth.SawToothScaleYModifier,
		modcharting.modifiers.SawTooth.SawToothSkewModifier,modcharting.modifiers.SawTooth.SawToothSkewXModifier,modcharting.modifiers.SawTooth.SawToothSkewYModifier,

		modcharting.modifiers.Square.SquareXModifier,modcharting.modifiers.Square.SquareYModifier,modcharting.modifiers.Square.SquareZModifier,
		modcharting.modifiers.Square.SquareAngleModifier,modcharting.modifiers.Square.SquareAngleXModifier,modcharting.modifiers.Square.SquareAngleYModifier,
		modcharting.modifiers.Square.SquareScaleModifier,modcharting.modifiers.Square.SquareScaleXModifier,modcharting.modifiers.Square.SquareScaleYModifier,
		modcharting.modifiers.Square.SquareSkewModifier,modcharting.modifiers.Square.SquareSkewXModifier,modcharting.modifiers.Square.SquareSkewYModifier,

		modcharting.modifiers.Tornado.TornadoXModifier,modcharting.modifiers.Tornado.TornadoYModifier,modcharting.modifiers.Tornado.TornadoZModifier,
		modcharting.modifiers.Tornado.TornadoAngleModifier,
		modcharting.modifiers.Tornado.TornadoScaleModifier,modcharting.modifiers.Tornado.TornadoScaleXModifier,modcharting.modifiers.Tornado.TornadoScaleYModifier,
		modcharting.modifiers.Tornado.TornadoSkewModifier,modcharting.modifiers.Tornado.TornadoSkewXModifier,modcharting.modifiers.Tornado.TornadoSkewYModifier,
		modcharting.modifiers.Tornado.TanTornadoXModifier,modcharting.modifiers.Tornado.TanTornadoYModifier,modcharting.modifiers.Tornado.TanTornadoZModifier,
		modcharting.modifiers.Tornado.TanTornadoAngleModifier,
		modcharting.modifiers.Tornado.TanTornadoScaleModifier,modcharting.modifiers.Tornado.TanTornadoScaleXModifier,modcharting.modifiers.Tornado.TanTornadoScaleYModifier,
		modcharting.modifiers.Tornado.TanTornadoSkewModifier,modcharting.modifiers.Tornado.TanTornadoSkewXModifier,modcharting.modifiers.Tornado.TanTornadoSkewYModifier,

		modcharting.modifiers.ZigZag.ZigZagXModifier,modcharting.modifiers.ZigZag.ZigZagYModifier,modcharting.modifiers.ZigZag.ZigZagZModifier,
		modcharting.modifiers.ZigZag.ZigZagAngleModifier,modcharting.modifiers.ZigZag.ZigZagAngleXModifier,modcharting.modifiers.ZigZag.ZigZagAngleYModifier,
		modcharting.modifiers.ZigZag.ZigZagScaleModifier,modcharting.modifiers.ZigZag.ZigZagScaleXModifier,modcharting.modifiers.ZigZag.ZigZagScaleYModifier,
		modcharting.modifiers.ZigZag.ZigZagSkewModifier,modcharting.modifiers.ZigZag.ZigZagSkewXModifier,modcharting.modifiers.ZigZag.ZigZagSkewYModifier,

		modcharting.modifiers.Digital.DigitalXModifier,modcharting.modifiers.Digital.DigitalYModifier,modcharting.modifiers.Digital.DigitalZModifier,
		modcharting.modifiers.Digital.DigitalAngleModifier,modcharting.modifiers.Digital.DigitalAngleXModifier,modcharting.modifiers.Digital.DigitalAngleYModifier,
		modcharting.modifiers.Digital.DigitalScaleModifier,modcharting.modifiers.Digital.DigitalScaleXModifier,modcharting.modifiers.Digital.DigitalScaleYModifier,
		modcharting.modifiers.Digital.DigitalSkewModifier,modcharting.modifiers.Digital.DigitalSkewXModifier,modcharting.modifiers.Digital.DigitalSkewYModifier,

		modcharting.modifiers.ExtraMods.ShakyNotesModifier,modcharting.modifiers.ExtraMods.ShakeNotesModifier,
		modcharting.modifiers.ExtraMods.OrientModifier,
		modcharting.modifiers.ExtraMods.ArrowPathModifier,
		modcharting.modifiers.ExtraMods.CustomPathModifier,
		modcharting.modifiers.ExtraMods.SpiralHoldsModifier,
	];
	public static var easeList:Array<String> = ImprovedEases.easeList;

	// used for indexing
	public static var MOD_NAME = ModchartFile.MOD_NAME; // the modifier name
	public static var MOD_CLASS = ModchartFile.MOD_CLASS; // the class/custom mod it uses
	public static var MOD_TYPE = ModchartFile.MOD_TYPE; // the type, which changes if its for the player, opponent, a specific lane or all
	public static var MOD_PF = ModchartFile.MOD_PF; // the playfield that mod uses
	public static var MOD_LANE = ModchartFile.MOD_LANE; // the lane the mod uses

	public static var EVENT_TYPE = ModchartFile.EVENT_TYPE; // event type (set or ease)
	public static var EVENT_DATA = ModchartFile.EVENT_DATA; // event data
	public static var EVENT_REPEAT = ModchartFile.EVENT_REPEAT; // event repeat data

	public static var EVENT_TIME = ModchartFile.EVENT_TIME; // event time (in beats)
	public static var EVENT_SETDATA = ModchartFile.EVENT_SETDATA; // event data (for sets)
	public static var EVENT_EASETIME = ModchartFile.EVENT_EASETIME; // event ease time
	public static var EVENT_EASE = ModchartFile.EVENT_EASE; // event ease
	public static var EVENT_EASEDATA = ModchartFile.EVENT_EASEDATA; // event data (for eases)

	public static var EVENT_REPEATBOOL = ModchartFile.EVENT_REPEATBOOL; // if event should repeat
	public static var EVENT_REPEATCOUNT = ModchartFile.EVENT_REPEATCOUNT; // how many times it repeats
	public static var EVENT_REPEATBEATGAP = ModchartFile.EVENT_REPEATBEATGAP; // how many beats in between each repeat

	public var camHUD:FlxCamera;
	public var camGame:FlxCamera;
	public var notes:FlxTypedGroup<Note>;

	private var strumLine:FlxSprite;

	public var strumLineNotes:FlxTypedGroup<StrumNoteType>;
	public var opponentStrums:FlxTypedGroup<StrumNoteType>;
	public var playerStrums:FlxTypedGroup<StrumNoteType>;
	public var unspawnNotes:Array<Note> = [];
	public var loadedNotes:Array<Note> = []; // stored notes from the chart that unspawnNotes can copy from
	public var vocals:FlxSound;
	public var opponentVocals:FlxSound;

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

	var UI_box:PsychUIBox;

	var textBlockers:Array<PsychUIInputText> = [];
	var scrollBlockers:Array<PsychUIDropDownMenu> = [];

	var playbackSpeed:Float = 1;

	var activeModifiersText:FlxText;
	var selectedEventBox:FlxSprite;

	var inst:FlxSound;

	var col:FlxColor = 0xFFFFD700;
	var col2:FlxColor = 0xFFFFD700;

	var beat:Float = 0;
	var dataStuff:Float = 0;

	override public function new()
	{
		super();
	}


	public static var instance:ModchartEditorState = null;
	override public function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		persistentUpdate = true;
		persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat'));
		bg.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
		add(bg);

		// if (PlayState.isPixelStage) //Skew Kills Pixel Notes (How are you going to stretch already pixelated bit by bit notes?)
		// {
		//     modifierList.remove(SkewModifier);
		//     modifierList.remove(SkewXModifier);
		//     modifierList.remove(SkewYModifier);
		// }

		Conductor.mapBPMChanges(PlayState.SONG);
		// #if (PSYCH && PSYCHVERSION >= "0.7")
		Conductor.bpm = PlayState.SONG.bpm;
		// #else
		// Conductor.changeBPM(PlayState.SONG.bpm);
		// #end

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		FlxG.mouse.visible = true;

		instance = this;
		strumLine = new FlxSprite(ClientPrefs.data.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X, 50).makeGraphic(FlxG.width, 10);
		if (ModchartUtil.getDownscroll(this))
			strumLine.y = FlxG.height - 150;
		strumLine.scrollFactor.set();

		strumLineNotes = new FlxTypedGroup<StrumNoteType>();
		add(strumLineNotes);

		opponentStrums = new FlxTypedGroup<StrumNoteType>();
		playerStrums = new FlxTypedGroup<StrumNoteType>();

		generateSong(PlayState.SONG);

		generateStaticArrows(0);
		generateStaticArrows(1);
		NoteMovement.getDefaultStrumPosEditor(this);

		strumLineNotes.visible = false;
		notes.visible = false;

		playfieldRenderer = new PlayfieldRenderer(strumLineNotes, notes, unspawnNotes, this);
		playfieldRenderer.cameras = playfieldRenderer.allObjects.cameras = [camHUD];
		playfieldRenderer.inEditor = true;
		// playfieldRenderer.aftCapture = new HazardAFT_Capture.HazardAFT_CaptureMultiCam([camHUD]);
		// playfieldRenderer.aftCapture.updateRate = 0.0;
		// playfieldRenderer.aftCapture.recursive = true;
		add(playfieldRenderer);

		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];

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
			var beatText = new FlxText(-50, gridSize, 0, i + "", 32);
			add(beatText);
			beatTexts.push(beatText);
		}

		eventSprites = new FlxTypedGroup<ModchartEditorEvent>();
		add(eventSprites);

		highlight = new FlxSprite().makeGraphic(gridSize, gridSize);
		highlight.alpha = 0.5;
		add(highlight);

		selectedEventBox = new FlxSprite().makeGraphic(32, 32);
		selectedEventBox.y = gridSize * 0.5;
		selectedEventBox.visible = false;
		add(selectedEventBox);

		updateEventSprites();

		line = new FlxSprite().makeGraphic(10, gridSize);
		line.color = FlxColor.BLACK;
		add(line);

		// gridGap = FlxMath.remapToRange(Conductor.stepCrochet, 0, Conductor.stepCrochet, 0, gridSize); //idk why i even thought this was how i do it
		// trace(gridGap);

		debugText = new FlxText(0, gridSize * 2, 0, "", 16);
		debugText.alignment = FlxTextAlign.LEFT;

		UI_box = new PsychUIBox(100, gridSize * 2, FlxG.width - 200, 500, ['Editor', 'Events', 'Modifiers', 'Playfields']);
		UI_box.scrollFactor.set();
		add(UI_box);

		add(debugText);

		super.create(); // do here because tooltips be dumb
		setupEditorUI();
		setupModifierUI();
		setupEventUI();
		setupPlayfieldUI();

		var hideNotes:FlxButton = new FlxButton(0, FlxG.height, 'Show/Hide Notes', function()
		{
			// camHUD.visible = !camHUD.visible;
			playfieldRenderer.visible = !playfieldRenderer.visible;
		});
		hideNotes.scale.y *= 1.5;
		hideNotes.updateHitbox();
		hideNotes.y -= hideNotes.height;
		add(hideNotes);

		var hidenHud:Bool = false;
		var hideUI:FlxButton = new FlxButton(FlxG.width, FlxG.height, 'Show/Hide UI', function()
		{
			hidenHud = !hidenHud;
			if (hidenHud)
			{
				UI_box.alpha = 0;
				debugText.alpha = 0;
			}
			else
			{
				UI_box.alpha = 0.5;
				debugText.alpha = 1;
			}
			// camGame.visible = !camGame.visible;
		});
		hideUI.y -= hideUI.height;
		hideUI.x -= hideUI.width;
		add(hideUI);

		// if (ClientPrefs.quantization && !PlayState.SONG.disableNoteRGB) setUpNoteQuant();
	}

	var dirtyUpdateNotes:Bool = false;
	var dirtyUpdateEvents:Bool = false;
	var dirtyUpdateModifiers:Bool = false;
	var totalElapsed:Float = 0;

	override public function update(elapsed:Float)
	{
		// if (finishedSetUpQuantStuff)
		// {
		//     if (ClientPrefs.quantization && !PlayState.SONG.disableNoteRGB)
		//         {
		//             var group:FlxTypedGroup<StrumNote> = playerStrums;
		//             for (this2 in group){
		//                 if (this2.animation.curAnim.name == 'static'){
		//                     this2.rgbShader.r = 0xFFFFFFFF;
		//                     this2.rgbShader.b = 0xFF808080;
		//                 }
		//             }
		//         }
		// }
		totalElapsed += elapsed;
		highlight.alpha = 0.8 + FlxMath.fastSin(totalElapsed * 5) * 0.15;
		super.update(elapsed);
		if (inst.time < 0)
		{
			inst.pause();
			inst.time = 0;
		}
		else if (inst.time > inst.length)
		{
			inst.pause();
			inst.time = 0;
		}
		Conductor.songPosition = inst.time;

		var songPosPixelPos = (((Conductor.songPosition / Conductor.stepCrochet) % 4) * gridSize);
		grid.x = -curDecStep * gridSize;
		line.x = gridSize * 4;

		for (i in 0...beatTexts.length)
		{
			beatTexts[i].x = -songPosPixelPos + (gridSize * 4 * (i + 1)) - 16;
			beatTexts[i].text = "" + (Math.floor(Conductor.songPosition / Conductor.crochet) + i);
		}
		var eventIsSelected:Bool = false;
		for (i in 0...eventSprites.members.length)
		{
			var pos = grid.x + (eventSprites.members[i].getBeatTime() * gridSize * 4) + (gridSize * 4);
			// var dec = eventSprites.members[i].beatTime-Math.floor(eventSprites.members[i].beatTime);
			eventSprites.members[i].x = pos; // + (dec*4*gridSize);
			if (highlightedEvent != null)
				if (eventSprites.members[i].data == highlightedEvent)
				{
					eventIsSelected = true;
					selectedEventBox.x = pos;
				}
		}
		selectedEventBox.visible = eventIsSelected;

		if (PsychUIInputText.focusOn == null)
		{
			ClientPrefs.toggleVolumeKeys(true);
			if (FlxG.keys.justPressed.SPACE)
			{
				if (inst.playing)
				{
					inst.pause();
					if (vocals != null)
						vocals.pause();
					if (opponentVocals != null)
						opponentVocals.pause();
					playfieldRenderer.editorPaused = true;
					dirtyUpdateEvents = true;
				}
				else
				{
					if (vocals != null)
					{
						vocals.play();
						vocals.pause();
						vocals.time = inst.time;
						vocals.play();
					}
					if (opponentVocals != null)
					{
						opponentVocals.play();
						opponentVocals.pause();
						opponentVocals.time = inst.time;
						opponentVocals.play();
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
				if (vocals != null)
					vocals.pause();
				if (opponentVocals != null)
					opponentVocals.pause();
				inst.time += (FlxG.mouse.wheel * Conductor.stepCrochet * 0.8 * shiftThing);
				if (vocals != null)
				{
					vocals.pause();
					vocals.time = inst.time;
				}
				if (opponentVocals != null)
				{
					opponentVocals.pause();
					opponentVocals.time = inst.time;
				}
				playfieldRenderer.editorPaused = true;
				dirtyUpdateNotes = true;
				dirtyUpdateEvents = true;
			}

			if (FlxG.keys.justPressed.D || FlxG.keys.justPressed.RIGHT)
			{
				inst.pause();
				if (vocals != null)
					vocals.pause();
				if (opponentVocals != null)
					opponentVocals.pause();
				inst.time += (Conductor.crochet * 4 * shiftThing);
				dirtyUpdateNotes = true;
				dirtyUpdateEvents = true;
			}
			if (FlxG.keys.justPressed.A || FlxG.keys.justPressed.LEFT)
			{
				inst.pause();
				if (vocals != null)
					vocals.pause();
				if (opponentVocals != null)
					opponentVocals.pause();
				inst.time -= (Conductor.crochet * 4 * shiftThing);
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
		else
		{
			ClientPrefs.toggleVolumeKeys(false);
		}

		if (playbackSpeed <= 0.1)
			playbackSpeed = 0.1;
		if (playbackSpeed >= 3)
			playbackSpeed = 3;

		playfieldRenderer.speed = playbackSpeed; // adjust the speed of tweens
		#if FLX_PITCH
		inst.pitch = playbackSpeed;
		vocals.pitch = playbackSpeed;
		opponentVocals.pitch = playbackSpeed;
		#end

		if (unspawnNotes[0] != null)
		{
			var time:Float = 2000;
			if (PlayState.SONG.speed < 1)
				time /= PlayState.SONG.speed;

			while (unspawnNotes.length > 0 && unspawnNotes[0].strumTime - Conductor.songPosition < time)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.insert(0, dunceNote);
				dunceNote.spawned = true;
				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		var noteKillOffset = 350 / PlayState.SONG.speed;

		notes.forEachAlive(function(daNote:Note)
		{
			if (Conductor.songPosition >= daNote.strumTime)
			{
				daNote.wasGoodHit = true;
				var spr:StrumNoteType = null;
				if (!daNote.mustPress)
				{
					spr = opponentStrums.members[daNote.noteData];
				}
				else
				{
					spr = playerStrums.members[daNote.noteData];
				}
				spr.playAnim("confirm", true);
				spr.resetAnim = Conductor.stepCrochet * 1.25 / 1000 / playbackSpeed;
				spr.rgbShader.r = daNote.rgbShader.r;
				spr.rgbShader.b = daNote.rgbShader.b;
				if (!daNote.isSustainNote)
				{
					// daNote.kill();
					notes.remove(daNote, true);
					// daNote.destroy();
				}
			}

			if (Conductor.songPosition > noteKillOffset + daNote.strumTime)
			{
				daNote.active = false;
				daNote.visible = false;

				// daNote.kill();
				notes.remove(daNote, true);
				// daNote.destroy();
			}
		});

		if (FlxG.mouse.y < grid.y + grid.height && FlxG.mouse.y > grid.y) // not using overlap because the grid would go out of world bounds
		{
			if (FlxG.keys.pressed.SHIFT)
				highlight.x = FlxG.mouse.x;
			else
				highlight.x = (Math.floor((FlxG.mouse.x - (grid.x % gridSize)) / gridSize) * gridSize) + (grid.x % gridSize);
			if (FlxG.mouse.overlaps(eventSprites))
			{
				if (FlxG.mouse.justPressed)
				{
					stackedHighlightedEvents = []; // reset stacked events
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
							// trace(stackedHighlightedEvents);
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
					var timeFromMouse = ((highlight.x - grid.x) / gridSize / 4) - 1;
					// trace(timeFromMouse);
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
			clearNotesAfter(Conductor.songPosition + 2000); // so scrolling back doesnt lag shit
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
			playfieldRenderer.tweenManager.clear(); // Clear instead of completeall so tweens appear paused when pausing the song -Hazard
			playfieldRenderer.eventManager.clearEvents();
			playfieldRenderer.modifierTable.resetMods();
			playfieldRenderer.modchart.loadEvents();
			dirtyUpdateEvents = false;
			playfieldRenderer.update(0);
			updateEventSprites();
		}

		if (playfieldRenderer.modchart.data.playfields != playfieldCountStepper.value)
		{
			playfieldRenderer.modchart.data.playfields = Std.int(playfieldCountStepper.value);
			playfieldRenderer.modchart.loadPlayfields();
		}

		if (playfieldRenderer.modchart.data.proxiefields != proxiefieldCountStepper.value)
		{
			playfieldRenderer.modchart.data.proxiefields = Std.int(proxiefieldCountStepper.value);
			playfieldRenderer.modchart.loadProxiefields();
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			var exitFunc = function()
			{
				ClientPrefs.toggleVolumeKeys(true);
				FlxG.mouse.visible = false;
				inst.stop();
				if (vocals != null)
					vocals.stop();
				if (opponentVocals != null)
					opponentVocals.stop();
				engine.StageData.loadDirectory(PlayState.SONG);
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
			curBpmChange.bpm = PlayState.SONG.bpm; // start bpm
		}
		if (curBpmChange.bpm != Conductor.bpm)
		{
			// trace('changed bpm to ' + curBpmChange.bpm);
			Conductor.bpm = PlayState.SONG.bpm;
		}

		debugText.text = Std.string(FlxMath.roundDecimal(Conductor.songPosition / 1000, 2))
			+ " / "
			+ Std.string(FlxMath.roundDecimal(inst.length / 1000, 2))
			+ "\nBeat: "
			+ Std.string(curDecBeat).substring(0, 4)
			+ "\nStep: "
			+ curStep
			+ "\n";

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

		songSlider.value = Conductor.songPosition;

		activeModifiersText.text = leText;
	}

	function addNewEvent(time:Float)
	{
		var event:Array<Dynamic> = ['ease', [time, 1, 'cubeInOut', ','], [false, 1, 1]];
		if (highlightedEvent != null) // copy over current event data (without acting as a reference)
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
			if (curBeat > beat - 5 && curBeat < beat + 5)
			{
				var daEvent:ModchartEditorEvent = new ModchartEditorEvent(playfieldRenderer.modchart.data.events[i]);
				eventSprites.add(daEvent);
				// trace("added event sprite "+beat);
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
		// trace("beat hit");
		super.beatHit();
	}

	override public function draw()
	{
		super.draw();
	}

	public function clearNotesBefore(time:Float)
	{
		var i:Int = unspawnNotes.length - 1;
		while (i >= 0)
		{
			var daNote:Note = unspawnNotes[i];
			if (daNote.strumTime + 350 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				// daNote.ignoreNote = true;

				// daNote.kill();
				unspawnNotes.remove(daNote);
				// daNote.destroy();
			}
			--i;
		}

		i = notes.length - 1;
		while (i >= 0)
		{
			var daNote:Note = notes.members[i];
			if (daNote.strumTime + 350 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				// daNote.ignoreNote = true;

				// daNote.kill();
				notes.remove(daNote, true);
				// daNote.destroy();
			}
			--i;
		}
	}

	public function clearNotesAfter(time:Float)
	{
		var i = notes.length - 1;
		while (i >= 0)
		{
			var daNote:Note = notes.members[i];
			if (daNote.strumTime > time)
			{
				daNote.active = false;
				daNote.visible = false;
				// daNote.ignoreNote = true;

				// daNote.kill();
				notes.remove(daNote, true);
				// daNote.destroy();
			}
			--i;
		}
	}

	function getFromCharacter(char:String):objects.Character.CharacterFile
	{
		try
		{
			var path:String = Paths.getPath('characters/$char.json', TEXT);
			#if MODS_ALLOWED
			var character:Dynamic = Json.parse(File.getContent(path));
			#else
			var character:Dynamic = Json.parse(OpenFLAssets.getText(path));
			#end
			return character;
		}
		catch (e:Dynamic)
		{
		}
		return null;
	}

	public function generateSong(songData:SwagSong):Void
	{
		var songData = PlayState.SONG;
		Conductor.bpm = songData.bpm;

		final vocalPl:String = getFromCharacter(PlayState.SONG.player1).vocals_file;
		final vocalSuffix:String = (vocalPl != null && vocalPl.length > 0) ? vocalPl : 'Player';

		final vocalOp:String = getFromCharacter(PlayState.SONG.player2).vocals_file;
		final vocalSuffixOp:String = (vocalOp != null && vocalOp.length > 0) ? vocalOp : 'Opponent';

		final formattedSong:String = Paths.formatToSongPath(songData.song);

		vocals = new FlxSound();
		opponentVocals = new FlxSound();
		try
		{
			if (PlayState.SONG.needsVoices)
			{
				var sng_name = Paths.formatToSongPath(songData.song); // !
				var legacy_path = Paths.getPath('songs/${sng_name}/Voices.ogg');
				var opponent_path = Paths.getPath('songs/${sng_name}/Voices-Opponent.ogg');
				var is_base_legacy_path = legacy_path.startsWith("assets/shared/");
				var is_base_opponent_path = opponent_path.startsWith("assets/shared/");

				var legacyVoices = Paths.voices(songData.song);
				if (PlayState.storyDifficulty == 1 && (formattedSong == "system-reloaded" || formattedSong == "metakill"))
				{
					legacyVoices = Paths.voicesClassic(songData.song, vocalSuffix);
					if (legacyVoices == null)
						legacyVoices = Paths.voicesClassic(songData.song);
				}
				if (legacyVoices == null)
				{
					var playerVocals = Paths.voices(songData.song, vocalSuffix);
					vocals.loadEmbedded(playerVocals);
				}
				else
					vocals.loadEmbedded(legacyVoices);

				if (legacyVoices == null || (is_base_legacy_path == is_base_opponent_path))
				{
					var oppVocals = Paths.voices(songData.song, vocalSuffixOp);
					if (PlayState.storyDifficulty == 1 && (sng_name == "system-reloaded" || sng_name == "metakill"))
					{
						oppVocals = Paths.voicesClassic(songData.song, vocalSuffixOp);
						if (oppVocals == null)
							oppVocals = Paths.voicesClassic(songData.song);
					}
					if (oppVocals != null && oppVocals.length > 0)
						opponentVocals.loadEmbedded(oppVocals);
				}
			}
		}
		catch (e:Dynamic)
		{
		}

		FlxG.sound.list.add(vocals);
		FlxG.sound.list.add(opponentVocals);

		inst = new FlxSound();
		try
		{
			inst.loadEmbedded(Paths.inst(songData.song));
			if (PlayState.storyDifficulty == 1 && (formattedSong == "system-reloaded" || formattedSong == "metakill"))
				inst.loadEmbedded(Paths.instClassic(songData.song));
		}
		catch (e:Dynamic)
		{
		}
		FlxG.sound.list.add(inst);

		inst.onComplete = function()
		{
			inst.time = 0;
			inst.pause();
			Conductor.songPosition = 0;
			if (vocals != null)
			{
				vocals.pause();
				vocals.time = 0;
			}
			if (opponentVocals != null)
			{
				opponentVocals.pause();
				opponentVocals.time = 0;
			}
		};

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var oldNote:Note = null;
		var sectionsData:Array<SwagSection> = PlayState.SONG.notes;
		var ghostNotesCaught:Int = 0;
		var daBpm:Float = Conductor.bpm;

		for (section in sectionsData)
		{
			if (section.changeBPM != null && section.changeBPM && section.bpm != null && daBpm != section.bpm)
				daBpm = section.bpm;

			for (i in 0...section.sectionNotes.length)
			{
				final songNotes:Array<Dynamic> = section.sectionNotes[i];
				var spawnTime:Float = songNotes[0];
				var noteColumn:Int = Std.int(songNotes[1] % 4);
				var holdLength:Float = songNotes[2];
				var noteType:String = songNotes[3];
				if (Math.isNaN(holdLength))
					holdLength = 0.0;

				var gottaHitNote:Bool = (songNotes[1] < 4);

				if (i != 0)
				{
					// CLEAR ANY POSSIBLE GHOST NOTES
					for (evilNote in unspawnNotes)
					{
						var matches:Bool = (noteColumn == evilNote.noteData && gottaHitNote == evilNote.mustPress && evilNote.noteType == noteType);
						if (matches && Math.abs(spawnTime - evilNote.strumTime) == 0.0)
						{
							evilNote.destroy();
							unspawnNotes.remove(evilNote);
							ghostNotesCaught++;
							// continue;
						}
					}
				}

				var swagNote:Note = new Note(spawnTime, noteColumn, oldNote, this);
				var isAlt:Bool = section.altAnim && !gottaHitNote;
				// swagNote.gfNote = (section.gfSection && gottaHitNote == section.mustHitSection);
				swagNote.animSuffix = isAlt ? "-alt" : "";
				swagNote.mustPress = gottaHitNote;
				swagNote.sustainLength = holdLength;
				swagNote.noteType = noteType;

				swagNote.scrollFactor.set();
				unspawnNotes.push(swagNote);

				var curStepCrochet:Float = 60 / daBpm * 1000 / 4.0;
				final roundSus:Int = Math.round(swagNote.sustainLength / curStepCrochet);
				if (roundSus > 0)
				{
					for (susNote in 0...roundSus)
					{
						oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

						var sustainNote:Note = new Note(spawnTime + (curStepCrochet * susNote), noteColumn, oldNote, true, this);
						sustainNote.animSuffix = swagNote.animSuffix;
						sustainNote.mustPress = swagNote.mustPress;
						// sustainNote.gfNote = swagNote.gfNote;
						sustainNote.noteType = swagNote.noteType;
						sustainNote.scrollFactor.set();
						sustainNote.parent = swagNote;
						unspawnNotes.push(sustainNote);
						swagNote.tail.push(sustainNote);

						sustainNote.correctionOffset = swagNote.height / 2;
						if (!PlayState.isPixelStage)
						{
							if (oldNote.isSustainNote)
							{
								oldNote.scale.y *= Note.SUSTAIN_SIZE / oldNote.frameHeight;
								oldNote.scale.y /= playbackSpeed;
								oldNote.resizeByRatio(curStepCrochet / Conductor.stepCrochet);
							}

							if (ClientPrefs.data.downScroll)
								sustainNote.correctionOffset = 0;
						}
						else if (oldNote.isSustainNote)
						{
							oldNote.scale.y /= playbackSpeed;
							oldNote.resizeByRatio(curStepCrochet / Conductor.stepCrochet);
						}

						if (sustainNote.mustPress)
							sustainNote.x += FlxG.width / 2; // general offset
						else if (ClientPrefs.data.middleScroll)
						{
							sustainNote.x += 310;
							if (noteColumn > 1) // Up and Right
								sustainNote.x += FlxG.width / 2 + 25;
						}
					}
				}

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else if (ClientPrefs.data.middleScroll)
				{
					swagNote.x += 310;
					if (noteColumn > 1) // Up and Right
					{
						swagNote.x += FlxG.width / 2 + 25;
					}
				}
				oldNote = swagNote;
			}
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

		var strumLineX:Float = ClientPrefs.data.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X;

		var TRUE_STRUM_X:Float = strumLineX;

		for (i in 0...usedKeyCount)
		{
			// FlxG.log.add(i);
			var targetAlpha:Float = 1;
			if (player < 1)
			{
				if (ClientPrefs.data.middleScroll && !PlayState.forceRightScroll || PlayState.forceMiddleScroll)
					targetAlpha = 0.35;
			}
			var babyArrow:StrumNote = new StrumNote(!PlayState.forcedAScroll ? (ClientPrefs.data.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) : if (PlayState.forceRightScroll
				&& !PlayState.forceMiddleScroll) PlayState.STRUM_X else if (PlayState.forceMiddleScroll && !PlayState.forceRightScroll)
				PlayState.STRUM_X_MIDDLESCROLL else ClientPrefs.data.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X,
				strumLine.y, i, player);
			babyArrow.downScroll = ClientPrefs.data.downScroll;
			babyArrow.alpha = targetAlpha;

			var middleScroll:Bool = false;
			middleScroll = ClientPrefs.data.middleScroll;

			if (player == 1)
			{
				playerStrums.add(babyArrow);
			}
			else
			{
				if (middleScroll && !PlayState.forceRightScroll || PlayState.forceMiddleScroll)
				{
					babyArrow.x += 310;
					if (i > 1)
					{ // Up and Right
						babyArrow.x += FlxG.width / 2 + 25;
					}
				}
				opponentStrums.add(babyArrow);
			}

			strumLineNotes.add(babyArrow);
			babyArrow.playerPosition();
		}
	}

	private function round(num:Float, numDecimalPlaces:Int)
	{
		var mult = 10 ^ (numDecimalPlaces > 0 ? numDecimalPlaces : 0);
		return Math.floor(num * mult + 0.5) / mult;
	}

	/*public function setUpNoteQuant()
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
							col = ClientPrefs.data.arrowRGBQuantize[0][0];
							col2 = ClientPrefs.data.arrowRGBQuantize[0][2];
						}
						else if(beat%(192/8)==0){
							col = ClientPrefs.data.arrowRGBQuantize[1][0];
							col2 = ClientPrefs.data.arrowRGBQuantize[1][2];
						}
						else if(beat%(192/12)==0){
							col = ClientPrefs.data.arrowRGBQuantize[2][0];
							col2 = ClientPrefs.data.arrowRGBQuantize[2][2];
						}
						else if(beat%(192/16)==0){
							col = ClientPrefs.data.arrowRGBQuantize[3][0];
							col2 = ClientPrefs.data.arrowRGBQuantize[3][2];
						}
						else if(beat%(192/24)==0){
							col = ClientPrefs.data.arrowRGBQuantize[4][0];
							col2 = ClientPrefs.data.arrowRGBQuantize[4][2];
						}
						else if(beat%(192/32)==0){
							col = ClientPrefs.data.arrowRGBQuantize[5][0];
							col2 = ClientPrefs.data.arrowRGBQuantize[5][2];
						}
						else if(beat%(192/48)==0){
							col = ClientPrefs.data.arrowRGBQuantize[6][0];
							col2 = ClientPrefs.data.arrowRGBQuantize[6][2];
						}
						else if(beat%(192/64)==0){
							col = ClientPrefs.data.arrowRGBQuantize[7][0];
							col2 = ClientPrefs.data.arrowRGBQuantize[7][2];
						}else{
							col = 0xFF7C7C7C;
							col2 = 0xFF3A3A3A;
						}
						note.rgbShader.r = col;
						note.rgbShader.g = ClientPrefs.data.arrowRGBQuantize[0][1];
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
	}*/
	var finishedSetUpQuantStuff = false;

	var animSkins:Array<String> = ['ITHIT', 'MANIAHIT', 'STEPMANIA', 'NOTITG'];

	var lastStepHit:Int = -1;

	override function stepHit()
	{
		super.stepHit();

		if (curStep == lastStepHit)
		{
			return;
		}
		/* for (i in 0... animSkins.length){
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
		}*/
		lastStepHit = curStep;
	}

	public static function createGrid(CellWidth:Int, CellHeight:Int, Width:Int, Height:Int):BitmapData
	{
		// How many cells can we fit into the width/height? (round it UP if not even, then trim back)
		var Color1 = 0xFFAAAAAA; // not quant colors LMAO
		var Color2 = 0xFFAAAAAA;
		var Color3 = 0xFF888888;

		// if(ClientPrefs.quantization){
		Color1 = 0xFFFFAAAA; // quant colors!!!
		Color2 = 0xFFB3B2FF;
		Color3 = 0xFF759E71;
		// }

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
				if (timesFilled % 4 == 0)
					lastColor = Color1;
				else if (timesFilled % 4 == 1)
					lastColor = Color3;
				else if (timesFilled % 4 == 2)
					lastColor = Color2;
				else if (timesFilled % 4 == 3)
					lastColor = Color3;
				grid.fillRect(new Rectangle(x, y, CellWidth, CellHeight), lastColor);
				// grid.unlock();
				timesFilled++;

				x += CellWidth;
			}

			y += CellHeight;
		}

		return grid;
	}

	var currentModifier:Array<Dynamic> = null;
	var modNameInputText:PsychUIInputText;
	var modClassInputText:PsychUIInputText;
	var explainText:FlxText;
	var modTypeInputText:PsychUIInputText;
	var playfieldStepper:PsychUINumericStepper;
	var targetLaneStepper:PsychUINumericStepper;
	var modifierDropDown:PsychUIDropDownMenu;
	var mods:Array<String> = [];
	var subMods:Array<String> = [""];

	function updateModList()
	{
		mods = [];
		for (i in 0...playfieldRenderer.modchart.data.modifiers.length)
			mods.push(playfieldRenderer.modchart.data.modifiers[i][MOD_NAME]);
		if (mods.length == 0)
			mods.push('');
		modifierDropDown.list = mods;
		eventModifierDropDown.list = mods;
	}

	function updateSubModList(modName:String)
	{
		subMods = [""];
		if (playfieldRenderer.modifierTable.modifiers.exists(modName))
		{
			for (subModName => subMod in playfieldRenderer.modifierTable.modifiers.get(modName).subValues)
			{
				subMods.push(subModName);
			}
		}
		subModDropDown.list = subMods;
	}

	function setupModifierUI()
	{
		var tab_group = UI_box.getTab('Modifiers').menu;

		for (i in 0...playfieldRenderer.modchart.data.modifiers.length)
			mods.push(playfieldRenderer.modchart.data.modifiers[i][MOD_NAME]);

		if (mods.length == 0)
			mods.push('');

		modifierDropDown = new PsychUIDropDownMenu(25, 50, mods, function(id:Int, mod:String)
		{
			var modName = mod;
			for (i in 0...playfieldRenderer.modchart.data.modifiers.length)
				if (playfieldRenderer.modchart.data.modifiers[i][MOD_NAME] == modName)
					currentModifier = playfieldRenderer.modchart.data.modifiers[i];

			if (currentModifier != null)
			{
				// trace(currentModifier);
				modNameInputText.text = currentModifier[MOD_NAME];
				modClassInputText.text = currentModifier[MOD_CLASS];
				modTypeInputText.text = currentModifier[MOD_TYPE];
				playfieldStepper.value = currentModifier[MOD_PF];
				if (currentModifier[MOD_LANE] != null)
					targetLaneStepper.value = currentModifier[MOD_LANE];
			}
		});

		var refreshModifiers:PsychUIButton = new PsychUIButton(25 + modifierDropDown.width + 10, modifierDropDown.y, 'Refresh Modifiers', function()
		{
			updateModList();
		}, 80, 28);

		var saveModifier:PsychUIButton = new PsychUIButton(refreshModifiers.x, refreshModifiers.y + refreshModifiers.height + 20, 'Save Modifier', function()
		{
			var alreadyExists = false;
			for (i in 0...playfieldRenderer.modchart.data.modifiers.length)
				if (playfieldRenderer.modchart.data.modifiers[i][MOD_NAME] == modNameInputText.text)
				{
					playfieldRenderer.modchart.data.modifiers[i] = [
						modNameInputText.text,
						modClassInputText.text,
						modTypeInputText.text,
						playfieldStepper.value,
						targetLaneStepper.value
					];
					alreadyExists = true;
				}

			if (!alreadyExists)
			{
				playfieldRenderer.modchart.data.modifiers.push([
					modNameInputText.text,
					modClassInputText.text,
					modTypeInputText.text,
					playfieldStepper.value,
					targetLaneStepper.value
				]);
			}
			dirtyUpdateModifiers = true;
			updateModList();
			hasUnsavedChanges = true;
		});

		var removeModifier:PsychUIButton = new PsychUIButton(saveModifier.x, saveModifier.y + saveModifier.height + 20, 'Remove Modifier', function()
		{
			for (i in 0...playfieldRenderer.modchart.data.modifiers.length)
				if (playfieldRenderer.modchart.data.modifiers[i][MOD_NAME] == modNameInputText.text)
				{
					playfieldRenderer.modchart.data.modifiers.remove(playfieldRenderer.modchart.data.modifiers[i]);
				}
			dirtyUpdateModifiers = true;
			updateModList();
			hasUnsavedChanges = true;
		}, 80, 28);

		modNameInputText = new PsychUIInputText(modifierDropDown.x + 300, modifierDropDown.y, 160, '', 8);
		modClassInputText = new PsychUIInputText(modifierDropDown.x + 500, modifierDropDown.y, 160, '', 8);
		explainText = new FlxText(modifierDropDown.x + 200, modifierDropDown.y + 200, 160, '', 8);
		modTypeInputText = new PsychUIInputText(modifierDropDown.x + 700, modifierDropDown.y, 160, '', 8);
		playfieldStepper = new PsychUINumericStepper(modifierDropDown.x + 900, modifierDropDown.y, 1, -1, -1, 100, 0);
		targetLaneStepper = new PsychUINumericStepper(modifierDropDown.x + 900, modifierDropDown.y + 300, 1, -1, -1, 100, 0);

		textBlockers.push(modNameInputText);
		textBlockers.push(modClassInputText);
		textBlockers.push(modTypeInputText);
		scrollBlockers.push(modifierDropDown);

		var modClassList:Array<String> = [];
		for (i in 0...modifierList.length)
		{
			modClassList.push(Std.string(modifierList[i]).replace("modcharting.modifiers.", ""));
		}

		var modClassDropDown = new PsychUIDropDownMenu(modClassInputText.x, modClassInputText.y + 30, modClassList, function(id:Int, mod:String)
		{
			modClassInputText.text = mod;
			if (modClassInputText.text != '')
				explainText.text = ('Current Modifier: ${modClassInputText.text}, Explaination: ' + modifierExplain(modClassInputText.text));
		});
		centerXToObject(modClassInputText, modClassDropDown);
		var modTypeList = ["All", "Player", "Opponent", "Lane"];
		var modTypeDropDown = new PsychUIDropDownMenu(modTypeInputText.x, modClassInputText.y + 30, modTypeList, function(id:Int, mod:String)
		{
			modTypeInputText.text = mod;
		});
		centerXToObject(modTypeInputText, modTypeDropDown);
		centerXToObject(modTypeInputText, explainText);

		activeModifiersText = new FlxText(50, 180);
		tab_group.add(activeModifiersText);

		tab_group.add(modNameInputText);
		tab_group.add(modClassInputText);
		tab_group.add(explainText);
		tab_group.add(modTypeInputText);
		tab_group.add(playfieldStepper);
		tab_group.add(targetLaneStepper);

		tab_group.add(refreshModifiers);
		tab_group.add(saveModifier);
		tab_group.add(removeModifier);

		tab_group.add(makeLabel(modNameInputText, 0, -15, "Modifier Name"));
		tab_group.add(makeLabel(modClassInputText, 0, -15, "Modifier Class"));
		tab_group.add(makeLabel(explainText, 0, -15, "Modifier Explaination:"));
		tab_group.add(makeLabel(modTypeInputText, 0, -15, "Modifier Type"));
		tab_group.add(makeLabel(playfieldStepper, 0, -15, "Playfield (-1 = all)"));
		tab_group.add(makeLabel(targetLaneStepper, 0, -15, "Target Lane (only for Lane mods!)"));
		tab_group.add(makeLabel(playfieldStepper, 0, 15, "Playfield number starts at 0!"));

		tab_group.add(modifierDropDown);
		tab_group.add(modClassDropDown);
		tab_group.add(modTypeDropDown);
	}

	// Thanks to glowsoony for the idea lol
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
			case 'DrunkAngleModifier':
				explainString = "Modifier used to do a wave at angle of the notes and targets";
			case 'DrunkScaleModifier':
				explainString = "Modifier used to do a wave at scale of the notes and targets";
			case 'TipsyXModifier':
				explainString = "Modifier similar to DrunkX but don't affect notes poss";
			case 'TipsyYModifier':
				explainString = "Modifier similar to DrunkY but don't affect notes poss";
			case 'TipsyZModifier':
				explainString = "Modifier similar to DrunkZ but don't affect notes poss";
			case 'TipsyAngleModifier':
				explainString = "Modifier similar to DrunkAngle but don't affect notes poss";
			case 'TipsyScaleModifier':
				explainString = "Modifier similar to DrunkScale but don't affect notes poss";
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
			case 'TanBumpyModifier':
				explainString = "Modifier similar to bumpy but it will use Tangent math instead of sin";
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
			case 'AlphaModifier':
				explainString = "Modifier used to change notes and targets alpha";
			case 'NoteAlphaModifier':
				explainString = "Modifier used to change notes alpha";
			case 'TargetAlphaModifier':
				explainString = "Modifier used to change targets alpha";
			case 'StealthModifier':
				explainString = "Modifier used to change Note alpha with some glow effect";
			case 'DarkModifier':
				explainString = "Modifier used to change Target alpha with some glow effect";
			case 'StealthColorModifier':
				explainString = "Modifier used to change Glow color into stealth mods";
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
			case 'BeatScaleModifier':
				explainString = "Modifier used to scale notes and targets with a small jump effect";
			case 'BeatAngleModifier':
				explainString = "Modifier used to rotate notes and targets with a small jump effect";
			case 'BounceXModifier':
				explainString = "Modifier similar to beatX but it only affect notes X with a jump effect";
			case 'BounceYModifier':
				explainString = "Modifier similar to beatY but it only affect notes Y with a jump effect";
			case 'BounceZModifier':
				explainString = "Modifier similar to beatZ but it only affect notes Z with a jump effect";
			case 'BounceScaleModifier':
				explainString = "Modifier similar to beatScale but it only affect notes scale with a jump effect";
			case 'BounceAngleModifier':
				explainString = "Modifier similar to beatAngle but it only affect notes angle with a jump effect";
			case 'EaseModifier':
				explainString = "This enables the Ease";
			case 'EaseXModifier':
				explainString = "Modifier similar to IncomingAngleMod (X), it will make notes come faster at X poss";
			case 'EaseYModifier':
				explainString = "Modifier similar to IncomingAngleMod (Y), it will make notes come faster at Y poss";
			case 'EaseZModifier':
				explainString = "Modifier similar to IncomingAngleMod (X+Y), it will make notes come faster at Z perspective";
			case 'EaseScaleModifier':
				explainString = "Modifier similar to All Ease, it will make notes scale change, usually next to target";
			case 'EaseAngleModifier':
				explainString = "Modifier similar to All Ease, it will make notes angle change, usually next to target";
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
			case 'CenterModifier':
				explainString = "Modifier used to center notes on the screen";
			case 'WaveXModifier':
				explainString = "Modifier similar to drunkX but this one will simulate a true wave in X (don't affect the notes)";
			case 'WaveYModifier':
				explainString = "Modifier similar to drunkY but this one will simulate a true wave in Y (don't affect the notes)";
			case 'WaveZModifier':
				explainString = "Modifier similar to drunkZ but this one will simulate a true wave in Z (don't affect the notes)";
			case 'WaveScaleModifier':
				explainString = "Modifier similar to drunkScale but this one will simulate a true wave in scale (don't affect the notes)";
			case 'WaveAngleModifier':
				explainString = "Modifier similar to drunkAngle but this one will simulate a true wave in angle (don't affect the notes)";
			case 'TimeStopModifier':
				explainString = "Modifier used to stop the notes at the top/bottom part of your screen to make it hard to read";
			case 'StrumAngleModifier':
				explainString = "Modifier combined between strumRotate, Confusion, IncomingAngleY, making a rotation easily";
			case 'JumpTargetModifier':
				explainString = "Modifier similar to jump but only target aplied";
			case 'JumpNotesModifier':
				explainString = "Modifier similar to jump but only notes aplied";
			case 'SineXModifier':
				explainString = "Modifier used to make notes go left to right on the screen";
			case 'SineYModifier':
				explainString = "Modifier used to make notes go up to down on the screen";
			case 'SineZModifier':
				explainString = "Modifier used to make notes go far to near right on the screen";
			case 'SineScaleModifier':
				explainString = "Modifier used to make notes scale go far to near as scale";
			case 'SineAngleModifier':
				explainString = "Modifier used to make notes angle go far to near as angle";
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
			case 'TanDrunkScaleModifier':
				explainString = "Modifier similar to TanDrunk but in scale";
			case 'TanWaveAngleModifier':
				explainString = "Modifier similar to TanWave but in angle";
			case 'TanWaveScaleModifier':
				explainString = "Modifier similar to TanWave but in scale";
			case 'ShakyNotesModifier':
				explainString = "Modifier used to make notes shake in their on possition";
			case 'TornadoModifier':
				explainString = "Modifier similar to invertSine, but notes will do their own path instead";
			case 'TornadoYModifier':
				explainString = "Modifier similar to invertSine, but only in Y";
			case 'TornadoZModifier':
				explainString = "Modifier similar to invertSine, but only in Z";
			case 'SawToothXModifier':
				explainString = "Modifier used to make notes do a Saw Effect into their X";
			case 'SawToothYModifier':
				explainString = "Modifier used to make notes do a Saw Effect into their Y";
			case 'SawToothZModifier':
				explainString = "Modifier used to make notes do a Saw Effect into their Z";
			case 'SawToothAngleModifier':
				explainString = "Modifier used to make notes do a Saw Effect into their angle";
			case 'SawToothScaleModifier':
				explainString = "Modifier used to make notes do a Saw Effect into their scale";
			case "ZigZagXModifier":
				explainString = "Modifier used to make notes do a ZigZag Effect into their X";
			case "ZigZagYModifier":
				explainString = "Modifier used to make notes do a ZigZag Effect into their Y";
			case "ZigZagZModifier":
				explainString = "Modifier used to make notes do a ZigZag Effect into their Z";
			case "ZigZagAngleModifier":
				explainString = "Modifier used to make notes do a ZigZag Effect into their angle";
			case "ZigZagScaleModifier":
				explainString = "Modifier used to make notes do a ZigZag Effect into their scale";
			case "SquareXModifier":
				explainString = "Modifier used to make notes do a Square Effect into their X";
			case "SquareYModifier":
				explainString = "Modifier used to make notes do a Square Effect into their Y";
			case "SquareZModifier":
				explainString = "Modifier used to make notes do a Square Effect into their Z";
			case "SquareAngleModifier":
				explainString = "Modifier used to make notes do a Square Effect into their angle";
			case "SquareScaleModifier":
				explainString = "Modifier used to make notes do a Square Effect into their scale";
			case 'ParalysisModifier':
				explainString = "Modifier used to make notes go into a small Paralysis (stop)";
			case 'ArrowPath':
				explainString = "This modifier its able to make custom paths for the mods so this should be a very helpful tool";
		}

		return explainString;
	}

	function findCorrectModData(data:Array<Dynamic>) // the data is stored at different indexes based on the type (maybe should have kept them the same)
	{
		switch (data[EVENT_TYPE])
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
		switch (data[EVENT_TYPE])
		{
			case "ease":
				data[EVENT_DATA][EVENT_EASEDATA] = dataStr;
			case "set":
				data[EVENT_DATA][EVENT_SETDATA] = dataStr;
		}
		return data;
	}

	// TODO: fix this shit
	function convertModData(beforeData:Array<Dynamic>, newType:String):Array<Dynamic>
	{
		var ease:String = beforeData[EVENT_TYPE];
		switch (ease) // convert stuff over i guess
		{
			case "ease":
				if (newType != 'ease')
				{
					trace('converting ease to set');
					return [
						newType,
						[
							beforeData[EVENT_DATA][EVENT_TIME],
							0,
							"NOEASE",
							beforeData[EVENT_DATA][EVENT_EASEDATA],
						],
						beforeData[EVENT_REPEAT]
					];
				}
			case "set":
				if (newType != 'set')
				{
					trace('converting set to ease');
					return [
						newType,
						[
							beforeData[EVENT_DATA][EVENT_TIME],
							1,
							"linear",
							beforeData[EVENT_DATA][EVENT_SETDATA],
						],
						beforeData[EVENT_REPEAT]
					];
				}
		}
		return [newType, [0, 0, "", ""], [false, 0, 0]];
	}

	function updateEventModData(shitToUpdate:String, isMod:Bool)
	{
		var data = getCurrentEventInData();
		if (data != null)
		{
			var dataStr:String = findCorrectModData(data);
			var dataSplit = dataStr.split(',');
			// the way the data works is it goes "value,mod,value,mod,....." and goes on forever, so it has to deconstruct and reconstruct to edit it and shit

			dataSplit[(getEventModIndex() * 2) + (isMod ? 1 : 0)] = shitToUpdate;
			dataStr = stringifyEventModData(dataSplit);
			data = setCorrectModData(data, dataStr);
		}
	}

	function getEventModData(isMod:Bool):String
	{
		var data = getCurrentEventInData();
		if (data != null)
		{
			var dataStr:String = findCorrectModData(data);
			var dataSplit = dataStr.split(',');
			return dataSplit[(getEventModIndex() * 2) + (isMod ? 1 : 0)];
		}
		return "";
	}

	function stringifyEventModData(dataSplit:Array<String>):String
	{
		var dataStr = "";
		for (i in 0...dataSplit.length)
		{
			dataStr += dataSplit[i];
			if (i < dataSplit.length - 1)
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
			dataStr += ",,"; // just how it works lol
			data = setCorrectModData(data, dataStr);
		}
		return data;
	}

	function removeModData()
	{
		var data = getCurrentEventInData();
		if (data != null)
		{
			if (selectedEventDataStepper.max > 0) // dont remove if theres only 1
			{
				var dataStr:String = findCorrectModData(data);
				var dataSplit = dataStr.split(',');
				dataSplit.resize(dataSplit.length - 2); // remove last 2 things
				dataStr = stringifyEventModData(dataSplit);
				data = setCorrectModData(data, dataStr);
			}
		}
		return data;
	}

	var eventTimeStepper:PsychUINumericStepper;
	var eventModInputText:PsychUIInputText;
	var eventValueInputText:PsychUIInputText;
	var eventDataInputText:PsychUIInputText;
	var eventModifierDropDown:PsychUIDropDownMenu;
	var eventTypeDropDown:PsychUIDropDownMenu;
	var eventEaseInputText:PsychUIInputText;
	var eventTimeInputText:PsychUIInputText;
	var selectedEventDataStepper:PsychUINumericStepper;
	var repeatCheckbox:PsychUICheckBox;
	var repeatBeatGapStepper:PsychUINumericStepper;
	var repeatCountStepper:PsychUINumericStepper;
	var easeDropDown:PsychUIDropDownMenu;
	var subModDropDown:PsychUIDropDownMenu;
	var builtInModDropDown:PsychUIDropDownMenu;
	var stackedEventStepper:PsychUINumericStepper;

	function setupEventUI()
	{
		var tab_group = UI_box.getTab('Events').menu;

		eventTimeStepper = new PsychUINumericStepper(850, 50, 0.25, 0, 0, 9999, 3);

		repeatCheckbox = new PsychUICheckBox(950, 50, "Repeat Event?");
		repeatCheckbox.checked = false;
		repeatCheckbox.onClick = function()
		{
			var data = getCurrentEventInData();
			if (data != null)
			{
				data[EVENT_REPEAT][EVENT_REPEATBOOL] = repeatCheckbox.checked;
				highlightedEvent = data;
				dirtyUpdateEvents = true;
				hasUnsavedChanges = true;
			}
		}
		repeatBeatGapStepper = new PsychUINumericStepper(950, 100, 0.25, 0, 0, 9999, 3);
		repeatBeatGapStepper.name = 'repeatBeatGap';
		repeatCountStepper = new PsychUINumericStepper(950, 150, 1, 1, 1, 9999, 3);
		repeatCountStepper.name = 'repeatCount';
		centerXToObject(repeatCheckbox, repeatBeatGapStepper);
		centerXToObject(repeatCheckbox, repeatCountStepper);

		eventModInputText = new PsychUIInputText(25, 50, 160, '', 8);
		eventModInputText.onChange = function(str:String, str2:String)
		{
			updateEventModData(eventModInputText.text, true);
			var data = getCurrentEventInData();
			var allData = EVENT_EASEDATA;
			if (data != null)
			{
				if (data[EVENT_TYPE] == "set")
				{
					allData = EVENT_SETDATA;
				}
				highlightedEvent = data;
				eventDataInputText.text = highlightedEvent[EVENT_DATA][allData];
				dirtyUpdateEvents = true;
				hasUnsavedChanges = true;
			}
		};
		eventValueInputText = new PsychUIInputText(25 + 200, 50, 160, '', 8);
		eventValueInputText.onChange = function(str:String, str2:String)
		{
			updateEventModData(eventValueInputText.text, false);
			var data = getCurrentEventInData();
			var allData = EVENT_EASEDATA;
			if (data != null)
			{
				if (data[EVENT_TYPE] == "set")
				{
					allData = EVENT_SETDATA;
				}
				highlightedEvent = data;
				eventDataInputText.text = highlightedEvent[EVENT_DATA][allData];
				dirtyUpdateEvents = true;
				hasUnsavedChanges = true;
			}
		};

		selectedEventDataStepper = new PsychUINumericStepper(25 + 400, 50, 1, 0, 0, 0, 0);
		selectedEventDataStepper.name = "selectedEventMod";

		stackedEventStepper = new PsychUINumericStepper(25 + 400, 200, 1, 0, 0, 0, 0);
		stackedEventStepper.name = "stackedEvent";

		var addStacked:PsychUIButton = new PsychUIButton(stackedEventStepper.x, stackedEventStepper.y + 30, 'Add', function()
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
		});
		centerXToObject(stackedEventStepper, addStacked);

		eventTypeDropDown = new PsychUIDropDownMenu(25 + 500, 50, eventTypes, function(id:Int, type:String)
		{
			var et = type;
			trace(et);

			var data = getCurrentEventInData();
			if (data != null)
			{
				if (data[EVENT_TYPE] != et)
				{
					var newData = convertModData(data, et);
					highlightedEvent = newData;
				}
				trace(highlightedEvent);
			}
			eventEaseInputText.alpha = 1;
			eventTimeInputText.alpha = 1;
			if (et != 'ease')
			{
				eventEaseInputText.alpha = 0.5;
				eventTimeInputText.alpha = 0.5;
			}
			dirtyUpdateEvents = true;
			hasUnsavedChanges = true;
		});
		eventEaseInputText = new PsychUIInputText(25 + 650, 50 + 100, 160, '', 8);
		eventTimeInputText = new PsychUIInputText(25 + 650, 50, 160, '', 8);
		eventEaseInputText.onChange = function(str:String, str2:String)
		{
			var data = getCurrentEventInData();
			if (data != null)
			{
				if (data[EVENT_TYPE] == 'ease')
					data[EVENT_DATA][EVENT_EASE] = eventEaseInputText.text;
				else
					data[EVENT_DATA][EVENT_EASE] = 'linear';
			}
			dirtyUpdateEvents = true;
			hasUnsavedChanges = true;
		}
		eventTimeInputText.onChange = function(str:String, str2:String)
		{
			var data = getCurrentEventInData();
			if (data != null)
			{
				if (data[EVENT_TYPE] == 'ease')
					data[EVENT_DATA][EVENT_EASETIME] = eventTimeInputText.text;
				else
					data[EVENT_DATA][EVENT_TIME] = 0;
			}
			dirtyUpdateEvents = true;
			hasUnsavedChanges = true;
		}

		easeDropDown = new PsychUIDropDownMenu(25, eventEaseInputText.y + 30, easeList, function(id:Int, ease:String)
		{
			var easeStr = ease;
			eventEaseInputText.text = easeStr;
			eventEaseInputText.onChange("", ""); // make sure it updates
			hasUnsavedChanges = true;
		});
		centerXToObject(eventEaseInputText, easeDropDown);

		eventModifierDropDown = new PsychUIDropDownMenu(25, 50 + 20, mods, function(id:Int, mod:String)
		{
			var modName = mod;
			eventModInputText.text = modName;
			updateSubModList(modName);
			eventModInputText.onChange("", ""); // make sure it updates
			hasUnsavedChanges = true;
		});
		centerXToObject(eventModInputText, eventModifierDropDown);

		subModDropDown = new PsychUIDropDownMenu(25, 50 + 80, subMods, function(id:Int, subMod:String)
		{
			var modName = subMod;
			var splitShit = eventModInputText.text.split(":"); // use to get the normal mod

			if (modName == "")
			{
				eventModInputText.text = splitShit[0]; // remove the sub mod
			}
			else
			{
				eventModInputText.text = splitShit[0] + ":" + modName;
			}

			eventModInputText.onChange("", ""); // make sure it updates
			hasUnsavedChanges = true;
		});
		centerXToObject(eventModInputText, subModDropDown);

		eventDataInputText = new PsychUIInputText(25, 300, 300, '', 8);
		// eventDataInputText.resize(300, 300);
		eventDataInputText.onChange = function(str:String, str2:String)
		{
			var data = getCurrentEventInData();
			var allData = EVENT_EASEDATA;
			if (data != null)
			{
				if (data[EVENT_TYPE] == "set")
				{
					allData = EVENT_SETDATA;
				}
				data[EVENT_DATA][allData] = eventDataInputText.text;
				highlightedEvent = data;
				dirtyUpdateEvents = true;
				hasUnsavedChanges = true;
			}
		};

		var add:PsychUIButton = new PsychUIButton(0, selectedEventDataStepper.y + 30, 'Add', function()
		{
			var data = addNewModData();
			var allData = EVENT_EASEDATA;
			if (data != null)
			{
				if (data[EVENT_TYPE] == "set")
				{
					allData = EVENT_SETDATA;
				}
				highlightedEvent = data;
				updateSelectedEventDataStepper();
				eventDataInputText.text = highlightedEvent[EVENT_DATA][allData];
				eventModInputText.text = getEventModData(true);
				eventValueInputText.text = getEventModData(false);
				dirtyUpdateEvents = true;
				hasUnsavedChanges = true;
			}
		});
		var remove:PsychUIButton = new PsychUIButton(0, selectedEventDataStepper.y + 50, 'Remove', function()
		{
			var data = removeModData();
			var allData = EVENT_EASEDATA;
			if (data != null)
			{
				if (data[EVENT_TYPE] == "set")
				{
					allData = EVENT_SETDATA;
				}
				highlightedEvent = data;
				updateSelectedEventDataStepper();
				eventDataInputText.text = highlightedEvent[EVENT_DATA][allData];
				eventModInputText.text = getEventModData(true);
				eventValueInputText.text = getEventModData(false);
				dirtyUpdateEvents = true;
				hasUnsavedChanges = true;
			}
		});
		centerXToObject(selectedEventDataStepper, add);
		centerXToObject(selectedEventDataStepper, remove);
		tab_group.add(add);
		tab_group.add(remove);

		tab_group.add(addStacked);
		/*addUI(tab_group, "addStacked", addStacked, 'Add New Stacked Event', 'Adds a new stacked event and duplicates the current one.');

			addUI(tab_group, "eventDataInputText", eventDataInputText, 'Raw Event Data', 'The raw data used in the event, you wont really need to use this.');
			addUI(tab_group, "stackedEventStepper", stackedEventStepper, 'Stacked Event Stepper', 'Allows you to find/switch to stacked events.'); */
		tab_group.add(eventDataInputText);
		tab_group.add(stackedEventStepper);
		tab_group.add(makeLabel(stackedEventStepper, 0, -15, "Stacked Events Index"));

		tab_group.add(eventValueInputText);
		tab_group.add(eventModInputText);
		/*addUI(tab_group, "eventValueInputText", eventValueInputText, 'Event Value', 'The value that the modifier will change to.');
			addUI(tab_group, "eventModInputText", eventModInputText, 'Event Modifier', 'The name of the modifier used in the event.');

			addUI(tab_group, "repeatBeatGapStepper", repeatBeatGapStepper, 'Repeat Beat Gap', 'The amount of beats in between each repeat.');
			addUI(tab_group, "repeatCheckbox", repeatCheckbox, 'Repeat', 'Check the box if you want the event to repeat.');
			addUI(tab_group, "repeatCountStepper", repeatCountStepper, 'Repeat Count', 'How many times the event will repeat.'); */
		tab_group.add(repeatBeatGapStepper);
		tab_group.add(repeatCheckbox);
		tab_group.add(repeatCountStepper);
		tab_group.add(makeLabel(repeatBeatGapStepper, 0, -30, "How many beats in between\neach repeat?"));
		tab_group.add(makeLabel(repeatCountStepper, 0, -15, "How many times to repeat?"));

		/*addUI(tab_group, "eventEaseInputText", eventEaseInputText, 'Event Ease', 'The easing function used by the event (only for "ease" type).');
			addUI(tab_group, "eventTimeInputText", eventTimeInputText, 'Event Ease Time', 'How long the tween takes to finish in beats (only for "ease" type).'); */
		tab_group.add(eventEaseInputText);
		tab_group.add(eventTimeInputText);
		tab_group.add(makeLabel(eventEaseInputText, 0, -15, "Event Ease"));
		tab_group.add(makeLabel(eventTimeInputText, 0, -15, "Event Ease Time (in Beats)"));
		tab_group.add(makeLabel(eventTypeDropDown, 0, -15, "Event Type"));

		/*addUI(tab_group, "eventTimeStepper", eventTimeStepper, 'Event Time', 'The beat that the event occurs on.');
			addUI(tab_group, "selectedEventDataStepper", selectedEventDataStepper, 'Selected Event', 'Which modifier event is selected within the event.'); */
		tab_group.add(eventTimeStepper);
		tab_group.add(selectedEventDataStepper);
		tab_group.add(makeLabel(selectedEventDataStepper, 0, -15, "Selected Data Index"));
		tab_group.add(makeLabel(eventDataInputText, 0, -15, "Raw Event Data"));
		tab_group.add(makeLabel(eventValueInputText, 0, -15, "Event Value"));
		tab_group.add(makeLabel(eventModInputText, 0, -15, "Event Mod"));
		tab_group.add(makeLabel(subModDropDown, 0, -15, "Sub Mods"));

		tab_group.add(subModDropDown);
		tab_group.add(eventModifierDropDown);
		tab_group.add(eventTypeDropDown);
		tab_group.add(easeDropDown);
		/*addUI(tab_group, "subModDropDown", subModDropDown, 'Sub Mods', 'Drop down for sub mods on the currently selected modifier, not all mods have them.');
			addUI(tab_group, "eventModifierDropDown", eventModifierDropDown, 'Stored Modifiers', 'Drop down for stored modifiers.');
			addUI(tab_group, "eventTypeDropDown", eventTypeDropDown, 'Event Type', 'Drop down to swtich the event type, currently there is only "set" and "ease", "set" makes the event happen instantly, and "ease" has a time and an ease function to smoothly change the modifiers.');
			addUI(tab_group, "easeDropDown", easeDropDown, 'Eases', 'Drop down that stores all the built-in easing functions.'); */
	}

	function getCurrentEventInData() // find stored data to match with highlighted event
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

	function getMaxEventModDataLength() // used for the stepper so it doesnt go over max and break something
	{
		var data = getCurrentEventInData();
		if (data != null)
		{
			var dataStr:String = findCorrectModData(data);
			var dataSplit = dataStr.split(',');
			return Math.floor((dataSplit.length / 2) - 1);
		}
		return 0;
	}

	function updateSelectedEventDataStepper() // update the stepper
	{
		selectedEventDataStepper.max = getMaxEventModDataLength();
		if (selectedEventDataStepper.value > selectedEventDataStepper.max)
			selectedEventDataStepper.value = 0;
	}

	function updateStackedEventDataStepper() // update the stepper
	{
		stackedEventStepper.max = stackedHighlightedEvents.length - 1;
		stackedEventStepper.value = stackedEventStepper.max; // when you select an event, if theres stacked events it should be the one at the end of the list so just set it to the end
	}

	function getEventModIndex()
	{
		return Math.floor(selectedEventDataStepper.value);
	}

	var eventTypes:Array<String> = ["ease", "set"];

	function onSelectEvent(fromStackedEventStepper = false)
	{
		// update texts and stuff
		var allData = EVENT_EASEDATA;
		if (highlightedEvent != null)
		{
			if (highlightedEvent[EVENT_TYPE] == "set")
			{
				allData = EVENT_SETDATA;
			}
		}

		updateSelectedEventDataStepper();
		eventTimeStepper.value = Std.parseFloat(highlightedEvent[EVENT_DATA][EVENT_TIME]);
		eventDataInputText.text = highlightedEvent[EVENT_DATA][allData];

		eventEaseInputText.alpha = 0.5;
		eventTimeInputText.alpha = 0.5;
		if (highlightedEvent[EVENT_TYPE] == 'ease')
		{
			eventEaseInputText.alpha = 1;
			eventTimeInputText.alpha = 1;
			eventEaseInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASE];
			eventTimeInputText.text = highlightedEvent[EVENT_DATA][EVENT_EASETIME];
		}
		else
		{
			eventTimeInputText.text = "0";
			eventEaseInputText.text = "Linear";
		}
		eventTypeDropDown.selectedLabel = highlightedEvent[EVENT_TYPE];
		eventModInputText.text = getEventModData(true);
		eventValueInputText.text = getEventModData(false);
		repeatBeatGapStepper.value = highlightedEvent[EVENT_REPEAT][EVENT_REPEATBEATGAP];
		repeatCountStepper.value = highlightedEvent[EVENT_REPEAT][EVENT_REPEATCOUNT];
		repeatCheckbox.checked = highlightedEvent[EVENT_REPEAT][EVENT_REPEATBOOL];
		if (!fromStackedEventStepper)
			stackedEventStepper.value = 0;
		dirtyUpdateEvents = true;
	}

	public function UIEvent(id:String, sender:Dynamic)
	{
		if (id == PsychUINumericStepper.CHANGE_EVENT && (sender is PsychUINumericStepper))
		{
			if (sender == selectedEventDataStepper)
			{
				if (highlightedEvent != null)
				{
					var allData = EVENT_EASEDATA;
					if (highlightedEvent[EVENT_TYPE] == "set")
					{
						allData = EVENT_SETDATA;
					}
					eventDataInputText.text = highlightedEvent[EVENT_DATA][allData];
					eventModInputText.text = getEventModData(true);
					eventValueInputText.text = getEventModData(false);
				}
			}
			else if (sender == repeatBeatGapStepper)
			{
				var data = getCurrentEventInData();
				if (data != null)
				{
					data[EVENT_REPEAT][EVENT_REPEATBEATGAP] = repeatBeatGapStepper.value;
					highlightedEvent = data;
					hasUnsavedChanges = true;
					dirtyUpdateEvents = true;
				}
			}
			else if (sender == repeatCountStepper)
			{
				var data = getCurrentEventInData();
				if (data != null)
				{
					data[EVENT_REPEAT][EVENT_REPEATCOUNT] = repeatCountStepper.value;
					highlightedEvent = data;
					hasUnsavedChanges = true;
					dirtyUpdateEvents = true;
				}
			}
			else if (sender == stackedEventStepper)
			{
				if (highlightedEvent != null)
				{
					// trace(stackedHighlightedEvents);
					highlightedEvent = stackedHighlightedEvents[Std.int(stackedEventStepper.value)];
					onSelectEvent(true);
				}
			}
		}
	}

	var playfieldCountStepper:PsychUINumericStepper;
	var proxiefieldCountStepper:PsychUINumericStepper;

	function setupPlayfieldUI()
	{
		var tab_group = UI_box.getTab('Playfields').menu;

		playfieldCountStepper = new PsychUINumericStepper(25, 50, 1, 1, 1, 100, 0);
		playfieldCountStepper.value = playfieldRenderer.modchart.data.playfields;

		tab_group.add(playfieldCountStepper);
		tab_group.add(makeLabel(playfieldCountStepper, 0, -15, "Playfield Count"));
		tab_group.add(makeLabel(playfieldCountStepper, 55, 25, "Don't add too many or the game will lag!!!"));

		proxiefieldCountStepper = new PsychUINumericStepper(playfieldCountStepper.x + 150, 50, 1, 1, 1, 100, 0);
		proxiefieldCountStepper.value = playfieldRenderer.modchart.data.proxiefields;

		tab_group.add(proxiefieldCountStepper);
		tab_group.add(makeLabel(proxiefieldCountStepper, 0, -15, "Proxiefield Count"));
		// tab_group.add(makeLabel(proxieCountStepper, 55, 25, "Don't add too many or the game will lag!!!"));
	}

	var sliderRate:PsychUISlider;
	var songSlider:PsychUISlider;

	function setupEditorUI()
	{
		var tab_group = UI_box.getTab('Editor').menu;

		sliderRate = new PsychUISlider(20, 120, function(val:Float)
		{
			playbackSpeed = val;
			dirtyUpdateEvents = true;
		}, playbackSpeed, 0.1, 3, 250, FlxColor.WHITE, FlxColor.RED);
		sliderRate.label = 'Playback Rate';

		songSlider = new PsychUISlider(20, 200, function(val:Float)
		{
			inst.time = val;
			vocals.time = inst.time;
			opponentVocals.time = inst.time;
			Conductor.songPosition = inst.time;
			dirtyUpdateEvents = true;
			dirtyUpdateNotes = true;
		}, inst.time, 0, inst.length, 250, FlxColor.WHITE, FlxColor.RED);
		songSlider.label = 'Song Time';

		var check_mute_inst = new PsychUICheckBox(10, 20, "Mute Instrumental (in editor)", 100);
		check_mute_inst.checked = false;
		check_mute_inst.onClick = function()
		{
			var vol:Float = 1;

			if (check_mute_inst.checked)
				vol = 0;

			inst.volume = vol;
		};
		var check_mute_vocals = new PsychUICheckBox(check_mute_inst.x + 120, check_mute_inst.y, "Mute Main Vocals (in editor)", 100);
		check_mute_vocals.checked = false;
		check_mute_vocals.onClick = function()
		{
			var vol:Float = 1;
			if (check_mute_vocals.checked)
				vol = 0;

			if (vocals != null)
				vocals.volume = vol;
		};

		var check_mute_opponent_vocals = new PsychUICheckBox(check_mute_vocals.x + 120, check_mute_vocals.y, "Mute Opponent Vocals (in editor)", 100);
		check_mute_opponent_vocals.checked = false;
		check_mute_opponent_vocals.onClick = function()
		{
			var vol:Float = 1;
			if (check_mute_opponent_vocals.checked)
				vol = 0;
			if (opponentVocals != null)
				opponentVocals.volume = vol;
		};

		var resetSpeed:PsychUIButton = new PsychUIButton(sliderRate.x + 300, sliderRate.y, 'Reset', function()
		{
			playbackSpeed = 1.0;
			sliderRate.value = 1.0;
		});

		var saveJson:PsychUIButton = new PsychUIButton(20, 300, 'Save Modchart', function()
		{
			saveModchartJson(this);
		});
		tab_group.add(saveJson);
		// addUI(tab_group, "saveJson", saveJson, 'Save Modchart', 'Saves the modchart to a .json file which can be stored and loaded later.');
		// tab_group.addAsset(saveJson, "saveJson");
		tab_group.add(sliderRate);
		// addUI(tab_group, "resetSpeed", resetSpeed, 'Reset Speed', 'Resets playback speed to 1.');
		tab_group.add(resetSpeed);
		tab_group.add(songSlider);

		tab_group.add(check_mute_inst);
		tab_group.add(check_mute_vocals);
	}

	/*function addUI(tab_group:FlxUI, name:String, ui:FlxSprite, title:String = "", body:String = "", anchor:Anchor = null)
		{
			tooltips.add(ui, {
				title: title,
				body: body,
				anchor: anchor,
				style: {
					titleWidth: 150,
					bodyWidth: 150,
					bodyOffset: new FlxPoint(5, 5),
					leftPadding: 5,
					rightPadding: 5,
					topPadding: 5,
					bottomPadding: 5,
					borderSize: 1,
				}
			});

			tab_group.add(ui);
	}*/
	function centerXToObject(obj1:FlxSprite, obj2:FlxSprite) // snap second obj to first
	{
		obj2.x = obj1.x + (obj1.width / 2) - (obj2.width / 2);
	}

	function makeLabel(obj:FlxSprite, offsetX:Float, offsetY:Float, textStr:String)
	{
		var text = new FlxText(0, obj.y + offsetY, 0, textStr);
		centerXToObject(obj, text);
		text.x += offsetX;
		return text;
	}

	var _file:FileReference;

	public function saveModchartJson(?instance:ModchartMusicBeatState = null):Void
	{
		if (instance == null)
			instance = PlayState.instance;

		var data:String = Json.stringify(instance.playfieldRenderer.modchart.data, "\t");
		// data = data.replace("\n", "");
		// data = data.replace(" ", "");
		#if sys
		// sys.io.File.saveContent("modchart.json", data.trim());
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

		var goBackButton:PsychUIButton = new PsychUIButton(0, 500, 'Go Back', function()
		{
			close();
		});
		goBackButton.scale.set(2.5, 2.5);
		goBackButton.updateHitbox();
		goBackButton.x = (FlxG.width * 0.3) - (goBackButton.width * 0.5);
		add(goBackButton);

		var exit:PsychUIButton = new PsychUIButton(0, 500, 'Exit without saving', function()
		{
			exitFunc();
		});
		exit.scale.set(2.5, 2.5);
		exit.updateHitbox();
		exit.x = (FlxG.width * 0.7) - (exit.width * 0.5);
		add(exit);

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}
}
