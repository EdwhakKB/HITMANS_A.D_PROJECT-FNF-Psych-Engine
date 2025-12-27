package scripting.lua;

import shaders.Shaders;
import openfl.filters.ShaderFilter;
import codenameengine.CustomCodeShader;
import flixel.addons.effects.FlxSkewedSprite;

#if LUA_ALLOWED
class CustomFunctions {
    public static function implement(funk:FunkinLua) {
        var lua:State = funk.lua;

        Lua_helper.add_callback(lua,"removeActorShader", function(id:String) {
			if (LuaUtils.getObjectDirectly(id, false) != null)
                LuaUtils.getObjectDirectly(id, false).shader = null;
            if(LuaUtils.getActorByName(id) != null)
                LuaUtils.getActorByName(id).shader = null;
        });

        Lua_helper.add_callback(lua, "summongHxShader", function(name:String, classString:String, ?hardCoded:Bool) {

            if (!ClientPrefs.data.shaders && !hardCoded) //now it should get some shaders hardcoded if i need
                return;

			trace('shaders.' + classString);
            var shaderClass = Type.resolveClass('shaders.' + classString);
			trace(shaderClass);
            if (shaderClass != null)
            {
                var shad:ShaderEffectNew = Type.createInstance(shaderClass, []);
				trace(shad);
                LuaUtils.lua_Shaders.set(name, shad);
                trace('created shader: '+name);
            }
            else 
            {
                lime.app.Application.current.window.alert("shader broken:\n"+classString+" is non existent","Hitmans Corps!");
            }
        });
        Lua_helper.add_callback(lua,"setActorShader", function(actorStr:String, shaderName:String) {
			var shad = LuaUtils.lua_Shaders.get(shaderName);
			var actor = LuaUtils.getActorByName(actorStr);
			var spr:FlxSprite = PlayState.instance.getLuaObject(actorStr);
	
			if(spr==null){
				var split:Array<String> = actorStr.split('.');
				spr = LuaUtils.getObjectDirectly(split[0]);
				if(split.length > 1) {
					spr = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
				}
			}

			if (shad != null)
			{
				if (spr != null)
					spr.shader = Reflect.getProperty(shad, 'shader');
				if (actor != null)
					actor.shader = Reflect.getProperty(shad, 'shader');
				
				if (actor == null && spr == null) trace('Actor and spr are both null!');
			}
        });

        Lua_helper.add_callback(lua, "setShaderProperty", function(shaderName:String, prop:String, value:Dynamic) {
            var shad = LuaUtils.lua_Shaders.get(shaderName);

            if(shad != null)
            {
                Reflect.setProperty(shad, prop, value);
                //trace('set shader prop');
            }else if (shad == null){
				return;
			}
        });

        Lua_helper.add_callback(lua,"tweenShaderProperty", function(shaderName:String, prop:String, value:Dynamic, time:Float, easeStr:String = "linear", ?tag:String = 'shader') {
            var shad = LuaUtils.lua_Shaders.get(shaderName);
            var ease = LuaUtils.getTweenEaseByString(easeStr);

            if(shad != null)
            {
                var startVal = Reflect.getProperty(shad, prop);

				MusicBeatState.getVariables().set(tag, 
                    PlayState.tweenManager.num(startVal, value, time, {
                    ease: ease,
                    onUpdate: function(tween:FlxTween) {
                        var ting = FlxMath.lerp(startVal,value, ease(tween.percent));
                        Reflect.setProperty(shad, prop, ting);
                    }, 
                    onComplete: function(tween:FlxTween) {
                        Reflect.setProperty(shad, prop, value);
                        PlayState.instance.callOnLuas('onTweenCompleted', [tag]);
                        MusicBeatState.getVariables().remove(tag);
                    }})
                );
                //trace('set shader prop');
			}else if(shad == null){
				return;
			}
        });

		Lua_helper.add_callback(lua,"setCameraShader", function(camStr:String, shaderName:String) {
            var cam = LuaUtils.getCameraByName(camStr);
            var shad = LuaUtils.lua_Shaders.get(shaderName);

            if(cam != null && shad != null)
            {
                cam.shaders.push(new ShaderFilter(Reflect.getProperty(shad, 'shader'))); //use reflect to workaround compiler errors
                cam.shaderNames.push(shaderName);
                cam.cam.filters = cam.shaders;
                //trace('added shader '+shaderName+" to " + camStr);
			}else if(cam == null && shad == null){
				return;
			}
        });
        Lua_helper.add_callback(lua,"removeCameraShader", function(camStr:String, shaderName:String) {
            var cam = LuaUtils.getCameraByName(camStr);
            if (cam != null)
            {
                if (cam.shaderNames.contains(shaderName))
                {
                    var idx:Int = cam.shaderNames.indexOf(shaderName);
                    if (idx != -1)
                    {
                        cam.shaderNames.remove(cam.shaderNames[idx]);
                        cam.shaders.remove(cam.shaders[idx]);
                        cam.cam.filters = cam.shaders; //refresh filters
                    }
                    
                }
            }
        });

		Lua_helper.add_callback(lua, "createLuaShader", function(id:String, file:String, glslVersion:String = '120'){
			var funnyCustomShader:CustomCodeShader = new CustomCodeShader(file, glslVersion);
			LuaUtils.lua_Custom_Shaders.set(id, funnyCustomShader);
		});

		Lua_helper.add_callback(lua, "setActorCustomShader", function(id:String, actor:String){
			var funnyCustomShader:CustomCodeShader = LuaUtils.lua_Custom_Shaders.get(id);
			if (LuaUtils.getActorByName(actor) != null)
				LuaUtils.getActorByName(actor).shader = funnyCustomShader;
			if (LuaUtils.getObjectDirectly(actor, false) != null)
				LuaUtils.getObjectDirectly(actor, false).shader = funnyCustomShader;
		});

		Lua_helper.add_callback(lua, "removeActorCustomShader", function(actor:String){
			if (LuaUtils.getActorByName(actor) != null)
				LuaUtils.getActorByName(actor).shader = null;
			if (LuaUtils.getObjectDirectly(actor, false) != null)
				LuaUtils.getObjectDirectly(actor, false).shader = null;
		});

		Lua_helper.add_callback(lua, "setCameraCustomShader", function(id:String, camera:String){
			var funnyCustomShader:CustomCodeShader = LuaUtils.lua_Custom_Shaders.get(id);
			LuaUtils.cameraFromString(camera).filters = [new ShaderFilter(funnyCustomShader)];
		});

		Lua_helper.add_callback(lua, "pushShaderToCamera", function(id:String, camera:String){
			var funnyCustomShader:CustomCodeShader = LuaUtils.lua_Custom_Shaders.get(id);
			LuaUtils.cameraFromString(camera).filters.push(new ShaderFilter(funnyCustomShader));
		});

		Lua_helper.add_callback(lua, "setCameraNoCustomShader", function(camera:String){
			LuaUtils.cameraFromString(camera).filters = [];
		});

		Lua_helper.add_callback(lua, "getCustomShaderProperty", function(id:String, property:Dynamic) {
			var funnyCustomShader:CustomCodeShader = LuaUtils.lua_Custom_Shaders.get(id);
			return funnyCustomShader.hget(property);
		});

		Lua_helper.add_callback(lua, "setCustomShaderProperty", function(id:String, property:String, value:Dynamic) {
			var funnyCustomShader:CustomCodeShader = LuaUtils.lua_Custom_Shaders.get(id);
			funnyCustomShader.hset(property, value);
		});

		//Custom shader made by me (glowsoony)
		Lua_helper.add_callback(lua, "tweenCustomShaderProperty", function(tag:String, shaderName:String, prop:String, value:Dynamic, time:Float, easeStr:String = "linear", startVal:Null<Float> = null) {
            if (!ClientPrefs.data.shaders) return;
            var shad:CustomCodeShader = LuaUtils.lua_Custom_Shaders.get(shaderName);
            var ease = LuaUtils.getTweenEaseByString(easeStr);
			var startValue:Null<Float> = startVal;
			if (startValue == null) startValue = shad.hget(prop);

            if(shad != null)
            {
				MusicBeatState.getVariables().set(tag, 
					PlayState.tweenManager.num(startValue, value, time, {
					onUpdate: function(tween:FlxTween){
						var ting = FlxMath.lerp(startValue, value, ease(tween.percent));
                    	shad.hset(prop, ting);
					}, ease: ease, 
					onComplete: function(tween:FlxTween) {
						shad.hset(prop, value);
						PlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						MusicBeatState.getVariables().remove(tag);
					}})
				);
                //trace('set shader prop');
            }
        });

		//SHADER PROPERTY FROM LUA BRUH
		Lua_helper.add_callback(lua, "getLuaShaderProperty", function(shaderName:String, prop:String) {
            var shad = PlayState.instance.shaderValues.get(shaderName);

            if(shad != null)
            {
                Reflect.getProperty(shad, prop);
                //trace('set shader prop');
            }else if (shad == null){
				return;
			}
        });

		Lua_helper.add_callback(lua, "setLuaShaderProperty", function(shaderName:String, prop:String, value:Dynamic) {
            var shad = PlayState.instance.shaderValues.get(shaderName);

            if(shad != null)
            {
                Reflect.setProperty(shad, prop, value);
                //trace('set shader prop');
            }else if (shad == null){
				return;
			}
        });

		//Welp finally this code is FINAL! (unless you want to make changes edwhak!)
		Lua_helper.add_callback(lua, "makeArrowCopy", function(tag:String = '', ?compositionArray:Array<Dynamic>) {
            tag = tag.replace('.', '');
            LuaUtils.destroyObject(tag);
			
			if (compositionArray == null) compositionArray = [0, 0, 0, false, "camHUD", '', '', '', 1, 1]; // works ig?
			//X = 0, Y = 1, noteData = 2, isStrum = 3, camera = 4, daSkin = 5, daType = 6, daNoteTypeStyle = 7, daScaleX = 8, daScaleY = 9

            trace('what the x, ' + compositionArray[0] + ', y, ' + compositionArray[1] + ', noteData, ' + compositionArray[2] + 
				', isStrum, ' + compositionArray[3] + ', camera, ' + compositionArray[4] + ', daSkin, ' + compositionArray[5] + 
				', daType, ' + compositionArray[6] + ', daNoteTypeStyle, ' + compositionArray[7] + 
				', daScaleX, ' + compositionArray[8] + ', daScaleY, ' + compositionArray[9]);

            var noteTypeSkin = compositionArray[7];

            var theSkin = 'Skins/Notes/${ClientPrefs.data.notesSkin[0]}/NOTE_assets';
            if (compositionArray[5] != '') theSkin = compositionArray[5];

 			var colArray:Array<String> = ['purple', 'blue', 'green', 'red'];

            if (compositionArray[3] == true){
                var spriteCopy:StrumNote = new StrumNote(compositionArray[0],compositionArray[1],Std.int(compositionArray[2]),0,theSkin,null,false);
				spriteCopy.animation.play(colArray[Std.int(compositionArray[2]) % colArray.length], true);
                spriteCopy.camera = LuaUtils.cameraFromString(compositionArray[4]);
                LuaUtils.getTargetInstance().add(spriteCopy);
                MusicBeatState.getVariables().set(tag, spriteCopy);
            }else{
                var spriteCopy:Note = new Note(0,Std.int(compositionArray[2]),false,true);
                spriteCopy.setPosition(compositionArray[0],compositionArray[1]);
                spriteCopy.scale.set(compositionArray[8],compositionArray[9]);

                if (compositionArray[6] != '' && (compositionArray[5] == '')) {
                    spriteCopy.noteType = compositionArray[6];
                    if (noteTypeSkin != '' && (compositionArray[6].toLowerCase() == 'hurt' || compositionArray[6].toLowerCase() == 'mine'))
                        spriteCopy.reloadNote('Skins/${noteTypeSkin}');
                }
                else if (compositionArray[5] != '' && (compositionArray[6] == '')) {
                   spriteCopy.noteType = '';
                   spriteCopy.reloadNote(compositionArray[5]);
                }
                else{
                   spriteCopy.reloadNote('Skins/Notes/${ClientPrefs.data.notesSkin[0]}/NOTE_assets');
                }

				spriteCopy.animation.play(colArray[Std.int(compositionArray[2]) % colArray.length] + 'Scroll', true);
                spriteCopy.camera = LuaUtils.cameraFromString(compositionArray[4]);
                LuaUtils.getTargetInstance().add(spriteCopy);
                MusicBeatState.getVariables().set(tag, spriteCopy);
            }
        });

		/*Lua_helper.add_callback(lua, "makeArrowCopy", function(tag:String = '', x:Float, y:Float, noteData:Int, isStrum:Bool, 
			camera:String, daSkin:String, daType:String, daNoteTypeStyle:String, daScaleX:Float, daScaleY:Float) 
		{
            tag = tag.replace('.', '');
            resetSpriteTag(tag);
			
			if (compositionArray == null) compositionArray = [0, 0, 0, false, "camHUD", '', '', '', 1, 1]; // works ig?
			//X = 0, Y = 1, noteData = 2, isStrum = 3, camera = 4, daSkin = 5, daType = 6, daNoteTypeStyle = 7, daScaleX = 8, daScaleY = 9

            trace('what the x, ' + compositionArray[0] + ', y, ' + compositionArray[1] + ', noteData, ' + compositionArray[2] + 
				', isStrum, ' + compositionArray[3] + ', camera, ' + compositionArray[4] + ', daSkin, ' + compositionArray[5] + 
				', daType, ' + compositionArray[6] + ', daNoteTypeStyle, ' + compositionArray[7] + 
				', daScaleX, ' + compositionArray[8] + ', daScaleY, ' + compositionArray[9]);

            var noteTypeSkin = compositionArray[7];

            var theSkin = 'Skins/Notes/${ClientPrefs.data.notesSkin[0]}/NOTE_assets';
            if (compositionArray[5] != '') theSkin = compositionArray[5];

 			var colArray:Array<String> = ['purple', 'blue', 'green', 'red'];

            if (compositionArray[3] == true){
                var spriteCopy:StrumNew = new StrumNew(compositionArray[0],compositionArray[1],compositionArray[2],0,theSkin,null,false);
				spriteCopy.animation.play(colArray[Std.int(compositionArray[2]) % colArray.length], true);
                spriteCopy.camera = cameraFromString(compositionArray[4]);
                getInstance().add(spriteCopy);
                PlayState.instance.modchartSprites.set(tag, spriteCopy);
            }else{
                var spriteCopy:NewNote = new NewNote(0,compositionArray[2],false,true);
                spriteCopy.setPosition(compositionArray[0],compositionArray[1]);
                spriteCopy.scale.set(compositionArray[8],compositionArray[9]);

                if (compositionArray[6] != '' && (compositionArray[5] == '')) {
                    spriteCopy.noteType = compositionArray[6];
                    if (noteTypeSkin != '' && (compositionArray[6].toLowerCase() == 'hurt' || compositionArray[6].toLowerCase() == 'mine'))
                        spriteCopy.reloadNote('', 'Skins/${noteTypeSkin}');
                }
                else if (compositionArray[5] != '' && (compositionArray[6] == '')) {
                   spriteCopy.noteType = '';
                   spriteCopy.reloadNote('', compositionArray[5]);
                }
                else{
                   spriteCopy.reloadNote('', 'Skins/Notes/${ClientPrefs.data.notesSkin[0]}/NOTE_assets');
                }

				spriteCopy.animation.play(colArray[Std.int(compositionArray[2]) % colArray.length] + 'Scroll', true);
                spriteCopy.camera = cameraFromString(compositionArray[4]);
                getInstance().add(spriteCopy);
                PlayState.instance.modchartSprites.set(tag, spriteCopy);
            }
        });*/

		Lua_helper.add_callback(lua, "objectPlayLoopAnimation", function(obj:String, name:String, forced:Bool = false, ?startFrame:Int = 0, ?isStrum:Bool = false) {
			// luaTrace("objectPlayAnimation is deprecated! Use playAnim instead", false, true)

			var spr:Dynamic = LuaUtils.getObjectDirectly(obj);

			if(spr != null) {
				spr.animation.play(name, forced, false, startFrame);
				spr.animation.finishCallback = function(na:String)
				{
					spr.animation.play(name, forced, false, startFrame);
				}
				return true;
			}
			return false;
		});

		// Lua_helper.add_callback(lua, "threadBeat", function(beat:Float, func:Dynamic) {
        //     PlayState.threadBeat(beat, () -> {func});
        //     // var retVal:Dynamic = null;

        //     // #if hscript
        //     // initHaxeModule();
        //     // try {
        //     //     retVal = hscript.execute('game.threadBeat($beat, () -> {$func});');
        //     // }
        //     // catch (e:Dynamic) {
        //     //     luaTrace(scriptName + ": threadBeat("+ beat +") failed: " + e, false, false, FlxColor.RED);
        //     // }
        //     // #else
        //     // luaTrace("threadBeat: doesn't work in this platform!", false, false, FlxColor.RED);
        //     // #end

        //     // if(retVal != null && !isOfTypes(retVal, [Bool, Int, Float, String, Array])) retVal = null;
        //     // if(retVal == null) Lua.pushnil(lua);
        //     // return retVal;
        // });

		// Lua_helper.add_callback(lua, "threadUpdate", function(beatStart:Float, beatEnd:Float, func:Dynamic, onComp:Dynamic) {
        //     PlayState.threadUpdate(beatStart, beatEnd, () -> {func}, () -> {onComp});
        //     // var retVal:Dynamic = null;

        //     // #if hscript
        //     // initHaxeModule();
        //     // try {
        //     //     retVal = hscript.execute('game.threadUpdate($beatStart,$beatEnd, () -> {$func}, () -> {$onComp});');
        //     // }
        //     // catch (e:Dynamic) {
        //     //     luaTrace(scriptName + ": threadUpdate("+ beatStart +"," + beatEnd + ") failed: " + e, false, false, FlxColor.RED);
        //     // }
        //     // #else
        //     // luaTrace("threadUpdate: doesn't work in this platform!", false, false, FlxColor.RED);
        //     // #end

        //     // if(retVal != null && !isOfTypes(retVal, [Bool, Int, Float, String, Array])) retVal = null;
        //     // if(retVal == null) Lua.pushnil(lua);
        //     // return retVal;
        // });

		Lua_helper.add_callback(lua, "makeLuaProxy", function(tag:String, x:Float, y:Float, ?camera:String = '') {
			final micamera:FlxCamera = PlayState.instance.camProxy;
			if(PlayState.instance.aftBitmap != null)
			{
				tag = tag.replace('.', '');
				LuaUtils.destroyObject(tag);
				final leSprite:FlxSkewedSprite = new FlxSkewedSprite(x, y);
				leSprite.loadGraphic(PlayState.instance.aftBitmap.bitmap); //idk if this even works but whatever
				leSprite.antialiasing = ClientPrefs.data.antialiasing;
				MusicBeatState.getVariables().set(tag, leSprite);
				leSprite.active = true;
				leSprite.camera = camera?.length > 0 ? LuaUtils.cameraFromString(camera) : micamera;
			}else{
				FunkinLua.luaTrace('makeLuaProxy: attempted to make a proxy but aftBitmap is null!', false, false, FlxColor.RED);
			}
		});
    }
}
#end