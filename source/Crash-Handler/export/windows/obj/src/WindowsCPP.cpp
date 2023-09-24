#include <hxcpp.h>

#ifndef INCLUDED_WindowsCPP
#include <WindowsCPP.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_889adc632453f9b3_36__setWindowLayered,"WindowsCPP","_setWindowLayered",0x2810aa4f,"WindowsCPP._setWindowLayered","WindowsCPP.hx",36,0xf2d75c3e)
HX_LOCAL_STACK_FRAME(_hx_pos_889adc632453f9b3_61_setWindowAlpha,"WindowsCPP","setWindowAlpha",0x5c9286fa,"WindowsCPP.setWindowAlpha","WindowsCPP.hx",61,0xf2d75c3e)

#include <Windows.h>

#include <cstdio>

#include <iostream>

#include <tchar.h>

#include <dwmapi.h>

#include <winuser.h>

#include <winternl.h>


#include <Shlobj.h>


#define UNICODE




#pragma comment(lib, "Dwmapi")

#pragma comment(lib, "ntdll.lib")

#pragma comment(lib, "User32.lib")

#pragma comment(lib, "Shell32.lib")



void WindowsCPP_obj::__construct() { }

Dynamic WindowsCPP_obj::__CreateEmpty() { return new WindowsCPP_obj; }

void *WindowsCPP_obj::_hx_vtable = 0;

Dynamic WindowsCPP_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< WindowsCPP_obj > _hx_result = new WindowsCPP_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool WindowsCPP_obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x39d91fa4;
}

void WindowsCPP_obj::_setWindowLayered(){
            	HX_STACKFRAME(&_hx_pos_889adc632453f9b3_36__setWindowLayered)
            	
	HWND window = GetActiveWindow();
	SetWindowLong(window, GWL_EXSTYLE, GetWindowLong(window, GWL_EXSTYLE) ^ WS_EX_LAYERED);
	

            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(WindowsCPP_obj,_setWindowLayered,(void))

Float WindowsCPP_obj::setWindowAlpha(Float alpha){
            	HX_STACKFRAME(&_hx_pos_889adc632453f9b3_61_setWindowAlpha)
            	
        HWND window = GetActiveWindow();

		float a = alpha;

		if (alpha > 1) {
			a = 1;
		} 
		if (alpha < 0) {
			a = 0;
		}

       	SetLayeredWindowAttributes(window, 0, (255 * (a * 100)) / 100, LWA_ALPHA);

    

HXDLIN(  61)		return alpha;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(WindowsCPP_obj,setWindowAlpha,return )


WindowsCPP_obj::WindowsCPP_obj()
{
}

bool WindowsCPP_obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 14:
		if (HX_FIELD_EQ(inName,"setWindowAlpha") ) { outValue = setWindowAlpha_dyn(); return true; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"_setWindowLayered") ) { outValue = _setWindowLayered_dyn(); return true; }
	}
	return false;
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *WindowsCPP_obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo *WindowsCPP_obj_sStaticStorageInfo = 0;
#endif

::hx::Class WindowsCPP_obj::__mClass;

static ::String WindowsCPP_obj_sStaticFields[] = {
	HX_("_setWindowLayered",bd,27,37,56),
	HX_("setWindowAlpha",cc,78,27,ba),
	::String(null())
};

void WindowsCPP_obj::__register()
{
	WindowsCPP_obj _hx_dummy;
	WindowsCPP_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("WindowsCPP",80,f6,e4,e2);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &WindowsCPP_obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(WindowsCPP_obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< WindowsCPP_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = WindowsCPP_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = WindowsCPP_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

