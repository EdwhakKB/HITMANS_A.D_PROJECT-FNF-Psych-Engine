#include <hxcpp.h>

#ifndef INCLUDED_95f339a1d026d52c
#define INCLUDED_95f339a1d026d52c
#include "hxMath.h"
#endif
#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxCamera
#include <flixel/FlxCamera.h>
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
#ifndef INCLUDED_flixel_effects_FlxFlicker
#include <flixel/effects/FlxFlicker.h>
#endif
#ifndef INCLUDED_flixel_math_FlxBasePoint
#include <flixel/math/FlxBasePoint.h>
#endif
#ifndef INCLUDED_flixel_math_FlxRect
#include <flixel/math/FlxRect.h>
#endif
#ifndef INCLUDED_flixel_system_FlxAssets
#include <flixel/system/FlxAssets.h>
#endif
#ifndef INCLUDED_flixel_tweens_FlxTween
#include <flixel/tweens/FlxTween.h>
#endif
#ifndef INCLUDED_flixel_tweens_misc_NumTween
#include <flixel/tweens/misc/NumTween.h>
#endif
#ifndef INCLUDED_flixel_util_FlxPool_flixel_math_FlxBasePoint
#include <flixel/util/FlxPool_flixel_math_FlxBasePoint.h>
#endif
#ifndef INCLUDED_flixel_util_FlxPool_flixel_math_FlxRect
#include <flixel/util/FlxPool_flixel_math_FlxRect.h>
#endif
#ifndef INCLUDED_flixel_util_FlxSpriteUtil
#include <flixel/util/FlxSpriteUtil.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxPool
#include <flixel/util/IFlxPool.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxPooled
#include <flixel/util/IFlxPooled.h>
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
#ifndef INCLUDED_openfl_display_Graphics
#include <openfl/display/Graphics.h>
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
#ifndef INCLUDED_openfl_geom_ColorTransform
#include <openfl/geom/ColorTransform.h>
#endif
#ifndef INCLUDED_openfl_geom_Matrix
#include <openfl/geom/Matrix.h>
#endif
#ifndef INCLUDED_openfl_geom_Point
#include <openfl/geom/Point.h>
#endif
#ifndef INCLUDED_openfl_geom_Rectangle
#include <openfl/geom/Rectangle.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_57_alphaMask,"flixel.util.FlxSpriteUtil","alphaMask",0xaad6793b,"flixel.util.FlxSpriteUtil.alphaMask","flixel/util/FlxSpriteUtil.hx",57,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_86_alphaMaskFlxSprite,"flixel.util.FlxSpriteUtil","alphaMaskFlxSprite",0x13c0dd5c,"flixel.util.FlxSpriteUtil.alphaMaskFlxSprite","flixel/util/FlxSpriteUtil.hx",86,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_106_screenWrap,"flixel.util.FlxSpriteUtil","screenWrap",0x74418065,"flixel.util.FlxSpriteUtil.screenWrap","flixel/util/FlxSpriteUtil.hx",106,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_139_bound,"flixel.util.FlxSpriteUtil","bound",0x7d89918f,"flixel.util.FlxSpriteUtil.bound","flixel/util/FlxSpriteUtil.hx",139,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_168_cameraWrap,"flixel.util.FlxSpriteUtil","cameraWrap",0x62291c1e,"flixel.util.FlxSpriteUtil.cameraWrap","flixel/util/FlxSpriteUtil.hx",168,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_204_cameraBound,"flixel.util.FlxSpriteUtil","cameraBound",0x6878d76a,"flixel.util.FlxSpriteUtil.cameraBound","flixel/util/FlxSpriteUtil.hx",204,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_243_space,"flixel.util.FlxSpriteUtil","space",0x47f36e17,"flixel.util.FlxSpriteUtil.space","flixel/util/FlxSpriteUtil.hx",243,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_345_drawLine,"flixel.util.FlxSpriteUtil","drawLine",0x239cc967,"flixel.util.FlxSpriteUtil.drawLine","flixel/util/FlxSpriteUtil.hx",345,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_372_drawCurve,"flixel.util.FlxSpriteUtil","drawCurve",0xdee9dfdc,"flixel.util.FlxSpriteUtil.drawCurve","flixel/util/FlxSpriteUtil.hx",372,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_396_drawRect,"flixel.util.FlxSpriteUtil","drawRect",0x2790fe97,"flixel.util.FlxSpriteUtil.drawRect","flixel/util/FlxSpriteUtil.hx",396,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_420_drawRoundRect,"flixel.util.FlxSpriteUtil","drawRoundRect",0x00e2de3f,"flixel.util.FlxSpriteUtil.drawRoundRect","flixel/util/FlxSpriteUtil.hx",420,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_448_drawRoundRectComplex,"flixel.util.FlxSpriteUtil","drawRoundRectComplex",0xe28185b1,"flixel.util.FlxSpriteUtil.drawRoundRectComplex","flixel/util/FlxSpriteUtil.hx",448,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_470_drawCircle,"flixel.util.FlxSpriteUtil","drawCircle",0x44dca643,"flixel.util.FlxSpriteUtil.drawCircle","flixel/util/FlxSpriteUtil.hx",470,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_510_drawEllipse,"flixel.util.FlxSpriteUtil","drawEllipse",0x1204b94b,"flixel.util.FlxSpriteUtil.drawEllipse","flixel/util/FlxSpriteUtil.hx",510,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_531_drawTriangle,"flixel.util.FlxSpriteUtil","drawTriangle",0x35f0a5bb,"flixel.util.FlxSpriteUtil.drawTriangle","flixel/util/FlxSpriteUtil.hx",531,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_553_drawPolygon,"flixel.util.FlxSpriteUtil","drawPolygon",0x190f7ae7,"flixel.util.FlxSpriteUtil.drawPolygon","flixel/util/FlxSpriteUtil.hx",553,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_574_beginDraw,"flixel.util.FlxSpriteUtil","beginDraw",0x53d0689e,"flixel.util.FlxSpriteUtil.beginDraw","flixel/util/FlxSpriteUtil.hx",574,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_592_endDraw,"flixel.util.FlxSpriteUtil","endDraw",0x51197d10,"flixel.util.FlxSpriteUtil.endDraw","flixel/util/FlxSpriteUtil.hx",592,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_607_updateSpriteGraphic,"flixel.util.FlxSpriteUtil","updateSpriteGraphic",0x448b866b,"flixel.util.FlxSpriteUtil.updateSpriteGraphic","flixel/util/FlxSpriteUtil.hx",607,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_631_setLineStyle,"flixel.util.FlxSpriteUtil","setLineStyle",0xc19fc36a,"flixel.util.FlxSpriteUtil.setLineStyle","flixel/util/FlxSpriteUtil.hx",631,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_653_getDefaultLineStyle,"flixel.util.FlxSpriteUtil","getDefaultLineStyle",0x36c9a563,"flixel.util.FlxSpriteUtil.getDefaultLineStyle","flixel/util/FlxSpriteUtil.hx",653,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_672_fill,"flixel.util.FlxSpriteUtil","fill",0x7a944252,"flixel.util.FlxSpriteUtil.fill","flixel/util/FlxSpriteUtil.hx",672,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_698_flicker,"flixel.util.FlxSpriteUtil","flicker",0xa3717289,"flixel.util.FlxSpriteUtil.flicker","flixel/util/FlxSpriteUtil.hx",698,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_708_isFlickering,"flixel.util.FlxSpriteUtil","isFlickering",0x05aae043,"flixel.util.FlxSpriteUtil.isFlickering","flixel/util/FlxSpriteUtil.hx",708,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_718_stopFlickering,"flixel.util.FlxSpriteUtil","stopFlickering",0x9d49141b,"flixel.util.FlxSpriteUtil.stopFlickering","flixel/util/FlxSpriteUtil.hx",718,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_736_fadeIn,"flixel.util.FlxSpriteUtil","fadeIn",0xd9639210,"flixel.util.FlxSpriteUtil.fadeIn","flixel/util/FlxSpriteUtil.hx",736,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_731_fadeIn,"flixel.util.FlxSpriteUtil","fadeIn",0xd9639210,"flixel.util.FlxSpriteUtil.fadeIn","flixel/util/FlxSpriteUtil.hx",731,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_749_fadeOut,"flixel.util.FlxSpriteUtil","fadeOut",0x5dc0d003,"flixel.util.FlxSpriteUtil.fadeOut","flixel/util/FlxSpriteUtil.hx",749,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_748_fadeOut,"flixel.util.FlxSpriteUtil","fadeOut",0x5dc0d003,"flixel.util.FlxSpriteUtil.fadeOut","flixel/util/FlxSpriteUtil.hx",748,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_755_alphaTween,"flixel.util.FlxSpriteUtil","alphaTween",0xe721b73c,"flixel.util.FlxSpriteUtil.alphaTween","flixel/util/FlxSpriteUtil.hx",755,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_39_boot,"flixel.util.FlxSpriteUtil","boot",0x77f3f801,"flixel.util.FlxSpriteUtil.boot","flixel/util/FlxSpriteUtil.hx",39,0xc647097f)
HX_LOCAL_STACK_FRAME(_hx_pos_aff86ac70b6ed09e_41_boot,"flixel.util.FlxSpriteUtil","boot",0x77f3f801,"flixel.util.FlxSpriteUtil.boot","flixel/util/FlxSpriteUtil.hx",41,0xc647097f)
namespace flixel{
namespace util{

void FlxSpriteUtil_obj::__construct() { }

Dynamic FlxSpriteUtil_obj::__CreateEmpty() { return new FlxSpriteUtil_obj; }

void *FlxSpriteUtil_obj::_hx_vtable = 0;

Dynamic FlxSpriteUtil_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< FlxSpriteUtil_obj > _hx_result = new FlxSpriteUtil_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool FlxSpriteUtil_obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x0a1ec5f3;
}

