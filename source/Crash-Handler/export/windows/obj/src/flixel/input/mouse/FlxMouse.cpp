#include <hxcpp.h>

#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_Type
#include <Type.h>
#endif
#ifndef INCLUDED_flixel_FlxG
#include <flixel/FlxG.h>
#endif
#ifndef INCLUDED_flixel_FlxGame
#include <flixel/FlxGame.h>
#endif
#ifndef INCLUDED_flixel_input_FlxInput
#include <flixel/input/FlxInput.h>
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
#ifndef INCLUDED_flixel_input_mouse_FlxMouseButton
#include <flixel/input/mouse/FlxMouseButton.h>
#endif
#ifndef INCLUDED_flixel_input_mouse__FlxMouse_GraphicCursor
#include <flixel/input/mouse/_FlxMouse/GraphicCursor.h>
#endif
#ifndef INCLUDED_flixel_math_FlxBasePoint
#include <flixel/math/FlxBasePoint.h>
#endif
#ifndef INCLUDED_flixel_system_frontEnds_SignalFrontEnd
#include <flixel/system/frontEnds/SignalFrontEnd.h>
#endif
#ifndef INCLUDED_flixel_system_replay_MouseRecord
#include <flixel/system/replay/MouseRecord.h>
#endif
#ifndef INCLUDED_flixel_system_scaleModes_BaseScaleMode
#include <flixel/system/scaleModes/BaseScaleMode.h>
#endif
#ifndef INCLUDED_flixel_util_FlxDestroyUtil
#include <flixel/util/FlxDestroyUtil.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxPooled
#include <flixel/util/IFlxPooled.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxSignal
#include <flixel/util/IFlxSignal.h>
#endif
#ifndef INCLUDED_flixel_util__FlxSignal_FlxBaseSignal
#include <flixel/util/_FlxSignal/FlxBaseSignal.h>
#endif
#ifndef INCLUDED_flixel_util__FlxSignal_FlxSignal0
#include <flixel/util/_FlxSignal/FlxSignal0.h>
#endif
#ifndef INCLUDED_lime_app_IModule
#include <lime/app/IModule.h>
#endif
#ifndef INCLUDED_openfl_Lib
#include <openfl/Lib.h>
#endif
#ifndef INCLUDED_openfl_display_Bitmap
#include <openfl/display/Bitmap.h>
#endif
#ifndef INCLUDED_openfl_display_BitmapData
#include <openfl/display/BitmapData.h>
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
#ifndef INCLUDED_openfl_display_MovieClip
#include <openfl/display/MovieClip.h>
#endif
#ifndef INCLUDED_openfl_display_Sprite
#include <openfl/display/Sprite.h>
#endif
#ifndef INCLUDED_openfl_display_Stage
#include <openfl/display/Stage.h>
#endif
#ifndef INCLUDED_openfl_events_Event
#include <openfl/events/Event.h>
#endif
#ifndef INCLUDED_openfl_events_EventDispatcher
#include <openfl/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_IEventDispatcher
#include <openfl/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_MouseEvent
#include <openfl/events/MouseEvent.h>
#endif
#ifndef INCLUDED_openfl_ui_Mouse
#include <openfl/ui/Mouse.h>
#endif
#ifndef INCLUDED_openfl_utils_Assets
#include <openfl/utils/Assets.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_35_new,"flixel.input.mouse.FlxMouse","new",0x1251bd04,"flixel.input.mouse.FlxMouse.new","flixel/input/mouse/FlxMouse.hx",35,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_245_load,"flixel.input.mouse.FlxMouse","load",0xf3e8bd02,"flixel.input.mouse.FlxMouse.load","flixel/input/mouse/FlxMouse.hx",245,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_317_unload,"flixel.input.mouse.FlxMouse","unload",0x5a7132db,"flixel.input.mouse.FlxMouse.unload","flixel/input/mouse/FlxMouse.hx",317,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_403_destroy,"flixel.input.mouse.FlxMouse","destroy",0x77a13b9e,"flixel.input.mouse.FlxMouse.destroy","flixel/input/mouse/FlxMouse.hx",403,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_442_reset,"flixel.input.mouse.FlxMouse","reset",0xe595a773,"flixel.input.mouse.FlxMouse.reset","flixel/input/mouse/FlxMouse.hx",442,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_491_update,"flixel.input.mouse.FlxMouse","update",0x7bea17e5,"flixel.input.mouse.FlxMouse.update","flixel/input/mouse/FlxMouse.hx",491,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_527_onFocus,"flixel.input.mouse.FlxMouse","onFocus",0xede20cdd,"flixel.input.mouse.FlxMouse.onFocus","flixel/input/mouse/FlxMouse.hx",527,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_541_onFocusLost,"flixel.input.mouse.FlxMouse","onFocusLost",0xc7f71561,"flixel.input.mouse.FlxMouse.onFocusLost","flixel/input/mouse/FlxMouse.hx",541,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_558_onGameStart,"flixel.input.mouse.FlxMouse","onGameStart",0x61da7695,"flixel.input.mouse.FlxMouse.onGameStart","flixel/input/mouse/FlxMouse.hx",558,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_566_onMouseWheel,"flixel.input.mouse.FlxMouse","onMouseWheel",0xdc642911,"flixel.input.mouse.FlxMouse.onMouseWheel","flixel/input/mouse/FlxMouse.hx",566,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_579_onMouseLeave,"flixel.input.mouse.FlxMouse","onMouseLeave",0x84fd296d,"flixel.input.mouse.FlxMouse.onMouseLeave","flixel/input/mouse/FlxMouse.hx",579,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_586_get_justMoved,"flixel.input.mouse.FlxMouse","get_justMoved",0xd61e87e2,"flixel.input.mouse.FlxMouse.get_justMoved","flixel/input/mouse/FlxMouse.hx",586,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_589_get_deltaX,"flixel.input.mouse.FlxMouse","get_deltaX",0x58943105,"flixel.input.mouse.FlxMouse.get_deltaX","flixel/input/mouse/FlxMouse.hx",589,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_592_get_deltaY,"flixel.input.mouse.FlxMouse","get_deltaY",0x58943106,"flixel.input.mouse.FlxMouse.get_deltaY","flixel/input/mouse/FlxMouse.hx",592,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_595_get_deltaScreenX,"flixel.input.mouse.FlxMouse","get_deltaScreenX",0x17615bb9,"flixel.input.mouse.FlxMouse.get_deltaScreenX","flixel/input/mouse/FlxMouse.hx",595,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_598_get_deltaScreenY,"flixel.input.mouse.FlxMouse","get_deltaScreenY",0x17615bba,"flixel.input.mouse.FlxMouse.get_deltaScreenY","flixel/input/mouse/FlxMouse.hx",598,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_601_get_pressed,"flixel.input.mouse.FlxMouse","get_pressed",0x4652635d,"flixel.input.mouse.FlxMouse.get_pressed","flixel/input/mouse/FlxMouse.hx",601,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_604_get_justPressed,"flixel.input.mouse.FlxMouse","get_justPressed",0x70091811,"flixel.input.mouse.FlxMouse.get_justPressed","flixel/input/mouse/FlxMouse.hx",604,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_607_get_released,"flixel.input.mouse.FlxMouse","get_released",0x489a9ba2,"flixel.input.mouse.FlxMouse.get_released","flixel/input/mouse/FlxMouse.hx",607,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_610_get_justReleased,"flixel.input.mouse.FlxMouse","get_justReleased",0x9ec2046e,"flixel.input.mouse.FlxMouse.get_justReleased","flixel/input/mouse/FlxMouse.hx",610,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_613_get_justPressedTimeInTicks,"flixel.input.mouse.FlxMouse","get_justPressedTimeInTicks",0xbe077333,"flixel.input.mouse.FlxMouse.get_justPressedTimeInTicks","flixel/input/mouse/FlxMouse.hx",613,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_617_get_pressedRight,"flixel.input.mouse.FlxMouse","get_pressedRight",0x90e8c73f,"flixel.input.mouse.FlxMouse.get_pressedRight","flixel/input/mouse/FlxMouse.hx",617,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_620_get_justPressedRight,"flixel.input.mouse.FlxMouse","get_justPressedRight",0xa8a2860b,"flixel.input.mouse.FlxMouse.get_justPressedRight","flixel/input/mouse/FlxMouse.hx",620,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_623_get_releasedRight,"flixel.input.mouse.FlxMouse","get_releasedRight",0xdc7574da,"flixel.input.mouse.FlxMouse.get_releasedRight","flixel/input/mouse/FlxMouse.hx",623,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_626_get_justReleasedRight,"flixel.input.mouse.FlxMouse","get_justReleasedRight",0x8742a88e,"flixel.input.mouse.FlxMouse.get_justReleasedRight","flixel/input/mouse/FlxMouse.hx",626,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_629_get_justPressedTimeInTicksRight,"flixel.input.mouse.FlxMouse","get_justPressedTimeInTicksRight",0xf3dc8fa9,"flixel.input.mouse.FlxMouse.get_justPressedTimeInTicksRight","flixel/input/mouse/FlxMouse.hx",629,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_632_get_pressedMiddle,"flixel.input.mouse.FlxMouse","get_pressedMiddle",0x38fe0e92,"flixel.input.mouse.FlxMouse.get_pressedMiddle","flixel/input/mouse/FlxMouse.hx",632,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_635_get_justPressedMiddle,"flixel.input.mouse.FlxMouse","get_justPressedMiddle",0xe3cb4246,"flixel.input.mouse.FlxMouse.get_justPressedMiddle","flixel/input/mouse/FlxMouse.hx",635,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_638_get_releasedMiddle,"flixel.input.mouse.FlxMouse","get_releasedMiddle",0x08894897,"flixel.input.mouse.FlxMouse.get_releasedMiddle","flixel/input/mouse/FlxMouse.hx",638,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_641_get_justReleasedMiddle,"flixel.input.mouse.FlxMouse","get_justReleasedMiddle",0xd1495263,"flixel.input.mouse.FlxMouse.get_justReleasedMiddle","flixel/input/mouse/FlxMouse.hx",641,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_644_get_justPressedTimeInTicksMiddle,"flixel.input.mouse.FlxMouse","get_justPressedTimeInTicksMiddle",0x6b59a2e8,"flixel.input.mouse.FlxMouse.get_justPressedTimeInTicksMiddle","flixel/input/mouse/FlxMouse.hx",644,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_648_showSystemCursor,"flixel.input.mouse.FlxMouse","showSystemCursor",0xf4551c9e,"flixel.input.mouse.FlxMouse.showSystemCursor","flixel/input/mouse/FlxMouse.hx",648,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_659_hideSystemCursor,"flixel.input.mouse.FlxMouse","hideSystemCursor",0xb5438fe3,"flixel.input.mouse.FlxMouse.hideSystemCursor","flixel/input/mouse/FlxMouse.hx",659,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_676_set_useSystemCursor,"flixel.input.mouse.FlxMouse","set_useSystemCursor",0x074e74d3,"flixel.input.mouse.FlxMouse.set_useSystemCursor","flixel/input/mouse/FlxMouse.hx",676,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_690_showCursor,"flixel.input.mouse.FlxMouse","showCursor",0xa585e38f,"flixel.input.mouse.FlxMouse.showCursor","flixel/input/mouse/FlxMouse.hx",690,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_709_hideCursor,"flixel.input.mouse.FlxMouse","hideCursor",0xd396e514,"flixel.input.mouse.FlxMouse.hideCursor","flixel/input/mouse/FlxMouse.hx",709,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_715_set_visible,"flixel.input.mouse.FlxMouse","set_visible",0xb9fd1039,"flixel.input.mouse.FlxMouse.set_visible","flixel/input/mouse/FlxMouse.hx",715,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_726_record,"flixel.input.mouse.FlxMouse","record",0xf2d1086d,"flixel.input.mouse.FlxMouse.record","flixel/input/mouse/FlxMouse.hx",726,0xe4e80b89)
HX_LOCAL_STACK_FRAME(_hx_pos_dcc29ee8d0f87524_744_playback,"flixel.input.mouse.FlxMouse","playback",0xaadcd2f7,"flixel.input.mouse.FlxMouse.playback","flixel/input/mouse/FlxMouse.hx",744,0xe4e80b89)
namespace flixel{
namespace input{
namespace mouse{

void FlxMouse_obj::__construct( ::openfl::display::Sprite cursorContainer){
            	HX_GC_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_35_new)
HXLINE( 219)		this->_prevScreenY = 0;
HXLINE( 218)		this->_prevScreenX = 0;
HXLINE( 217)		this->_prevY = 0;
HXLINE( 216)		this->_prevX = 0;
HXLINE( 210)		this->_lastWheel = 0;
HXLINE( 209)		this->_lastY = 0;
HXLINE( 207)		this->_lastX = 0;
HXLINE( 202)		this->_visibleWhenFocusLost = true;
HXLINE( 201)		this->_wheelUsed = false;
HXLINE( 198)		this->_cursor = null();
HXLINE(  64)		this->useSystemCursor = false;
HXLINE(  59)		this->visible = true;
HXLINE(  47)		this->wheel = 0;
HXLINE(  41)		this->enabled = true;
HXLINE( 457)		super::__construct();
HXLINE( 458)		this->cursorContainer = cursorContainer;
HXLINE( 459)		this->cursorContainer->mouseChildren = false;
HXLINE( 460)		this->cursorContainer->mouseEnabled = false;
HXLINE( 462)		this->_leftButton =  ::flixel::input::mouse::FlxMouseButton_obj::__alloc( HX_CTX ,-1);
HXLINE( 464)		this->_stage = ::openfl::Lib_obj::get_current()->stage;
HXLINE( 465)		this->_stage->addEventListener(HX_("mouseDown",27,b1,c2,ee),this->_leftButton->onDown_dyn(),null(),null(),null());
HXLINE( 466)		this->_stage->addEventListener(HX_("mouseUp",e0,f3,72,c0),this->_leftButton->onUp_dyn(),null(),null(),null());
HXLINE( 469)		this->_middleButton =  ::flixel::input::mouse::FlxMouseButton_obj::__alloc( HX_CTX ,-2);
HXLINE( 470)		this->_rightButton =  ::flixel::input::mouse::FlxMouseButton_obj::__alloc( HX_CTX ,-3);
HXLINE( 472)		this->_stage->addEventListener(HX_("middleMouseDown",12,2b,fe,01),this->_middleButton->onDown_dyn(),null(),null(),null());
HXLINE( 473)		this->_stage->addEventListener(HX_("middleMouseUp",0b,8d,f5,3a),this->_middleButton->onUp_dyn(),null(),null(),null());
HXLINE( 474)		this->_stage->addEventListener(HX_("rightMouseDown",ab,29,d7,cd),this->_rightButton->onDown_dyn(),null(),null(),null());
HXLINE( 475)		this->_stage->addEventListener(HX_("rightMouseUp",64,83,21,ab),this->_rightButton->onUp_dyn(),null(),null(),null());
HXLINE( 477)		this->_stage->addEventListener(HX_("mouseLeave",92,28,20,90),this->onMouseLeave_dyn(),null(),null(),null());
HXLINE( 480)		this->_stage->addEventListener(HX_("mouseWheel",36,28,87,e7),this->onMouseWheel_dyn(),null(),null(),null());
HXLINE( 482)		::flixel::FlxG_obj::signals->postGameStart->add(this->onGameStart_dyn());
HXLINE( 483)		::openfl::ui::Mouse_obj::hide();
            	}

Dynamic FlxMouse_obj::__CreateEmpty() { return new FlxMouse_obj; }

void *FlxMouse_obj::_hx_vtable = 0;

Dynamic FlxMouse_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< FlxMouse_obj > _hx_result = new FlxMouse_obj();
	_hx_result->__construct(inArgs[0]);
	return _hx_result;
}

bool FlxMouse_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x5316fc32) {
		return inClassId==(int)0x00000001 || inClassId==(int)0x5316fc32;
	} else {
		return inClassId==(int)0x62adae31;
	}
}

