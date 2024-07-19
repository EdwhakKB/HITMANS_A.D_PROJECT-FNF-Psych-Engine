package editors;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

#if MODS_ALLOWED
import sys.FileSystem;
#end

import flixel.util.FlxTimer;
import flash.system.System;
import openfl.Lib;

using StringTools;

class MasterEditorMenu extends MusicBeatState
{
	var options:Array<String> = [
		'Week Editor',
		'Menu Character Editor',
		'Dialogue Editor',
		'Dialogue Portrait Editor',
		'Character Editor',
		'Chart Editor'
	];
	private var grpTexts:FlxTypedGroup<Alphabet>;
	private var directories:Array<String> = [null];

	private var curSelected = 0;
	private var curDirectory = 0;
	private var directoryTxt:FlxText;

	var hitmansSongs:Array<String> = ['c18h27no3-demo', 'forgotten', 'icebeat', 'hernameis', 'duality', 'hallucination', 'operating']; // Anti cheat system goes brrrrr

	override function create()
	{
		FlxG.camera.bgColor = FlxColor.BLACK;
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Editors Main Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set();
		bg.color = 0xFF353535;
		add(bg);

		grpTexts = new FlxTypedGroup<Alphabet>();
		add(grpTexts);

		for (i in 0...options.length)
		{
			var leText:Alphabet = new Alphabet(90, 320, options[i], true);
			leText.isMenuItem = true;
			leText.targetY = i;
			grpTexts.add(leText);
			leText.snapToPosition();
		}
		
		#if MODS_ALLOWED
		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 42).makeGraphic(FlxG.width, 42, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		directoryTxt = new FlxText(textBG.x, textBG.y + 4, FlxG.width, '', 32);
		directoryTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		directoryTxt.scrollFactor.set();
		add(directoryTxt);
		for (folder in Mods.getModDirectories())
		{
			directories.push(folder);
		}

		var found:Int = directories.indexOf(Mods.currentModDirectory);
		if(found > -1) curDirectory = found;
		changeDirectory();
		#end
		changeSelection();

		FlxG.mouse.visible = false;
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}
		#if MODS_ALLOWED
		if(controls.UI_LEFT_P)
		{
			changeDirectory(-1);
		}
		if(controls.UI_RIGHT_P)
		{
			changeDirectory(1);
		}
		#end

		if (controls.BACK)
		{
			MusicBeatState.switchState(new MainMenuState());
		}

		if (controls.ACCEPT)
		{
			switch(options[curSelected]) {
				case 'Character Editor':
					LoadingState.loadAndSwitchState(new CharacterEditorState(Character.DEFAULT_CHARACTER, false));
				case 'Week Editor':
					MusicBeatState.switchState(new WeekEditorState());
				case 'Menu Character Editor':
					MusicBeatState.switchState(new MenuCharacterEditorState());
				case 'Dialogue Portrait Editor':
					LoadingState.loadAndSwitchState(new DialogueCharacterEditorState(), false);
				case 'Dialogue Editor':
					LoadingState.loadAndSwitchState(new DialogueEditorState(), false);
				case 'Chart Editor'://felt it would be cool maybe
					if (PlayState.SONG != null && PlayState.SONG.song != null){
						if (hitmansSongs.contains(PlayState.SONG.song.toLowerCase()) && !ClientPrefs.edwhakMode && !ClientPrefs.developerMode){
							antiCheat();
						}else{
							LoadingState.loadAndSwitchState(new ChartingState(), false);
						}
					}else{
						LoadingState.loadAndSwitchState(new ChartingState(), false);
					}
			}
			FlxG.sound.music.volume = 0;
			#if PRELOAD_ALL
			FreeplayState.destroyFreeplayVocals();
			#end
		}
		
		var bullShit:Int = 0;
		for (item in grpTexts.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;
	}

	function antiCheat(){
			//fuck you
			if (FlxG.sound.music.playing)
			{
				FlxG.sound.music.pause();
			}

			var edwhakBlack:BGSprite = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
			edwhakBlack.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
			edwhakBlack.scrollFactor.set(1);

			var edwhakBG:BGSprite = new BGSprite('Edwhak/Hitmans/unused/cheat-bg');
			edwhakBG.setGraphicSize(FlxG.width, FlxG.height);
			//edwhakBG.x += (FlxG.width/2); //Mmmmmm scuffed positioning, my favourite!
			//edwhakBG.y += (FlxG.height/2) - 20;
			edwhakBG.updateHitbox();
			edwhakBG.scrollFactor.set(1);
			edwhakBG.screenCenter();
			edwhakBG.x=0;

			var cheater:BGSprite = new BGSprite('Edwhak/Hitmans/unused/cheat', -600, -480, 0.5, 0.5);
			cheater.setGraphicSize(Std.int(cheater.width * 1.5));
			cheater.updateHitbox();
			cheater.scrollFactor.set(1);
			cheater.screenCenter();	
			cheater.x+=50;

			add(edwhakBlack);
			add(edwhakBG);
			add(cheater);
			FlxG.camera.shake(0.05,5);
			FlxG.sound.play(Paths.sound('Edwhak/cheatercheatercheater'), 1, true);
			#if desktop
			// Updating Discord Rich Presence
			DiscordClient.changePresence("CHEATER CHEATER CHEATER CHEATER CHEATER CHEATER ", StringTools.replace(PlayState.SONG.song, '-', ' '));
			#end

			//Stolen from the bob mod LMAO
			new FlxTimer().start(0.01, function(tmr:FlxTimer)
				{
					Lib.application.window.move(Lib.application.window.x + FlxG.random.int( -10, 10),Lib.application.window.y + FlxG.random.int( -8, 8));
				}, 0);

			new FlxTimer().start(1.5, function(tmr:FlxTimer) 
			{
				//trace("Quit");
				System.exit(0);
			});
	}

	#if MODS_ALLOWED
	function changeDirectory(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curDirectory += change;

		if(curDirectory < 0)
			curDirectory = directories.length - 1;
		if(curDirectory >= directories.length)
			curDirectory = 0;
	
		WeekData.setDirectoryFromWeek();
		if(directories[curDirectory] == null || directories[curDirectory].length < 1)
			directoryTxt.text = '< No Mod Directory Loaded >';
		else
		{
			Mods.currentModDirectory = directories[curDirectory];
			directoryTxt.text = '< Loaded Mod Directory: ' + Mods.currentModDirectory + ' >';
		}
		directoryTxt.text = directoryTxt.text.toUpperCase();
	}
	#end
}