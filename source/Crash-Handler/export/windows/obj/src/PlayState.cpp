#include <hxcpp.h>

#ifndef INCLUDED_CppAPI
#include <CppAPI.h>
#endif
#ifndef INCLUDED_EReg
#include <EReg.h>
#endif
#ifndef INCLUDED_PlayState
#include <PlayState.h>
#endif
#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_Sys
#include <Sys.h>
#endif
#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxG
#include <flixel/FlxG.h>
#endif
#ifndef INCLUDED_flixel_FlxObject
#include <flixel/FlxObject.h>
#endif
#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
#ifndef INCLUDED_flixel_FlxState
#include <flixel/FlxState.h>
#endif
#ifndef INCLUDED_flixel_group_FlxTypedGroup
#include <flixel/group/FlxTypedGroup.h>
#endif
#ifndef INCLUDED_flixel_input_FlxPointer
#include <flixel/input/FlxPointer.h>
#endif
#ifndef INCLUDED_flixel_input_IFlxInput
#include <flixel/input/IFlxInput.h>
#endif
#ifndef INCLUDED_flixel_input_IFlxInputManager
#include <flixel/input/IFlxInputManager.h>
#endif
#ifndef INCLUDED_flixel_input_mouse_FlxMouse
#include <flixel/input/mouse/FlxMouse.h>
#endif
#ifndef INCLUDED_flixel_math_FlxBasePoint
#include <flixel/math/FlxBasePoint.h>
#endif
#ifndef INCLUDED_flixel_text_FlxText
#include <flixel/text/FlxText.h>
#endif
#ifndef INCLUDED_flixel_text_FlxTextBorderStyle
#include <flixel/text/FlxTextBorderStyle.h>
#endif
#ifndef INCLUDED_flixel_tweens_FlxEase
#include <flixel/tweens/FlxEase.h>
#endif
#ifndef INCLUDED_flixel_tweens_FlxTween
#include <flixel/tweens/FlxTween.h>
#endif
#ifndef INCLUDED_flixel_tweens_misc_NumTween
#include <flixel/tweens/misc/NumTween.h>
#endif
#ifndef INCLUDED_flixel_tweens_misc_VarTween
#include <flixel/tweens/misc/VarTween.h>
#endif
#ifndef INCLUDED_flixel_ui_FlxButton
#include <flixel/ui/FlxButton.h>
#endif
#ifndef INCLUDED_flixel_ui_FlxTypedButton_flixel_text_FlxText
#include <flixel/ui/FlxTypedButton_flixel_text_FlxText.h>
#endif
#ifndef INCLUDED_flixel_util_FlxTimer
#include <flixel/util/FlxTimer.h>
#endif
#ifndef INCLUDED_flixel_util_FlxTimerManager
#include <flixel/util/FlxTimerManager.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxPooled
#include <flixel/util/IFlxPooled.h>
#endif
#ifndef INCLUDED_haxe_Exception
#include <haxe/Exception.h>
#endif
#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
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
#ifndef INCLUDED_lime_ui_Window
#include <lime/ui/Window.h>
#endif
#ifndef INCLUDED_openfl_Lib
#include <openfl/Lib.h>
#endif
#ifndef INCLUDED_openfl_net_URLRequest
#include <openfl/net/URLRequest.h>
#endif
#ifndef INCLUDED_sys_FileSystem
#include <sys/FileSystem.h>
#endif
#ifndef INCLUDED_sys_io_File
#include <sys/io/File.h>
#endif
#ifndef INCLUDED_sys_io_Process
#include <sys/io/Process.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_af23706db05c7feb_20_new,"PlayState","new",0xf8bf96cf,"PlayState.new","PlayState.hx",20,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_39_create,"PlayState","create",0x82220fed,"PlayState.create","PlayState.hx",39,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_119_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",119,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_143_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",143,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_152_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",152,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_148_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",148,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_165_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",165,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_169_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",169,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_176_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",176,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_183_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",183,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_193_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",193,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_199_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",199,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_179_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",179,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_210_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",210,0xb30d7781)
HX_LOCAL_STACK_FRAME(_hx_pos_af23706db05c7feb_54_crashHandler,"PlayState","crashHandler",0xd9976654,"PlayState.crashHandler","PlayState.hx",54,0xb30d7781)

void PlayState_obj::__construct( ::Dynamic MaxSize){
            	HX_STACKFRAME(&_hx_pos_af23706db05c7feb_20_new)
HXLINE(  22)		this->FNFExe = HX_("Hitmans.exe",70,c3,a4,1f);
HXLINE(  20)		super::__construct(MaxSize);
            	}

