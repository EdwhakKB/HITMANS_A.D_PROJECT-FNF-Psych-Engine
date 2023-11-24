package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class MiscSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Misc Settings';
		rpcTitle = 'Note Misc Settings Menu'; //for Discord Rich Presence

        var option:Option = new Option('Mine Skin:',
		"What Mine Note Skin You want to use??.",
		'noteSkin[2]',
		'string',
		'HITMANS',
		['HITMANS', 'FNF', 'INHUMAN', 'STEPMANIA', 'DELTA', 'GROVE', 'SUSSY', 'EPIC', 'ITGOPT', 'DDR', 'ITHIT']);
		addOption(option);
		option.onChange = onChangeSkin;

		super();
	}
}