 ::openfl::display::Sprite FlxSpriteUtil_obj::flashGfxSprite;

 ::openfl::display::Graphics FlxSpriteUtil_obj::flashGfx;

 ::flixel::FlxSprite FlxSpriteUtil_obj::alphaMask( ::flixel::FlxSprite output, ::Dynamic source, ::Dynamic mask){
            	HX_GC_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_57_alphaMask)
HXLINE(  58)		 ::openfl::display::BitmapData data = ::flixel::_hx_system::FlxAssets_obj::resolveBitmapData(source);
HXLINE(  59)		 ::openfl::display::BitmapData maskData = ::flixel::_hx_system::FlxAssets_obj::resolveBitmapData(mask);
HXLINE(  61)		bool _hx_tmp;
HXDLIN(  61)		if (::hx::IsNotNull( data )) {
HXLINE(  61)			_hx_tmp = ::hx::IsNull( maskData );
            		}
            		else {
HXLINE(  61)			_hx_tmp = true;
            		}
HXDLIN(  61)		if (_hx_tmp) {
HXLINE(  63)			return null();
            		}
HXLINE(  66)		data = data->clone();
HXLINE(  67)		 ::openfl::geom::Rectangle _hx_tmp1 =  ::openfl::geom::Rectangle_obj::__alloc( HX_CTX ,0,0,data->width,data->height);
HXDLIN(  67)		data->copyChannel(maskData,_hx_tmp1, ::openfl::geom::Point_obj::__alloc( HX_CTX ,null(),null()),8,8);
HXLINE(  68)		output->set_pixels(data);
HXLINE(  69)		return output;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(FlxSpriteUtil_obj,alphaMask,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::alphaMaskFlxSprite( ::flixel::FlxSprite sprite, ::flixel::FlxSprite mask, ::flixel::FlxSprite output){
            	HX_GC_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_86_alphaMaskFlxSprite)
HXLINE(  87)		sprite->drawFrame(null());
HXLINE(  88)		 ::openfl::display::BitmapData data = sprite->get_pixels()->clone();
HXLINE(  89)		 ::openfl::display::BitmapData _hx_tmp = mask->get_pixels();
HXDLIN(  89)		Float _hx_tmp1 = sprite->get_width();
HXDLIN(  89)		 ::openfl::geom::Rectangle _hx_tmp2 =  ::openfl::geom::Rectangle_obj::__alloc( HX_CTX ,0,0,_hx_tmp1,sprite->get_height());
HXDLIN(  89)		data->copyChannel(_hx_tmp,_hx_tmp2, ::openfl::geom::Point_obj::__alloc( HX_CTX ,null(),null()),8,8);
HXLINE(  90)		output->set_pixels(data);
HXLINE(  91)		return output;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(FlxSpriteUtil_obj,alphaMaskFlxSprite,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::screenWrap( ::flixel::FlxSprite sprite,::hx::Null< bool >  __o_Left,::hx::Null< bool >  __o_Right,::hx::Null< bool >  __o_Top,::hx::Null< bool >  __o_Bottom){
            		bool Left = __o_Left.Default(true);
            		bool Right = __o_Right.Default(true);
            		bool Top = __o_Top.Default(true);
            		bool Bottom = __o_Bottom.Default(true);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_106_screenWrap)
HXLINE( 107)		bool _hx_tmp;
HXDLIN( 107)		if (Left) {
HXLINE( 107)			_hx_tmp = ((sprite->x + (( (Float)(sprite->frameWidth) ) / ( (Float)(2) ))) <= 0);
            		}
            		else {
HXLINE( 107)			_hx_tmp = false;
            		}
HXDLIN( 107)		if (_hx_tmp) {
HXLINE( 109)			sprite->set_x(( (Float)(::flixel::FlxG_obj::width) ));
            		}
            		else {
HXLINE( 111)			bool _hx_tmp;
HXDLIN( 111)			if (Right) {
HXLINE( 111)				_hx_tmp = (sprite->x >= ::flixel::FlxG_obj::width);
            			}
            			else {
HXLINE( 111)				_hx_tmp = false;
            			}
HXDLIN( 111)			if (_hx_tmp) {
HXLINE( 113)				sprite->set_x(( (Float)(0) ));
            			}
            		}
HXLINE( 116)		bool _hx_tmp1;
HXDLIN( 116)		if (Top) {
HXLINE( 116)			_hx_tmp1 = ((sprite->y + (( (Float)(sprite->frameHeight) ) / ( (Float)(2) ))) <= 0);
            		}
            		else {
HXLINE( 116)			_hx_tmp1 = false;
            		}
HXDLIN( 116)		if (_hx_tmp1) {
HXLINE( 118)			sprite->set_y(( (Float)(::flixel::FlxG_obj::height) ));
            		}
            		else {
HXLINE( 120)			bool _hx_tmp;
HXDLIN( 120)			if (Bottom) {
HXLINE( 120)				_hx_tmp = (sprite->y >= ::flixel::FlxG_obj::height);
            			}
            			else {
HXLINE( 120)				_hx_tmp = false;
            			}
HXDLIN( 120)			if (_hx_tmp) {
HXLINE( 122)				sprite->set_y(( (Float)(0) ));
            			}
            		}
HXLINE( 124)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC5(FlxSpriteUtil_obj,screenWrap,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::bound( ::flixel::FlxSprite sprite,::hx::Null< Float >  __o_MinX,::hx::Null< Float >  __o_MaxX,::hx::Null< Float >  __o_MinY,::hx::Null< Float >  __o_MaxY){
            		Float MinX = __o_MinX.Default(0);
            		Float MaxX = __o_MaxX.Default(0);
            		Float MinY = __o_MinY.Default(0);
            		Float MaxY = __o_MaxY.Default(0);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_139_bound)
HXLINE( 140)		if ((MaxX <= 0)) {
HXLINE( 142)			MaxX = ( (Float)(::flixel::FlxG_obj::width) );
            		}
HXLINE( 144)		if ((MaxY <= 0)) {
HXLINE( 146)			MaxY = ( (Float)(::flixel::FlxG_obj::height) );
            		}
HXLINE( 149)		MaxX = (MaxX - ( (Float)(sprite->frameWidth) ));
HXLINE( 150)		MaxY = (MaxY - ( (Float)(sprite->frameHeight) ));
HXLINE( 152)		Float Value = sprite->x;
HXDLIN( 152)		Float lowerBound;
HXDLIN( 152)		bool lowerBound1;
HXDLIN( 152)		if (::hx::IsNotNull( MinX )) {
HXLINE( 152)			lowerBound1 = (Value < MinX);
            		}
            		else {
HXLINE( 152)			lowerBound1 = false;
            		}
HXDLIN( 152)		if (lowerBound1) {
HXLINE( 152)			lowerBound = MinX;
            		}
            		else {
HXLINE( 152)			lowerBound = Value;
            		}
HXDLIN( 152)		Float _hx_tmp;
HXDLIN( 152)		bool _hx_tmp1;
HXDLIN( 152)		if (::hx::IsNotNull( MaxX )) {
HXLINE( 152)			_hx_tmp1 = (lowerBound > MaxX);
            		}
            		else {
HXLINE( 152)			_hx_tmp1 = false;
            		}
HXDLIN( 152)		if (_hx_tmp1) {
HXLINE( 152)			_hx_tmp = MaxX;
            		}
            		else {
HXLINE( 152)			_hx_tmp = lowerBound;
            		}
HXDLIN( 152)		sprite->set_x(_hx_tmp);
HXLINE( 153)		Float Value1 = sprite->y;
HXDLIN( 153)		Float lowerBound2;
HXDLIN( 153)		bool lowerBound3;
HXDLIN( 153)		if (::hx::IsNotNull( MinY )) {
HXLINE( 153)			lowerBound3 = (Value1 < MinY);
            		}
            		else {
HXLINE( 153)			lowerBound3 = false;
            		}
HXDLIN( 153)		if (lowerBound3) {
HXLINE( 153)			lowerBound2 = MinY;
            		}
            		else {
HXLINE( 153)			lowerBound2 = Value1;
            		}
HXDLIN( 153)		Float _hx_tmp2;
HXDLIN( 153)		bool _hx_tmp3;
HXDLIN( 153)		if (::hx::IsNotNull( MaxY )) {
HXLINE( 153)			_hx_tmp3 = (lowerBound2 > MaxY);
            		}
            		else {
HXLINE( 153)			_hx_tmp3 = false;
            		}
HXDLIN( 153)		if (_hx_tmp3) {
HXLINE( 153)			_hx_tmp2 = MaxY;
            		}
            		else {
HXLINE( 153)			_hx_tmp2 = lowerBound2;
            		}
HXDLIN( 153)		sprite->set_y(_hx_tmp2);
HXLINE( 155)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC5(FlxSpriteUtil_obj,bound,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::cameraWrap( ::flixel::FlxSprite sprite, ::flixel::FlxCamera camera,::hx::Null< int >  __o_edges){
            		int edges = __o_edges.Default(4369);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_168_cameraWrap)
HXLINE( 169)		if (::hx::IsNull( camera )) {
HXLINE( 170)			camera = ::flixel::FlxG_obj::camera;
            		}
HXLINE( 172)		 ::flixel::math::FlxRect spriteBounds = sprite->getScreenBounds(null(),camera);
HXLINE( 173)		Float x = ((sprite->x - spriteBounds->x) - camera->scroll->x);
HXDLIN( 173)		Float y = ((sprite->y - spriteBounds->y) - camera->scroll->y);
HXDLIN( 173)		 ::flixel::math::FlxBasePoint point = ::flixel::math::FlxBasePoint_obj::pool->get()->set(x,y);
HXDLIN( 173)		point->_inPool = false;
HXDLIN( 173)		 ::flixel::math::FlxBasePoint offset = point;
HXLINE( 178)		bool _hx_tmp;
HXDLIN( 178)		int dir = 1;
HXDLIN( 178)		if (((edges & dir) == dir)) {
HXLINE( 178)			_hx_tmp = ((spriteBounds->x + spriteBounds->width) < (camera->scroll->x + camera->viewMarginX));
            		}
            		else {
HXLINE( 178)			_hx_tmp = false;
            		}
HXDLIN( 178)		if (_hx_tmp) {
HXLINE( 179)			sprite->set_x(((camera->scroll->x + (( (Float)(camera->width) ) - camera->viewMarginX)) + offset->x));
            		}
            		else {
HXLINE( 180)			bool _hx_tmp;
HXDLIN( 180)			int dir = 16;
HXDLIN( 180)			if (((edges & dir) == dir)) {
HXLINE( 180)				_hx_tmp = (spriteBounds->x > (camera->scroll->x + (( (Float)(camera->width) ) - camera->viewMarginX)));
            			}
            			else {
HXLINE( 180)				_hx_tmp = false;
            			}
HXDLIN( 180)			if (_hx_tmp) {
HXLINE( 181)				sprite->set_x((((camera->scroll->x + camera->viewMarginX) + offset->x) - spriteBounds->width));
            			}
            		}
HXLINE( 183)		bool _hx_tmp1;
HXDLIN( 183)		int dir1 = 256;
HXDLIN( 183)		if (((edges & dir1) == dir1)) {
HXLINE( 183)			_hx_tmp1 = ((spriteBounds->y + spriteBounds->height) < (camera->scroll->y + camera->viewMarginY));
            		}
            		else {
HXLINE( 183)			_hx_tmp1 = false;
            		}
HXDLIN( 183)		if (_hx_tmp1) {
HXLINE( 184)			sprite->set_y(((camera->scroll->x + (( (Float)(camera->height) ) - camera->viewMarginY)) + offset->y));
            		}
            		else {
HXLINE( 185)			bool _hx_tmp;
HXDLIN( 185)			int dir = 4096;
HXDLIN( 185)			if (((edges & dir) == dir)) {
HXLINE( 185)				_hx_tmp = (spriteBounds->y > (camera->scroll->x + (( (Float)(camera->height) ) - camera->viewMarginY)));
            			}
            			else {
HXLINE( 185)				_hx_tmp = false;
            			}
HXDLIN( 185)			if (_hx_tmp) {
HXLINE( 186)				sprite->set_y((((camera->scroll->y + camera->viewMarginY) + offset->y) - spriteBounds->height));
            			}
            		}
HXLINE( 188)		if (!(spriteBounds->_inPool)) {
HXLINE( 188)			spriteBounds->_inPool = true;
HXDLIN( 188)			spriteBounds->_weak = false;
HXDLIN( 188)			::flixel::math::FlxRect_obj::_pool->putUnsafe(spriteBounds);
            		}
HXLINE( 189)		offset->put();
HXLINE( 191)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(FlxSpriteUtil_obj,cameraWrap,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::cameraBound( ::flixel::FlxSprite sprite, ::flixel::FlxCamera camera,::hx::Null< int >  __o_edges){
            		int edges = __o_edges.Default(4369);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_204_cameraBound)
HXLINE( 205)		if (::hx::IsNull( camera )) {
HXLINE( 206)			camera = ::flixel::FlxG_obj::camera;
            		}
HXLINE( 208)		 ::flixel::math::FlxRect spriteBounds = sprite->getScreenBounds(null(),camera);
HXLINE( 209)		Float x = ((sprite->x - spriteBounds->x) - camera->scroll->x);
HXDLIN( 209)		Float y = ((sprite->y - spriteBounds->y) - camera->scroll->y);
HXDLIN( 209)		 ::flixel::math::FlxBasePoint point = ::flixel::math::FlxBasePoint_obj::pool->get()->set(x,y);
HXDLIN( 209)		point->_inPool = false;
HXDLIN( 209)		 ::flixel::math::FlxBasePoint offset = point;
HXLINE( 214)		bool _hx_tmp;
HXDLIN( 214)		int dir = 1;
HXDLIN( 214)		if (((edges & dir) == dir)) {
HXLINE( 214)			_hx_tmp = (spriteBounds->x < (camera->scroll->x + camera->viewMarginX));
            		}
            		else {
HXLINE( 214)			_hx_tmp = false;
            		}
HXDLIN( 214)		if (_hx_tmp) {
HXLINE( 215)			sprite->set_x(((camera->scroll->x + camera->viewMarginX) + offset->x));
            		}
            		else {
HXLINE( 216)			bool _hx_tmp;
HXDLIN( 216)			int dir = 16;
HXDLIN( 216)			if (((edges & dir) == dir)) {
HXLINE( 216)				_hx_tmp = ((spriteBounds->x + spriteBounds->width) > (camera->scroll->x + (( (Float)(camera->width) ) - camera->viewMarginX)));
            			}
            			else {
HXLINE( 216)				_hx_tmp = false;
            			}
HXDLIN( 216)			if (_hx_tmp) {
HXLINE( 217)				sprite->set_x((((camera->scroll->x + (( (Float)(camera->width) ) - camera->viewMarginX)) + offset->x) - spriteBounds->width));
            			}
            		}
HXLINE( 219)		bool _hx_tmp1;
HXDLIN( 219)		int dir1 = 256;
HXDLIN( 219)		if (((edges & dir1) == dir1)) {
HXLINE( 219)			_hx_tmp1 = (spriteBounds->y < (camera->scroll->y + camera->viewMarginY));
            		}
            		else {
HXLINE( 219)			_hx_tmp1 = false;
            		}
HXDLIN( 219)		if (_hx_tmp1) {
HXLINE( 220)			sprite->set_y(((camera->scroll->y + camera->viewMarginY) + offset->y));
            		}
            		else {
HXLINE( 221)			bool _hx_tmp;
HXDLIN( 221)			int dir = 4096;
HXDLIN( 221)			if (((edges & dir) == dir)) {
HXLINE( 221)				_hx_tmp = ((spriteBounds->y + spriteBounds->height) > (camera->scroll->x + (( (Float)(camera->height) ) - camera->viewMarginY)));
            			}
            			else {
HXLINE( 221)				_hx_tmp = false;
            			}
HXDLIN( 221)			if (_hx_tmp) {
HXLINE( 222)				sprite->set_y((((camera->scroll->x + (( (Float)(camera->height) ) - camera->viewMarginY)) + offset->y) - spriteBounds->height));
            			}
            		}
HXLINE( 224)		if (!(spriteBounds->_inPool)) {
HXLINE( 224)			spriteBounds->_inPool = true;
HXDLIN( 224)			spriteBounds->_weak = false;
HXDLIN( 224)			::flixel::math::FlxRect_obj::_pool->putUnsafe(spriteBounds);
            		}
HXLINE( 225)		offset->put();
HXLINE( 227)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(FlxSpriteUtil_obj,cameraBound,return )

void FlxSpriteUtil_obj::space(::Array< ::Dynamic> objects,Float startX,Float startY, ::Dynamic horizontalSpacing, ::Dynamic verticalSpacing,::hx::Null< bool >  __o_spaceFromBounds, ::Dynamic position){
            		bool spaceFromBounds = __o_spaceFromBounds.Default(false);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_243_space)
HXLINE( 244)		Float prevWidth = ( (Float)(0) );
HXLINE( 245)		Float runningX = ( (Float)(0) );
HXLINE( 247)		if (::hx::IsNotNull( horizontalSpacing )) {
HXLINE( 249)			if (spaceFromBounds) {
HXLINE( 251)				prevWidth = objects->__get(0).StaticCast<  ::flixel::FlxObject >()->get_width();
            			}
HXLINE( 253)			runningX = startX;
            		}
            		else {
HXLINE( 257)			runningX = objects->__get(0).StaticCast<  ::flixel::FlxObject >()->x;
            		}
HXLINE( 260)		Float prevHeight = ( (Float)(0) );
HXLINE( 261)		Float runningY = ( (Float)(0) );
HXLINE( 263)		if (::hx::IsNotNull( verticalSpacing )) {
HXLINE( 265)			if (spaceFromBounds) {
HXLINE( 267)				prevHeight = objects->__get(0).StaticCast<  ::flixel::FlxObject >()->get_height();
            			}
HXLINE( 269)			runningY = startY;
            		}
            		else {
HXLINE( 273)			runningY = objects->__get(0).StaticCast<  ::flixel::FlxObject >()->y;
            		}
HXLINE( 276)		if (::hx::IsNotNull( position )) {
HXLINE( 278)			position(objects->__get(0).StaticCast<  ::flixel::FlxObject >(),runningX,runningY);
            		}
            		else {
HXLINE( 282)			objects->__get(0).StaticCast<  ::flixel::FlxObject >()->set_x(runningX);
HXLINE( 283)			objects->__get(0).StaticCast<  ::flixel::FlxObject >()->set_y(runningY);
            		}
HXLINE( 286)		Float curX = ( (Float)(0) );
HXLINE( 287)		Float curY = ( (Float)(0) );
HXLINE( 289)		{
HXLINE( 289)			int _g = 1;
HXDLIN( 289)			int _g1 = objects->length;
HXDLIN( 289)			while((_g < _g1)){
HXLINE( 289)				_g = (_g + 1);
HXDLIN( 289)				int i = (_g - 1);
HXLINE( 291)				 ::flixel::FlxObject object = objects->__get(i).StaticCast<  ::flixel::FlxObject >();
HXLINE( 293)				if (::hx::IsNotNull( horizontalSpacing )) {
HXLINE( 295)					curX = ((runningX + prevWidth) + horizontalSpacing);
HXLINE( 296)					runningX = curX;
            				}
            				else {
HXLINE( 300)					curX = object->x;
            				}
HXLINE( 303)				if (::hx::IsNotNull( verticalSpacing )) {
HXLINE( 305)					curY = ((runningY + prevHeight) + verticalSpacing);
HXLINE( 306)					runningY = curY;
            				}
            				else {
HXLINE( 310)					curY = object->y;
            				}
HXLINE( 313)				if (::hx::IsNotNull( position )) {
HXLINE( 315)					position(object,curX,curY);
            				}
            				else {
HXLINE( 319)					object->set_x(curX);
HXLINE( 320)					object->set_y(curY);
            				}
HXLINE( 323)				if (spaceFromBounds) {
HXLINE( 325)					prevWidth = object->get_width();
HXLINE( 326)					prevHeight = object->get_height();
            				}
            			}
            		}
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC7(FlxSpriteUtil_obj,space,(void))

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawLine( ::flixel::FlxSprite sprite,Float StartX,Float StartY,Float EndX,Float EndY, ::Dynamic lineStyle, ::Dynamic drawStyle){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_345_drawLine)
HXLINE( 346)		 ::Dynamic lineStyle1 = lineStyle;
HXDLIN( 346)		if (::hx::IsNull( lineStyle1 )) {
HXLINE( 346)			lineStyle1 =  ::Dynamic(::hx::Anon_obj::Create(2)
            				->setFixed(0,HX_("color",63,71,5c,4a),-1)
            				->setFixed(1,HX_("thickness",74,f1,66,5a),1));
            		}
HXDLIN( 346)		if (::hx::IsNull( lineStyle1->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 346)			lineStyle1->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            		}
HXDLIN( 346)		if (::hx::IsNull( lineStyle1->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 346)			lineStyle1->__SetField(HX_("color",63,71,5c,4a),-1,::hx::paccDynamic);
            		}
HXDLIN( 346)		lineStyle = lineStyle1;
HXLINE( 347)		{
HXLINE( 347)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 347)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 347)				 ::Dynamic color;
HXDLIN( 347)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 347)					color = -16777216;
            				}
            				else {
HXLINE( 347)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 347)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 347)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 347)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 347)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 347)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 347)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 347)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 347)			if ((0 != 0)) {
HXLINE( 347)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((0 & 16777215),(( (Float)(((0 >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 348)		::flixel::util::FlxSpriteUtil_obj::flashGfx->moveTo(StartX,StartY);
HXLINE( 349)		::flixel::util::FlxSpriteUtil_obj::flashGfx->lineTo(EndX,EndY);
HXLINE( 350)		{
HXLINE( 350)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 350)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 351)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC7(FlxSpriteUtil_obj,drawLine,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawCurve( ::flixel::FlxSprite sprite,Float StartX,Float StartY,Float EndX,Float EndY,Float ControlX,Float ControlY,::hx::Null< int >  __o_FillColor, ::Dynamic lineStyle, ::Dynamic drawStyle){
            		int FillColor = __o_FillColor.Default(0);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_372_drawCurve)
HXLINE( 373)		 ::Dynamic lineStyle1 = lineStyle;
HXDLIN( 373)		if (::hx::IsNull( lineStyle1 )) {
HXLINE( 373)			lineStyle1 =  ::Dynamic(::hx::Anon_obj::Create(2)
            				->setFixed(0,HX_("color",63,71,5c,4a),-1)
            				->setFixed(1,HX_("thickness",74,f1,66,5a),1));
            		}
HXDLIN( 373)		if (::hx::IsNull( lineStyle1->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 373)			lineStyle1->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            		}
HXDLIN( 373)		if (::hx::IsNull( lineStyle1->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 373)			lineStyle1->__SetField(HX_("color",63,71,5c,4a),-1,::hx::paccDynamic);
            		}
HXDLIN( 373)		lineStyle = lineStyle1;
HXLINE( 374)		{
HXLINE( 374)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 374)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 374)				 ::Dynamic color;
HXDLIN( 374)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 374)					color = -16777216;
            				}
            				else {
HXLINE( 374)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 374)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 374)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 374)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 374)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 374)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 374)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 374)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 374)			if ((FillColor != 0)) {
HXLINE( 374)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 375)		::flixel::util::FlxSpriteUtil_obj::flashGfx->moveTo(StartX,StartY);
HXLINE( 376)		::flixel::util::FlxSpriteUtil_obj::flashGfx->curveTo(EndX,EndY,ControlX,ControlY);
HXLINE( 377)		{
HXLINE( 377)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 377)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 378)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC10(FlxSpriteUtil_obj,drawCurve,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawRect( ::flixel::FlxSprite sprite,Float X,Float Y,Float Width,Float Height,::hx::Null< int >  __o_FillColor, ::Dynamic lineStyle, ::Dynamic drawStyle){
            		int FillColor = __o_FillColor.Default(-1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_396_drawRect)
HXLINE( 397)		{
HXLINE( 397)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 397)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 397)				 ::Dynamic color;
HXDLIN( 397)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 397)					color = -16777216;
            				}
            				else {
HXLINE( 397)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 397)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 397)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 397)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 397)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 397)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 397)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 397)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 397)			if ((FillColor != 0)) {
HXLINE( 397)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 398)		::flixel::util::FlxSpriteUtil_obj::flashGfx->drawRect(X,Y,Width,Height);
HXLINE( 399)		{
HXLINE( 399)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 399)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 400)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC8(FlxSpriteUtil_obj,drawRect,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawRoundRect( ::flixel::FlxSprite sprite,Float X,Float Y,Float Width,Float Height,Float EllipseWidth,Float EllipseHeight,::hx::Null< int >  __o_FillColor, ::Dynamic lineStyle, ::Dynamic drawStyle){
            		int FillColor = __o_FillColor.Default(-1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_420_drawRoundRect)
HXLINE( 421)		{
HXLINE( 421)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 421)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 421)				 ::Dynamic color;
HXDLIN( 421)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 421)					color = -16777216;
            				}
            				else {
HXLINE( 421)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 421)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 421)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 421)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 421)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 421)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 421)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 421)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 421)			if ((FillColor != 0)) {
HXLINE( 421)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 422)		::flixel::util::FlxSpriteUtil_obj::flashGfx->drawRoundRect(X,Y,Width,Height,EllipseWidth,EllipseHeight);
HXLINE( 423)		{
HXLINE( 423)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 423)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 424)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC10(FlxSpriteUtil_obj,drawRoundRect,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawRoundRectComplex( ::flixel::FlxSprite sprite,Float X,Float Y,Float Width,Float Height,Float TopLeftRadius,Float TopRightRadius,Float BottomLeftRadius,Float BottomRightRadius,::hx::Null< int >  __o_FillColor, ::Dynamic lineStyle, ::Dynamic drawStyle){
            		int FillColor = __o_FillColor.Default(-1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_448_drawRoundRectComplex)
HXLINE( 449)		{
HXLINE( 449)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 449)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 449)				 ::Dynamic color;
HXDLIN( 449)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 449)					color = -16777216;
            				}
            				else {
HXLINE( 449)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 449)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 449)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 449)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 449)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 449)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 449)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 449)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 449)			if ((FillColor != 0)) {
HXLINE( 449)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 450)		::flixel::util::FlxSpriteUtil_obj::flashGfx->drawRoundRectComplex(X,Y,Width,Height,TopLeftRadius,TopRightRadius,BottomLeftRadius,BottomRightRadius);
HXLINE( 451)		{
HXLINE( 451)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 451)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 452)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC12(FlxSpriteUtil_obj,drawRoundRectComplex,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawCircle( ::flixel::FlxSprite sprite,::hx::Null< Float >  __o_X,::hx::Null< Float >  __o_Y,::hx::Null< Float >  __o_Radius,::hx::Null< int >  __o_FillColor, ::Dynamic lineStyle, ::Dynamic drawStyle){
            		Float X = __o_X.Default(-1);
            		Float Y = __o_Y.Default(-1);
            		Float Radius = __o_Radius.Default(-1);
            		int FillColor = __o_FillColor.Default(-1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_470_drawCircle)
HXLINE( 471)		bool _hx_tmp;
HXDLIN( 471)		if ((X != -1)) {
HXLINE( 471)			_hx_tmp = (Y == -1);
            		}
            		else {
HXLINE( 471)			_hx_tmp = true;
            		}
HXDLIN( 471)		if (_hx_tmp) {
HXLINE( 473)			 ::flixel::math::FlxBasePoint midPoint = sprite->getGraphicMidpoint(null());
HXLINE( 475)			if ((X == -1)) {
HXLINE( 476)				X = (midPoint->x - sprite->x);
            			}
HXLINE( 477)			if ((Y == -1)) {
HXLINE( 478)				Y = (midPoint->y - sprite->y);
            			}
HXLINE( 480)			midPoint->put();
            		}
HXLINE( 483)		if ((Radius < 1)) {
HXLINE( 485)			Float minVal = ::Math_obj::min(( (Float)(sprite->frameWidth) ),( (Float)(sprite->frameHeight) ));
HXLINE( 486)			Radius = (minVal / ( (Float)(2) ));
            		}
HXLINE( 489)		{
HXLINE( 489)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 489)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 489)				 ::Dynamic color;
HXDLIN( 489)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 489)					color = -16777216;
            				}
            				else {
HXLINE( 489)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 489)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 489)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 489)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 489)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 489)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 489)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 489)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 489)			if ((FillColor != 0)) {
HXLINE( 489)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 490)		::flixel::util::FlxSpriteUtil_obj::flashGfx->drawCircle(X,Y,Radius);
HXLINE( 491)		{
HXLINE( 491)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 491)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 492)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC7(FlxSpriteUtil_obj,drawCircle,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawEllipse( ::flixel::FlxSprite sprite,Float X,Float Y,Float Width,Float Height,::hx::Null< int >  __o_FillColor, ::Dynamic lineStyle, ::Dynamic drawStyle){
            		int FillColor = __o_FillColor.Default(-1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_510_drawEllipse)
HXLINE( 511)		{
HXLINE( 511)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 511)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 511)				 ::Dynamic color;
HXDLIN( 511)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 511)					color = -16777216;
            				}
            				else {
HXLINE( 511)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 511)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 511)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 511)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 511)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 511)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 511)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 511)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 511)			if ((FillColor != 0)) {
HXLINE( 511)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 512)		::flixel::util::FlxSpriteUtil_obj::flashGfx->drawEllipse(X,Y,Width,Height);
HXLINE( 513)		{
HXLINE( 513)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 513)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 514)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC8(FlxSpriteUtil_obj,drawEllipse,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawTriangle( ::flixel::FlxSprite sprite,Float X,Float Y,Float Height,::hx::Null< int >  __o_FillColor, ::Dynamic lineStyle, ::Dynamic drawStyle){
            		int FillColor = __o_FillColor.Default(-1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_531_drawTriangle)
HXLINE( 532)		{
HXLINE( 532)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 532)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 532)				 ::Dynamic color;
HXDLIN( 532)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 532)					color = -16777216;
            				}
            				else {
HXLINE( 532)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 532)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 532)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 532)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 532)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 532)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 532)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 532)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 532)			if ((FillColor != 0)) {
HXLINE( 532)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 533)		::flixel::util::FlxSpriteUtil_obj::flashGfx->moveTo((X + (Height / ( (Float)(2) ))),Y);
HXLINE( 534)		::flixel::util::FlxSpriteUtil_obj::flashGfx->lineTo((X + Height),(Height + Y));
HXLINE( 535)		::flixel::util::FlxSpriteUtil_obj::flashGfx->lineTo(X,(Height + Y));
HXLINE( 536)		::flixel::util::FlxSpriteUtil_obj::flashGfx->lineTo((X + (Height / ( (Float)(2) ))),Y);
HXLINE( 537)		{
HXLINE( 537)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 537)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 538)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC7(FlxSpriteUtil_obj,drawTriangle,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::drawPolygon( ::flixel::FlxSprite sprite,::Array< ::Dynamic> Vertices,::hx::Null< int >  __o_FillColor, ::Dynamic lineStyle, ::Dynamic drawStyle){
            		int FillColor = __o_FillColor.Default(-1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_553_drawPolygon)
HXLINE( 554)		{
HXLINE( 554)			::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXDLIN( 554)			if (::hx::IsNotNull( lineStyle )) {
HXLINE( 554)				 ::Dynamic color;
HXDLIN( 554)				if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 554)					color = -16777216;
            				}
            				else {
HXLINE( 554)					color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            				}
HXDLIN( 554)				if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 554)					lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            				}
HXDLIN( 554)				if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 554)					lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            				}
HXDLIN( 554)				if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 554)					lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            				}
HXDLIN( 554)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            			}
HXDLIN( 554)			if ((FillColor != 0)) {
HXLINE( 554)				::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            			}
            		}