static ::flixel::input::IFlxInputManager_obj _hx_flixel_input_mouse_FlxMouse__hx_flixel_input_IFlxInputManager= {
	( void (::hx::Object::*)())&::flixel::input::mouse::FlxMouse_obj::destroy,
	( void (::hx::Object::*)())&::flixel::input::mouse::FlxMouse_obj::reset,
	( void (::hx::Object::*)())&::flixel::input::mouse::FlxMouse_obj::update,
	( void (::hx::Object::*)())&::flixel::input::mouse::FlxMouse_obj::onFocus,
	( void (::hx::Object::*)())&::flixel::input::mouse::FlxMouse_obj::onFocusLost,
};

static ::flixel::util::IFlxDestroyable_obj _hx_flixel_input_mouse_FlxMouse__hx_flixel_util_IFlxDestroyable= {
	( void (::hx::Object::*)())&::flixel::input::mouse::FlxMouse_obj::destroy,
};

void *FlxMouse_obj::_hx_getInterface(int inHash) {
	switch(inHash) {
		case (int)0x65dd217a: return &_hx_flixel_input_mouse_FlxMouse__hx_flixel_input_IFlxInputManager;
		case (int)0xd4fe2fcd: return &_hx_flixel_input_mouse_FlxMouse__hx_flixel_util_IFlxDestroyable;
	}
	return super::_hx_getInterface(inHash);
}

