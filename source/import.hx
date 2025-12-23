#if !macro
import engine.*;
import engine.Paths;
import engine.CoolUtil;
import engine.Conductor;
import engine.ClientPrefs;
#if DISCORD_ALLOWED
import engine.Discord;
import engine.Discord.DiscordClient;
#end
#if MODS_ALLOWED
import engine.Mods;
#end
import engine.WeekData;
import engine.StageData;
import cutscene.*;
import objects.*;
import scripting.*;
import states.*;
import states.menus.*;
import states.subs.*;
import shaders.*;
import play.*;
import huds.*;
import editors.*;
import editors.content.Prompt;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

import lime.utils.Assets as LimeAssets;
import openfl.utils.Assets as OpenFLAssets;

// Flixel
import flixel.*;
import flixel.text.*;
import flixel.text.FlxText;
import flixel.util.*;
import flixel.util.FlxTimer;
import flixel.ui.*;
import flixel.ui.FlxBar;
import flixel.sound.*;
import flixel.tweens.*;
import flixel.tweens.FlxTween;
import flixel.math.*;
import flixel.group.*;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.system.*;
import flixel.system.FlxAssets;

import modcharting.*;
import modcharting.utils.RGBPalette;
import modcharting.utils.RGBPalette.RGBShaderReference;

#if ACHIEVEMENTS_ALLOWED
import achievements.*;
#end


#if flxanimate
import flxanimate.PsychFlxAnimate as FlxAnimate;
#end

import haxe.Json;

import scripting.SSHScript;

#if SScript
import tea.SScript;
#end

using StringTools;
#end