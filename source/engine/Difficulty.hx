package engine;

class Difficulty
{
	public static final defaultList:Array<String> = [
		'begginer',
		'light',
		'standard',
		'heavy',
		'oni',
		'massacre',
		'hitman'
	];
	private static final defaultDifficulty:String = 'standard'; //The chart that has no postfix and starting difficulty on Freeplay/Story Mode

	public static var list:Array<String> = [];

	inline public static function getFilePath(num:Null<Int> = null)
	{
		num ??= PlayState.storyDifficulty;

		var filePostfix:String = list[num];
		if(filePostfix != null && Paths.formatToSongPath(filePostfix) != Paths.formatToSongPath(defaultDifficulty))
			filePostfix = '-' + filePostfix;
		else
			filePostfix = '';
		return Paths.formatToSongPath(filePostfix);
	}

	inline public static function loadFromWeek(week:WeekData = null)
	{
		week ??= WeekData.getCurrentWeek();

		var diffStr:String = week.difficulties;
		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.trim().split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
				list = diffs;
		}
		else resetList();
	}

	inline public static function resetList(skipCheck:Bool = true) {
        if ((!skipCheck && list.length < 1) || skipCheck) list = defaultList.copy();
    }

	inline public static function copyFrom(diffs:Array<String>)
	    list = diffs.copy();

	inline public static function getString(?num:Null<Int> = null):String
		return list[num ??= PlayState.storyDifficulty] ?? defaultDifficulty;

	inline public static function getDefault():String
	    return defaultDifficulty;
}