void FlxMouse_obj::load( ::Dynamic Graphic,::hx::Null< Float >  __o_Scale,::hx::Null< int >  __o_XOffset,::hx::Null< int >  __o_YOffset){
            		Float Scale = __o_Scale.Default(1);
            		int XOffset = __o_XOffset.Default(0);
            		int YOffset = __o_YOffset.Default(0);
            	HX_GC_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_245_load)
HXLINE( 247)		if (::hx::IsNotNull( this->_cursor )) {
HXLINE( 249)			::flixel::util::FlxDestroyUtil_obj::removeChild(this->cursorContainer,this->_cursor);
            		}
HXLINE( 253)		if (::hx::IsNull( Graphic )) {
HXLINE( 255)			Graphic =  ::flixel::input::mouse::_FlxMouse::GraphicCursor_obj::__alloc( HX_CTX ,0,0,null(),null());
            		}
HXLINE( 258)		if (::Std_obj::isOfType(Graphic,::hx::ClassOf< ::hx::Class >())) {
HXLINE( 260)			this->_cursor = ( ( ::openfl::display::Bitmap)(::Type_obj::createInstance(Graphic,::cpp::VirtualArray_obj::__new(0))) );
            		}
            		else {
HXLINE( 262)			if (::Std_obj::isOfType(Graphic,::hx::ClassOf< ::openfl::display::BitmapData >())) {
HXLINE( 264)				this->_cursor =  ::openfl::display::Bitmap_obj::__alloc( HX_CTX ,( ( ::openfl::display::BitmapData)(Graphic) ),null(),null());
            			}
            			else {
HXLINE( 266)				if (::Std_obj::isOfType(Graphic,::hx::ClassOf< ::String >())) {
HXLINE( 268)					::String id = ( (::String)(Graphic) );
HXDLIN( 268)					 ::openfl::display::BitmapData _hx_tmp;
HXDLIN( 268)					if (::openfl::utils::Assets_obj::exists(id,null())) {
HXLINE( 268)						_hx_tmp = ::openfl::utils::Assets_obj::getBitmapData(id,false);
            					}
            					else {
HXLINE( 268)						_hx_tmp = null();
            					}
HXDLIN( 268)					this->_cursor =  ::openfl::display::Bitmap_obj::__alloc( HX_CTX ,_hx_tmp,null(),null());
            				}
            				else {
HXLINE( 272)					this->_cursor =  ::openfl::display::Bitmap_obj::__alloc( HX_CTX , ::flixel::input::mouse::_FlxMouse::GraphicCursor_obj::__alloc( HX_CTX ,0,0,null(),null()),null(),null());
            				}
            			}
            		}
HXLINE( 275)		this->_cursor->set_x(( (Float)(XOffset) ));
HXLINE( 276)		this->_cursor->set_y(( (Float)(YOffset) ));
HXLINE( 277)		this->_cursor->set_scaleX(Scale);
HXLINE( 278)		this->_cursor->set_scaleY(Scale);
HXLINE( 307)		this->cursorContainer->addChild(this->_cursor);
            	}


HX_DEFINE_DYNAMIC_FUNC4(FlxMouse_obj,load,(void))

void FlxMouse_obj::unload(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_317_unload)
HXDLIN( 317)		if (::hx::IsNotNull( this->_cursor )) {
HXLINE( 319)			if (this->cursorContainer->get_visible()) {
HXLINE( 321)				this->load(null(),null(),null(),null());
            			}
            			else {
HXLINE( 325)				this->_cursor = ( ( ::openfl::display::Bitmap)(::flixel::util::FlxDestroyUtil_obj::removeChild(this->cursorContainer,this->_cursor)) );
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,unload,(void))

void FlxMouse_obj::destroy(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_403_destroy)
HXLINE( 404)		if (::hx::IsNotNull( this->_stage )) {
HXLINE( 406)			this->_stage->removeEventListener(HX_("mouseDown",27,b1,c2,ee),this->_leftButton->onDown_dyn(),null());
HXLINE( 407)			this->_stage->removeEventListener(HX_("mouseUp",e0,f3,72,c0),this->_leftButton->onUp_dyn(),null());
HXLINE( 410)			this->_stage->removeEventListener(HX_("middleMouseDown",12,2b,fe,01),this->_middleButton->onDown_dyn(),null());
HXLINE( 411)			this->_stage->removeEventListener(HX_("middleMouseUp",0b,8d,f5,3a),this->_middleButton->onUp_dyn(),null());
HXLINE( 412)			this->_stage->removeEventListener(HX_("rightMouseDown",ab,29,d7,cd),this->_rightButton->onDown_dyn(),null());
HXLINE( 413)			this->_stage->removeEventListener(HX_("rightMouseUp",64,83,21,ab),this->_rightButton->onUp_dyn(),null());
HXLINE( 415)			this->_stage->removeEventListener(HX_("mouseLeave",92,28,20,90),this->onMouseLeave_dyn(),null());
HXLINE( 418)			this->_stage->removeEventListener(HX_("mouseWheel",36,28,87,e7),this->onMouseWheel_dyn(),null());
            		}
HXLINE( 421)		this->cursorContainer = null();
HXLINE( 422)		this->_cursor = null();
HXLINE( 428)		this->_leftButton = ( ( ::flixel::input::mouse::FlxMouseButton)(::flixel::util::FlxDestroyUtil_obj::destroy(this->_leftButton)) );
HXLINE( 430)		this->_middleButton = ( ( ::flixel::input::mouse::FlxMouseButton)(::flixel::util::FlxDestroyUtil_obj::destroy(this->_middleButton)) );
HXLINE( 431)		this->_rightButton = ( ( ::flixel::input::mouse::FlxMouseButton)(::flixel::util::FlxDestroyUtil_obj::destroy(this->_rightButton)) );
HXLINE( 434)		this->_cursorBitmapData = ::flixel::util::FlxDestroyUtil_obj::dispose(this->_cursorBitmapData);
HXLINE( 435)		::flixel::FlxG_obj::signals->postGameStart->remove(this->onGameStart_dyn());
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,destroy,(void))