HXLINE( 555)		 ::flixel::math::FlxBasePoint p = Vertices->shift().StaticCast<  ::flixel::math::FlxBasePoint >();
HXLINE( 556)		::flixel::util::FlxSpriteUtil_obj::flashGfx->moveTo(p->x,p->y);
HXLINE( 557)		{
HXLINE( 557)			int _g = 0;
HXDLIN( 557)			while((_g < Vertices->length)){
HXLINE( 557)				 ::flixel::math::FlxBasePoint p = Vertices->__get(_g).StaticCast<  ::flixel::math::FlxBasePoint >();
HXDLIN( 557)				_g = (_g + 1);
HXLINE( 559)				::flixel::util::FlxSpriteUtil_obj::flashGfx->lineTo(p->x,p->y);
            			}
            		}
HXLINE( 561)		{
HXLINE( 561)			::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXDLIN( 561)			::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
            		}
HXLINE( 562)		Vertices->unshift(p);
HXLINE( 563)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC5(FlxSpriteUtil_obj,drawPolygon,return )

void FlxSpriteUtil_obj::beginDraw(int FillColor, ::Dynamic lineStyle){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_574_beginDraw)
HXLINE( 575)		::flixel::util::FlxSpriteUtil_obj::flashGfx->clear();
HXLINE( 576)		if (::hx::IsNotNull( lineStyle )) {
HXLINE( 576)			 ::Dynamic color;
HXDLIN( 576)			if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 576)				color = -16777216;
            			}
            			else {
HXLINE( 576)				color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            			}
HXDLIN( 576)			if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 576)				lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            			}
HXDLIN( 576)			if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 576)				lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            			}
HXDLIN( 576)			if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 576)				lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            			}
HXDLIN( 576)			::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            		}
HXLINE( 578)		if ((FillColor != 0)) {
HXLINE( 580)			::flixel::util::FlxSpriteUtil_obj::flashGfx->beginFill((FillColor & 16777215),(( (Float)(((FillColor >> 24) & 255)) ) / ( (Float)(255) )));
            		}
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(FlxSpriteUtil_obj,beginDraw,(void))

 ::flixel::FlxSprite FlxSpriteUtil_obj::endDraw( ::flixel::FlxSprite sprite, ::Dynamic drawStyle){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_592_endDraw)
