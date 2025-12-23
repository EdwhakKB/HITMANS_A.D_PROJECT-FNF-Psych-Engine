package options;

import openfl.text.TextField;
import flixel.addons.display.FlxGridOverlay;

import flixel.FlxSubState;
import openfl.text.TextField;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import play.Controls;

class MiscSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Misc Settings';
		rpcTitle = 'Note Misc Settings Menu'; //for Discord Rich Presence

        var option:Option = new Option('Mine Skin:',
		"What Mine Note Skin You want to use??.",
		'mineSkin',
		'string',
		'HITMANS',
		['HITMANS', 'FNF', 'INHUMAN', 'STEPMANIA', 'NOTITG', 'ITHIT']);
		addOption(option);
		// option.onChange = onChangeSkin;

		var option:Option = new Option('Mimic Note Alpha:',
			'Changes the alpha of the mimic notes',
			'mimicNoteAlpha',
			'float',
			0.5);
		option.scrollSpeed = 1;
		option.minValue = 0.3;
		option.maxValue = 0.7;
		option.changeValue = 0.1;
		addOption(option);

		var option:Option = new Option('Note Quantization',
		"Notes will change their color based on the beats.",
		'quantization',
		'bool',
		false);
		addOption(option);

		super();
	}
}