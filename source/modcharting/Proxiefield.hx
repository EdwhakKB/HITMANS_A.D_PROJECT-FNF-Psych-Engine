package modcharting;

import flixel.addons.effects.FlxSkewedSprite;
import openfl.display.BitmapData;

class Proxie extends FlxSkewedSprite
{
	public var z:Float = 0;

	public function loadCapture(bitmap:BitmapData)
	{
		this.loadGraphic(bitmap);
		this.antialiasing = ClientPrefs.data.antialiasing;
		this.active = true;
	}

	public function applyDefault(sprite:Proxie)
	{
		this.x = sprite.x;
		this.y = sprite.y;
		this.z = sprite.z;
		this.alpha = sprite.alpha;
	}
}

class Proxiefield
{
	public var sprite:Proxie;

	public function new(newSprite:Proxie)
	{
		this.sprite = newSprite;
		this.sprite.applyDefault(newSprite);
	}

	public function applyOffsets(noteData:NotePositionData)
	{
		noteData.x += 200 + sprite.x;
		noteData.y += 200 + sprite.y;
		noteData.z += 200 + sprite.z;
		noteData.alpha *= sprite.alpha;
	}
}