HXLINE( 593)		::flixel::util::FlxSpriteUtil_obj::flashGfx->endFill();
HXLINE( 594)		::flixel::util::FlxSpriteUtil_obj::updateSpriteGraphic(sprite,drawStyle);
HXLINE( 595)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(FlxSpriteUtil_obj,endDraw,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::updateSpriteGraphic( ::flixel::FlxSprite sprite, ::Dynamic drawStyle){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_607_updateSpriteGraphic)
HXLINE( 608)		if (::hx::IsNull( drawStyle )) {
HXLINE( 610)			drawStyle =  ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("smoothing",74,d5,e1,95),false));
            		}
            		else {
HXLINE( 612)			if (::hx::IsNull( drawStyle->__Field(HX_("smoothing",74,d5,e1,95),::hx::paccDynamic) )) {
HXLINE( 614)				drawStyle->__SetField(HX_("smoothing",74,d5,e1,95),false,::hx::paccDynamic);
            			}
            		}
HXLINE( 617)		sprite->get_pixels()->draw(::flixel::util::FlxSpriteUtil_obj::flashGfxSprite,( ( ::openfl::geom::Matrix)(drawStyle->__Field(HX_("matrix",41,36,c8,bb),::hx::paccDynamic)) ),( ( ::openfl::geom::ColorTransform)(drawStyle->__Field(HX_("colorTransform",89,d7,3f,ad),::hx::paccDynamic)) ),drawStyle->__Field(HX_("blendMode",54,e4,37,0c),::hx::paccDynamic),( ( ::openfl::geom::Rectangle)(drawStyle->__Field(HX_("clipRect",14,90,6a,58),::hx::paccDynamic)) ),drawStyle->__Field(HX_("smoothing",74,d5,e1,95),::hx::paccDynamic));
HXLINE( 618)		sprite->dirty = true;
HXLINE( 619)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(FlxSpriteUtil_obj,updateSpriteGraphic,return )

