package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;
import haxe.Json;
import haxe.format.JsonParser;

using StringTools;

typedef DatosMenu = {

	var character:Array<Array<Dynamic>>;
	var roles:Array<Array<Dynamic>>;

}
class CreditsState extends MusicBeatState
{
	var curSelected:Int = 0;

	private var grpOptions:FlxTypedGroup<FlxSprite>;

	var datos:DatosMenu;

	var bg:FlxSprite;
	var marcoSelector:FlxSprite;
	var personajes:FlxSprite;
	var cuadroTexto:FlxSprite;
	
	var nombre:FlxText;
	var rol:FlxText;
	var descripcion:FlxText;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Menu - Credits", null);
		#end

		persistentUpdate = true;

		FlxG.mouse.visible = true;

		bg = new FlxSprite();
		add(bg);
		
		grpOptions = new FlxTypedGroup<FlxSprite>();
		add(grpOptions);

		datos = Json.parse(Paths.getTextFromFile('images/creditos/Datos.json'));

		for (i in 0...datos.character.length)
		{

			var icon:FlxSprite = new FlxSprite().loadGraphic(Paths.image('creditos/icons/'+ datos.character[i][0]));
			icon.antialiasing = ClientPrefs.globalAntialiasing;
			icon.setGraphicSize(102,102);
			icon.updateHitbox();
			icon.ID = i;

			if (i < 28)
			{
				icon.x = (17 + ((i * 110) % (7 * 110)));
				icon.y = 25 + (110 * Math.ffloor(i / 7));
			}
			else
			{
				icon.x = (55 + (((i - 1) * 110) % (6 * 110)));
				icon.y = 25 + (110 * (Math.ffloor((i - 4) / 6)));
			}

			grpOptions.add(icon);
		}
		
		personajes = new FlxSprite(815,50);
		personajes.antialiasing = ClientPrefs.globalAntialiasing;
		add(personajes);

		nombre = new FlxText(774, 422, 450, 'nombre');
		nombre.setFormat(Paths.font("DEADLY KILLERS.ttf"), 0, FlxColor.WHITE);
		nombre.alignment = CENTER;
		add(nombre);

		rol = new FlxText(770, 478, 450, 'rol');
		rol.setFormat(Paths.font("DEADLY KILLERS.ttf"), 0);
		rol.alignment = CENTER;
		add(rol);

		cuadroTexto = new FlxSprite(744, 535).loadGraphic(Paths.image('creditos/quote_box'));
		cuadroTexto.setGraphicSize(500,110);
		cuadroTexto.updateHitbox();
		cuadroTexto.antialiasing = ClientPrefs.globalAntialiasing;
		cuadroTexto.blend = OVERLAY;
		add(cuadroTexto);

		descripcion = new FlxText(774, 0, 450, 'descripcion');
		descripcion.setFormat(Paths.font("DEADLY KILLERS.ttf"), 0, FlxColor.WHITE);
		descripcion.alignment = CENTER;
		add(descripcion);

		marcoSelector = new FlxSprite().loadGraphic(Paths.image('creditos/selector'));
		marcoSelector.setGraphicSize(129,129);
		marcoSelector.updateHitbox();
		marcoSelector.antialiasing = ClientPrefs.globalAntialiasing;
		add(marcoSelector);

		select();

		super.create();
	}

	var selecto:Int = -1;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (controls.BACK || FlxG.mouse.pressedRight)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.mouse.visible = false;
			MusicBeatState.switchState(new MainMenuState());
		}

		grpOptions.forEach(function(spr:FlxSprite)
		{
			if (FlxG.mouse.overlaps(spr))
			{
				curSelected = spr.ID;

				if (selecto == -1){

				 selecto = spr.ID;
				 FlxG.sound.play(Paths.sound('scrollMenu'));
				 select();
				}

				else if (selecto != curSelected){
					selecto = -1;
				}

				if(FlxG.mouse.justPressed)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					CoolUtil.browserLoad(datos.character[curSelected][5]);
				}
			}
		});
		super.update(elapsed);
	}

	function select() {

		grpOptions.forEach(function(sprite:FlxSprite){
			if(sprite.ID == curSelected){
				sprite.alpha = 1;
				FlxTween.tween(marcoSelector,{x:sprite.x- 14,y:sprite.y- 14}, 0.125);
			}
			else{
				sprite.alpha = 0.5;
			}
		});

		nombre.text = datos.character[curSelected][0];
		nombre.size = datos.character[curSelected][1];

		descripcion.text = datos.character[curSelected][2];
		descripcion.size = datos.character[curSelected][3];
		descripcion.y = 590 - descripcion.height/2;

		rol.text = datos.roles[datos.character[curSelected][4]][0];
		rol.size = datos.roles[datos.character[curSelected][4]][1];
		rol.color = FlxColor.fromRGB(
		datos.roles[datos.character[curSelected][4]][2], 
		datos.roles[datos.character[curSelected][4]][3], 
		datos.roles[datos.character[curSelected][4]][4]);

		bg.loadGraphic(Paths.image('creditos/imagenes/' + datos.roles[datos.character[curSelected][4]][0]));
		bg.setGraphicSize(1280,720);
		bg.updateHitbox();

		personajes.loadGraphic(Paths.image('creditos/icons/' + datos.character[curSelected][0]));
		personajes.setGraphicSize(360,360);
		personajes.updateHitbox();

	}
}