Dynamic PlayState_obj::__CreateEmpty() { return new PlayState_obj; }

void *PlayState_obj::_hx_vtable = 0;

Dynamic PlayState_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< PlayState_obj > _hx_result = new PlayState_obj();
	_hx_result->__construct(inArgs[0]);
	return _hx_result;
}

bool PlayState_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x62817b24) {
		if (inClassId<=(int)0x0a05f89d) {
			return inClassId==(int)0x00000001 || inClassId==(int)0x0a05f89d;
		} else {
			return inClassId==(int)0x62817b24;
		}
	} else {
		return inClassId==(int)0x7c795c9f || inClassId==(int)0x7ccf8994;
	}
}

void PlayState_obj::create(){
            	HX_STACKFRAME(&_hx_pos_af23706db05c7feb_39_create)
HXLINE(  40)		::flixel::FlxG_obj::mouse->set_useSystemCursor(true);
HXLINE(  41)		::flixel::FlxG_obj::autoPause = false;
HXLINE(  42)		try {
            			HX_STACK_CATCHABLE( ::Dynamic, 0);
HXLINE(  43)			this->crashHandler();
            		} catch( ::Dynamic _hx_e) {
            			if (_hx_e.IsClass<  ::Dynamic >() ){
            				HX_STACK_BEGIN_CATCH
            				 ::Dynamic _g = _hx_e;
HXLINE(  44)				{
HXLINE(  44)					null();
            				}
HXDLIN(  44)				 ::Dynamic e = ::haxe::Exception_obj::caught(_g)->unwrap();
HXDLIN(  44)				{
HXLINE(  45)					 ::lime::ui::Window _hx_tmp = ::lime::app::Application_obj::current->_hx___window;
HXDLIN(  45)					_hx_tmp->alert((HX_("Error:\n",38,a8,5b,b7) + ::Std_obj::string(e)),HX_("Crash Hanlder got an error..?",17,19,d8,58));
HXLINE(  46)					::Sys_obj::exit(1);
            				}
            			}
            			else {
            				HX_STACK_DO_THROW(_hx_e);
            			}
            		}
HXLINE(  50)		this->super::create();
            	}


void PlayState_obj::crashHandler(){
            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_0, ::flixel::text::FlxText,text) HXARGC(1)
            		void _hx_run( ::flixel::util::FlxTimer tmr){
            			HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_119_crashHandler)
HXLINE( 120)			::flixel::tweens::FlxTween_obj::tween(text, ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("alpha",5e,a7,96,21),1)),((Float)0.7), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
HXLINE( 121)			::flixel::tweens::FlxTween_obj::tween(text, ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("y",79,00,00,00),(text->y - ( (Float)(30) )))),((Float)0.7), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
            		}
            		HX_END_LOCAL_FUNC1((void))

            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_1, ::flixel::text::FlxText,crashReason) HXARGC(1)
            		void _hx_run( ::flixel::util::FlxTimer tmr){
            			HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_143_crashHandler)
HXLINE( 144)			::flixel::tweens::FlxTween_obj::tween(crashReason, ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("alpha",5e,a7,96,21),1)),((Float)0.7), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
HXLINE( 145)			::flixel::tweens::FlxTween_obj::tween(crashReason, ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("y",79,00,00,00),(crashReason->y - ( (Float)(30) )))),((Float)0.7), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
            		}
            		HX_END_LOCAL_FUNC1((void))

            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_3, ::PlayState,_gthis) HXARGC(0)
            		void _hx_run(){
            			HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_2, ::PlayState,_gthis) HXARGC(1)
            			void _hx_run( ::flixel::util::FlxTimer tmr){
            				HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_152_crashHandler)
HXLINE( 153)				::flixel::tweens::FlxTween_obj::tween(_gthis->viewGitHub, ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("y",79,00,00,00),(_gthis->viewGitHub->y + 30))),((Float)0.2), ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
HXLINE( 154)				::flixel::tweens::FlxTween_obj::tween(_gthis->closeCrashHandler, ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("y",79,00,00,00),(_gthis->closeCrashHandler->y + 30))),((Float)0.2), ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
            			}
            			HX_END_LOCAL_FUNC1((void))

            			HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_148_crashHandler)
