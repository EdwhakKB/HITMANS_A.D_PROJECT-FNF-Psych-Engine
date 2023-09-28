/*package;

import ClientPrefs;
import flixel.util.FlxColor;

class Ratings
{
	public static var timingWindows:Array<RatingWindow> = []; //highest rating goes first

	public static function judgeNote(noteDiff:Float):RatingWindow
	{
		var diff = Math.abs(noteDiff);

		var shitWindows:Array<RatingWindow> = timingWindows.copy();
		shitWindows.reverse();

		if (PlayState.instance != null && PlayState.instance.cpuControlled)
			return shitWindows[0];

		for (index in 0...shitWindows.length)
		{
			if (diff <= shitWindows[index].timingWindow)
			{
				return shitWindows[index];
			}
		}
		return shitWindows[shitWindows.length - 1];
	}
}

class RatingWindow
{
	public var name:String;
	public var timingWindow:Float;
	public var displayColor:FlxColor;
	public var healthBonus:Float;
	public var scoreBonus:Float;
	public var defaultTimingWindow:Float;
	public var causeMiss:Bool;
	public var doNoteSplash:Bool;
	public var count:Int = 0;
	public var accuracyBonus:Float;

	public var pluralSuffix:String;

	public var comboRanking:String;

	public function new(name:String, timingWindow:Float, comboRanking:String, displayColor:FlxColor, healthBonus:Float, scoreBonus:Float, accuracyBonus:Float,
			causeMiss:Bool, doNoteSplash:Bool)
	{
		this.name = name;
		this.timingWindow = timingWindow;
		this.comboRanking = comboRanking;
		this.displayColor = displayColor;
		this.healthBonus = healthBonus;
		this.scoreBonus = scoreBonus;
		this.accuracyBonus = accuracyBonus;
		this.causeMiss = causeMiss;
		this.doNoteSplash = doNoteSplash;
	}

	public static function createRatings():Void
	{
		Ratings.timingWindows = [];
	
		var ratings:Array<String> = ['Shit', 'Bad', 'Good', 'Sick', 'Marvelous'];
		var timings:Array<Float> = [
			ClientPrefs.shitWindow,
			ClientPrefs.badWindow,
			ClientPrefs.goodWindow,
			ClientPrefs.sickWindow,
			ClientPrefs.marvelousWindow
		];
		var colors:Array<FlxColor> = [
			FlxColor.fromString('0xfb8e01'),
			FlxColor.fromString('0xFF8C00FF'),
			FlxColor.fromString('0xED0800FF'),
			FlxColor.fromString('0xFFFFE600'),
			FlxColor.fromString('0xFF00B400')
		];
		var acc:Array<Float> = [-1.00, 0.5, 0.75, 1.00, 1.00];

		var healthBonuses:Array<Float> = [-0.2, -0.06, 0, 0.04, 0.06];
		var scoreBonuses:Array<Int> = [-300, 0, 200, 350, 450];
		var defaultTimings:Array<Float> = [180, 135, 90, 45, 22.5];
		var missArray:Array<Bool> = [false, false, false, false, false];
		var splashArray:Array<Bool> = [false, false, false, false, false];
		var suffixes:Array<String> = ['s', 's', 's', 's', 's'];
		var combos:Array<String> = ['', 'FC', 'GFC', 'PFC', 'MFC'];

		for (i in 0...ratings.length)
		{
			var rClass = new RatingWindow(ratings[i], timings[i], combos[i], colors[i], healthBonuses[i], scoreBonuses[i], acc[i], missArray[i],
				splashArray[i]);
			rClass.defaultTimingWindow = defaultTimings[i];
			rClass.pluralSuffix = suffixes[i];
			Ratings.timingWindows.push(rClass);
		}
	}
}*/


//Awful enough to give up fast, might try back in a future, a LONG LONG future...

//thanks glow for the help but yeah... it was killing myself slowly...

//Edwhak - 27/09/2023