void FlxSpriteUtil_obj::setLineStyle( ::Dynamic lineStyle){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_631_setLineStyle)
HXDLIN( 631)		if (::hx::IsNotNull( lineStyle )) {
HXLINE( 633)			 ::Dynamic color;
HXDLIN( 633)			if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 633)				color = -16777216;
            			}
            			else {
HXLINE( 633)				color = lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic);
            			}
HXLINE( 635)			if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 636)				lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            			}
HXLINE( 637)			if (::hx::IsNull( lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic) )) {
HXLINE( 638)				lineStyle->__SetField(HX_("pixelHinting",d5,9b,fb,6c),false,::hx::paccDynamic);
            			}
HXLINE( 639)			if (::hx::IsNull( lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic) )) {
HXLINE( 640)				lineStyle->__SetField(HX_("miterLimit",f6,5c,6a,54),3,::hx::paccDynamic);
            			}
HXLINE( 642)			::flixel::util::FlxSpriteUtil_obj::flashGfx->lineStyle(lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic),(( (int)(color) ) & 16777215),(( (Float)(((( (int)(color) ) >> 24) & 255)) ) / ( (Float)(255) )),lineStyle->__Field(HX_("pixelHinting",d5,9b,fb,6c),::hx::paccDynamic),lineStyle->__Field(HX_("scaleMode",0d,db,d3,2b),::hx::paccDynamic),lineStyle->__Field(HX_("capsStyle",50,61,32,83),::hx::paccDynamic),lineStyle->__Field(HX_("jointStyle",87,ef,1c,e2),::hx::paccDynamic),lineStyle->__Field(HX_("miterLimit",f6,5c,6a,54),::hx::paccDynamic));
            		}
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(FlxSpriteUtil_obj,setLineStyle,(void))

 ::Dynamic FlxSpriteUtil_obj::getDefaultLineStyle( ::Dynamic lineStyle){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_653_getDefaultLineStyle)
