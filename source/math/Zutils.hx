package math;

import flixel.FlxBasic;
import flixel.util.FlxSort;

class Zutils
{
    //No importa donde va esto
    /**
   * You can use this function in FlxTypedGroup.sort() to sort FlxObjects by their z-index values.
   * The value defaults to 0, but by assigning it you can easily rearrange objects as desired.
   *
   * @param order Either `FlxSort.ASCENDING` or `FlxSort.DESCENDING`
   * @param a The first FlxObject to compare.
   * @param b The second FlxObject to compare.
   * @return 1 if `a` has a higher z-index, -1 if `b` has a higher z-index.
   */
    public static inline function byZIndex(order:Int, a:FlxBasic, b:FlxBasic):Int
    {
        if (a == null || b == null) return 0;
        return FlxSort.byValues(order, a.zIndex, b.zIndex);
    }


    /**
   * You can use this function in FlxTypedGroup.sort() to sort FlxObjects by their z-index values.
   * The value defaults to 0, but by assigning it you can easily rearrange objects as desired.
   *
   * @param order Either `FlxSort.ASCENDING` or `FlxSort.DESCENDING`
   * @param a The first FlxObject to compare.
   * @param b The second FlxObject to compare.
   * @return 1 if `a` has a higher z, -1 if `b` has a higher z-index.
   */
    public static inline function byZ(order:Int, a:Dynamic, b:Dynamic):Int
    {
        if (a == null || b == null) return 0;
        return FlxSort.byValues(order, a.z, b.z);
    }
}