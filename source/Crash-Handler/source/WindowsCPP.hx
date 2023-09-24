package;

#if windows
@:cppFileCode('
#include <Windows.h>\n
#include <cstdio>\n
#include <iostream>\n
#include <tchar.h>\n
#include <dwmapi.h>\n
#include <winuser.h>\n
#include <winternl.h>\n

#include <Shlobj.h>\n

#define UNICODE


\n\n#pragma comment(lib, "Dwmapi")\n
#pragma comment(lib, "ntdll.lib")\n
#pragma comment(lib, "User32.lib")\n
#pragma comment(lib, "Shell32.lib")\n
')
#end



class WindowsCPP
{
	#if windows
	@:functionCode('
	HWND window = GetActiveWindow();
	SetWindowLong(window, GWL_EXSTYLE, GetWindowLong(window, GWL_EXSTYLE) ^ WS_EX_LAYERED);
	')
	@:noCompletion
	public static function _setWindowLayered()
	{
	}

	@:functionCode('
        HWND window = GetActiveWindow();

		float a = alpha;

		if (alpha > 1) {
			a = 1;
		} 
		if (alpha < 0) {
			a = 0;
		}

       	SetLayeredWindowAttributes(window, 0, (255 * (a * 100)) / 100, LWA_ALPHA);

    ')
	/**
	 * Set Whole Window's Opacity
	 * ! MAKE SURE TO CALL CppAPI._setWindowLayered(); BEFORE RUNNING THIS
	 * @param alpha 
	 */
	public static function setWindowAlpha(alpha:Float)
	{
		return alpha;
	}
	#end
}