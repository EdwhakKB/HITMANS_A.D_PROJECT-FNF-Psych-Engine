package;

class CppAPI
{
	#if cpp

	public static function setWindowOppacity(a:Float)
	{
		WindowsCPP.setWindowAlpha(a);
	}

	public static function _setWindowLayered()
	{
		WindowsCPP._setWindowLayered();
	}

	#end
}