HXLINE( 150)			_gthis->timer9 =  ::flixel::util::FlxTimer_obj::__alloc( HX_CTX ,null());
HXLINE( 151)			_gthis->timer9->start(((Float)0.1), ::Dynamic(new _hx_Closure_2(_gthis)),null());
HXLINE( 157)			 ::sys::io::Process_obj::__alloc( HX_CTX ,_gthis->FNFExe,::Array_obj< ::String >::__new(0),null());
HXLINE( 158)			::Sys_obj::exit(0);
            		}
            		HX_END_LOCAL_FUNC0((void))

            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_4, ::PlayState,_gthis) HXARGC(1)
            		void _hx_run( ::flixel::util::FlxTimer tmr){
            			HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_165_crashHandler)
HXLINE( 165)			::flixel::tweens::FlxTween_obj::tween(_gthis->resetGameButton, ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("y",79,00,00,00),(_gthis->resetGameButton->y - ( (Float)(30) )))),((Float)0.7), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
            		}
            		HX_END_LOCAL_FUNC1((void))

            		HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_5) HXARGC(0)
            		void _hx_run(){
            			HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_169_crashHandler)
HXLINE( 169)			::String prefix = HX_("",00,00,00,00);
HXDLIN( 169)			if (!( ::EReg_obj::__alloc( HX_CTX ,HX_("^https?://",48,ee,dd,38),HX_("",00,00,00,00))->match(HX_("https://github.com/EdwhakKB/HITMANS_A.D_PROJECT-FNF-Psych-Engine",c6,68,30,ce)))) {
HXLINE( 169)				prefix = HX_("http://",52,75,cd,5a);
            			}
HXDLIN( 169)			::openfl::Lib_obj::getURL( ::openfl::net::URLRequest_obj::__alloc( HX_CTX ,(prefix + HX_("https://github.com/EdwhakKB/HITMANS_A.D_PROJECT-FNF-Psych-Engine",c6,68,30,ce))),HX_("_blank",95,26,d9,b0));
            		}
            		HX_END_LOCAL_FUNC0((void))

            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_6, ::PlayState,_gthis) HXARGC(1)
            		void _hx_run( ::flixel::util::FlxTimer tmr){
            			HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_176_crashHandler)
HXLINE( 176)			::flixel::tweens::FlxTween_obj::tween(_gthis->viewGitHub, ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("y",79,00,00,00),(_gthis->viewGitHub->y - ( (Float)(30) )))),((Float)0.7), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
            		}
            		HX_END_LOCAL_FUNC1((void))

            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_10, ::PlayState,_gthis) HXARGC(0)
            		void _hx_run(){
            			HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_7, ::PlayState,_gthis) HXARGC(1)
            			void _hx_run( ::flixel::util::FlxTimer tmr){
            				HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_183_crashHandler)
HXLINE( 184)				::flixel::tweens::FlxTween_obj::tween(_gthis->viewGitHub, ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("y",79,00,00,00),(_gthis->viewGitHub->y + 30))),((Float)0.2), ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
HXLINE( 185)				::flixel::tweens::FlxTween_obj::tween(_gthis->resetGameButton, ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("y",79,00,00,00),(_gthis->resetGameButton->y + 30))),((Float)0.2), ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
            			}
            			HX_END_LOCAL_FUNC1((void))

            			HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_8) HXARGC(1)
            			void _hx_run( ::flixel::tweens::FlxTween twn){
            				HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_193_crashHandler)
HXLINE( 193)				::Sys_obj::exit(0);
            			}
            			HX_END_LOCAL_FUNC1((void))

            			HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_9, ::flixel::tweens::misc::NumTween,numTween) HXARGC(1)
            			void _hx_run( ::flixel::tweens::FlxTween twn){
            				HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_199_crashHandler)
HXLINE( 199)				::CppAPI_obj::setWindowOppacity(numTween->value);
            			}
            			HX_END_LOCAL_FUNC1((void))

            			HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_179_crashHandler)
HXLINE( 181)			_gthis->timer8 =  ::flixel::util::FlxTimer_obj::__alloc( HX_CTX ,null());
HXLINE( 182)			_gthis->timer8->start(((Float)0.1), ::Dynamic(new _hx_Closure_7(_gthis)),null());
HXLINE( 189)			::CppAPI_obj::_setWindowLayered();
HXLINE( 190)			 ::flixel::tweens::misc::NumTween numTween = ::flixel::tweens::FlxTween_obj::num(( (Float)(1) ),( (Float)(0) ),((Float)0.7), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("onComplete",f8,d4,7e,5d), ::Dynamic(new _hx_Closure_8()))),null());
HXLINE( 197)			numTween->onUpdate =  ::Dynamic(new _hx_Closure_9(numTween));
            		}
            		HX_END_LOCAL_FUNC0((void))

            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_11, ::PlayState,_gthis) HXARGC(1)
            		void _hx_run( ::flixel::util::FlxTimer tmr){
            			HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_210_crashHandler)