void FlxMouse_obj::reset(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_442_reset)
HXLINE( 443)		this->_leftButton->reset();
HXLINE( 446)		this->_middleButton->reset();
HXLINE( 447)		this->_rightButton->reset();
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,reset,(void))

void FlxMouse_obj::update(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_491_update)
HXLINE( 492)		this->_prevX = this->x;
HXLINE( 493)		this->_prevY = this->y;
HXLINE( 494)		this->_prevScreenX = this->screenX;
HXLINE( 495)		this->_prevScreenY = this->screenY;
HXLINE( 498)		{
HXLINE( 498)			Float newX = ::flixel::FlxG_obj::game->get_mouseX();
HXDLIN( 498)			Float newY = ::flixel::FlxG_obj::game->get_mouseY();
HXDLIN( 498)			this->_globalScreenX = ::Std_obj::_hx_int((newX / ::flixel::FlxG_obj::scaleMode->scale->x));
HXDLIN( 498)			this->_globalScreenY = ::Std_obj::_hx_int((newY / ::flixel::FlxG_obj::scaleMode->scale->y));
HXDLIN( 498)			this->updatePositions();
            		}
HXLINE( 501)		if (this->visible) {
HXLINE( 503)			 ::openfl::display::Sprite _hx_tmp = this->cursorContainer;
HXDLIN( 503)			_hx_tmp->set_x(::flixel::FlxG_obj::game->get_mouseX());
HXLINE( 504)			 ::openfl::display::Sprite _hx_tmp1 = this->cursorContainer;
HXDLIN( 504)			_hx_tmp1->set_y(::flixel::FlxG_obj::game->get_mouseY());
            		}
HXLINE( 509)		this->_leftButton->update();
HXLINE( 511)		this->_middleButton->update();
HXLINE( 512)		this->_rightButton->update();
HXLINE( 516)		if (!(this->_wheelUsed)) {
HXLINE( 518)			this->wheel = 0;
            		}
HXLINE( 520)		this->_wheelUsed = false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,update,(void))

void FlxMouse_obj::onFocus(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_527_onFocus)
HXLINE( 528)		this->reset();
HXLINE( 531)		this->set_useSystemCursor(this->useSystemCursor);
HXLINE( 533)		this->set_visible(this->_visibleWhenFocusLost);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,onFocus,(void))

void FlxMouse_obj::onFocusLost(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_541_onFocusLost)
HXLINE( 543)		this->_visibleWhenFocusLost = this->visible;
HXLINE( 545)		if (this->visible) {
HXLINE( 547)			this->set_visible(false);
            		}
HXLINE( 550)		::openfl::ui::Mouse_obj::show();
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,onFocusLost,(void))

void FlxMouse_obj::onGameStart(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_558_onGameStart)
HXDLIN( 558)		this->set_visible(this->visible);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,onGameStart,(void))

void FlxMouse_obj::onMouseWheel( ::openfl::events::MouseEvent flashEvent){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_566_onMouseWheel)
HXDLIN( 566)		if (this->enabled) {
HXLINE( 568)			this->_wheelUsed = true;
HXLINE( 569)			this->wheel = flashEvent->delta;
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxMouse_obj,onMouseWheel,(void))

void FlxMouse_obj::onMouseLeave( ::openfl::events::Event _){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_579_onMouseLeave)
HXLINE( 580)		this->_rightButton->onUp(null());
HXLINE( 581)		this->_middleButton->onUp(null());
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxMouse_obj,onMouseLeave,(void))

bool FlxMouse_obj::get_justMoved(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_586_get_justMoved)
HXDLIN( 586)		if ((this->_prevX == this->x)) {
HXDLIN( 586)			return (this->_prevY != this->y);
            		}
            		else {
HXDLIN( 586)			return true;
            		}
HXDLIN( 586)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justMoved,return )

int FlxMouse_obj::get_deltaX(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_589_get_deltaX)
HXDLIN( 589)		return (this->x - this->_prevX);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_deltaX,return )

int FlxMouse_obj::get_deltaY(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_592_get_deltaY)
HXDLIN( 592)		return (this->y - this->_prevY);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_deltaY,return )

int FlxMouse_obj::get_deltaScreenX(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_595_get_deltaScreenX)
HXDLIN( 595)		return (this->screenX - this->_prevScreenX);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_deltaScreenX,return )

int FlxMouse_obj::get_deltaScreenY(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_598_get_deltaScreenY)
HXDLIN( 598)		return (this->screenY - this->_prevScreenY);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_deltaScreenY,return )

bool FlxMouse_obj::get_pressed(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_601_get_pressed)
HXDLIN( 601)		 ::flixel::input::mouse::FlxMouseButton _this = this->_leftButton;
HXDLIN( 601)		if ((_this->current != 1)) {
HXDLIN( 601)			return (_this->current == 2);
            		}
            		else {
HXDLIN( 601)			return true;
            		}
HXDLIN( 601)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_pressed,return )

bool FlxMouse_obj::get_justPressed(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_604_get_justPressed)
HXDLIN( 604)		return (this->_leftButton->current == 2);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justPressed,return )

bool FlxMouse_obj::get_released(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_607_get_released)
HXDLIN( 607)		 ::flixel::input::mouse::FlxMouseButton _this = this->_leftButton;
HXDLIN( 607)		if ((_this->current != 0)) {
HXDLIN( 607)			return (_this->current == -1);
            		}
            		else {
HXDLIN( 607)			return true;
            		}
HXDLIN( 607)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_released,return )

bool FlxMouse_obj::get_justReleased(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_610_get_justReleased)
HXDLIN( 610)		return (this->_leftButton->current == -1);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justReleased,return )

int FlxMouse_obj::get_justPressedTimeInTicks(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_613_get_justPressedTimeInTicks)
HXDLIN( 613)		return this->_leftButton->justPressedTimeInTicks;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justPressedTimeInTicks,return )

bool FlxMouse_obj::get_pressedRight(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_617_get_pressedRight)
HXDLIN( 617)		 ::flixel::input::mouse::FlxMouseButton _this = this->_rightButton;
HXDLIN( 617)		if ((_this->current != 1)) {
HXDLIN( 617)			return (_this->current == 2);
            		}
            		else {
HXDLIN( 617)			return true;
            		}
HXDLIN( 617)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_pressedRight,return )

bool FlxMouse_obj::get_justPressedRight(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_620_get_justPressedRight)
HXDLIN( 620)		return (this->_rightButton->current == 2);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justPressedRight,return )

bool FlxMouse_obj::get_releasedRight(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_623_get_releasedRight)
HXDLIN( 623)		 ::flixel::input::mouse::FlxMouseButton _this = this->_rightButton;
HXDLIN( 623)		if ((_this->current != 0)) {
HXDLIN( 623)			return (_this->current == -1);
            		}
            		else {
HXDLIN( 623)			return true;
            		}
HXDLIN( 623)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_releasedRight,return )

bool FlxMouse_obj::get_justReleasedRight(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_626_get_justReleasedRight)
HXDLIN( 626)		return (this->_rightButton->current == -1);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justReleasedRight,return )

int FlxMouse_obj::get_justPressedTimeInTicksRight(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_629_get_justPressedTimeInTicksRight)
HXDLIN( 629)		return this->_rightButton->justPressedTimeInTicks;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justPressedTimeInTicksRight,return )

bool FlxMouse_obj::get_pressedMiddle(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_632_get_pressedMiddle)
HXDLIN( 632)		 ::flixel::input::mouse::FlxMouseButton _this = this->_middleButton;
HXDLIN( 632)		if ((_this->current != 1)) {
HXDLIN( 632)			return (_this->current == 2);
            		}
            		else {
HXDLIN( 632)			return true;
            		}