HXLINE( 654)		if (::hx::IsNull( lineStyle )) {
HXLINE( 655)			lineStyle =  ::Dynamic(::hx::Anon_obj::Create(2)
            				->setFixed(0,HX_("color",63,71,5c,4a),-1)
            				->setFixed(1,HX_("thickness",74,f1,66,5a),1));
            		}
HXLINE( 656)		if (::hx::IsNull( lineStyle->__Field(HX_("thickness",74,f1,66,5a),::hx::paccDynamic) )) {
HXLINE( 657)			lineStyle->__SetField(HX_("thickness",74,f1,66,5a),1,::hx::paccDynamic);
            		}
HXLINE( 658)		if (::hx::IsNull( lineStyle->__Field(HX_("color",63,71,5c,4a),::hx::paccDynamic) )) {
HXLINE( 659)			lineStyle->__SetField(HX_("color",63,71,5c,4a),-1,::hx::paccDynamic);
            		}
HXLINE( 661)		return lineStyle;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(FlxSpriteUtil_obj,getDefaultLineStyle,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::fill( ::flixel::FlxSprite sprite,int FillColor){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_672_fill)
HXLINE( 673)		 ::openfl::display::BitmapData _hx_tmp = sprite->get_pixels();
HXDLIN( 673)		_hx_tmp->fillRect(sprite->get_pixels()->rect,FillColor);
HXLINE( 675)		 ::openfl::display::BitmapData _hx_tmp1 = sprite->get_pixels();
HXDLIN( 675)		if (::hx::IsInstanceNotEq( _hx_tmp1,sprite->framePixels )) {
HXLINE( 677)			sprite->dirty = true;
            		}
HXLINE( 680)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(FlxSpriteUtil_obj,fill,return )

 ::flixel::effects::FlxFlicker FlxSpriteUtil_obj::flicker( ::flixel::FlxObject Object,::hx::Null< Float >  __o_Duration,::hx::Null< Float >  __o_Interval,::hx::Null< bool >  __o_EndVisibility,::hx::Null< bool >  __o_ForceRestart, ::Dynamic CompletionCallback, ::Dynamic ProgressCallback){
            		Float Duration = __o_Duration.Default(1);
            		Float Interval = __o_Interval.Default(((Float)0.04));
            		bool EndVisibility = __o_EndVisibility.Default(true);
            		bool ForceRestart = __o_ForceRestart.Default(true);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_698_flicker)
HXDLIN( 698)		return ::flixel::effects::FlxFlicker_obj::flicker(Object,Duration,Interval,EndVisibility,ForceRestart,CompletionCallback,ProgressCallback);
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC7(FlxSpriteUtil_obj,flicker,return )

bool FlxSpriteUtil_obj::isFlickering( ::flixel::FlxObject Object){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_708_isFlickering)
HXDLIN( 708)		return ::flixel::effects::FlxFlicker_obj::isFlickering(Object);
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(FlxSpriteUtil_obj,isFlickering,return )

 ::flixel::FlxObject FlxSpriteUtil_obj::stopFlickering( ::flixel::FlxObject Object){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_718_stopFlickering)
HXLINE( 719)		::flixel::effects::FlxFlicker_obj::stopFlickering(Object);
HXLINE( 720)		return Object;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(FlxSpriteUtil_obj,stopFlickering,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::fadeIn( ::flixel::FlxSprite sprite,::hx::Null< Float >  __o_Duration, ::Dynamic ResetAlpha, ::Dynamic OnComplete){
            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_0, ::flixel::FlxSprite,sprite1) HXARGC(1)
            		void _hx_run(Float f){
            			HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_736_fadeIn)
HXLINE( 736)			::flixel::util::FlxSpriteUtil_obj::alphaTween(sprite1,f);
            		}
            		HX_END_LOCAL_FUNC1((void))

            		Float Duration = __o_Duration.Default(1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_731_fadeIn)
HXLINE( 732)		if (( (bool)(ResetAlpha) )) {
HXLINE( 734)			sprite->set_alpha(( (Float)(0) ));
            		}
HXLINE( 736)		 ::flixel::FlxSprite sprite1 = sprite;
HXDLIN( 736)		 ::Dynamic _hx_tmp =  ::Dynamic(new _hx_Closure_0(sprite1));
HXDLIN( 736)		::flixel::tweens::FlxTween_obj::num(sprite->alpha,( (Float)(1) ),Duration, ::Dynamic(::hx::Anon_obj::Create(1)
            			->setFixed(0,HX_("onComplete",f8,d4,7e,5d),OnComplete)),_hx_tmp);
HXLINE( 737)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC4(FlxSpriteUtil_obj,fadeIn,return )

 ::flixel::FlxSprite FlxSpriteUtil_obj::fadeOut( ::flixel::FlxSprite sprite,::hx::Null< Float >  __o_Duration, ::Dynamic OnComplete){
            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_0, ::flixel::FlxSprite,sprite1) HXARGC(1)
            		void _hx_run(Float f){
            			HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_749_fadeOut)
HXLINE( 749)			::flixel::util::FlxSpriteUtil_obj::alphaTween(sprite1,f);
            		}
            		HX_END_LOCAL_FUNC1((void))

            		Float Duration = __o_Duration.Default(1);
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_748_fadeOut)
HXLINE( 749)		 ::flixel::FlxSprite sprite1 = sprite;
HXDLIN( 749)		 ::Dynamic _hx_tmp =  ::Dynamic(new _hx_Closure_0(sprite1));
HXDLIN( 749)		::flixel::tweens::FlxTween_obj::num(sprite->alpha,( (Float)(0) ),Duration, ::Dynamic(::hx::Anon_obj::Create(1)
            			->setFixed(0,HX_("onComplete",f8,d4,7e,5d),OnComplete)),_hx_tmp);