HXLINE( 210)			::flixel::tweens::FlxTween_obj::tween(_gthis->closeCrashHandler, ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("y",79,00,00,00),(_gthis->closeCrashHandler->y - ( (Float)(30) )))),((Float)0.9), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("ease",ee,8b,0c,43),::flixel::tweens::FlxEase_obj::quadInOut_dyn())));
            		}
            		HX_END_LOCAL_FUNC1((void))

            	HX_GC_STACKFRAME(&_hx_pos_af23706db05c7feb_54_crashHandler)
HXDLIN(  54)		 ::PlayState _gthis = ::hx::ObjectPtr<OBJ_>(this);
HXLINE(  55)		::Array< ::String > args = ::Sys_obj::args();
HXLINE(  56)		if ((args->length < 2)) {
HXLINE(  57)			::lime::app::Application_obj::current->_hx___window->alert(HX_("Se debe proporcionar la ruta del archivo como argumento.",2a,4a,df,78),HX_("ERROR! in this crash handler..?",1c,f1,f6,bd));
HXLINE(  58)			::haxe::Log_obj::trace(HX_("Se debe proporcionar la ruta del archivo como argumento.",2a,4a,df,78),::hx::SourceInfo(HX_("source/PlayState.hx",75,24,2b,b8),58,HX_("PlayState",5d,83,c2,46),HX_("crashHandler",a3,f2,61,be)));
HXLINE(  59)			::Sys_obj::exit(1);
HXLINE(  60)			return;
            		}
HXLINE(  63)		::String path = args->__get(1);
HXLINE(  64)		if (!(::sys::FileSystem_obj::exists(path))) {
HXLINE(  65)			::lime::app::Application_obj::current->_hx___window->alert((HX_("El archivo no existe en la ruta especificada: ",29,05,4f,9a) + path),HX_("ERROR! in this crash handler..?",1c,f1,f6,bd));
HXLINE(  66)			::haxe::Log_obj::trace((HX_("El archivo no existe en la ruta especificada: ",29,05,4f,9a) + path),::hx::SourceInfo(HX_("source/PlayState.hx",75,24,2b,b8),66,HX_("PlayState",5d,83,c2,46),HX_("crashHandler",a3,f2,61,be)));
HXLINE(  67)			::Sys_obj::exit(1);
HXLINE(  68)			return;
            		}
HXLINE(  71)		int maxLength = 50;
HXLINE(  73)		::String contents = ::sys::io::File_obj::getContent(path);
HXLINE(  74)		::haxe::Log_obj::trace((HX_("\nTXT CONTENT:\n",cf,17,bf,75) + contents),::hx::SourceInfo(HX_("source/PlayState.hx",75,24,2b,b8),74,HX_("PlayState",5d,83,c2,46),HX_("crashHandler",a3,f2,61,be)));
HXLINE(  76)		::Array< ::String > split = contents.split(HX_("\n",0a,00,00,00));
HXLINE(  79)		 ::flixel::FlxSprite bg =  ::flixel::FlxSprite_obj::__alloc( HX_CTX ,null(),null(),null())->loadGraphic(HX_("assets/images/Art/CrashHandlerBG.png",fa,d7,a8,a9),null(),null(),null(),null(),null());
HXLINE(  81)		{
HXLINE(  81)			int axes = 17;
HXDLIN(  81)			bool _hx_tmp;
HXDLIN(  81)			if ((axes != 1)) {
HXLINE(  81)				_hx_tmp = (axes == 17);
            			}
            			else {
HXLINE(  81)				_hx_tmp = true;
            			}
HXDLIN(  81)			if (_hx_tmp) {
HXLINE(  81)				int _hx_tmp = ::flixel::FlxG_obj::width;
HXDLIN(  81)				bg->set_x(((( (Float)(_hx_tmp) ) - bg->get_width()) / ( (Float)(2) )));
            			}
HXDLIN(  81)			bool _hx_tmp1;
HXDLIN(  81)			if ((axes != 16)) {
HXLINE(  81)				_hx_tmp1 = (axes == 17);
            			}
            			else {
HXLINE(  81)				_hx_tmp1 = true;
            			}
HXDLIN(  81)			if (_hx_tmp1) {
HXLINE(  81)				int _hx_tmp = ::flixel::FlxG_obj::height;
HXDLIN(  81)				bg->set_y(((( (Float)(_hx_tmp) ) - bg->get_height()) / ( (Float)(2) )));
            			}
            		}
