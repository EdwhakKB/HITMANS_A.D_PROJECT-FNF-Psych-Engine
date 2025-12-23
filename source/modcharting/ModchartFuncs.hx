package modcharting;

// import editors.EditorLua;
// import editors.content.EditorPlayState;
import flixel.FlxG;
import haxe.Json;
import modcharting.ModchartUtil;
import modcharting.Modifier;
import modcharting.modifiers.*;
import modcharting.NoteMovement;
import modcharting.PlayfieldRenderer;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileReference;

using StringTools;

#if LUA_ALLOWED
import llua.Convert;
import llua.Lua;
import llua.LuaL;
import llua.State;
#end
#if LEATHER
import game.Conductor;
import states.PlayState;
#end

// for lua and hscript
class ModchartFuncs
{
	public static var editor:Bool = false;

	public static function loadLuaFunctions()
	{
		loadVars(true);
	}

	public static function loadLuaEditorFunctions()
	{
		loadVars(false);
	}

	public static function loadVars(isPlayState:Bool = true)
	{
		#if PSYCH
		#if LUA_ALLOWED
		// if (isPlayState)
		// {
		for (funkin in PlayState.instance.luaArray)
		{
			Lua_helper.add_callback(funkin.lua, 'startMod', function(name:String, modClass:String, type:String = '', pf:Int = -1)
			{
				startMod(name, modClass, type, pf);

				PlayState.instance.playfieldRenderer.modifierTable.reconstructTable(); // needs to be reconstructed for lua modcharts
			});
			Lua_helper.add_callback(funkin.lua, 'registerMod', function(name:String, type:String = '', pf:Int = -1)
			{
				registerMod(name, type, pf);

				PlayState.instance.playfieldRenderer.modifierTable.reconstructTable(); // needs to be reconstructed for lua modcharts
			});
			Lua_helper.add_callback(funkin.lua, 'setMod', function(name:String, value:Float)
			{
				setMod(name, value);
			});
			Lua_helper.add_callback(funkin.lua, 'setSubMod', function(name:String, subValName:String, value:Float)
			{
				setSubMod(name, subValName, value);
			});
			Lua_helper.add_callback(funkin.lua, 'setModTargetLane', function(name:String, value:Int)
			{
				setModTargetLane(name, value);
			});
			Lua_helper.add_callback(funkin.lua, 'setModPlayfield', setModPlayfield);
			Lua_helper.add_callback(funkin.lua, 'addPlayfield', addPlayfield);
			Lua_helper.add_callback(funkin.lua, 'removePlayfield', removePlayfield);
			Lua_helper.add_callback(funkin.lua, 'tweenModifier', tweenModifier);
			Lua_helper.add_callback(funkin.lua, 'tweenModifierSubValue', tweenModifierSubValue);
			Lua_helper.add_callback(funkin.lua, 'setModEaseFunc', setModEaseFunc);
			Lua_helper.add_callback(funkin.lua, 'set', function(beat:Float, argsAsString:String)
			{
				set(beat, argsAsString);
			});
			Lua_helper.add_callback(funkin.lua, 'ease', function(beat:Float, time:Float, easeStr:String, argsAsString:String)
			{
				ease(beat, time, easeStr, argsAsString);
			});
			Lua_helper.add_callback(funkin.lua, 'stepSet', function(beat:Float, argsAsString:String)
			{
				stepSet(beat, argsAsString);
			});
			Lua_helper.add_callback(funkin.lua, 'stepEase', function(beat:Float, time:Float, easeStr:String, argsAsString:String)
			{
				stepEase(beat, time, easeStr, argsAsString);
			});
			Lua_helper.add_callback(funkin.lua, 'add', function(beat:Float, time:Float, easeStr:String, argsAsString:String)
			{
				add(beat, time, easeStr, argsAsString);
			});
			Lua_helper.add_callback(funkin.lua, 'setAdd', function(beat:Float, argsAsString:String)
			{
				setAdd(beat, argsAsString);
			});
			Lua_helper.add_callback(funkin.lua, 'getMod', function(name:String, base:Bool = false)
			{
				var result = getMod(name, base);
				return result;
			});
			Lua_helper.add_callback(funkin.lua, 'getSubMod', function(name:String, subMod:String, base:Bool = false)
			{
				var result = getSubMod(name, subMod, base);
				return result;
			});
		}
		// }
		// else
		// {
		//     for (funkin in EditorPlayState.instance.luaArray)
		//     {
		//         Lua_helper.add_callback(funkin.lua, 'startMod', function(name:String, modClass:String, type:String = '', pf:Int = -1){
		//             startMod(name,modClass,type,pf);

		//             EditorPlayState.instance.playfieldRenderer.modifierTable.reconstructTable(); //needs to be reconstructed for lua modcharts
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'setMod', function(name:String, value:Float){
		//             setMod(name, value);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'setSubMod', function(name:String, subValName:String, value:Float){
		//             setSubMod(name, subValName,value);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'setModTargetLane', function(name:String, value:Int){
		//             setModTargetLane(name, value);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'setModPlayfield', function(name:String, value:Int){
		//             setModPlayfield(name,value);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'addPlayfield', function(?x:Float = 0, ?y:Float = 0, ?z:Float = 0){
		//             addPlayfield(x,y,z);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'removePlayfield', function(idx:Int){
		//             removePlayfield(idx);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'tweenModifier', function(modifier:String, val:Float, time:Float, ease:String){
		//             tweenModifier(modifier,val,time,ease);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'tweenModifierSubValue', function(modifier:String, subValue:String, val:Float, time:Float, ease:String){
		//             tweenModifierSubValue(modifier,subValue,val,time,ease);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'setModEaseFunc', function(name:String, ease:String){
		//             setModEaseFunc(name,ease);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'set', function(beat:Float, argsAsString:String){
		//             set(beat, argsAsString);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'ease', function(beat:Float, time:Float, easeStr:String, argsAsString:String){
		//             ease(beat, time, easeStr, argsAsString);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'stepSet', function(beat:Float, argsAsString:String){
		//             stepSet(beat, argsAsString);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'stepEase', function(beat:Float, time:Float, easeStr:String, argsAsString:String){
		//             stepEase(beat, time, easeStr, argsAsString);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'add', function(beat:Float, time:Float, easeStr:String, argsAsString:String){
		//             add(beat, time, easeStr, argsAsString);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'setAdd', function(beat:Float, argsAsString:String){
		//             setAdd(beat, argsAsString);
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'getMod', function(name:String, base:Bool = false){
		//             var result = getMod(name, base);
		//             return result;
		//         });
		//         Lua_helper.add_callback(funkin.lua, 'getSubMod', function(name:String, subMod:String, base:Bool = false){
		//             var result = getSubMod(name, subMod, base);
		//             return result;
		//         });
		//     }

		//     #if hscript
		//     if (EditorLua.hscript != null)
		//     {
		//         EditorLua.hscript.variables.set('Math', Math);
		//         EditorLua.hscript.variables.set('PlayfieldRenderer', PlayfieldRenderer);
		//         EditorLua.hscript.variables.set('ModchartUtil', ModchartUtil);
		//         EditorLua.hscript.variables.set('Modifier', Modifier);
		//         EditorLua.hscript.variables.set('NoteMovement', NoteMovement);
		//         EditorLua.hscript.variables.set('NotePositionData', NotePositionData);
		//         EditorLua.hscript.variables.set('ModchartFile', ModchartFile);
		//     }
		//     #end
		// }
		#end
		#end
	}

	public static function loadHScriptFunctions(parent:Dynamic)
	{
		#if HSCRIPT_ALLOWED
		parent.set('startMod', function(name:String, modClass:String, type:String = '', pf:Int = -1)
		{
			startMod(name, modClass, type, pf);

			if (PlayState.instance == FlxG.state && PlayState.instance.playfieldRenderer != null)
			{
				PlayState.instance.playfieldRenderer.modifierTable.reconstructTable(); // needs to be reconstructed for lua modcharts
			}
		});
		parent.set('registerMod', function(name:String, type:String = '', pf:Int = -1)
		{
			registerMod(name, type, pf);

			if (PlayState.instance == FlxG.state && PlayState.instance.playfieldRenderer != null)
			{
				PlayState.instance.playfieldRenderer.modifierTable.reconstructTable(); // needs to be reconstructed for lua modcharts
			}
		});
		parent.set('setMod', setMod);
		parent.set('setSubMod', setSubMod);
		parent.set('setModTargetLane', setModTargetLane);
		parent.set('setModPlayfield', setModPlayfield);
		parent.set('addPlayfield', addPlayfield);
		parent.set('removePlayfield', removePlayfield);
		parent.set('tweenModifier', tweenModifier);
		parent.set('tweenModifierSubValue', tweenModifierSubValue);
		parent.set('setModEaseFunc', setModEaseFunc);
		parent.set('setModValue', set);
		parent.set('easeModValue', ease);
		parent.set('sSetModValue', stepSet);
		parent.set('sEaseModValue', stepEase);
		parent.set('setAdd', setAdd);
		parent.set('easeAdd', add);
		parent.set('getMod', function(name:String, base:Bool = false) return getMod(name, base));
		parent.set('getSubMod', function(name:String, subMod:String, base:Bool = false) return getSubMod(name, subMod, base));
		#end
	}

	public static function startMod(name:String, modClass:String, type:String = '', pf:Int = -1, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
			if (instance.playfieldRenderer.modchart.scriptListen)
			{
				instance.playfieldRenderer.modchart.data.modifiers.push([name, modClass, type, pf]);
				trace(name, modClass, type, pf);
			}
		}

		if (instance.playfieldRenderer.modchart.customModifiers.exists(modClass))
		{
			var modifier = new Modifier(name, getModTypeFromString(type), pf);
			if (instance.playfieldRenderer.modchart.customModifiers.get(modClass).interp != null)
				instance.playfieldRenderer.modchart.customModifiers.get(modClass).interp.variables.set('instance', instance);
			instance.playfieldRenderer.modchart.customModifiers.get(modClass)
				.initMod(modifier); // need to do it this way instead because using current value in the modifier script didnt work
			// var modifier = instance.playfieldRenderer.modchart.customModifiers.get(modClass).copy();
			// modifier.tag = name; //set correct stuff because its copying shit
			// modifier.playfield = pf;
			// modifier.type = getModTypeFromString(type);
			instance.playfieldRenderer.modifierTable.add(modifier);
			return;
		}

		var mod = Type.resolveClass('modcharting.modifiers.' + modClass);
		if (mod == null)
		{
			mod = Type.resolveClass('modcharting.modifiers.' + modClass + "Modifier");
		} // dont need to add "Modifier" to the end of every mod

		if (mod != null)
		{
			var modType = getModTypeFromString(type);
			var modifier = Type.createInstance(mod, [name, modType, pf]);
			instance.playfieldRenderer.modifierTable.add(modifier);
		}
	}

	public static function registerMod(name:String, type:String = '', pf:Int = -1, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
			if (instance.playfieldRenderer.modchart.scriptListen)
			{
				instance.playfieldRenderer.modchart.data.modifiers.push([name, "Modifier", type, pf]);
				trace(name, "Modifier", type, pf);
			}
		}

		if (instance.playfieldRenderer.modchart.customModifiers.exists("Modifier"))
		{
			var modifier = new Modifier(name, getModTypeFromString(type), pf);
			if (instance.playfieldRenderer.modchart.customModifiers.get("Modifier").interp != null)
				instance.playfieldRenderer.modchart.customModifiers.get("Modifier").interp.variables.set('instance', instance);
			instance.playfieldRenderer.modchart.customModifiers.get("Modifier")
				.initMod(modifier); // need to do it this way instead because using current value in the modifier script didnt work
			// var modifier = instance.playfieldRenderer.modchart.customModifiers.get(modClass).copy();
			// modifier.tag = name; //set correct stuff because its copying shit
			// modifier.playfield = pf;
			// modifier.type = getModTypeFromString(type);
			instance.playfieldRenderer.modifierTable.add(modifier);
			return;
		}

		var mod = Type.resolveClass('modcharting.Modifier');
		if (mod != null)
		{
			var modType = getModTypeFromString(type);
			var modifier = Type.createInstance(mod, [name, modType, pf]);
			instance.playfieldRenderer.modifierTable.add(modifier);
		}
	}