HXLINE( 750)		return sprite;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(FlxSpriteUtil_obj,fadeOut,return )

void FlxSpriteUtil_obj::alphaTween( ::flixel::FlxSprite sprite,Float f){
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_755_alphaTween)
HXDLIN( 755)		sprite->set_alpha(f);
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(FlxSpriteUtil_obj,alphaTween,(void))


FlxSpriteUtil_obj::FlxSpriteUtil_obj()
{
}

bool FlxSpriteUtil_obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"fill") ) { outValue = fill_dyn(); return true; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"bound") ) { outValue = bound_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"space") ) { outValue = space_dyn(); return true; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"fadeIn") ) { outValue = fadeIn_dyn(); return true; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"endDraw") ) { outValue = endDraw_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"flicker") ) { outValue = flicker_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"fadeOut") ) { outValue = fadeOut_dyn(); return true; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"flashGfx") ) { outValue = ( flashGfx ); return true; }
		if (HX_FIELD_EQ(inName,"drawLine") ) { outValue = drawLine_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"drawRect") ) { outValue = drawRect_dyn(); return true; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"alphaMask") ) { outValue = alphaMask_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"drawCurve") ) { outValue = drawCurve_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"beginDraw") ) { outValue = beginDraw_dyn(); return true; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"screenWrap") ) { outValue = screenWrap_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"cameraWrap") ) { outValue = cameraWrap_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"drawCircle") ) { outValue = drawCircle_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"alphaTween") ) { outValue = alphaTween_dyn(); return true; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"cameraBound") ) { outValue = cameraBound_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"drawEllipse") ) { outValue = drawEllipse_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"drawPolygon") ) { outValue = drawPolygon_dyn(); return true; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"drawTriangle") ) { outValue = drawTriangle_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"setLineStyle") ) { outValue = setLineStyle_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"isFlickering") ) { outValue = isFlickering_dyn(); return true; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"drawRoundRect") ) { outValue = drawRoundRect_dyn(); return true; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"flashGfxSprite") ) { outValue = ( flashGfxSprite ); return true; }
		if (HX_FIELD_EQ(inName,"stopFlickering") ) { outValue = stopFlickering_dyn(); return true; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"alphaMaskFlxSprite") ) { outValue = alphaMaskFlxSprite_dyn(); return true; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"updateSpriteGraphic") ) { outValue = updateSpriteGraphic_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"getDefaultLineStyle") ) { outValue = getDefaultLineStyle_dyn(); return true; }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"drawRoundRectComplex") ) { outValue = drawRoundRectComplex_dyn(); return true; }
	}
	return false;
}