HXDLIN( 632)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_pressedMiddle,return )

bool FlxMouse_obj::get_justPressedMiddle(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_635_get_justPressedMiddle)
HXDLIN( 635)		return (this->_middleButton->current == 2);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justPressedMiddle,return )

bool FlxMouse_obj::get_releasedMiddle(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_638_get_releasedMiddle)
HXDLIN( 638)		 ::flixel::input::mouse::FlxMouseButton _this = this->_middleButton;
HXDLIN( 638)		if ((_this->current != 0)) {
HXDLIN( 638)			return (_this->current == -1);
            		}
            		else {
HXDLIN( 638)			return true;
            		}
HXDLIN( 638)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_releasedMiddle,return )

bool FlxMouse_obj::get_justReleasedMiddle(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_641_get_justReleasedMiddle)
HXDLIN( 641)		return (this->_middleButton->current == -1);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justReleasedMiddle,return )

int FlxMouse_obj::get_justPressedTimeInTicksMiddle(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_644_get_justPressedTimeInTicksMiddle)
HXDLIN( 644)		return this->_middleButton->justPressedTimeInTicks;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,get_justPressedTimeInTicksMiddle,return )

void FlxMouse_obj::showSystemCursor(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_648_showSystemCursor)
HXLINE( 652)		this->cursorContainer->set_visible(false);
HXLINE( 655)		::openfl::ui::Mouse_obj::show();
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,showSystemCursor,(void))

void FlxMouse_obj::hideSystemCursor(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_659_hideSystemCursor)
HXLINE( 666)		::openfl::ui::Mouse_obj::hide();
HXLINE( 668)		if (this->visible) {
HXLINE( 670)			this->cursorContainer->set_visible(true);
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,hideSystemCursor,(void))

bool FlxMouse_obj::set_useSystemCursor(bool value){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_676_set_useSystemCursor)
HXLINE( 677)		if (value) {
HXLINE( 679)			this->showSystemCursor();
            		}
            		else {
HXLINE( 683)			this->hideSystemCursor();
            		}
HXLINE( 685)		return (this->useSystemCursor = value);
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxMouse_obj,set_useSystemCursor,return )

void FlxMouse_obj::showCursor(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_690_showCursor)
HXDLIN( 690)		if (this->useSystemCursor) {
HXLINE( 692)			::openfl::ui::Mouse_obj::show();
            		}
            		else {
HXLINE( 696)			if (::hx::IsNull( this->_cursor )) {
HXLINE( 697)				this->load(null(),null(),null(),null());
            			}
HXLINE( 702)			this->cursorContainer->set_visible(true);
HXLINE( 703)			::openfl::ui::Mouse_obj::hide();
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,showCursor,(void))

void FlxMouse_obj::hideCursor(){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_709_hideCursor)
HXLINE( 710)		this->cursorContainer->set_visible(false);
HXLINE( 711)		::openfl::ui::Mouse_obj::hide();
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,hideCursor,(void))

bool FlxMouse_obj::set_visible(bool value){
            	HX_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_715_set_visible)
HXLINE( 716)		if (value) {
HXLINE( 717)			this->showCursor();
            		}
            		else {
HXLINE( 719)			this->hideCursor();
            		}
HXLINE( 721)		return (this->visible = value);
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxMouse_obj,set_visible,return )

 ::flixel::_hx_system::replay::MouseRecord FlxMouse_obj::record(){
            	HX_GC_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_726_record)
HXLINE( 727)		bool _hx_tmp;
HXDLIN( 727)		bool _hx_tmp1;
HXDLIN( 727)		bool _hx_tmp2;
HXDLIN( 727)		if ((this->_lastX == this->_globalScreenX)) {
HXLINE( 727)			_hx_tmp2 = (this->_lastY == this->_globalScreenY);
            		}
            		else {
HXLINE( 727)			_hx_tmp2 = false;
            		}
HXDLIN( 727)		if (_hx_tmp2) {
HXLINE( 727)			_hx_tmp1 = (this->_lastLeftButtonState == this->_leftButton->current);
            		}
            		else {
HXLINE( 727)			_hx_tmp1 = false;
            		}
HXDLIN( 727)		if (_hx_tmp1) {
HXLINE( 727)			_hx_tmp = (this->_lastWheel == this->wheel);
            		}
            		else {
HXLINE( 727)			_hx_tmp = false;
            		}
HXDLIN( 727)		if (_hx_tmp) {
HXLINE( 732)			return null();
            		}
HXLINE( 735)		this->_lastX = this->_globalScreenX;
HXLINE( 736)		this->_lastY = this->_globalScreenY;
HXLINE( 737)		this->_lastLeftButtonState = this->_leftButton->current;
HXLINE( 738)		this->_lastWheel = this->wheel;
HXLINE( 739)		return  ::flixel::_hx_system::replay::MouseRecord_obj::__alloc( HX_CTX ,this->_lastX,this->_lastY,this->_leftButton->current,this->_lastWheel);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxMouse_obj,record,return )

void FlxMouse_obj::playback( ::flixel::_hx_system::replay::MouseRecord record){
            	HX_GC_STACKFRAME(&_hx_pos_dcc29ee8d0f87524_744_playback)
HXLINE( 748)		bool _hx_tmp;
HXDLIN( 748)		bool _hx_tmp1;
HXDLIN( 748)		if ((this->_lastLeftButtonState != 1)) {
HXLINE( 748)			_hx_tmp1 = (this->_lastLeftButtonState == 2);
            		}
            		else {
HXLINE( 748)			_hx_tmp1 = true;
            		}
HXDLIN( 748)		if (_hx_tmp1) {
HXLINE( 749)			if ((record->button != 0)) {
HXLINE( 748)				_hx_tmp = (record->button == -1);
            			}
            			else {
HXLINE( 748)				_hx_tmp = true;
            			}
            		}
            		else {
HXLINE( 748)			_hx_tmp = false;
            		}
HXDLIN( 748)		if (_hx_tmp) {
HXLINE( 751)			 ::openfl::display::Stage _hx_tmp = this->_stage;
HXDLIN( 751)			_hx_tmp->dispatchEvent( ::openfl::events::MouseEvent_obj::__alloc( HX_CTX ,HX_("mouseUp",e0,f3,72,c0),true,false,record->x,record->y,null(),null(),null(),null(),null(),null(),null(),null()));
            		}
HXLINE( 753)		this->_lastLeftButtonState = (this->_leftButton->current = record->button);
HXLINE( 754)		this->wheel = record->wheel;
HXLINE( 755)		this->_globalScreenX = record->x;
HXLINE( 756)		this->_globalScreenY = record->y;
HXLINE( 757)		this->updatePositions();
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxMouse_obj,playback,(void))


::hx::ObjectPtr< FlxMouse_obj > FlxMouse_obj::__new( ::openfl::display::Sprite cursorContainer) {
	::hx::ObjectPtr< FlxMouse_obj > __this = new FlxMouse_obj();
	__this->__construct(cursorContainer);
	return __this;
}

::hx::ObjectPtr< FlxMouse_obj > FlxMouse_obj::__alloc(::hx::Ctx *_hx_ctx, ::openfl::display::Sprite cursorContainer) {
	FlxMouse_obj *__this = (FlxMouse_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(FlxMouse_obj), true, "flixel.input.mouse.FlxMouse"));
	*(void **)__this = FlxMouse_obj::_hx_vtable;
	__this->__construct(cursorContainer);
	return __this;
}

FlxMouse_obj::FlxMouse_obj()
{
}