	public static function getModTypeFromString(type:String)
	{
		var modType = ModifierType.ALL;
		switch (type.toLowerCase())
		{
			case 'player':
				modType = ModifierType.PLAYERONLY;
			case 'opponent':
				modType = ModifierType.OPPONENTONLY;
			case 'lane' | 'lanespecific':
				modType = ModifierType.LANESPECIFIC;
		}
		return modType;
	}

	public static function setMod(name:String, value:Float, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		if (instance.playfieldRenderer.modchart.scriptListen)
		{
			instance.playfieldRenderer.modchart.data.events.push(["set", [0, value + "," + name]]);
		}
		if (instance.playfieldRenderer.modifierTable.modifiers.exists(name))
			instance.playfieldRenderer.modifierTable.modifiers.get(name).currentValue = value;
	}

	public static function setSubMod(name:String, subValName:String, value:Float, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		if (instance.playfieldRenderer.modchart.scriptListen)
		{
			instance.playfieldRenderer.modchart.data.events.push(["set", [0, value + "," + name + ":" + subValName]]);
		}
		if (instance.playfieldRenderer.modifiers.exists(name))
			if (instance.playfieldRenderer.modifiers.get(name).subValues.exists(subValName))
				instance.playfieldRenderer.modifiers.get(name).subValues.get(subValName).value = value;
			else
				instance.playfieldRenderer.modifiers.get(name).subValues.set(subValName, new Modifier.ModifierSubValue(value));
	}