HXLINE(  82)		bg->set_antialiasing(true);
HXLINE(  83)		bg->set_alpha(( (Float)(1) ));
HXLINE(  84)		this->add(bg);
HXLINE(  86)		 ::flixel::text::FlxText watermark =  ::flixel::text::FlxText_obj::__alloc( HX_CTX ,3,2,0,HX_("Crash Handler [v1.0] by Slushi",95,17,d2,cd),null(),null());
HXLINE(  87)		watermark->setFormat(HX_("assets/fonts/vcr.ttf",46,38,26,7e),11,-1,HX_("left",07,08,b0,47),::flixel::text::FlxTextBorderStyle_obj::OUTLINE_dyn(),-16777216,null());
HXLINE(  88)		{
HXLINE(  88)			 ::flixel::math::FlxBasePoint this1 = watermark->scrollFactor;
HXDLIN(  88)			this1->set_x(( (Float)(0) ));
HXDLIN(  88)			this1->set_y(( (Float)(0) ));
            		}
HXLINE(  89)		watermark->set_borderSize(((Float)1.25));
HXLINE(  90)		watermark->set_antialiasing(true);
HXLINE(  91)		watermark->set_alpha(( (Float)(1) ));
HXLINE(  92)		this->add(watermark);
HXLINE(  94)		 ::flixel::FlxSprite logo =  ::flixel::FlxSprite_obj::__alloc( HX_CTX ,0,-225,null())->loadGraphic(HX_("assets/images/Art/CrashHandlerLogo.png",40,d7,87,cf),null(),null(),null(),null(),null());
HXLINE(  96)		{
HXLINE(  96)			int axes1 = 1;
HXDLIN(  96)			bool _hx_tmp2;
HXDLIN(  96)			if ((axes1 != 1)) {
HXLINE(  96)				_hx_tmp2 = (axes1 == 17);
            			}
            			else {
HXLINE(  96)				_hx_tmp2 = true;
            			}
HXDLIN(  96)			if (_hx_tmp2) {
HXLINE(  96)				int _hx_tmp = ::flixel::FlxG_obj::width;
HXDLIN(  96)				logo->set_x(((( (Float)(_hx_tmp) ) - logo->get_width()) / ( (Float)(2) )));
            			}
HXDLIN(  96)			bool _hx_tmp3;
HXDLIN(  96)			if ((axes1 != 16)) {
HXLINE(  96)				_hx_tmp3 = (axes1 == 17);
            			}
            			else {
HXLINE(  96)				_hx_tmp3 = true;
            			}
HXDLIN(  96)			if (_hx_tmp3) {
HXLINE(  96)				int _hx_tmp = ::flixel::FlxG_obj::height;
HXDLIN(  96)				logo->set_y(((( (Float)(_hx_tmp) ) - logo->get_height()) / ( (Float)(2) )));
            			}
            		}
HXLINE(  97)		logo->set_visible(true);
HXLINE(  98)		logo->set_antialiasing(true);
HXLINE(  99)		this->add(logo);
HXLINE( 101)		 ::flixel::text::FlxText text =  ::flixel::text::FlxText_obj::__alloc( HX_CTX ,10,185,::Std_obj::_hx_int((( (Float)(::flixel::FlxG_obj::width) ) * ((Float)0.9))),HX_("",00,00,00,00),null(),null());
HXLINE( 102)		text->setFormat(HX_("assets/fonts/vcr.ttf",46,38,26,7e),15,-1,HX_("left",07,08,b0,47),::flixel::text::FlxTextBorderStyle_obj::OUTLINE_dyn(),-16777216,null());
HXLINE( 103)		{
HXLINE( 103)			 ::flixel::math::FlxBasePoint this2 = text->scrollFactor;
HXDLIN( 103)			this2->set_x(( (Float)(0) ));
HXDLIN( 103)			this2->set_y(( (Float)(0) ));
            		}
