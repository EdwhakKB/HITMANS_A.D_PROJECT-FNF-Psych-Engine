package codenameengine;

#if macro
import haxe.macro.*;
import haxe.macro.Expr;

/**
 * Macros containing additional help functions to expand HScript capabilities.
 */
class Macros
{
  public static function addAdditionalClasses()
  {
    for (inc in [
      // FLIXEL
      "flixel",
      
      // BASE HAXE
      "haxe",
    ])
      Compiler.include(inc, true, [
        'haxe.atomic.*',
        'haxe.macro.*',
        'flixel.addons.tile.FlxRayCastTilemap',
        'flixel.addons.editors.spine.*',
        'flixel.addons.nape.*',
        'flixel.system.macros.*'
      ]);

    if (Context.defined("sys"))
    {
      for (inc in ["sys", "openfl.net"])
      {
        Compiler.include(inc);
      }
    }
  }
}
#end