	public static function setModTargetLane(name:String, value:Int, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		if (instance.playfieldRenderer.modifierTable.modifiers.exists(name))
			instance.playfieldRenderer.modifierTable.modifiers.get(name).targetLane = value;
	}

	public static function setModPlayfield(name:String, value:Int, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		if (instance.playfieldRenderer.modifierTable.modifiers.exists(name))
			instance.playfieldRenderer.modifierTable.modifiers.get(name).playfield = value;
	}

	public static function addPlayfield(?index:Int, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		instance.playfieldRenderer.addPlayfield(index ?? instance.playfieldRenderer.noteFields.length);
	}

	public static function removePlayfield(idx:Int, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		instance.playfieldRenderer.removePlayfield(idx);
	}

	public static function tweenModifier(modifier:String, val:Float, time:Float, ease:String, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		instance.playfieldRenderer.modifierTable.tweenModifier(modifier, val, time, ease, Modifier.beat);
	}

	public static function tweenModifierSubValue(modifier:String, subValue:String, val:Float, time:Float, ease:String, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		instance.playfieldRenderer.modifierTable.tweenModifierSubValue(modifier, subValue, val, time, ease, Modifier.beat);
	}

	public static function setModEaseFunc(name:String, ease:String, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}
		if (instance.playfieldRenderer.modifierTable.modifiers.exists(name))
		{
			var mod = instance.playfieldRenderer.modifierTable.modifiers.get(name);
			if (Std.isOfType(mod, modcharting.modifiers.Incoming.Ease))
			{
				var temp:Dynamic = mod;
				var castedMod:modcharting.modifiers.Incoming.Ease = temp;
				castedMod.setEase(ease);
			}
		}
	}

	public static function set(beat:Float, argsAsString:String, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
			if (instance.playfieldRenderer.modchart.scriptListen)
			{
				instance.playfieldRenderer.modchart.data.events.push(["set", [beat, argsAsString]]);
			}
		}
		var args = argsAsString.trim().replace(' ', '').split(',');

		instance.playfieldRenderer.eventManager.addEvent(beat, function(arguments:Array<String>)
		{
			for (i in 0...Math.floor(arguments.length / 2))
			{
				var name:String = Std.string(arguments[1 + (i * 2)]);
				var value:Float = Std.parseFloat(arguments[0 + (i * 2)]);
				if (Math.isNaN(value))
					value = 0;
				if (instance.playfieldRenderer.modifierTable.modifiers.exists(name))
				{
					instance.playfieldRenderer.modifierTable.modifiers.get(name).currentValue = value;
				}
				else
				{
					var subModCheck = name.split(':');
					if (subModCheck.length > 1)
					{
						var modName = subModCheck[0];
						var subModName = subModCheck[1];
						if (instance.playfieldRenderer.modifierTable.modifiers.exists(modName))
							instance.playfieldRenderer.modifierTable.modifiers.get(modName).subValues.get(subModName).value = value;
					}
				}
			}
		}, args);
	}

	public static function ease(beat:Float, time:Float, ease:String, argsAsString:String, ?instance:ModchartMusicBeatState = null):Void
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
			if (instance.playfieldRenderer.modchart.scriptListen)
			{
				instance.playfieldRenderer.modchart.data.events.push(["ease", [beat, time, ease, argsAsString]]);
			}
		}

		if (Math.isNaN(time))
			time = 1;

		var args = argsAsString.trim().replace(' ', '').split(',');

		var func = function(arguments:Array<String>)
		{
			for (i in 0...Math.floor(arguments.length / 2))
			{
				var name:String = Std.string(arguments[1 + (i * 2)]);
				var value:Float = Std.parseFloat(arguments[0 + (i * 2)]);
				if (Math.isNaN(value))
					value = 0;
				var subModCheck = name.split(':');
				if (subModCheck.length > 1)
				{
					var modName = subModCheck[0];
					var subModName = subModCheck[1];
					// trace(subModCheck);
					instance.playfieldRenderer.modifierTable.tweenModifierSubValue(modName, subModName, value, time * Conductor.crochet * 0.001, ease, beat);
				}
				else
					instance.playfieldRenderer.modifierTable.tweenModifier(name, value, time * Conductor.crochet * 0.001, ease, beat);
			}
		};
		instance.playfieldRenderer.eventManager.addEvent(beat, func, args);
	}

	public static function stepSet(step:Float, argsAsString:String)
	{
		var actualBeat = (step / 4);
		set(actualBeat, argsAsString);
	}

	public static function stepEase(step:Float, time:Float, daease:String, argsAsString:String)
	{
		var actualBeat = (step / 4);
		ease(actualBeat, time, daease, argsAsString);
	}

	public static function add(beat:Float, time:Float, ease:String, argsAsString:String, ?instance:ModchartMusicBeatState = null):Void
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
			if (instance.playfieldRenderer.modchart.scriptListen)
			{
				instance.playfieldRenderer.modchart.data.events.push(["ease", [beat, time, ease, argsAsString]]);
			}
		}
		if (Math.isNaN(time))
			time = 1;

		var args = argsAsString.trim().replace(' ', '').split(',');

		var func = function(arguments:Array<String>)
		{
			for (i in 0...Math.floor(arguments.length / 2))
			{
				var name:String = Std.string(arguments[1 + (i * 2)]);
				var value:Float = Std.parseFloat(arguments[0 + (i * 2)]);
				if (Math.isNaN(value))
					value = 0;
				var subModCheck = name.split(':');
				if (subModCheck.length > 1)
				{
					var modName = subModCheck[0];
					var subModName = subModCheck[1];
					// trace(subModCheck);
					instance.playfieldRenderer.modifierTable.tweenAddSubValue(modName, subModName, value, time * Conductor.crochet * 0.001, ease, beat);
				}
				else
					instance.playfieldRenderer.modifierTable.tweenAdd(name, value, time * Conductor.crochet * 0.001, ease, beat);
			}
		};
		instance.playfieldRenderer.eventManager.addEvent(beat, func, args);
	}

	public static function setAdd(beat:Float, argsAsString:String, ?instance:ModchartMusicBeatState = null)
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
			if (instance.playfieldRenderer.modchart.scriptListen)
			{
				instance.playfieldRenderer.modchart.data.events.push(["set", [beat, argsAsString]]);
			}
		}
		var args = argsAsString.trim().replace(' ', '').split(',');

		instance.playfieldRenderer.eventManager.addEvent(beat, function(arguments:Array<String>)
		{
			for (i in 0...Math.floor(arguments.length / 2))
			{
				var name:String = Std.string(arguments[1 + (i * 2)]);
				var value:Float = Std.parseFloat(arguments[0 + (i * 2)]);
				if (Math.isNaN(value))
					value = 0;
				if (instance.playfieldRenderer.modifierTable.modifiers.exists(name))
				{
					instance.playfieldRenderer.modifierTable.modifiers.get(name).currentValue += value;
				}
				else
				{
					var subModCheck = name.split(':');
					if (subModCheck.length > 1)
					{
						var modName = subModCheck[0];
						var subModName = subModCheck[1];
						if (instance.playfieldRenderer.modifierTable.modifiers.exists(modName))
							instance.playfieldRenderer.modifierTable.modifiers.get(modName).subValues.get(subModName).value += value;
					}
				}
			}
		}, args);
	}

	public static function getMod(name:String, base:Bool, ?instance:ModchartMusicBeatState = null):Dynamic
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}

		if (instance.playfieldRenderer.modifierTable.modifiers.exists(name))
		{
			if (!base)
				return instance.playfieldRenderer.modifierTable.modifiers.get(name).currentValue;
			else
				return instance.playfieldRenderer.modifierTable.modifiers.get(name).baseValue;
		}
		else
			return 0;
	}

	public static function getSubMod(name:String, subValName:String, base:Bool, ?instance:ModchartMusicBeatState = null):Dynamic
	{
		if (instance == null)
		{
			// if (editor)
			//     instance = EditorPlayState.instance;
			// else
			instance = PlayState.instance;
		}

		if (instance.playfieldRenderer.modifierTable.modifiers.exists(name))
		{
			if (instance.playfieldRenderer.modifierTable.modifiers.get(name).subValues.exists(subValName))
			{
				if (!base)
					return instance.playfieldRenderer.modifierTable.modifiers.get(name).subValues.get(subValName).value;
				else
					return instance.playfieldRenderer.modifierTable.modifiers.get(name).subValues.get(subValName).baseValue;
			}
			else
			{
				return 0;
			}
		}
		else
			return 0;
	}
}
