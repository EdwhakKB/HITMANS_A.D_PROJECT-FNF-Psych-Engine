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

}
class CreditsState extends MusicBeatState
{
	var curSelected:Int = 0;

	private var grpOptions:FlxTypedGroup<FlxSprite>;

	var datos:DatosMenu;

	var bg:FlxSprite;
	var personajes:FlxSprite;
	var cuadroTexto:FlxSprite;

	var characterImage:FlxSprite;
	var imagenPath:String = 'creditos/characters/';
	var placeHolder:String = 'PLACEHOLDER';
	
	var descripcion:FlxText;

	var grupo:FlxTypedGroup<FlxSprite>;
	var grupoImagen:FlxTypedGroup<FlxSprite>;

	var characterData:Array<String> = [];

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Menu - Credits", null);
		#end

		persistentUpdate = true;

		FlxG.mouse.visible = true;

		bg = new FlxSprite().loadGraphic(Paths.image('MenuShit/wallPaper'));
		bg.updateHitbox();
		add(bg);
		
		grpOptions = new FlxTypedGroup<FlxSprite>();
		add(grpOptions);

		datos = Json.parse(Paths.getTextFromFile('images/creditos/Datos.json'));

		grupoImagen = new FlxTypedGroup<FlxSprite>();
		add(grupoImagen);

		grupo = new FlxTypedGroup<FlxSprite>();
		add(grupo);

		for (i in 0...datos.character.length)
		{

			var box:FlxSprite = new FlxSprite();
				box.loadGraphic(Paths.image('freeplay/EmptyBox'));
				// box.x=FlxG.width / 2 -(box.width/16);
				box.x = FlxG.width / 2 - (box.width / 1.2) + (i * 815);
				box.y = FlxG.height / 6;
				box.antialiasing = ClientPrefs.globalAntialiasing;
				box.ID = i;
				grupo.add(box);
	
				var imageShow:String = datos.character[i][0];
				var imagen:FlxSprite = new FlxSprite();
				characterData.push(datos.character[i][0]);
	
				imagen.loadGraphic(Paths.image(imagenPath+imageShow));
				if(imagen.graphic == null) //if no graphic was loaded, then load the placeholder
					imagen.loadGraphic(Paths.image(imagenPath+placeHolder));
	
				// imagen.x=FlxG.width / 2 -(imagen.width/16);
				imagen.x = FlxG.width / 2 - (imagen.width / 1.2) + (i * 815);
				imagen.y = FlxG.height / 6;
				imagen.antialiasing = ClientPrefs.globalAntialiasing;
				imagen.ID = i;
				grupoImagen.add(imagen);
		}
		personajes = new FlxSprite(0,0);
		personajes.antialiasing = ClientPrefs.globalAntialiasing;
		personajes.visible = false;
		add(personajes);

		cuadroTexto = new FlxSprite(744, 155).loadGraphic(Paths.image('creditos/quote_box'));
		cuadroTexto.setGraphicSize(500,110);
		cuadroTexto.updateHitbox();
		cuadroTexto.antialiasing = ClientPrefs.globalAntialiasing;
		cuadroTexto.blend = OVERLAY;
		add(cuadroTexto);

		descripcion = new FlxText(770, 170, 450, 'descripcion');
		descripcion.setFormat(Paths.font("DEADLY KILLERS.ttf"), 0, FlxColor.WHITE);
		descripcion.alignment = CENTER;
		add(descripcion);

		var pcInterfas:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('MenuShit/CreditsInterfas'));
		pcInterfas.updateHitbox();
		pcInterfas.screenCenter();
		pcInterfas.antialiasing = ClientPrefs.globalAntialiasing;
		add(pcInterfas);

		changeItem();

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

		if (controls.UI_LEFT_P)
			changeItem(-1);

		if (controls.UI_RIGHT_P)
			changeItem(1);

		if (controls.ACCEPT){
			FlxG.sound.play(Paths.sound('scrollMenu'));
			CoolUtil.browserLoad(datos.character[curSelected][5]);
		}

		if (curSelected == 0){
			descripcion.text = 'Hitmans Leader (Mod Creator)';
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
	
			curSelected += huh;
	
			if (curSelected >= datos.character.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = datos.character.length - 1;

			if (curSelected == 0){
				descripcion.text = 'Hitmans Leader (Mod Creator)';
			}else{
				descripcion.text = datos.character[curSelected][2];
			}
			descripcion.size = datos.character[curSelected][3];

			grupo.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr.offset, {x: 815 * curSelected}, 0.2, {ease: FlxEase.expoOut, type: FlxTween.ONESHOT});
		
					if (spr.ID == curSelected)
					{
						FlxTween.tween(spr, {alpha: 1}, 0.1);
						FlxTween.tween(spr.scale, {x: 0.865, y: 0.865}, 0.2, {ease: FlxEase.expoOut});
					}
					else
					{
						FlxTween.tween(spr, {alpha: 0.8}, 0.1);
						FlxTween.tween(spr.scale, {x: 0.465, y: 0.465}, 0.2, {ease: FlxEase.expoOut});
					}
				});
		
				grupoImagen.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr.offset, {x: 815 * curSelected}, 0.2, {ease: FlxEase.expoOut, type: FlxTween.ONESHOT});
		
					if (spr.ID == curSelected)
					{
						FlxTween.tween(spr, {alpha: 1}, 0.1);
						FlxTween.tween(spr.scale, {x: 0.865, y: 0.865}, 0.2, {ease: FlxEase.expoOut});
					}
					else
					{
						FlxTween.tween(spr, {alpha: 0.8}, 0.1);
						FlxTween.tween(spr.scale, {x: 0.465, y: 0.465}, 0.2, {ease: FlxEase.expoOut});
					}
				});

			personajes.loadGraphic(Paths.image(imagenPath + characterData[curSelected]));
			personajes.setGraphicSize(Std.int(personajes.width * 1.5));
			personajes.updateHitbox();
			personajes.screenCenter();
			personajes.y -= 20;
		}
}