void FlxMouse_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(FlxMouse);
	HX_MARK_MEMBER_NAME(enabled,"enabled");
	HX_MARK_MEMBER_NAME(wheel,"wheel");
	HX_MARK_MEMBER_NAME(cursorContainer,"cursorContainer");
	HX_MARK_MEMBER_NAME(visible,"visible");
	HX_MARK_MEMBER_NAME(useSystemCursor,"useSystemCursor");
	HX_MARK_MEMBER_NAME(_leftButton,"_leftButton");
	HX_MARK_MEMBER_NAME(_middleButton,"_middleButton");
	HX_MARK_MEMBER_NAME(_rightButton,"_rightButton");
	HX_MARK_MEMBER_NAME(_cursor,"_cursor");
	HX_MARK_MEMBER_NAME(_cursorBitmapData,"_cursorBitmapData");
	HX_MARK_MEMBER_NAME(_wheelUsed,"_wheelUsed");
	HX_MARK_MEMBER_NAME(_visibleWhenFocusLost,"_visibleWhenFocusLost");
	HX_MARK_MEMBER_NAME(_lastX,"_lastX");
	HX_MARK_MEMBER_NAME(_lastY,"_lastY");
	HX_MARK_MEMBER_NAME(_lastWheel,"_lastWheel");
	HX_MARK_MEMBER_NAME(_lastLeftButtonState,"_lastLeftButtonState");
	HX_MARK_MEMBER_NAME(_prevX,"_prevX");
	HX_MARK_MEMBER_NAME(_prevY,"_prevY");
	HX_MARK_MEMBER_NAME(_prevScreenX,"_prevScreenX");
	HX_MARK_MEMBER_NAME(_prevScreenY,"_prevScreenY");
	HX_MARK_MEMBER_NAME(_stage,"_stage");
	HX_MARK_END_CLASS();
}

void FlxMouse_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(enabled,"enabled");
	HX_VISIT_MEMBER_NAME(wheel,"wheel");
	HX_VISIT_MEMBER_NAME(cursorContainer,"cursorContainer");
	HX_VISIT_MEMBER_NAME(visible,"visible");
	HX_VISIT_MEMBER_NAME(useSystemCursor,"useSystemCursor");
	HX_VISIT_MEMBER_NAME(_leftButton,"_leftButton");
	HX_VISIT_MEMBER_NAME(_middleButton,"_middleButton");
	HX_VISIT_MEMBER_NAME(_rightButton,"_rightButton");
	HX_VISIT_MEMBER_NAME(_cursor,"_cursor");
	HX_VISIT_MEMBER_NAME(_cursorBitmapData,"_cursorBitmapData");
	HX_VISIT_MEMBER_NAME(_wheelUsed,"_wheelUsed");
	HX_VISIT_MEMBER_NAME(_visibleWhenFocusLost,"_visibleWhenFocusLost");
	HX_VISIT_MEMBER_NAME(_lastX,"_lastX");
	HX_VISIT_MEMBER_NAME(_lastY,"_lastY");
	HX_VISIT_MEMBER_NAME(_lastWheel,"_lastWheel");
	HX_VISIT_MEMBER_NAME(_lastLeftButtonState,"_lastLeftButtonState");
	HX_VISIT_MEMBER_NAME(_prevX,"_prevX");
	HX_VISIT_MEMBER_NAME(_prevY,"_prevY");
	HX_VISIT_MEMBER_NAME(_prevScreenX,"_prevScreenX");
	HX_VISIT_MEMBER_NAME(_prevScreenY,"_prevScreenY");
	HX_VISIT_MEMBER_NAME(_stage,"_stage");
}

