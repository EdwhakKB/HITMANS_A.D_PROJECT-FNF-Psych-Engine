package modcharting.utils;

import haxe.ds.Vector;

/**
 * @author: TheoDev
 * 
 * don't touch !!!
 */
class OptimizationUtil
{
    @:pure
	@:noDebug
    inline static public function ensureVectorCapacity<T:Dynamic>(vector:Vector<T>, expectedLength:Int, add:Int):Vector<T>
    {
        if (expectedLength >= vector.length)
        {
            var newVector = new Vector<T>(vector.length + add);
            for (i in 0...vector.length)
                newVector[i] = vector[i];
            vector.fill(null);
            return newVector;
        }
        return vector;
    }    

    @:pure
	@:noDebug
	inline public static function nullSort<T:Dynamic>(vector:Vector<T>, func:(T, T) -> Int):Vector<T>
	{
		vector.sort((a, b) ->
		{
			if (a == null || b == null)
				return 0;
			return func(a, b);
		});

		return vector;
	}
}