HXLINE( 104)		text->set_borderSize(((Float)1.25));
HXLINE( 105)		text->set_visible(true);
HXLINE( 106)		text->set_antialiasing(true);
HXLINE( 107)		{
HXLINE( 107)			int _g = 0;
HXDLIN( 107)			int _g1 = (split->length - 1);
HXDLIN( 107)			while((_g < _g1)){
HXLINE( 107)				_g = (_g + 1);
HXDLIN( 107)				int i = (_g - 1);
HXLINE( 109)				if ((i == (split->length - 15))) {
HXLINE( 110)					text->set_text((text->text + split->__get(i)));
            				}
            				else {
HXLINE( 112)					text->set_text((text->text + (split->__get(i) + HX_("\n",0a,00,00,00))));
            				}
            			}
            		}
HXLINE( 114)		this->add(text);
HXLINE( 115)		text->set_alpha(( (Float)(0) ));
HXLINE( 117)		this->timer2 =  ::flixel::util::FlxTimer_obj::__alloc( HX_CTX ,null());
HXLINE( 118)		this->timer2->start(((Float)0.3), ::Dynamic(new _hx_Closure_0(text)),null());
HXLINE( 124)		 ::flixel::text::FlxText crashReason =  ::flixel::text::FlxText_obj::__alloc( HX_CTX ,text->x,(text->y + 415),435,HX_("",00,00,00,00),null(),null());
HXLINE( 125)		crashReason->setFormat(HX_("assets/fonts/vcr.ttf",46,38,26,7e),13,-1,HX_("left",07,08,b0,47),::flixel::text::FlxTextBorderStyle_obj::OUTLINE_dyn(),-16777216,null());
HXLINE( 126)		{
HXLINE( 126)			 ::flixel::math::FlxBasePoint this3 = crashReason->scrollFactor;
HXDLIN( 126)			this3->set_x(( (Float)(0) ));
HXDLIN( 126)			this3->set_y(( (Float)(0) ));
            		}
HXLINE( 127)		crashReason->set_borderSize(((Float)1.25));
HXLINE( 128)		crashReason->set_antialiasing(true);
HXLINE( 131)		{
HXLINE( 131)			int _g2 = (split->length - 1);
HXDLIN( 131)			int _g3 = split->length;
HXDLIN( 131)			while((_g2 < _g3)){
HXLINE( 131)				_g2 = (_g2 + 1);
HXDLIN( 131)				int i = (_g2 - 1);
HXLINE( 132)				if ((i == (split->length - 9))) {
HXLINE( 133)					crashReason->set_text((crashReason->text + split->__get(i)));
            				}
            				else {
HXLINE( 135)					crashReason->set_text((crashReason->text + (split->__get(i) + HX_("\n",0a,00,00,00))));
            				}
            			}
            		}
HXLINE( 138)		this->add(crashReason);
HXLINE( 139)		crashReason->set_alpha(( (Float)(0) ));
HXLINE( 141)		this->timer3 =  ::flixel::util::FlxTimer_obj::__alloc( HX_CTX ,null());
HXLINE( 142)		this->timer3->start(((Float)0.3), ::Dynamic(new _hx_Closure_1(crashReason)),null());
HXLINE( 148)		this->resetGameButton =  ::flixel::ui::FlxButton_obj::__alloc( HX_CTX ,70,640,HX_("Restart Game",23,86,05,0c), ::Dynamic(new _hx_Closure_3(_gthis)));
HXLINE( 160)		this->add(this->resetGameButton);
HXLINE( 162)		this->timer4 =  ::flixel::util::FlxTimer_obj::__alloc( HX_CTX ,null());
HXLINE( 163)		this->timer4->start(((Float)0.5), ::Dynamic(new _hx_Closure_4(_gthis)),null());
HXLINE( 168)		this->viewGitHub =  ::flixel::ui::FlxButton_obj::__alloc( HX_CTX ,(this->resetGameButton->x + 100),this->resetGameButton->y,HX_("GitHub",e3,4f,4d,25), ::Dynamic(new _hx_Closure_5()));
HXLINE( 171)		this->add(this->viewGitHub);
HXLINE( 173)		this->timer5 =  ::flixel::util::FlxTimer_obj::__alloc( HX_CTX ,null());
HXLINE( 174)		this->timer5->start(((Float)0.8), ::Dynamic(new _hx_Closure_6(_gthis)),null());
HXLINE( 179)		this->closeCrashHandler =  ::flixel::ui::FlxButton_obj::__alloc( HX_CTX ,(this->resetGameButton->x + 205),this->resetGameButton->y,HX_("Close",98,87,90,db), ::Dynamic(new _hx_Closure_10(_gthis)));
HXLINE( 205)		this->add(this->closeCrashHandler);
HXLINE( 207)		this->timer6 =  ::flixel::util::FlxTimer_obj::__alloc( HX_CTX ,null());
HXLINE( 208)		this->timer6->start(((Float)0.8), ::Dynamic(new _hx_Closure_11(_gthis)),null());
            	}