::hx::Val FlxMouse_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"load") ) { return ::hx::Val( load_dyn() ); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"wheel") ) { return ::hx::Val( wheel ); }
		if (HX_FIELD_EQ(inName,"reset") ) { return ::hx::Val( reset_dyn() ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"deltaX") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_deltaX() ); }
		if (HX_FIELD_EQ(inName,"deltaY") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_deltaY() ); }
		if (HX_FIELD_EQ(inName,"_lastX") ) { return ::hx::Val( _lastX ); }
		if (HX_FIELD_EQ(inName,"_lastY") ) { return ::hx::Val( _lastY ); }
		if (HX_FIELD_EQ(inName,"_prevX") ) { return ::hx::Val( _prevX ); }
		if (HX_FIELD_EQ(inName,"_prevY") ) { return ::hx::Val( _prevY ); }
		if (HX_FIELD_EQ(inName,"_stage") ) { return ::hx::Val( _stage ); }
		if (HX_FIELD_EQ(inName,"unload") ) { return ::hx::Val( unload_dyn() ); }
		if (HX_FIELD_EQ(inName,"update") ) { return ::hx::Val( update_dyn() ); }
		if (HX_FIELD_EQ(inName,"record") ) { return ::hx::Val( record_dyn() ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"enabled") ) { return ::hx::Val( enabled ); }
		if (HX_FIELD_EQ(inName,"visible") ) { return ::hx::Val( visible ); }
		if (HX_FIELD_EQ(inName,"pressed") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_pressed() ); }
		if (HX_FIELD_EQ(inName,"_cursor") ) { return ::hx::Val( _cursor ); }
		if (HX_FIELD_EQ(inName,"destroy") ) { return ::hx::Val( destroy_dyn() ); }
		if (HX_FIELD_EQ(inName,"onFocus") ) { return ::hx::Val( onFocus_dyn() ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"released") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_released() ); }
		if (HX_FIELD_EQ(inName,"playback") ) { return ::hx::Val( playback_dyn() ); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"justMoved") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justMoved() ); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"_wheelUsed") ) { return ::hx::Val( _wheelUsed ); }
		if (HX_FIELD_EQ(inName,"_lastWheel") ) { return ::hx::Val( _lastWheel ); }
		if (HX_FIELD_EQ(inName,"get_deltaX") ) { return ::hx::Val( get_deltaX_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_deltaY") ) { return ::hx::Val( get_deltaY_dyn() ); }
		if (HX_FIELD_EQ(inName,"showCursor") ) { return ::hx::Val( showCursor_dyn() ); }
		if (HX_FIELD_EQ(inName,"hideCursor") ) { return ::hx::Val( hideCursor_dyn() ); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"justPressed") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justPressed() ); }
		if (HX_FIELD_EQ(inName,"_leftButton") ) { return ::hx::Val( _leftButton ); }
		if (HX_FIELD_EQ(inName,"onFocusLost") ) { return ::hx::Val( onFocusLost_dyn() ); }
		if (HX_FIELD_EQ(inName,"onGameStart") ) { return ::hx::Val( onGameStart_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_pressed") ) { return ::hx::Val( get_pressed_dyn() ); }
		if (HX_FIELD_EQ(inName,"set_visible") ) { return ::hx::Val( set_visible_dyn() ); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"deltaScreenX") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_deltaScreenX() ); }
		if (HX_FIELD_EQ(inName,"deltaScreenY") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_deltaScreenY() ); }
		if (HX_FIELD_EQ(inName,"justReleased") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justReleased() ); }
		if (HX_FIELD_EQ(inName,"pressedRight") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_pressedRight() ); }
		if (HX_FIELD_EQ(inName,"_rightButton") ) { return ::hx::Val( _rightButton ); }
		if (HX_FIELD_EQ(inName,"_prevScreenX") ) { return ::hx::Val( _prevScreenX ); }
		if (HX_FIELD_EQ(inName,"_prevScreenY") ) { return ::hx::Val( _prevScreenY ); }
		if (HX_FIELD_EQ(inName,"onMouseWheel") ) { return ::hx::Val( onMouseWheel_dyn() ); }
		if (HX_FIELD_EQ(inName,"onMouseLeave") ) { return ::hx::Val( onMouseLeave_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_released") ) { return ::hx::Val( get_released_dyn() ); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"releasedRight") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_releasedRight() ); }
		if (HX_FIELD_EQ(inName,"pressedMiddle") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_pressedMiddle() ); }
		if (HX_FIELD_EQ(inName,"_middleButton") ) { return ::hx::Val( _middleButton ); }
		if (HX_FIELD_EQ(inName,"get_justMoved") ) { return ::hx::Val( get_justMoved_dyn() ); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"releasedMiddle") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_releasedMiddle() ); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"cursorContainer") ) { return ::hx::Val( cursorContainer ); }
		if (HX_FIELD_EQ(inName,"useSystemCursor") ) { return ::hx::Val( useSystemCursor ); }
		if (HX_FIELD_EQ(inName,"get_justPressed") ) { return ::hx::Val( get_justPressed_dyn() ); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"justPressedRight") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justPressedRight() ); }
		if (HX_FIELD_EQ(inName,"get_deltaScreenX") ) { return ::hx::Val( get_deltaScreenX_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_deltaScreenY") ) { return ::hx::Val( get_deltaScreenY_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_justReleased") ) { return ::hx::Val( get_justReleased_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_pressedRight") ) { return ::hx::Val( get_pressedRight_dyn() ); }
		if (HX_FIELD_EQ(inName,"showSystemCursor") ) { return ::hx::Val( showSystemCursor_dyn() ); }
		if (HX_FIELD_EQ(inName,"hideSystemCursor") ) { return ::hx::Val( hideSystemCursor_dyn() ); }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"justReleasedRight") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justReleasedRight() ); }
		if (HX_FIELD_EQ(inName,"justPressedMiddle") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justPressedMiddle() ); }
		if (HX_FIELD_EQ(inName,"_cursorBitmapData") ) { return ::hx::Val( _cursorBitmapData ); }
		if (HX_FIELD_EQ(inName,"get_releasedRight") ) { return ::hx::Val( get_releasedRight_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_pressedMiddle") ) { return ::hx::Val( get_pressedMiddle_dyn() ); }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"justReleasedMiddle") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justReleasedMiddle() ); }
		if (HX_FIELD_EQ(inName,"get_releasedMiddle") ) { return ::hx::Val( get_releasedMiddle_dyn() ); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"set_useSystemCursor") ) { return ::hx::Val( set_useSystemCursor_dyn() ); }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"_lastLeftButtonState") ) { return ::hx::Val( _lastLeftButtonState ); }
		if (HX_FIELD_EQ(inName,"get_justPressedRight") ) { return ::hx::Val( get_justPressedRight_dyn() ); }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"_visibleWhenFocusLost") ) { return ::hx::Val( _visibleWhenFocusLost ); }
		if (HX_FIELD_EQ(inName,"get_justReleasedRight") ) { return ::hx::Val( get_justReleasedRight_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_justPressedMiddle") ) { return ::hx::Val( get_justPressedMiddle_dyn() ); }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"justPressedTimeInTicks") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justPressedTimeInTicks() ); }
		if (HX_FIELD_EQ(inName,"get_justReleasedMiddle") ) { return ::hx::Val( get_justReleasedMiddle_dyn() ); }
		break;
	case 26:
		if (HX_FIELD_EQ(inName,"get_justPressedTimeInTicks") ) { return ::hx::Val( get_justPressedTimeInTicks_dyn() ); }
		break;
	case 27:
		if (HX_FIELD_EQ(inName,"justPressedTimeInTicksRight") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justPressedTimeInTicksRight() ); }
		break;
	case 28:
		if (HX_FIELD_EQ(inName,"justPressedTimeInTicksMiddle") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_justPressedTimeInTicksMiddle() ); }
		break;
	case 31:
		if (HX_FIELD_EQ(inName,"get_justPressedTimeInTicksRight") ) { return ::hx::Val( get_justPressedTimeInTicksRight_dyn() ); }
		break;
	case 32:
		if (HX_FIELD_EQ(inName,"get_justPressedTimeInTicksMiddle") ) { return ::hx::Val( get_justPressedTimeInTicksMiddle_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val FlxMouse_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"wheel") ) { wheel=inValue.Cast< int >(); return inValue; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"_lastX") ) { _lastX=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_lastY") ) { _lastY=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_prevX") ) { _prevX=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_prevY") ) { _prevY=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_stage") ) { _stage=inValue.Cast<  ::openfl::display::Stage >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"enabled") ) { enabled=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"visible") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( set_visible(inValue.Cast< bool >()) );visible=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_cursor") ) { _cursor=inValue.Cast<  ::openfl::display::Bitmap >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"_wheelUsed") ) { _wheelUsed=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_lastWheel") ) { _lastWheel=inValue.Cast< int >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"_leftButton") ) { _leftButton=inValue.Cast<  ::flixel::input::mouse::FlxMouseButton >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"_rightButton") ) { _rightButton=inValue.Cast<  ::flixel::input::mouse::FlxMouseButton >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_prevScreenX") ) { _prevScreenX=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_prevScreenY") ) { _prevScreenY=inValue.Cast< int >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"_middleButton") ) { _middleButton=inValue.Cast<  ::flixel::input::mouse::FlxMouseButton >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"cursorContainer") ) { cursorContainer=inValue.Cast<  ::openfl::display::Sprite >(); return inValue; }
		if (HX_FIELD_EQ(inName,"useSystemCursor") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( set_useSystemCursor(inValue.Cast< bool >()) );useSystemCursor=inValue.Cast< bool >(); return inValue; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"_cursorBitmapData") ) { _cursorBitmapData=inValue.Cast<  ::openfl::display::BitmapData >(); return inValue; }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"_lastLeftButtonState") ) { _lastLeftButtonState=inValue.Cast< int >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"_visibleWhenFocusLost") ) { _visibleWhenFocusLost=inValue.Cast< bool >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void FlxMouse_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("enabled",81,04,31,7e));
	outFields->push(HX_("wheel",9b,34,ba,c9));
	outFields->push(HX_("cursorContainer",8b,3b,1c,12));
	outFields->push(HX_("visible",72,78,24,a3));
	outFields->push(HX_("useSystemCursor",0c,3e,de,f9));
	outFields->push(HX_("justMoved",67,12,21,2b));
	outFields->push(HX_("deltaX",60,11,e4,6a));
	outFields->push(HX_("deltaY",61,11,e4,6a));
	outFields->push(HX_("deltaScreenX",54,72,fa,de));
	outFields->push(HX_("deltaScreenY",55,72,fa,de));
	outFields->push(HX_("pressed",a2,d2,e6,39));
	outFields->push(HX_("justPressed",d6,0d,a7,f2));
	outFields->push(HX_("released",bd,88,e7,76));
	outFields->push(HX_("justReleased",09,1b,5b,66));
	outFields->push(HX_("justPressedTimeInTicks",8e,f9,c2,82));
	outFields->push(HX_("pressedRight",da,dd,81,58));
	outFields->push(HX_("justPressedRight",26,86,9a,c0));
	outFields->push(HX_("releasedRight",df,25,d0,ba));
	outFields->push(HX_("justReleasedRight",13,c0,4a,68));
	outFields->push(HX_("justPressedTimeInTicksRight",6e,1f,15,5e));
	outFields->push(HX_("pressedMiddle",97,bf,58,17));
	outFields->push(HX_("justPressedMiddle",cb,59,d3,c4));
	outFields->push(HX_("releasedMiddle",f2,7b,89,b9));
	outFields->push(HX_("justReleasedMiddle",3e,cf,55,d7));
	outFields->push(HX_("justPressedTimeInTicksMiddle",83,df,9e,f2));
	outFields->push(HX_("_leftButton",78,ea,7a,db));
	outFields->push(HX_("_middleButton",06,ea,42,d7));
	outFields->push(HX_("_rightButton",ef,dc,6e,a9));
	outFields->push(HX_("_cursor",75,a0,5f,ad));
	outFields->push(HX_("_cursorBitmapData",8e,5e,40,cd));
	outFields->push(HX_("_wheelUsed",39,58,29,d8));
	outFields->push(HX_("_visibleWhenFocusLost",cf,95,3f,38));
	outFields->push(HX_("_lastX",83,48,a3,6b));
	outFields->push(HX_("_lastY",84,48,a3,6b));
	outFields->push(HX_("_lastWheel",26,de,09,72));
	outFields->push(HX_("_lastLeftButtonState",43,eb,82,82));
	outFields->push(HX_("_prevX",46,9d,6f,c4));
	outFields->push(HX_("_prevY",47,9d,6f,c4));
	outFields->push(HX_("_prevScreenX",ba,ee,88,f6));
	outFields->push(HX_("_prevScreenY",bb,ee,88,f6));
	outFields->push(HX_("_stage",ff,b1,f2,7f));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo FlxMouse_obj_sMemberStorageInfo[] = {
	{::hx::fsBool,(int)offsetof(FlxMouse_obj,enabled),HX_("enabled",81,04,31,7e)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,wheel),HX_("wheel",9b,34,ba,c9)},
	{::hx::fsObject /*  ::openfl::display::Sprite */ ,(int)offsetof(FlxMouse_obj,cursorContainer),HX_("cursorContainer",8b,3b,1c,12)},
	{::hx::fsBool,(int)offsetof(FlxMouse_obj,visible),HX_("visible",72,78,24,a3)},
	{::hx::fsBool,(int)offsetof(FlxMouse_obj,useSystemCursor),HX_("useSystemCursor",0c,3e,de,f9)},
	{::hx::fsObject /*  ::flixel::input::mouse::FlxMouseButton */ ,(int)offsetof(FlxMouse_obj,_leftButton),HX_("_leftButton",78,ea,7a,db)},
	{::hx::fsObject /*  ::flixel::input::mouse::FlxMouseButton */ ,(int)offsetof(FlxMouse_obj,_middleButton),HX_("_middleButton",06,ea,42,d7)},
	{::hx::fsObject /*  ::flixel::input::mouse::FlxMouseButton */ ,(int)offsetof(FlxMouse_obj,_rightButton),HX_("_rightButton",ef,dc,6e,a9)},
	{::hx::fsObject /*  ::openfl::display::Bitmap */ ,(int)offsetof(FlxMouse_obj,_cursor),HX_("_cursor",75,a0,5f,ad)},
	{::hx::fsObject /*  ::openfl::display::BitmapData */ ,(int)offsetof(FlxMouse_obj,_cursorBitmapData),HX_("_cursorBitmapData",8e,5e,40,cd)},
	{::hx::fsBool,(int)offsetof(FlxMouse_obj,_wheelUsed),HX_("_wheelUsed",39,58,29,d8)},
	{::hx::fsBool,(int)offsetof(FlxMouse_obj,_visibleWhenFocusLost),HX_("_visibleWhenFocusLost",cf,95,3f,38)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,_lastX),HX_("_lastX",83,48,a3,6b)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,_lastY),HX_("_lastY",84,48,a3,6b)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,_lastWheel),HX_("_lastWheel",26,de,09,72)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,_lastLeftButtonState),HX_("_lastLeftButtonState",43,eb,82,82)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,_prevX),HX_("_prevX",46,9d,6f,c4)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,_prevY),HX_("_prevY",47,9d,6f,c4)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,_prevScreenX),HX_("_prevScreenX",ba,ee,88,f6)},
	{::hx::fsInt,(int)offsetof(FlxMouse_obj,_prevScreenY),HX_("_prevScreenY",bb,ee,88,f6)},
	{::hx::fsObject /*  ::openfl::display::Stage */ ,(int)offsetof(FlxMouse_obj,_stage),HX_("_stage",ff,b1,f2,7f)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *FlxMouse_obj_sStaticStorageInfo = 0;
#endif

static ::String FlxMouse_obj_sMemberFields[] = {
	HX_("enabled",81,04,31,7e),
	HX_("wheel",9b,34,ba,c9),
	HX_("cursorContainer",8b,3b,1c,12),
	HX_("visible",72,78,24,a3),
	HX_("useSystemCursor",0c,3e,de,f9),
	HX_("_leftButton",78,ea,7a,db),
	HX_("_middleButton",06,ea,42,d7),
	HX_("_rightButton",ef,dc,6e,a9),
	HX_("_cursor",75,a0,5f,ad),
	HX_("_cursorBitmapData",8e,5e,40,cd),
	HX_("_wheelUsed",39,58,29,d8),
	HX_("_visibleWhenFocusLost",cf,95,3f,38),
	HX_("_lastX",83,48,a3,6b),
	HX_("_lastY",84,48,a3,6b),
	HX_("_lastWheel",26,de,09,72),
	HX_("_lastLeftButtonState",43,eb,82,82),
	HX_("_prevX",46,9d,6f,c4),
	HX_("_prevY",47,9d,6f,c4),
	HX_("_prevScreenX",ba,ee,88,f6),
	HX_("_prevScreenY",bb,ee,88,f6),
	HX_("_stage",ff,b1,f2,7f),
	HX_("load",26,9a,b7,47),
	HX_("unload",ff,a0,8c,65),
	HX_("destroy",fa,2c,86,24),
	HX_("reset",cf,49,c8,e6),
	HX_("update",09,86,05,87),
	HX_("onFocus",39,fe,c6,9a),
	HX_("onFocusLost",bd,e4,85,41),
	HX_("onGameStart",f1,45,69,db),
	HX_("onMouseWheel",35,ca,ca,bf),
	HX_("onMouseLeave",91,ca,63,68),
	HX_("get_justMoved",3e,e6,84,ec),
	HX_("get_deltaX",29,81,6b,5b),
	HX_("get_deltaY",2a,81,6b,5b),
	HX_("get_deltaScreenX",dd,5e,99,e3),
	HX_("get_deltaScreenY",de,5e,99,e3),
	HX_("get_pressed",b9,32,e1,bf),
	HX_("get_justPressed",6d,c5,88,b3),
	HX_("get_released",c6,3c,01,2c),
	HX_("get_justReleased",92,07,fa,6a),
	HX_("get_justPressedTimeInTicks",57,4b,c8,ba),
	HX_("get_pressedRight",63,ca,20,5d),
	HX_("get_justPressedRight",2f,eb,04,df),
	HX_("get_releasedRight",36,31,40,c1),
	HX_("get_justReleasedRight",ea,c2,f8,e6),
	HX_("get_justPressedTimeInTicksRight",05,b5,e5,39),
	HX_("get_pressedMiddle",ee,ca,c8,1d),
	HX_("get_justPressedMiddle",a2,5c,81,43),
	HX_("get_releasedMiddle",bb,5c,23,55),
	HX_("get_justReleasedMiddle",87,48,ea,30),
	HX_("get_justPressedTimeInTicksMiddle",0c,2e,51,6d),
	HX_("showSystemCursor",c2,1f,8d,c0),
	HX_("hideSystemCursor",07,93,7b,81),
	HX_("set_useSystemCursor",2f,00,86,c1),
	HX_("showCursor",b3,33,5d,a8),
	HX_("hideCursor",38,35,6e,d6),
	HX_("set_visible",95,df,8b,33),
	HX_("record",91,76,ec,fd),
	HX_("playback",1b,12,4b,46),
	::String(null()) };

::hx::Class FlxMouse_obj::__mClass;

void FlxMouse_obj::__register()
{
	FlxMouse_obj _hx_dummy;
	FlxMouse_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.input.mouse.FlxMouse",12,2b,6e,8c);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(FlxMouse_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< FlxMouse_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = FlxMouse_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = FlxMouse_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace flixel
} // end namespace input
} // end namespace mouse