bool FlxSpriteUtil_obj::__SetStatic(const ::String &inName,Dynamic &ioValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"flashGfx") ) { flashGfx=ioValue.Cast<  ::openfl::display::Graphics >(); return true; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"flashGfxSprite") ) { flashGfxSprite=ioValue.Cast<  ::openfl::display::Sprite >(); return true; }
	}
	return false;
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *FlxSpriteUtil_obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo FlxSpriteUtil_obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::openfl::display::Sprite */ ,(void *) &FlxSpriteUtil_obj::flashGfxSprite,HX_("flashGfxSprite",8e,26,3f,ab)},
	{::hx::fsObject /*  ::openfl::display::Graphics */ ,(void *) &FlxSpriteUtil_obj::flashGfx,HX_("flashGfx",a9,b1,ce,99)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void FlxSpriteUtil_obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(FlxSpriteUtil_obj::flashGfxSprite,"flashGfxSprite");
	HX_MARK_MEMBER_NAME(FlxSpriteUtil_obj::flashGfx,"flashGfx");
};

#ifdef HXCPP_VISIT_ALLOCS
static void FlxSpriteUtil_obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(FlxSpriteUtil_obj::flashGfxSprite,"flashGfxSprite");
	HX_VISIT_MEMBER_NAME(FlxSpriteUtil_obj::flashGfx,"flashGfx");
};

#endif

::hx::Class FlxSpriteUtil_obj::__mClass;

static ::String FlxSpriteUtil_obj_sStaticFields[] = {
	HX_("flashGfxSprite",8e,26,3f,ab),
	HX_("flashGfx",a9,b1,ce,99),
	HX_("alphaMask",6a,1b,50,e2),
	HX_("alphaMaskFlxSprite",4d,fd,ae,12),
	HX_("screenWrap",56,c7,35,c7),
	HX_("bound",3e,b0,fc,b6),
	HX_("cameraWrap",0f,63,1d,b5),
	HX_("cameraBound",59,a3,42,ab),
	HX_("space",c6,8c,66,81),
	HX_("drawLine",18,c2,1c,5c),
	HX_("drawCurve",0b,82,63,16),
	HX_("drawRect",48,f7,10,60),
	HX_("drawRoundRect",ee,c3,aa,e2),
	HX_("drawRoundRectComplex",e2,43,2c,11),
	HX_("drawCircle",34,ed,d0,97),
	HX_("drawEllipse",3a,85,ce,54),
	HX_("drawTriangle",ec,4a,b9,63),
	HX_("drawPolygon",d6,46,d9,5b),
	HX_("beginDraw",cd,0a,4a,8b),
	HX_("endDraw",7f,e5,94,24),
	HX_("updateSpriteGraphic",5a,59,f9,55),
	HX_("setLineStyle",9b,68,68,ef),
	HX_("getDefaultLineStyle",52,78,37,48),
	HX_("fill",83,ce,bb,43),
	HX_("flicker",f8,da,ec,76),
	HX_("isFlickering",74,85,73,33),
	HX_("stopFlickering",8c,27,6a,4a),
	HX_("fadeIn",81,4c,ab,e4),
	HX_("fadeOut",72,38,3c,31),
	HX_("alphaTween",2d,fe,15,3a),
	::String(null())
};

void FlxSpriteUtil_obj::__register()
{
	FlxSpriteUtil_obj _hx_dummy;
	FlxSpriteUtil_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.util.FlxSpriteUtil",ff,7e,4e,f7);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &FlxSpriteUtil_obj::__GetStatic;
	__mClass->mSetStaticField = &FlxSpriteUtil_obj::__SetStatic;
	__mClass->mMarkFunc = FlxSpriteUtil_obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(FlxSpriteUtil_obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< FlxSpriteUtil_obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = FlxSpriteUtil_obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = FlxSpriteUtil_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = FlxSpriteUtil_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void FlxSpriteUtil_obj::__boot()
{
{
            	HX_GC_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_39_boot)
HXDLIN(  39)		flashGfxSprite =  ::openfl::display::Sprite_obj::__alloc( HX_CTX );
            	}
{
            	HX_STACKFRAME(&_hx_pos_aff86ac70b6ed09e_41_boot)
HXDLIN(  41)		flashGfx = ::flixel::util::FlxSpriteUtil_obj::flashGfxSprite->get_graphics();
            	}
}

} // end namespace flixel
} // end namespace util