HX_DEFINE_DYNAMIC_FUNC0(PlayState_obj,crashHandler,(void))


::hx::ObjectPtr< PlayState_obj > PlayState_obj::__new( ::Dynamic MaxSize) {
	::hx::ObjectPtr< PlayState_obj > __this = new PlayState_obj();
	__this->__construct(MaxSize);
	return __this;
}

::hx::ObjectPtr< PlayState_obj > PlayState_obj::__alloc(::hx::Ctx *_hx_ctx, ::Dynamic MaxSize) {
	PlayState_obj *__this = (PlayState_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(PlayState_obj), true, "PlayState"));
	*(void **)__this = PlayState_obj::_hx_vtable;
	__this->__construct(MaxSize);
	return __this;
}

PlayState_obj::PlayState_obj()
{
}

void PlayState_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(PlayState);
	HX_MARK_MEMBER_NAME(FNFExe,"FNFExe");
	HX_MARK_MEMBER_NAME(timer1,"timer1");
	HX_MARK_MEMBER_NAME(timer2,"timer2");
	HX_MARK_MEMBER_NAME(timer3,"timer3");
	HX_MARK_MEMBER_NAME(timer4,"timer4");
	HX_MARK_MEMBER_NAME(timer5,"timer5");
	HX_MARK_MEMBER_NAME(timer6,"timer6");
	HX_MARK_MEMBER_NAME(timer7,"timer7");
	HX_MARK_MEMBER_NAME(timer8,"timer8");
	HX_MARK_MEMBER_NAME(timer9,"timer9");
	HX_MARK_MEMBER_NAME(resetGameButton,"resetGameButton");
	HX_MARK_MEMBER_NAME(viewGitHub,"viewGitHub");
	HX_MARK_MEMBER_NAME(closeCrashHandler,"closeCrashHandler");
	 ::flixel::FlxState_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void PlayState_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(FNFExe,"FNFExe");
	HX_VISIT_MEMBER_NAME(timer1,"timer1");
	HX_VISIT_MEMBER_NAME(timer2,"timer2");
	HX_VISIT_MEMBER_NAME(timer3,"timer3");
	HX_VISIT_MEMBER_NAME(timer4,"timer4");
	HX_VISIT_MEMBER_NAME(timer5,"timer5");
	HX_VISIT_MEMBER_NAME(timer6,"timer6");
	HX_VISIT_MEMBER_NAME(timer7,"timer7");
	HX_VISIT_MEMBER_NAME(timer8,"timer8");
	HX_VISIT_MEMBER_NAME(timer9,"timer9");
	HX_VISIT_MEMBER_NAME(resetGameButton,"resetGameButton");
	HX_VISIT_MEMBER_NAME(viewGitHub,"viewGitHub");
	HX_VISIT_MEMBER_NAME(closeCrashHandler,"closeCrashHandler");
	 ::flixel::FlxState_obj::__Visit(HX_VISIT_ARG);
}

