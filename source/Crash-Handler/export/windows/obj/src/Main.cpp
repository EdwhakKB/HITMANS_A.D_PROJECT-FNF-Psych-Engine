#include <hxcpp.h>

#ifndef INCLUDED_CppAPI
#include <CppAPI.h>
#endif
#ifndef INCLUDED_Main
#include <Main.h>
#endif
#ifndef INCLUDED_PlayState
#include <PlayState.h>
#endif
#ifndef INCLUDED_Sys
#include <Sys.h>
#endif
#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxGame
#include <flixel/FlxGame.h>
#endif
#ifndef INCLUDED_flixel_FlxState
#include <flixel/FlxState.h>
#endif
#ifndef INCLUDED_flixel_group_FlxTypedGroup
#include <flixel/group/FlxTypedGroup.h>
#endif
#ifndef INCLUDED_flixel_tweens_FlxTween
#include <flixel/tweens/FlxTween.h>
#endif
#ifndef INCLUDED_flixel_tweens_misc_NumTween
#include <flixel/tweens/misc/NumTween.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_lime_app_Application
#include <lime/app/Application.h>
#endif
#ifndef INCLUDED_lime_app_IModule
#include <lime/app/IModule.h>
#endif
#ifndef INCLUDED_lime_app_Module
#include <lime/app/Module.h>
#endif
#ifndef INCLUDED_lime_app__Event_Void_Void
#include <lime/app/_Event_Void_Void.h>
#endif
#ifndef INCLUDED_lime_graphics_Image
#include <lime/graphics/Image.h>
#endif
#ifndef INCLUDED_lime_ui_Window
#include <lime/ui/Window.h>
#endif
#ifndef INCLUDED_lime_utils_Assets
#include <lime/utils/Assets.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObject
#include <openfl/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectContainer
#include <openfl/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_display_Sprite
#include <openfl/display/Sprite.h>
#endif
#ifndef INCLUDED_openfl_events_EventDispatcher
#include <openfl/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_IEventDispatcher
#include <openfl/events/IEventDispatcher.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_e47a9afac0942eb9_16_new,"Main","new",0x6616a5cb,"Main.new","Main.hx",16,0x087e5c05)
HX_LOCAL_STACK_FRAME(_hx_pos_e47a9afac0942eb9_25_setupEventListeners,"Main","setupEventListeners",0xddf008cd,"Main.setupEventListeners","Main.hx",25,0x087e5c05)
HX_LOCAL_STACK_FRAME(_hx_pos_e47a9afac0942eb9_38_mainWindowClosed,"Main","mainWindowClosed",0xf0489f4a,"Main.mainWindowClosed","Main.hx",38,0x087e5c05)
HX_LOCAL_STACK_FRAME(_hx_pos_e47a9afac0942eb9_44_mainWindowClosed,"Main","mainWindowClosed",0xf0489f4a,"Main.mainWindowClosed","Main.hx",44,0x087e5c05)
HX_LOCAL_STACK_FRAME(_hx_pos_e47a9afac0942eb9_29_mainWindowClosed,"Main","mainWindowClosed",0xf0489f4a,"Main.mainWindowClosed","Main.hx",29,0x087e5c05)

void Main_obj::__construct(){
            	HX_GC_STACKFRAME(&_hx_pos_e47a9afac0942eb9_16_new)
HXLINE(  17)		::Main_obj::setupEventListeners();
HXLINE(  18)		 ::lime::ui::Window _hx_tmp = ::lime::app::Application_obj::current->_hx___window;
HXDLIN(  18)		_hx_tmp->setIcon(::lime::utils::Assets_obj::getImage(HX_("assets/art/iconOG.png",44,15,1e,7d),null()));
HXLINE(  19)		super::__construct();
HXLINE(  20)		this->addChild( ::flixel::FlxGame_obj::__alloc( HX_CTX ,0,0,::hx::ClassOf< ::PlayState >(),60,60,true,false));
            	}

Dynamic Main_obj::__CreateEmpty() { return new Main_obj; }