::hx::Val PlayState_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"FNFExe") ) { return ::hx::Val( FNFExe ); }
		if (HX_FIELD_EQ(inName,"timer1") ) { return ::hx::Val( timer1 ); }
		if (HX_FIELD_EQ(inName,"timer2") ) { return ::hx::Val( timer2 ); }
		if (HX_FIELD_EQ(inName,"timer3") ) { return ::hx::Val( timer3 ); }
		if (HX_FIELD_EQ(inName,"timer4") ) { return ::hx::Val( timer4 ); }
		if (HX_FIELD_EQ(inName,"timer5") ) { return ::hx::Val( timer5 ); }
		if (HX_FIELD_EQ(inName,"timer6") ) { return ::hx::Val( timer6 ); }
		if (HX_FIELD_EQ(inName,"timer7") ) { return ::hx::Val( timer7 ); }
		if (HX_FIELD_EQ(inName,"timer8") ) { return ::hx::Val( timer8 ); }
		if (HX_FIELD_EQ(inName,"timer9") ) { return ::hx::Val( timer9 ); }
		if (HX_FIELD_EQ(inName,"create") ) { return ::hx::Val( create_dyn() ); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"viewGitHub") ) { return ::hx::Val( viewGitHub ); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"crashHandler") ) { return ::hx::Val( crashHandler_dyn() ); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"resetGameButton") ) { return ::hx::Val( resetGameButton ); }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"closeCrashHandler") ) { return ::hx::Val( closeCrashHandler ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val PlayState_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"FNFExe") ) { FNFExe=inValue.Cast< ::String >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer1") ) { timer1=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer2") ) { timer2=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer3") ) { timer3=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer4") ) { timer4=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer5") ) { timer5=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer6") ) { timer6=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer7") ) { timer7=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer8") ) { timer8=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"timer9") ) { timer9=inValue.Cast<  ::flixel::util::FlxTimer >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"viewGitHub") ) { viewGitHub=inValue.Cast<  ::flixel::ui::FlxButton >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"resetGameButton") ) { resetGameButton=inValue.Cast<  ::flixel::ui::FlxButton >(); return inValue; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"closeCrashHandler") ) { closeCrashHandler=inValue.Cast<  ::flixel::ui::FlxButton >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void PlayState_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("FNFExe",34,35,b6,14));
	outFields->push(HX_("timer1",cc,0c,d2,1e));
	outFields->push(HX_("timer2",cd,0c,d2,1e));
	outFields->push(HX_("timer3",ce,0c,d2,1e));
	outFields->push(HX_("timer4",cf,0c,d2,1e));
	outFields->push(HX_("timer5",d0,0c,d2,1e));
	outFields->push(HX_("timer6",d1,0c,d2,1e));
	outFields->push(HX_("timer7",d2,0c,d2,1e));
	outFields->push(HX_("timer8",d3,0c,d2,1e));
	outFields->push(HX_("timer9",d4,0c,d2,1e));
	outFields->push(HX_("resetGameButton",33,92,3d,e4));
	outFields->push(HX_("viewGitHub",08,dc,05,32));
	outFields->push(HX_("closeCrashHandler",7b,0a,f8,c4));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo PlayState_obj_sMemberStorageInfo[] = {
	{::hx::fsString,(int)offsetof(PlayState_obj,FNFExe),HX_("FNFExe",34,35,b6,14)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer1),HX_("timer1",cc,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer2),HX_("timer2",cd,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer3),HX_("timer3",ce,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer4),HX_("timer4",cf,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer5),HX_("timer5",d0,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer6),HX_("timer6",d1,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer7),HX_("timer7",d2,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer8),HX_("timer8",d3,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::util::FlxTimer */ ,(int)offsetof(PlayState_obj,timer9),HX_("timer9",d4,0c,d2,1e)},
	{::hx::fsObject /*  ::flixel::ui::FlxButton */ ,(int)offsetof(PlayState_obj,resetGameButton),HX_("resetGameButton",33,92,3d,e4)},
	{::hx::fsObject /*  ::flixel::ui::FlxButton */ ,(int)offsetof(PlayState_obj,viewGitHub),HX_("viewGitHub",08,dc,05,32)},
	{::hx::fsObject /*  ::flixel::ui::FlxButton */ ,(int)offsetof(PlayState_obj,closeCrashHandler),HX_("closeCrashHandler",7b,0a,f8,c4)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *PlayState_obj_sStaticStorageInfo = 0;
#endif

static ::String PlayState_obj_sMemberFields[] = {
	HX_("FNFExe",34,35,b6,14),
	HX_("timer1",cc,0c,d2,1e),
	HX_("timer2",cd,0c,d2,1e),
	HX_("timer3",ce,0c,d2,1e),
	HX_("timer4",cf,0c,d2,1e),
	HX_("timer5",d0,0c,d2,1e),
	HX_("timer6",d1,0c,d2,1e),
	HX_("timer7",d2,0c,d2,1e),
	HX_("timer8",d3,0c,d2,1e),
	HX_("timer9",d4,0c,d2,1e),
	HX_("resetGameButton",33,92,3d,e4),
	HX_("viewGitHub",08,dc,05,32),
	HX_("closeCrashHandler",7b,0a,f8,c4),
	HX_("create",fc,66,0f,7c),
	HX_("crashHandler",a3,f2,61,be),
	::String(null()) };

::hx::Class PlayState_obj::__mClass;

void PlayState_obj::__register()
{
	PlayState_obj _hx_dummy;
	PlayState_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("PlayState",5d,83,c2,46);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(PlayState_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< PlayState_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = PlayState_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = PlayState_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