void *Main_obj::_hx_vtable = 0;

Dynamic Main_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Main_obj > _hx_result = new Main_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool Main_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x0c89e854) {
		if (inClassId<=(int)0x07825a7d) {
			if (inClassId<=(int)0x0330636f) {
				return inClassId==(int)0x00000001 || inClassId==(int)0x0330636f;
			} else {
				return inClassId==(int)0x07825a7d;
			}
		} else {
			return inClassId==(int)0x0c89e854;
		}
	} else {
		if (inClassId<=(int)0x4af7dd8e) {
			return inClassId==(int)0x1f4df417 || inClassId==(int)0x4af7dd8e;
		} else {
			return inClassId==(int)0x6b353933;
		}
	}
}

void Main_obj::setupEventListeners(){
            	HX_STACKFRAME(&_hx_pos_e47a9afac0942eb9_25_setupEventListeners)
HXDLIN(  25)		::lime::app::Application_obj::current->_hx___window->onClose->add(::Main_obj::mainWindowClosed_dyn(),null(),null());
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Main_obj,setupEventListeners,(void))

void Main_obj::mainWindowClosed(){
            		HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_0) HXARGC(1)
            		void _hx_run( ::flixel::tweens::FlxTween twn){
            			HX_STACKFRAME(&_hx_pos_e47a9afac0942eb9_38_mainWindowClosed)
HXLINE(  38)			::Sys_obj::exit(0);
            		}
            		HX_END_LOCAL_FUNC1((void))

            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_1, ::flixel::tweens::misc::NumTween,numTween) HXARGC(1)
            		void _hx_run( ::flixel::tweens::FlxTween twn){
            			HX_STACKFRAME(&_hx_pos_e47a9afac0942eb9_44_mainWindowClosed)
HXLINE(  44)			::CppAPI_obj::setWindowOppacity(numTween->value);
            		}
            		HX_END_LOCAL_FUNC1((void))

            	HX_STACKFRAME(&_hx_pos_e47a9afac0942eb9_29_mainWindowClosed)
HXLINE(  32)		::lime::app::Application_obj::current->_hx___window->onClose->cancel();
HXLINE(  34)		::CppAPI_obj::_setWindowLayered();
HXLINE(  35)		 ::flixel::tweens::misc::NumTween numTween = ::flixel::tweens::FlxTween_obj::num(( (Float)(1) ),( (Float)(0) ),((Float)0.7), ::Dynamic(::hx::Anon_obj::Create(1)
            			->setFixed(0,HX_("onComplete",f8,d4,7e,5d), ::Dynamic(new _hx_Closure_0()))),null());
HXLINE(  42)		numTween->onUpdate =  ::Dynamic(new _hx_Closure_1(numTween));
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Main_obj,mainWindowClosed,(void))


::hx::ObjectPtr< Main_obj > Main_obj::__new() {
	::hx::ObjectPtr< Main_obj > __this = new Main_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< Main_obj > Main_obj::__alloc(::hx::Ctx *_hx_ctx) {
	Main_obj *__this = (Main_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(Main_obj), true, "Main"));
	*(void **)__this = Main_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

Main_obj::Main_obj()
{
}

bool Main_obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 16:
		if (HX_FIELD_EQ(inName,"mainWindowClosed") ) { outValue = mainWindowClosed_dyn(); return true; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"setupEventListeners") ) { outValue = setupEventListeners_dyn(); return true; }
	}
	return false;
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *Main_obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo *Main_obj_sStaticStorageInfo = 0;
#endif

::hx::Class Main_obj::__mClass;

static ::String Main_obj_sStaticFields[] = {
	HX_("setupEventListeners",62,6d,8a,ba),
	HX_("mainWindowClosed",95,bb,7a,b2),
	::String(null())
};

void Main_obj::__register()
{
	Main_obj _hx_dummy;
	Main_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("Main",59,64,2f,33);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &Main_obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(Main_obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< Main_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Main_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Main_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

