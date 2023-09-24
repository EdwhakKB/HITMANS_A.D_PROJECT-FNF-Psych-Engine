#include <hxcpp.h>

#ifndef INCLUDED_95f339a1d026d52c
#define INCLUDED_95f339a1d026d52c
#include "hxMath.h"
#endif
#ifndef INCLUDED_lime_app_IModule
#include <lime/app/IModule.h>
#endif
#ifndef INCLUDED_lime_graphics_Image
#include <lime/graphics/Image.h>
#endif
#ifndef INCLUDED_lime_graphics_RenderContext
#include <lime/graphics/RenderContext.h>
#endif
#ifndef INCLUDED_lime_graphics_cairo_Cairo
#include <lime/graphics/cairo/Cairo.h>
#endif
#ifndef INCLUDED_lime_utils_ObjectPool
#include <lime/utils/ObjectPool.h>
#endif
#ifndef INCLUDED_openfl_display_Bitmap
#include <openfl/display/Bitmap.h>
#endif
#ifndef INCLUDED_openfl_display_BitmapData
#include <openfl/display/BitmapData.h>
#endif
#ifndef INCLUDED_openfl_display_CairoRenderer
#include <openfl/display/CairoRenderer.h>
#endif
#ifndef INCLUDED_openfl_display_DOMRenderer
#include <openfl/display/DOMRenderer.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObject
#include <openfl/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectContainer
#include <openfl/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectRenderer
#include <openfl/display/DisplayObjectRenderer.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectShader
#include <openfl/display/DisplayObjectShader.h>
#endif
#ifndef INCLUDED_openfl_display_Graphics
#include <openfl/display/Graphics.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_ITileContainer
#include <openfl/display/ITileContainer.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_display_OpenGLRenderer
#include <openfl/display/OpenGLRenderer.h>
#endif
#ifndef INCLUDED_openfl_display_Shader
#include <openfl/display/Shader.h>
#endif
#ifndef INCLUDED_openfl_display_Stage
#include <openfl/display/Stage.h>
#endif
#ifndef INCLUDED_openfl_display_Tilemap
#include <openfl/display/Tilemap.h>
#endif
#ifndef INCLUDED_openfl_display__internal_Context3DGraphics
#include <openfl/display/_internal/Context3DGraphics.h>
#endif
#ifndef INCLUDED_openfl_display3D_Context3D
#include <openfl/display3D/Context3D.h>
#endif
#ifndef INCLUDED_openfl_display3D__internal_Context3DState
#include <openfl/display3D/_internal/Context3DState.h>
#endif
#ifndef INCLUDED_openfl_display3D_textures_TextureBase
#include <openfl/display3D/textures/TextureBase.h>
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
#ifndef INCLUDED_openfl_events_RenderEvent
#include <openfl/events/RenderEvent.h>
#endif
#ifndef INCLUDED_openfl_filters_BitmapFilter
#include <openfl/filters/BitmapFilter.h>
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
#ifndef INCLUDED_openfl_geom_Transform
#include <openfl/geom/Transform.h>
#endif
#ifndef INCLUDED_openfl_text_TextField
#include <openfl/text/TextField.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_5a81acb3bead7383_61_new,"openfl.display.DisplayObjectRenderer","new",0x2db5f24c,"openfl.display.DisplayObjectRenderer.new","openfl/display/DisplayObjectRenderer.hx",61,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_70___clear,"openfl.display.DisplayObjectRenderer","__clear",0x54d15259,"openfl.display.DisplayObjectRenderer.__clear","openfl/display/DisplayObjectRenderer.hx",70,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_74___getAlpha,"openfl.display.DisplayObjectRenderer","__getAlpha",0x82bb5d9c,"openfl.display.DisplayObjectRenderer.__getAlpha","openfl/display/DisplayObjectRenderer.hx",74,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_79___getColorTransform,"openfl.display.DisplayObjectRenderer","__getColorTransform",0x8add698b,"openfl.display.DisplayObjectRenderer.__getColorTransform","openfl/display/DisplayObjectRenderer.hx",79,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_91___popMask,"openfl.display.DisplayObjectRenderer","__popMask",0xc15a12e9,"openfl.display.DisplayObjectRenderer.__popMask","openfl/display/DisplayObjectRenderer.hx",91,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_93___popMaskObject,"openfl.display.DisplayObjectRenderer","__popMaskObject",0xe6109a88,"openfl.display.DisplayObjectRenderer.__popMaskObject","openfl/display/DisplayObjectRenderer.hx",93,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_95___popMaskRect,"openfl.display.DisplayObjectRenderer","__popMaskRect",0x0ba8b4ad,"openfl.display.DisplayObjectRenderer.__popMaskRect","openfl/display/DisplayObjectRenderer.hx",95,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_97___pushMask,"openfl.display.DisplayObjectRenderer","__pushMask",0x18951a9a,"openfl.display.DisplayObjectRenderer.__pushMask","openfl/display/DisplayObjectRenderer.hx",97,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_99___pushMaskObject,"openfl.display.DisplayObjectRenderer","__pushMaskObject",0xb221fcf9,"openfl.display.DisplayObjectRenderer.__pushMaskObject","openfl/display/DisplayObjectRenderer.hx",99,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_101___pushMaskRect,"openfl.display.DisplayObjectRenderer","__pushMaskRect",0xd45fe8de,"openfl.display.DisplayObjectRenderer.__pushMaskRect","openfl/display/DisplayObjectRenderer.hx",101,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_103___render,"openfl.display.DisplayObjectRenderer","__render",0xdfd83d0a,"openfl.display.DisplayObjectRenderer.__render","openfl/display/DisplayObjectRenderer.hx",103,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_106___renderEvent,"openfl.display.DisplayObjectRenderer","__renderEvent",0x7eae76b0,"openfl.display.DisplayObjectRenderer.__renderEvent","openfl/display/DisplayObjectRenderer.hx",106,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_163___resize,"openfl.display.DisplayObjectRenderer","__resize",0xe32a2ba8,"openfl.display.DisplayObjectRenderer.__resize","openfl/display/DisplayObjectRenderer.hx",163,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_165___setBlendMode,"openfl.display.DisplayObjectRenderer","__setBlendMode",0x84c0b506,"openfl.display.DisplayObjectRenderer.__setBlendMode","openfl/display/DisplayObjectRenderer.hx",165,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_168___shouldCacheHardware,"openfl.display.DisplayObjectRenderer","__shouldCacheHardware",0x0f82bca3,"openfl.display.DisplayObjectRenderer.__shouldCacheHardware","openfl/display/DisplayObjectRenderer.hx",168,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_201___shouldCacheHardware_DisplayObject,"openfl.display.DisplayObjectRenderer","__shouldCacheHardware_DisplayObject",0x716eeea5,"openfl.display.DisplayObjectRenderer.__shouldCacheHardware_DisplayObject","openfl/display/DisplayObjectRenderer.hx",201,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_213___updateCacheBitmap,"openfl.display.DisplayObjectRenderer","__updateCacheBitmap",0xdf40cb14,"openfl.display.DisplayObjectRenderer.__updateCacheBitmap","openfl/display/DisplayObjectRenderer.hx",213,0x59a0b9a6)
HX_LOCAL_STACK_FRAME(_hx_pos_5a81acb3bead7383_43_boot,"openfl.display.DisplayObjectRenderer","boot",0xc99710c6,"openfl.display.DisplayObjectRenderer.boot","openfl/display/DisplayObjectRenderer.hx",43,0x59a0b9a6)
namespace openfl{
namespace display{

void DisplayObjectRenderer_obj::__construct(){
            	HX_GC_STACKFRAME(&_hx_pos_5a81acb3bead7383_61_new)
HXLINE(  62)		super::__construct(null());
HXLINE(  64)		this->_hx___allowSmoothing = true;
HXLINE(  65)		this->_hx___pixelRatio = ( (Float)(1) );
HXLINE(  66)		this->_hx___tempColorTransform =  ::openfl::geom::ColorTransform_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null(),null(),null());
HXLINE(  67)		this->_hx___worldAlpha = ( (Float)(1) );
            	}

Dynamic DisplayObjectRenderer_obj::__CreateEmpty() { return new DisplayObjectRenderer_obj; }

void *DisplayObjectRenderer_obj::_hx_vtable = 0;

Dynamic DisplayObjectRenderer_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< DisplayObjectRenderer_obj > _hx_result = new DisplayObjectRenderer_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool DisplayObjectRenderer_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x0c89e854) {
		return inClassId==(int)0x00000001 || inClassId==(int)0x0c89e854;
	} else {
		return inClassId==(int)0x49529132;
	}
}

void DisplayObjectRenderer_obj::_hx___clear(){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_70___clear)
            	}


HX_DEFINE_DYNAMIC_FUNC0(DisplayObjectRenderer_obj,_hx___clear,(void))

Float DisplayObjectRenderer_obj::_hx___getAlpha(Float value){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_74___getAlpha)
HXDLIN(  74)		return (value * this->_hx___worldAlpha);
            	}


HX_DEFINE_DYNAMIC_FUNC1(DisplayObjectRenderer_obj,_hx___getAlpha,return )

 ::openfl::geom::ColorTransform DisplayObjectRenderer_obj::_hx___getColorTransform( ::openfl::geom::ColorTransform value){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_79___getColorTransform)
HXDLIN(  79)		if (::hx::IsNotNull( this->_hx___worldColorTransform )) {
HXLINE(  81)			this->_hx___tempColorTransform->_hx___copyFrom(this->_hx___worldColorTransform);
HXLINE(  82)			this->_hx___tempColorTransform->_hx___combine(value);
HXLINE(  83)			return this->_hx___tempColorTransform;
            		}
            		else {
HXLINE(  87)			return value;
            		}
HXLINE(  79)		return null();
            	}


HX_DEFINE_DYNAMIC_FUNC1(DisplayObjectRenderer_obj,_hx___getColorTransform,return )

void DisplayObjectRenderer_obj::_hx___popMask(){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_91___popMask)
            	}


HX_DEFINE_DYNAMIC_FUNC0(DisplayObjectRenderer_obj,_hx___popMask,(void))

void DisplayObjectRenderer_obj::_hx___popMaskObject( ::openfl::display::DisplayObject object,::hx::Null< bool >  __o_handleScrollRect){
            		bool handleScrollRect = __o_handleScrollRect.Default(true);
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_93___popMaskObject)
            	}


HX_DEFINE_DYNAMIC_FUNC2(DisplayObjectRenderer_obj,_hx___popMaskObject,(void))

void DisplayObjectRenderer_obj::_hx___popMaskRect(){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_95___popMaskRect)
            	}


HX_DEFINE_DYNAMIC_FUNC0(DisplayObjectRenderer_obj,_hx___popMaskRect,(void))

void DisplayObjectRenderer_obj::_hx___pushMask( ::openfl::display::DisplayObject mask){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_97___pushMask)
            	}


HX_DEFINE_DYNAMIC_FUNC1(DisplayObjectRenderer_obj,_hx___pushMask,(void))

void DisplayObjectRenderer_obj::_hx___pushMaskObject( ::openfl::display::DisplayObject object,::hx::Null< bool >  __o_handleScrollRect){
            		bool handleScrollRect = __o_handleScrollRect.Default(true);
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_99___pushMaskObject)
            	}


HX_DEFINE_DYNAMIC_FUNC2(DisplayObjectRenderer_obj,_hx___pushMaskObject,(void))

void DisplayObjectRenderer_obj::_hx___pushMaskRect( ::openfl::geom::Rectangle rect, ::openfl::geom::Matrix transform){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_101___pushMaskRect)
            	}


HX_DEFINE_DYNAMIC_FUNC2(DisplayObjectRenderer_obj,_hx___pushMaskRect,(void))

void DisplayObjectRenderer_obj::_hx___render(::Dynamic object){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_103___render)
            	}


HX_DEFINE_DYNAMIC_FUNC1(DisplayObjectRenderer_obj,_hx___render,(void))

void DisplayObjectRenderer_obj::_hx___renderEvent( ::openfl::display::DisplayObject displayObject){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_106___renderEvent)
HXLINE( 107)		 ::openfl::display::DisplayObjectRenderer renderer = ::hx::ObjectPtr<OBJ_>(this);
HXLINE( 109)		bool _hx_tmp;
HXDLIN( 109)		if (::hx::IsNotNull( displayObject->_hx___customRenderEvent )) {
HXLINE( 109)			_hx_tmp = displayObject->_hx___renderable;
            		}
            		else {
HXLINE( 109)			_hx_tmp = false;
            		}
HXDLIN( 109)		if (_hx_tmp) {
HXLINE( 111)			displayObject->_hx___customRenderEvent->allowSmoothing = renderer->_hx___allowSmoothing;
HXLINE( 112)			displayObject->_hx___customRenderEvent->objectMatrix->copyFrom(displayObject->_hx___renderTransform);
HXLINE( 113)			displayObject->_hx___customRenderEvent->objectColorTransform->_hx___copyFrom(displayObject->_hx___worldColorTransform);
HXLINE( 114)			displayObject->_hx___customRenderEvent->renderer = renderer;
HXLINE( 116)			::String _hx_switch_0 = renderer->_hx___type;
            			if (  (_hx_switch_0==HX_("cairo",88,30,19,41)) ){
HXLINE( 128)				displayObject->_hx___customRenderEvent->type = HX_("renderCairo",52,5d,ca,0c);
HXDLIN( 128)				goto _hx_goto_11;
            			}
            			if (  (_hx_switch_0==HX_("canvas",d8,54,42,b8)) ){
HXLINE( 141)				displayObject->_hx___customRenderEvent->type = HX_("renderCanvas",ce,58,98,27);
HXDLIN( 141)				goto _hx_goto_11;
            			}
            			if (  (_hx_switch_0==HX_("dom",82,42,4c,00)) ){
HXLINE( 131)				bool _hx_tmp;
HXDLIN( 131)				if (::hx::IsNotNull( displayObject->stage )) {
HXLINE( 131)					_hx_tmp = displayObject->_hx___worldVisible;
            				}
            				else {
HXLINE( 131)					_hx_tmp = false;
            				}
HXDLIN( 131)				if (_hx_tmp) {
HXLINE( 133)					displayObject->_hx___customRenderEvent->type = HX_("renderDOM",cc,ac,57,cd);
            				}
            				else {
HXLINE( 137)					displayObject->_hx___customRenderEvent->type = HX_("clearDOM",f5,22,08,31);
            				}
HXLINE( 131)				goto _hx_goto_11;
            			}
            			if (  (_hx_switch_0==HX_("opengl",6f,64,94,21)) ){
HXLINE( 119)				if (!(renderer->_hx___cleared)) {
HXLINE( 119)					renderer->_hx___clear();
            				}
HXLINE( 121)				 ::openfl::display::OpenGLRenderer renderer1 = ( ( ::openfl::display::OpenGLRenderer)(renderer) );
HXLINE( 122)				renderer1->setShader(displayObject->_hx___worldShader);
HXLINE( 123)				renderer1->_hx___context3D->_hx___flushGL();
HXLINE( 125)				displayObject->_hx___customRenderEvent->type = HX_("renderOpenGL",65,4c,ea,90);
HXLINE( 118)				goto _hx_goto_11;
            			}
            			/* default */{
HXLINE( 144)				return;
            			}
            			_hx_goto_11:;
HXLINE( 147)			renderer->_hx___setBlendMode(displayObject->_hx___worldBlendMode);
HXLINE( 148)			renderer->_hx___pushMaskObject(displayObject,null());
HXLINE( 150)			displayObject->dispatchEvent(displayObject->_hx___customRenderEvent);
HXLINE( 152)			renderer->_hx___popMaskObject(displayObject,null());
HXLINE( 154)			if ((renderer->_hx___type == HX_("opengl",6f,64,94,21))) {
HXLINE( 156)				 ::openfl::display::OpenGLRenderer renderer1 = ( ( ::openfl::display::OpenGLRenderer)(renderer) );
HXLINE( 157)				renderer1->setViewport();
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(DisplayObjectRenderer_obj,_hx___renderEvent,(void))

void DisplayObjectRenderer_obj::_hx___resize(int width,int height){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_163___resize)
            	}


HX_DEFINE_DYNAMIC_FUNC2(DisplayObjectRenderer_obj,_hx___resize,(void))

void DisplayObjectRenderer_obj::_hx___setBlendMode( ::Dynamic value){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_165___setBlendMode)
            	}


HX_DEFINE_DYNAMIC_FUNC1(DisplayObjectRenderer_obj,_hx___setBlendMode,(void))

 ::Dynamic DisplayObjectRenderer_obj::_hx___shouldCacheHardware( ::openfl::display::DisplayObject displayObject, ::Dynamic value){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_168___shouldCacheHardware)
HXLINE( 169)		if (::hx::IsNull( displayObject )) {
HXLINE( 169)			return null();
            		}
HXLINE( 171)		switch((int)(displayObject->_hx___drawableType)){
            			case (int)4: case (int)5: {
HXLINE( 174)				if (::hx::IsEq( value,true )) {
HXLINE( 174)					return true;
            				}
HXLINE( 175)				value = this->_hx___shouldCacheHardware_DisplayObject(displayObject,value);
HXLINE( 176)				if (::hx::IsEq( value,true )) {
HXLINE( 176)					return true;
            				}
HXLINE( 178)				if (::hx::IsNotNull( displayObject->_hx___children )) {
HXLINE( 180)					int _g = 0;
HXDLIN( 180)					::Array< ::Dynamic> _g1 = displayObject->_hx___children;
HXDLIN( 180)					while((_g < _g1->length)){
HXLINE( 180)						 ::openfl::display::DisplayObject child = _g1->__get(_g).StaticCast<  ::openfl::display::DisplayObject >();
HXDLIN( 180)						_g = (_g + 1);
HXLINE( 182)						value = this->_hx___shouldCacheHardware_DisplayObject(child,value);
HXLINE( 183)						if (::hx::IsEq( value,true )) {
HXLINE( 183)							return true;
            						}
            					}
            				}
HXLINE( 187)				return value;
            			}
            			break;
            			case (int)7: {
HXLINE( 190)				if (::hx::IsEq( value,true )) {
HXLINE( 190)					return true;
            				}
            				else {
HXLINE( 190)					return false;
            				}
            			}
            			break;
            			case (int)9: {
HXLINE( 193)				return true;
            			}
            			break;
            			default:{
HXLINE( 196)				return this->_hx___shouldCacheHardware_DisplayObject(displayObject,value);
            			}
            		}
HXLINE( 171)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC2(DisplayObjectRenderer_obj,_hx___shouldCacheHardware,return )

 ::Dynamic DisplayObjectRenderer_obj::_hx___shouldCacheHardware_DisplayObject( ::openfl::display::DisplayObject displayObject, ::Dynamic value){
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_201___shouldCacheHardware_DisplayObject)
HXLINE( 202)		bool _hx_tmp;
HXDLIN( 202)		if (::hx::IsNotEq( value,true )) {
HXLINE( 202)			_hx_tmp = ::hx::IsNotNull( displayObject->_hx___filters );
            		}
            		else {
HXLINE( 202)			_hx_tmp = true;
            		}
HXDLIN( 202)		if (_hx_tmp) {
HXLINE( 202)			return true;
            		}
HXLINE( 204)		bool _hx_tmp1;
HXDLIN( 204)		if (::hx::IsNotEq( value,false )) {
HXLINE( 204)			if (::hx::IsNotNull( displayObject->_hx___graphics )) {
HXLINE( 204)				_hx_tmp1 = !(::openfl::display::_internal::Context3DGraphics_obj::isCompatible(displayObject->_hx___graphics));
            			}
            			else {
HXLINE( 204)				_hx_tmp1 = false;
            			}
            		}
            		else {
HXLINE( 204)			_hx_tmp1 = true;
            		}
HXDLIN( 204)		if (_hx_tmp1) {
HXLINE( 206)			return false;
            		}
HXLINE( 209)		return null();
            	}


HX_DEFINE_DYNAMIC_FUNC2(DisplayObjectRenderer_obj,_hx___shouldCacheHardware_DisplayObject,return )

bool DisplayObjectRenderer_obj::_hx___updateCacheBitmap( ::openfl::display::DisplayObject displayObject,bool force){
            	HX_GC_STACKFRAME(&_hx_pos_5a81acb3bead7383_213___updateCacheBitmap)
HXLINE( 214)		if (::hx::IsNull( displayObject )) {
HXLINE( 214)			return false;
            		}
HXLINE( 215)		 ::openfl::display::DisplayObjectRenderer renderer = ::hx::ObjectPtr<OBJ_>(this);
HXLINE( 217)		switch((int)(displayObject->_hx___drawableType)){
            			case (int)2: {
HXLINE( 220)				 ::openfl::display::Bitmap bitmap = ( ( ::openfl::display::Bitmap)(displayObject) );
HXLINE( 222)				bool _hx_tmp;
HXDLIN( 222)				if (::hx::IsNotNull( bitmap->_hx___bitmapData )) {
HXLINE( 223)					bool _hx_tmp1;
HXDLIN( 223)					if (::hx::IsNull( bitmap->_hx___filters )) {
HXLINE( 223)						_hx_tmp1 = (renderer->_hx___type == HX_("opengl",6f,64,94,21));
            					}
            					else {
HXLINE( 223)						_hx_tmp1 = false;
            					}
HXDLIN( 223)					if (_hx_tmp1) {
HXLINE( 222)						_hx_tmp = ::hx::IsNull( bitmap->_hx___cacheBitmap );
            					}
            					else {
HXLINE( 222)						_hx_tmp = false;
            					}
            				}
            				else {
HXLINE( 222)					_hx_tmp = true;
            				}
HXDLIN( 222)				if (_hx_tmp) {
HXLINE( 223)					return false;
            				}
HXLINE( 224)				if (::hx::IsNotNull( bitmap->_hx___bitmapData->image )) {
HXLINE( 224)					force = (bitmap->_hx___bitmapData->image->version != bitmap->_hx___imageVersion);
            				}
            				else {
HXLINE( 224)					force = false;
            				}
            			}
            			break;
            			case (int)7: {
HXLINE( 227)				 ::openfl::text::TextField textField = ( ( ::openfl::text::TextField)(displayObject) );
HXLINE( 228)				bool _hx_tmp;
HXDLIN( 228)				bool _hx_tmp1;
HXDLIN( 228)				bool _hx_tmp2;
HXDLIN( 228)				if (::hx::IsNull( textField->_hx___filters )) {
HXLINE( 228)					_hx_tmp2 = (renderer->_hx___type == HX_("opengl",6f,64,94,21));
            				}
            				else {
HXLINE( 228)					_hx_tmp2 = false;
            				}
HXDLIN( 228)				if (_hx_tmp2) {
HXLINE( 228)					_hx_tmp1 = ::hx::IsNull( textField->_hx___cacheBitmap );
            				}
            				else {
HXLINE( 228)					_hx_tmp1 = false;
            				}
HXDLIN( 228)				if (_hx_tmp1) {
HXLINE( 228)					_hx_tmp = !(textField->_hx___domRender);
            				}
            				else {
HXLINE( 228)					_hx_tmp = false;
            				}
HXDLIN( 228)				if (_hx_tmp) {
HXLINE( 229)					return false;
            				}
HXLINE( 230)				if (force) {
HXLINE( 230)					textField->_hx___renderDirty = true;
            				}
HXLINE( 231)				if (!(force)) {
HXLINE( 231)					force = textField->_hx___dirty;
            				}
            				else {
HXLINE( 231)					force = true;
            				}
            			}
            			break;
            			case (int)9: {
HXLINE( 234)				 ::openfl::display::Tilemap tilemap = ( ( ::openfl::display::Tilemap)(displayObject) );
HXLINE( 235)				bool _hx_tmp;
HXDLIN( 235)				bool _hx_tmp1;
HXDLIN( 235)				if (::hx::IsNull( tilemap->_hx___filters )) {
HXLINE( 235)					_hx_tmp1 = (renderer->_hx___type == HX_("opengl",6f,64,94,21));
            				}
            				else {
HXLINE( 235)					_hx_tmp1 = false;
            				}
HXDLIN( 235)				if (_hx_tmp1) {
HXLINE( 235)					_hx_tmp = ::hx::IsNull( tilemap->_hx___cacheBitmap );
            				}
            				else {
HXLINE( 235)					_hx_tmp = false;
            				}
HXDLIN( 235)				if (_hx_tmp) {
HXLINE( 235)					return false;
            				}
            			}
            			break;
            			default:{
            			}
            		}
HXLINE( 241)		if (displayObject->_hx___isCacheBitmapRender) {
HXLINE( 241)			return false;
            		}
HXLINE( 246)		 ::openfl::geom::ColorTransform colorTransform = ::openfl::geom::ColorTransform_obj::_hx___pool->get().StaticCast<  ::openfl::geom::ColorTransform >();
HXLINE( 247)		colorTransform->_hx___copyFrom(displayObject->_hx___worldColorTransform);
HXLINE( 248)		if (::hx::IsNotNull( renderer->_hx___worldColorTransform )) {
HXLINE( 248)			colorTransform->_hx___combine(renderer->_hx___worldColorTransform);
            		}
HXLINE( 249)		bool updated = false;
HXLINE( 252)		bool _hx_tmp;
HXDLIN( 252)		bool _hx_tmp1;
HXDLIN( 252)		if (!(displayObject->get_cacheAsBitmap())) {
HXLINE( 253)			if ((renderer->_hx___type != HX_("opengl",6f,64,94,21))) {
HXLINE( 252)				_hx_tmp1 = !(colorTransform->_hx___isDefault(true));
            			}
            			else {
HXLINE( 252)				_hx_tmp1 = false;
            			}
            		}
            		else {
HXLINE( 252)			_hx_tmp1 = true;
            		}
HXDLIN( 252)		if (!(_hx_tmp1)) {
HXLINE( 254)			if ((renderer->_hx___type == HX_("opengl",6f,64,94,21))) {
HXLINE( 252)				_hx_tmp = ::hx::IsNotNull( displayObject->get_scale9Grid() );
            			}
            			else {
HXLINE( 252)				_hx_tmp = false;
            			}
            		}
            		else {
HXLINE( 252)			_hx_tmp = true;
            		}
HXDLIN( 252)		if (_hx_tmp) {
HXLINE( 256)			 ::openfl::geom::Rectangle rect = null();
HXLINE( 258)			bool needRender;
HXDLIN( 258)			bool needRender1;
HXDLIN( 258)			if (::hx::IsNotNull( displayObject->_hx___cacheBitmap )) {
HXLINE( 259)				if (displayObject->_hx___renderDirty) {
HXLINE( 259)					if (!(force)) {
HXLINE( 259)						if (::hx::IsNotNull( displayObject->_hx___children )) {
HXLINE( 258)							needRender1 = (displayObject->_hx___children->length > 0);
            						}
            						else {
HXLINE( 258)							needRender1 = false;
            						}
            					}
            					else {
HXLINE( 258)						needRender1 = true;
            					}
            				}
            				else {
HXLINE( 258)					needRender1 = false;
            				}
            			}
            			else {
HXLINE( 258)				needRender1 = true;
            			}
HXDLIN( 258)			if (!(needRender1)) {
HXLINE( 258)				needRender = ::hx::IsNotEq( displayObject->opaqueBackground,displayObject->_hx___cacheBitmapBackground );
            			}
            			else {
HXLINE( 258)				needRender = true;
            			}
HXLINE( 261)			bool softwareDirty;
HXDLIN( 261)			bool softwareDirty1;
HXDLIN( 261)			if (!(needRender)) {
HXLINE( 262)				if (::hx::IsNotNull( displayObject->_hx___graphics )) {
HXLINE( 261)					softwareDirty1 = displayObject->_hx___graphics->_hx___softwareDirty;
            				}
            				else {
HXLINE( 261)					softwareDirty1 = false;
            				}
            			}
            			else {
HXLINE( 261)				softwareDirty1 = true;
            			}
HXDLIN( 261)			if (!(softwareDirty1)) {
HXLINE( 261)				softwareDirty = !(displayObject->_hx___cacheBitmapColorTransform->_hx___equals(colorTransform,true));
            			}
            			else {
HXLINE( 261)				softwareDirty = true;
            			}
HXLINE( 264)			bool hardwareDirty;
HXDLIN( 264)			if (!(needRender)) {
HXLINE( 264)				if (::hx::IsNotNull( displayObject->_hx___graphics )) {
HXLINE( 264)					hardwareDirty = displayObject->_hx___graphics->_hx___hardwareDirty;
            				}
            				else {
HXLINE( 264)					hardwareDirty = false;
            				}
            			}
            			else {
HXLINE( 264)				hardwareDirty = true;
            			}
HXLINE( 266)			::String renderType = renderer->_hx___type;
HXLINE( 268)			bool _hx_tmp;
HXDLIN( 268)			if (!(softwareDirty)) {
HXLINE( 268)				_hx_tmp = hardwareDirty;
            			}
            			else {
HXLINE( 268)				_hx_tmp = true;
            			}
HXDLIN( 268)			if (_hx_tmp) {
HXLINE( 271)				if ((renderType == HX_("opengl",6f,64,94,21))) {
HXLINE( 273)					if (::hx::IsEq( this->_hx___shouldCacheHardware(displayObject,null()),false )) {
HXLINE( 278)						renderType = HX_("cairo",88,30,19,41);
            					}
            				}
HXLINE( 284)				bool _hx_tmp;
HXDLIN( 284)				if (softwareDirty) {
HXLINE( 284)					if ((renderType != HX_("canvas",d8,54,42,b8))) {
HXLINE( 284)						_hx_tmp = (renderType == HX_("cairo",88,30,19,41));
            					}
            					else {
HXLINE( 284)						_hx_tmp = true;
            					}
            				}
            				else {
HXLINE( 284)					_hx_tmp = false;
            				}
HXDLIN( 284)				if (_hx_tmp) {
HXLINE( 284)					needRender = true;
            				}
HXLINE( 285)				bool _hx_tmp1;
HXDLIN( 285)				if (hardwareDirty) {
HXLINE( 285)					_hx_tmp1 = (renderType == HX_("opengl",6f,64,94,21));
            				}
            				else {
HXLINE( 285)					_hx_tmp1 = false;
            				}
HXDLIN( 285)				if (_hx_tmp1) {
HXLINE( 285)					needRender = true;
            				}
            			}
HXLINE( 288)			bool updateTransform;
HXDLIN( 288)			if (!(needRender)) {
HXLINE( 288)				updateTransform = !(displayObject->_hx___cacheBitmap->_hx___worldTransform->equals(displayObject->_hx___worldTransform));
            			}
            			else {
HXLINE( 288)				updateTransform = true;
            			}
HXLINE( 289)			bool hasFilters = ::hx::IsNotNull( displayObject->_hx___filters );
HXLINE( 292)			bool _hx_tmp1;
HXDLIN( 292)			if ((renderer->_hx___type == HX_("dom",82,42,4c,00))) {
HXLINE( 292)				_hx_tmp1 = !(hasFilters);
            			}
            			else {
HXLINE( 292)				_hx_tmp1 = false;
            			}
HXDLIN( 292)			if (_hx_tmp1) {
HXLINE( 294)				return false;
            			}
HXLINE( 298)			bool _hx_tmp2;
HXDLIN( 298)			if (hasFilters) {
HXLINE( 298)				_hx_tmp2 = !(needRender);
            			}
            			else {
HXLINE( 298)				_hx_tmp2 = false;
            			}
HXDLIN( 298)			if (_hx_tmp2) {
HXLINE( 300)				int _g = 0;
HXDLIN( 300)				::Array< ::Dynamic> _g1 = displayObject->_hx___filters;
HXDLIN( 300)				while((_g < _g1->length)){
HXLINE( 300)					 ::openfl::filters::BitmapFilter filter = _g1->__get(_g).StaticCast<  ::openfl::filters::BitmapFilter >();
HXDLIN( 300)					_g = (_g + 1);
HXLINE( 302)					if (filter->_hx___renderDirty) {
HXLINE( 304)						needRender = true;
HXLINE( 305)						goto _hx_goto_18;
            					}
            				}
            				_hx_goto_18:;
            			}
HXLINE( 310)			if (::hx::IsNull( displayObject->_hx___cacheBitmapMatrix )) {
HXLINE( 312)				displayObject->_hx___cacheBitmapMatrix =  ::openfl::geom::Matrix_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            			}
HXLINE( 315)			 ::openfl::geom::Matrix bitmapMatrix;
HXDLIN( 315)			if (::hx::IsNotNull( displayObject->_hx___cacheAsBitmapMatrix )) {
HXLINE( 315)				bitmapMatrix = displayObject->_hx___cacheAsBitmapMatrix;
            			}
            			else {
HXLINE( 315)				bitmapMatrix = displayObject->_hx___renderTransform;
            			}
HXLINE( 317)			bool _hx_tmp3;
HXDLIN( 317)			if (!(needRender)) {
HXLINE( 318)				bool _hx_tmp;
HXDLIN( 318)				bool _hx_tmp1;
HXDLIN( 318)				if ((bitmapMatrix->a == displayObject->_hx___cacheBitmapMatrix->a)) {
HXLINE( 318)					_hx_tmp1 = (bitmapMatrix->b != displayObject->_hx___cacheBitmapMatrix->b);
            				}
            				else {
HXLINE( 318)					_hx_tmp1 = true;
            				}
HXDLIN( 318)				if (!(_hx_tmp1)) {
HXLINE( 318)					_hx_tmp = (bitmapMatrix->c != displayObject->_hx___cacheBitmapMatrix->c);
            				}
            				else {
HXLINE( 318)					_hx_tmp = true;
            				}
HXDLIN( 318)				if (!(_hx_tmp)) {
HXLINE( 317)					_hx_tmp3 = (bitmapMatrix->d != displayObject->_hx___cacheBitmapMatrix->d);
            				}
            				else {
HXLINE( 317)					_hx_tmp3 = true;
            				}
            			}
            			else {
HXLINE( 317)				_hx_tmp3 = false;
            			}
HXDLIN( 317)			if (_hx_tmp3) {
HXLINE( 323)				needRender = true;
            			}
HXLINE( 326)			bool _hx_tmp4;
HXDLIN( 326)			bool _hx_tmp5;
HXDLIN( 326)			bool _hx_tmp6;
HXDLIN( 326)			bool _hx_tmp7;
HXDLIN( 326)			if (!(needRender)) {
HXLINE( 326)				_hx_tmp7 = (renderer->_hx___type != HX_("opengl",6f,64,94,21));
            			}
            			else {
HXLINE( 326)				_hx_tmp7 = false;
            			}
HXDLIN( 326)			if (_hx_tmp7) {
HXLINE( 326)				_hx_tmp6 = ::hx::IsNotNull( displayObject->_hx___cacheBitmapData );
            			}
            			else {
HXLINE( 326)				_hx_tmp6 = false;
            			}
HXDLIN( 326)			if (_hx_tmp6) {
HXLINE( 326)				_hx_tmp5 = ::hx::IsNotNull( displayObject->_hx___cacheBitmapData->image );
            			}
            			else {
HXLINE( 326)				_hx_tmp5 = false;
            			}
HXDLIN( 326)			if (_hx_tmp5) {
HXLINE( 326)				_hx_tmp4 = (displayObject->_hx___cacheBitmapData->image->version < displayObject->_hx___cacheBitmapData->_hx___textureVersion);
            			}
            			else {
HXLINE( 326)				_hx_tmp4 = false;
            			}
HXDLIN( 326)			if (_hx_tmp4) {
HXLINE( 332)				needRender = true;
            			}
HXLINE( 336)			if (!(needRender)) {
HXLINE( 338)				 ::openfl::display::DisplayObject current = displayObject;
HXLINE( 339)				while(::hx::IsNotNull( current )){
HXLINE( 341)					if (::hx::IsNotNull( current->get_scrollRect() )) {
HXLINE( 344)						updateTransform = true;
HXLINE( 345)						goto _hx_goto_19;
            					}
HXLINE( 347)					current = current->parent;
            				}
            				_hx_goto_19:;
            			}
HXLINE( 351)			displayObject->_hx___cacheBitmapMatrix->copyFrom(bitmapMatrix);
HXLINE( 352)			displayObject->_hx___cacheBitmapMatrix->tx = ( (Float)(0) );
HXLINE( 353)			displayObject->_hx___cacheBitmapMatrix->ty = ( (Float)(0) );
HXLINE( 357)			int bitmapWidth = 0;
HXDLIN( 357)			int bitmapHeight = 0;
HXLINE( 358)			int filterWidth = 0;
HXDLIN( 358)			int filterHeight = 0;
HXLINE( 359)			Float offsetX = ((Float)0.);
HXDLIN( 359)			Float offsetY = ((Float)0.);
HXLINE( 364)			Float pixelRatio = this->_hx___pixelRatio;
HXLINE( 367)			bool _hx_tmp8;
HXDLIN( 367)			if (!(updateTransform)) {
HXLINE( 367)				_hx_tmp8 = needRender;
            			}
            			else {
HXLINE( 367)				_hx_tmp8 = true;
            			}
HXDLIN( 367)			if (_hx_tmp8) {
HXLINE( 369)				rect = ::openfl::geom::Rectangle_obj::_hx___pool->get().StaticCast<  ::openfl::geom::Rectangle >();
HXLINE( 371)				displayObject->_hx___getFilterBounds(rect,displayObject->_hx___cacheBitmapMatrix);
HXLINE( 373)				if ((rect->width > 0)) {
HXLINE( 373)					filterWidth = ::Math_obj::ceil(((rect->width + 1) * pixelRatio));
            				}
            				else {
HXLINE( 373)					filterWidth = 0;
            				}
HXLINE( 374)				if ((rect->height > 0)) {
HXLINE( 374)					filterHeight = ::Math_obj::ceil(((rect->height + 1) * pixelRatio));
            				}
            				else {
HXLINE( 374)					filterHeight = 0;
            				}
HXLINE( 376)				if ((rect->x > 0)) {
HXLINE( 376)					offsetX = ( (Float)(::Math_obj::ceil(rect->x)) );
            				}
            				else {
HXLINE( 376)					offsetX = ( (Float)(::Math_obj::floor(rect->x)) );
            				}
HXLINE( 377)				if ((rect->y > 0)) {
HXLINE( 377)					offsetY = ( (Float)(::Math_obj::ceil(rect->y)) );
            				}
            				else {
HXLINE( 377)					offsetY = ( (Float)(::Math_obj::floor(rect->y)) );
            				}
HXLINE( 379)				if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData )) {
HXLINE( 381)					bool _hx_tmp;
HXDLIN( 381)					if ((filterWidth <= displayObject->_hx___cacheBitmapData->width)) {
HXLINE( 381)						_hx_tmp = (filterHeight > displayObject->_hx___cacheBitmapData->height);
            					}
            					else {
HXLINE( 381)						_hx_tmp = true;
            					}
HXDLIN( 381)					if (_hx_tmp) {
HXLINE( 383)						bitmapWidth = ::Math_obj::ceil(::Math_obj::max((( (Float)(filterWidth) ) * ((Float)1.25)),( (Float)(displayObject->_hx___cacheBitmapData->width) )));
HXLINE( 384)						bitmapHeight = ::Math_obj::ceil(::Math_obj::max((( (Float)(filterHeight) ) * ((Float)1.25)),( (Float)(displayObject->_hx___cacheBitmapData->height) )));
HXLINE( 385)						needRender = true;
            					}
            					else {
HXLINE( 389)						bitmapWidth = displayObject->_hx___cacheBitmapData->width;
HXLINE( 390)						bitmapHeight = displayObject->_hx___cacheBitmapData->height;
            					}
            				}
            				else {
HXLINE( 395)					bitmapWidth = filterWidth;
HXLINE( 396)					bitmapHeight = filterHeight;
            				}
            			}
HXLINE( 400)			if (needRender) {
HXLINE( 402)				updateTransform = true;
HXLINE( 403)				displayObject->_hx___cacheBitmapBackground = displayObject->opaqueBackground;
HXLINE( 405)				bool _hx_tmp;
HXDLIN( 405)				if ((filterWidth >= ((Float)0.5))) {
HXLINE( 405)					_hx_tmp = (filterHeight >= ((Float)0.5));
            				}
            				else {
HXLINE( 405)					_hx_tmp = false;
            				}
HXDLIN( 405)				if (_hx_tmp) {
HXLINE( 407)					bool needsFill;
HXDLIN( 407)					if (::hx::IsNotNull( displayObject->opaqueBackground )) {
HXLINE( 408)						if ((bitmapWidth == filterWidth)) {
HXLINE( 407)							needsFill = (bitmapHeight != filterHeight);
            						}
            						else {
HXLINE( 407)							needsFill = true;
            						}
            					}
            					else {
HXLINE( 407)						needsFill = false;
            					}
HXLINE( 409)					int fillColor;
HXDLIN( 409)					if (::hx::IsNotNull( displayObject->opaqueBackground )) {
HXLINE( 409)						fillColor = (-16777216 | ( (int)(displayObject->opaqueBackground) ));
            					}
            					else {
HXLINE( 409)						fillColor = 0;
            					}
HXLINE( 410)					int bitmapColor;
HXDLIN( 410)					if (needsFill) {
HXLINE( 410)						bitmapColor = 0;
            					}
            					else {
HXLINE( 410)						bitmapColor = fillColor;
            					}
HXLINE( 411)					bool allowFramebuffer = (renderer->_hx___type == HX_("opengl",6f,64,94,21));
HXLINE( 413)					bool _hx_tmp;
HXDLIN( 413)					bool _hx_tmp1;
HXDLIN( 413)					if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData )) {
HXLINE( 413)						_hx_tmp1 = (bitmapWidth > displayObject->_hx___cacheBitmapData->width);
            					}
            					else {
HXLINE( 413)						_hx_tmp1 = true;
            					}
HXDLIN( 413)					if (!(_hx_tmp1)) {
HXLINE( 413)						_hx_tmp = (bitmapHeight > displayObject->_hx___cacheBitmapData->height);
            					}
            					else {
HXLINE( 413)						_hx_tmp = true;
            					}
HXDLIN( 413)					if (_hx_tmp) {
HXLINE( 417)						displayObject->_hx___cacheBitmapData =  ::openfl::display::BitmapData_obj::__alloc( HX_CTX ,bitmapWidth,bitmapHeight,true,bitmapColor);
HXLINE( 419)						if (::hx::IsNull( displayObject->_hx___cacheBitmap )) {
HXLINE( 419)							displayObject->_hx___cacheBitmap =  ::openfl::display::Bitmap_obj::__alloc( HX_CTX ,null(),null(),null());
            						}
HXLINE( 420)						displayObject->_hx___cacheBitmap->_hx___bitmapData = displayObject->_hx___cacheBitmapData;
HXLINE( 421)						displayObject->_hx___cacheBitmapRenderer = null();
            					}
            					else {
HXLINE( 425)						displayObject->_hx___cacheBitmapData->_hx___fillRect(displayObject->_hx___cacheBitmapData->rect,bitmapColor,allowFramebuffer);
            					}
HXLINE( 428)					if (needsFill) {
HXLINE( 430)						rect->setTo(( (Float)(0) ),( (Float)(0) ),( (Float)(filterWidth) ),( (Float)(filterHeight) ));
HXLINE( 431)						displayObject->_hx___cacheBitmapData->_hx___fillRect(rect,fillColor,allowFramebuffer);
            					}
            				}
            				else {
HXLINE( 436)					::openfl::geom::ColorTransform_obj::_hx___pool->release(colorTransform);
HXLINE( 438)					displayObject->_hx___cacheBitmap = null();
HXLINE( 439)					displayObject->_hx___cacheBitmapData = null();
HXLINE( 440)					displayObject->_hx___cacheBitmapData2 = null();
HXLINE( 441)					displayObject->_hx___cacheBitmapData3 = null();
HXLINE( 442)					displayObject->_hx___cacheBitmapRenderer = null();
HXLINE( 444)					if ((displayObject->_hx___drawableType == 7)) {
HXLINE( 446)						 ::openfl::text::TextField textField = ( ( ::openfl::text::TextField)(displayObject) );
HXLINE( 447)						if (::hx::IsNotNull( textField->_hx___cacheBitmap )) {
HXLINE( 449)							 ::openfl::geom::Matrix fh = textField->_hx___cacheBitmap->_hx___renderTransform;
HXDLIN( 449)							fh->tx = (fh->tx - (textField->_hx___offsetX * pixelRatio));
HXLINE( 450)							 ::openfl::geom::Matrix fh1 = textField->_hx___cacheBitmap->_hx___renderTransform;
HXDLIN( 450)							fh1->ty = (fh1->ty - (textField->_hx___offsetY * pixelRatio));
            						}
            					}
HXLINE( 454)					return true;
            				}
            			}
            			else {
HXLINE( 461)				displayObject->_hx___cacheBitmapData = displayObject->_hx___cacheBitmap->get_bitmapData();
HXLINE( 462)				displayObject->_hx___cacheBitmapData2 = null();
HXLINE( 463)				displayObject->_hx___cacheBitmapData3 = null();
            			}
HXLINE( 466)			bool _hx_tmp9;
HXDLIN( 466)			if (!(updateTransform)) {
HXLINE( 466)				_hx_tmp9 = needRender;
            			}
            			else {
HXLINE( 466)				_hx_tmp9 = true;
            			}
HXDLIN( 466)			if (_hx_tmp9) {
HXLINE( 468)				displayObject->_hx___cacheBitmap->_hx___worldTransform->copyFrom(displayObject->_hx___worldTransform);
HXLINE( 470)				if (::hx::IsInstanceEq( bitmapMatrix,displayObject->_hx___renderTransform )) {
HXLINE( 472)					displayObject->_hx___cacheBitmap->_hx___renderTransform->identity();
HXLINE( 473)					displayObject->_hx___cacheBitmap->_hx___renderTransform->scale((( (Float)(1) ) / pixelRatio),(( (Float)(1) ) / pixelRatio));
HXLINE( 474)					displayObject->_hx___cacheBitmap->_hx___renderTransform->tx = (displayObject->_hx___renderTransform->tx + offsetX);
HXLINE( 475)					displayObject->_hx___cacheBitmap->_hx___renderTransform->ty = (displayObject->_hx___renderTransform->ty + offsetY);
            				}
            				else {
HXLINE( 479)					displayObject->_hx___cacheBitmap->_hx___renderTransform->copyFrom(displayObject->_hx___cacheBitmapMatrix);
HXLINE( 480)					displayObject->_hx___cacheBitmap->_hx___renderTransform->invert();
HXLINE( 481)					displayObject->_hx___cacheBitmap->_hx___renderTransform->concat(displayObject->_hx___renderTransform);
HXLINE( 482)					 ::openfl::geom::Matrix fh = displayObject->_hx___cacheBitmap->_hx___renderTransform;
HXDLIN( 482)					fh->a = (fh->a * (( (Float)(1) ) / pixelRatio));
HXLINE( 483)					 ::openfl::geom::Matrix fh1 = displayObject->_hx___cacheBitmap->_hx___renderTransform;
HXDLIN( 483)					fh1->d = (fh1->d * (( (Float)(1) ) / pixelRatio));
HXLINE( 484)					 ::openfl::geom::Matrix fh2 = displayObject->_hx___cacheBitmap->_hx___renderTransform;
HXDLIN( 484)					fh2->tx = (fh2->tx + offsetX);
HXLINE( 485)					 ::openfl::geom::Matrix fh3 = displayObject->_hx___cacheBitmap->_hx___renderTransform;
HXDLIN( 485)					fh3->ty = (fh3->ty + offsetY);
            				}
            			}
HXLINE( 489)			displayObject->_hx___cacheBitmap->smoothing = renderer->_hx___allowSmoothing;
HXLINE( 490)			displayObject->_hx___cacheBitmap->_hx___renderable = displayObject->_hx___renderable;
HXLINE( 491)			displayObject->_hx___cacheBitmap->_hx___worldAlpha = displayObject->_hx___worldAlpha;
HXLINE( 492)			displayObject->_hx___cacheBitmap->_hx___worldBlendMode = displayObject->_hx___worldBlendMode;
HXLINE( 493)			displayObject->_hx___cacheBitmap->_hx___worldShader = displayObject->_hx___worldShader;
HXLINE( 496)			displayObject->_hx___cacheBitmap->set_mask(displayObject->_hx___mask);
HXLINE( 498)			if (needRender) {
HXLINE( 501)				bool _hx_tmp;
HXDLIN( 501)				if (::hx::IsNotNull( displayObject->_hx___cacheBitmapRenderer )) {
HXLINE( 501)					_hx_tmp = (renderType != displayObject->_hx___cacheBitmapRenderer->_hx___type);
            				}
            				else {
HXLINE( 501)					_hx_tmp = true;
            				}
HXDLIN( 501)				if (_hx_tmp) {
HXLINE( 503)					if ((renderType == HX_("opengl",6f,64,94,21))) {
HXLINE( 505)						displayObject->_hx___cacheBitmapRenderer =  ::openfl::display::OpenGLRenderer_obj::__alloc( HX_CTX ,::hx::TCast<  ::openfl::display::OpenGLRenderer >::cast(renderer)->_hx___context3D,displayObject->_hx___cacheBitmapData);
            					}
            					else {
HXLINE( 509)						if (::hx::IsNull( displayObject->_hx___cacheBitmapData->image )) {
HXLINE( 511)							int color;
HXDLIN( 511)							if (::hx::IsNotNull( displayObject->opaqueBackground )) {
HXLINE( 511)								color = (-16777216 | ( (int)(displayObject->opaqueBackground) ));
            							}
            							else {
HXLINE( 511)								color = 0;
            							}
HXLINE( 512)							displayObject->_hx___cacheBitmapData =  ::openfl::display::BitmapData_obj::__alloc( HX_CTX ,bitmapWidth,bitmapHeight,true,color);
HXLINE( 513)							displayObject->_hx___cacheBitmap->_hx___bitmapData = displayObject->_hx___cacheBitmapData;
            						}
HXLINE( 520)						displayObject->_hx___cacheBitmapRenderer =  ::openfl::display::CairoRenderer_obj::__alloc( HX_CTX , ::lime::graphics::cairo::Cairo_obj::__alloc( HX_CTX ,displayObject->_hx___cacheBitmapData->getSurface()));
            					}
HXLINE( 524)					displayObject->_hx___cacheBitmapRenderer->_hx___worldTransform =  ::openfl::geom::Matrix_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
HXLINE( 525)					displayObject->_hx___cacheBitmapRenderer->_hx___worldColorTransform =  ::openfl::geom::ColorTransform_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null(),null(),null());
            				}
HXLINE( 531)				if (::hx::IsNull( displayObject->_hx___cacheBitmapColorTransform )) {
HXLINE( 531)					displayObject->_hx___cacheBitmapColorTransform =  ::openfl::geom::ColorTransform_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null(),null(),null());
            				}
HXLINE( 533)				displayObject->_hx___cacheBitmapRenderer->_hx___stage = displayObject->stage;
HXLINE( 535)				displayObject->_hx___cacheBitmapRenderer->_hx___allowSmoothing = renderer->_hx___allowSmoothing;
HXLINE( 536)				displayObject->_hx___cacheBitmapRenderer->_hx___setBlendMode(10);
HXLINE( 537)				displayObject->_hx___cacheBitmapRenderer->_hx___worldAlpha = (( (Float)(1) ) / displayObject->_hx___worldAlpha);
HXLINE( 539)				displayObject->_hx___cacheBitmapRenderer->_hx___worldTransform->copyFrom(displayObject->_hx___renderTransform);
HXLINE( 540)				displayObject->_hx___cacheBitmapRenderer->_hx___worldTransform->invert();
HXLINE( 541)				displayObject->_hx___cacheBitmapRenderer->_hx___worldTransform->concat(displayObject->_hx___cacheBitmapMatrix);
HXLINE( 542)				 ::openfl::geom::Matrix fh = displayObject->_hx___cacheBitmapRenderer->_hx___worldTransform;
HXDLIN( 542)				fh->tx = (fh->tx - offsetX);
HXLINE( 543)				 ::openfl::geom::Matrix fh1 = displayObject->_hx___cacheBitmapRenderer->_hx___worldTransform;
HXDLIN( 543)				fh1->ty = (fh1->ty - offsetY);
HXLINE( 544)				displayObject->_hx___cacheBitmapRenderer->_hx___worldTransform->scale(pixelRatio,pixelRatio);
HXLINE( 546)				displayObject->_hx___cacheBitmapRenderer->_hx___pixelRatio = pixelRatio;
HXLINE( 548)				displayObject->_hx___cacheBitmapRenderer->_hx___worldColorTransform->_hx___copyFrom(colorTransform);
HXLINE( 549)				displayObject->_hx___cacheBitmapRenderer->_hx___worldColorTransform->_hx___invert();
HXLINE( 551)				displayObject->_hx___isCacheBitmapRender = true;
HXLINE( 553)				if ((displayObject->_hx___cacheBitmapRenderer->_hx___type == HX_("opengl",6f,64,94,21))) {
HXLINE( 555)					 ::openfl::display::OpenGLRenderer parentRenderer = ( ( ::openfl::display::OpenGLRenderer)(renderer) );
HXLINE( 556)					 ::openfl::display::OpenGLRenderer childRenderer = ( ( ::openfl::display::OpenGLRenderer)(displayObject->_hx___cacheBitmapRenderer) );
HXLINE( 558)					 ::openfl::display3D::Context3D context = childRenderer->_hx___context3D;
HXLINE( 560)					 ::openfl::display3D::textures::TextureBase cacheRTT = context->_hx___state->renderToTexture;
HXLINE( 561)					bool cacheRTTDepthStencil = context->_hx___state->renderToTextureDepthStencil;
HXLINE( 562)					int cacheRTTAntiAlias = context->_hx___state->renderToTextureAntiAlias;
HXLINE( 563)					int cacheRTTSurfaceSelector = context->_hx___state->renderToTextureSurfaceSelector;
HXLINE( 567)					 ::Dynamic cacheBlendMode = parentRenderer->_hx___blendMode;
HXLINE( 568)					parentRenderer->_hx___suspendClipAndMask();
HXLINE( 569)					childRenderer->_hx___copyShader(parentRenderer);
HXLINE( 572)					displayObject->_hx___cacheBitmapData->_hx___setUVRect(context,( (Float)(0) ),( (Float)(0) ),( (Float)(filterWidth) ),( (Float)(filterHeight) ));
HXLINE( 573)					childRenderer->_hx___setRenderTarget(displayObject->_hx___cacheBitmapData);
HXLINE( 574)					if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData->image )) {
HXLINE( 575)						displayObject->_hx___cacheBitmapData->_hx___textureVersion = (displayObject->_hx___cacheBitmapData->image->version + 1);
            					}
HXLINE( 578)					displayObject->_hx___cacheBitmapData->_hx___drawGL(displayObject,childRenderer);
HXLINE( 580)					if (hasFilters) {
HXLINE( 582)						bool needSecondBitmapData = true;
HXLINE( 583)						bool needCopyOfOriginal = false;
HXLINE( 585)						{
HXLINE( 585)							int _g = 0;
HXDLIN( 585)							::Array< ::Dynamic> _g1 = displayObject->_hx___filters;
HXDLIN( 585)							while((_g < _g1->length)){
HXLINE( 585)								 ::openfl::filters::BitmapFilter filter = _g1->__get(_g).StaticCast<  ::openfl::filters::BitmapFilter >();
HXDLIN( 585)								_g = (_g + 1);
HXLINE( 590)								if (filter->_hx___preserveObject) {
HXLINE( 592)									needCopyOfOriginal = true;
            								}
            							}
            						}
HXLINE( 596)						 ::openfl::display::BitmapData bitmap = displayObject->_hx___cacheBitmapData;
HXLINE( 597)						 ::openfl::display::BitmapData bitmap2 = null();
HXLINE( 598)						 ::openfl::display::BitmapData bitmap3 = null();
HXLINE( 601)						bool _hx_tmp;
HXDLIN( 601)						bool _hx_tmp1;
HXDLIN( 601)						if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData2 )) {
HXLINE( 601)							_hx_tmp1 = (bitmapWidth > displayObject->_hx___cacheBitmapData2->width);
            						}
            						else {
HXLINE( 601)							_hx_tmp1 = true;
            						}
HXDLIN( 601)						if (!(_hx_tmp1)) {
HXLINE( 601)							_hx_tmp = (bitmapHeight > displayObject->_hx___cacheBitmapData2->height);
            						}
            						else {
HXLINE( 601)							_hx_tmp = true;
            						}
HXDLIN( 601)						if (_hx_tmp) {
HXLINE( 605)							displayObject->_hx___cacheBitmapData2 =  ::openfl::display::BitmapData_obj::__alloc( HX_CTX ,bitmapWidth,bitmapHeight,true,0);
            						}
            						else {
HXLINE( 609)							displayObject->_hx___cacheBitmapData2->fillRect(displayObject->_hx___cacheBitmapData2->rect,0);
HXLINE( 610)							if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData2->image )) {
HXLINE( 612)								displayObject->_hx___cacheBitmapData2->_hx___textureVersion = (displayObject->_hx___cacheBitmapData2->image->version + 1);
            							}
            						}
HXLINE( 615)						displayObject->_hx___cacheBitmapData2->_hx___setUVRect(context,( (Float)(0) ),( (Float)(0) ),( (Float)(filterWidth) ),( (Float)(filterHeight) ));
HXLINE( 616)						bitmap2 = displayObject->_hx___cacheBitmapData2;
HXLINE( 621)						if (needCopyOfOriginal) {
HXLINE( 623)							bool _hx_tmp;
HXDLIN( 623)							bool _hx_tmp1;
HXDLIN( 623)							if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData3 )) {
HXLINE( 623)								_hx_tmp1 = (bitmapWidth > displayObject->_hx___cacheBitmapData3->width);
            							}
            							else {
HXLINE( 623)								_hx_tmp1 = true;
            							}
HXDLIN( 623)							if (!(_hx_tmp1)) {
HXLINE( 623)								_hx_tmp = (bitmapHeight > displayObject->_hx___cacheBitmapData3->height);
            							}
            							else {
HXLINE( 623)								_hx_tmp = true;
            							}
HXDLIN( 623)							if (_hx_tmp) {
HXLINE( 627)								displayObject->_hx___cacheBitmapData3 =  ::openfl::display::BitmapData_obj::__alloc( HX_CTX ,bitmapWidth,bitmapHeight,true,0);
            							}
            							else {
HXLINE( 631)								displayObject->_hx___cacheBitmapData3->fillRect(displayObject->_hx___cacheBitmapData3->rect,0);
HXLINE( 632)								if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData3->image )) {
HXLINE( 634)									displayObject->_hx___cacheBitmapData3->_hx___textureVersion = (displayObject->_hx___cacheBitmapData3->image->version + 1);
            								}
            							}
HXLINE( 637)							displayObject->_hx___cacheBitmapData3->_hx___setUVRect(context,( (Float)(0) ),( (Float)(0) ),( (Float)(filterWidth) ),( (Float)(filterHeight) ));
HXLINE( 638)							bitmap3 = displayObject->_hx___cacheBitmapData3;
            						}
HXLINE( 641)						childRenderer->_hx___setBlendMode(10);
HXLINE( 642)						childRenderer->_hx___worldAlpha = ( (Float)(1) );
HXLINE( 643)						childRenderer->_hx___worldTransform->identity();
HXLINE( 644)						childRenderer->_hx___worldColorTransform->_hx___identity();
HXLINE( 649)						 ::openfl::display::Shader shader;
HXDLIN( 649)						 ::openfl::display::BitmapData cacheBitmap;
HXLINE( 651)						{
HXLINE( 651)							int _g2 = 0;
HXDLIN( 651)							::Array< ::Dynamic> _g3 = displayObject->_hx___filters;
HXDLIN( 651)							while((_g2 < _g3->length)){
HXLINE( 651)								 ::openfl::filters::BitmapFilter filter = _g3->__get(_g2).StaticCast<  ::openfl::filters::BitmapFilter >();
HXDLIN( 651)								_g2 = (_g2 + 1);
HXLINE( 653)								if (filter->_hx___preserveObject) {
HXLINE( 655)									childRenderer->_hx___setRenderTarget(bitmap3);
HXLINE( 656)									childRenderer->_hx___renderFilterPass(bitmap,childRenderer->_hx___defaultDisplayShader,filter->_hx___smooth,null());
            								}
HXLINE( 659)								{
HXLINE( 659)									int _g = 0;
HXDLIN( 659)									int _g1 = filter->_hx___numShaderPasses;
HXDLIN( 659)									while((_g < _g1)){
HXLINE( 659)										_g = (_g + 1);
HXDLIN( 659)										int i = (_g - 1);
HXLINE( 661)										 ::openfl::display::BitmapData shader1;
HXDLIN( 661)										if (filter->_hx___preserveObject) {
HXLINE( 661)											shader1 = bitmap3;
            										}
            										else {
HXLINE( 661)											shader1 = null();
            										}
HXDLIN( 661)										shader = filter->_hx___initShader(childRenderer,i,shader1);
HXLINE( 662)										childRenderer->_hx___setBlendMode(filter->_hx___shaderBlendMode);
HXLINE( 663)										childRenderer->_hx___setRenderTarget(bitmap2);
HXLINE( 664)										childRenderer->_hx___renderFilterPass(bitmap,shader,filter->_hx___smooth,null());
HXLINE( 666)										cacheBitmap = bitmap;
HXLINE( 667)										bitmap = bitmap2;
HXLINE( 668)										bitmap2 = cacheBitmap;
            									}
            								}
HXLINE( 671)								filter->_hx___renderDirty = false;
            							}
            						}
HXLINE( 674)						displayObject->_hx___cacheBitmap->_hx___bitmapData = bitmap;
            					}
HXLINE( 677)					parentRenderer->_hx___blendMode = 10;
HXLINE( 678)					parentRenderer->_hx___setBlendMode(cacheBlendMode);
HXLINE( 679)					parentRenderer->_hx___copyShader(childRenderer);
HXLINE( 681)					if (::hx::IsNotNull( cacheRTT )) {
HXLINE( 683)						context->setRenderToTexture(cacheRTT,cacheRTTDepthStencil,cacheRTTAntiAlias,cacheRTTSurfaceSelector);
            					}
            					else {
HXLINE( 687)						context->setRenderToBackBuffer();
            					}
HXLINE( 693)					parentRenderer->_hx___resumeClipAndMask(childRenderer);
HXLINE( 694)					parentRenderer->setViewport();
HXLINE( 696)					displayObject->_hx___cacheBitmapColorTransform->_hx___copyFrom(colorTransform);
            				}
            				else {
HXLINE( 703)					displayObject->_hx___cacheBitmapData->_hx___drawCairo(displayObject,( ( ::openfl::display::CairoRenderer)(displayObject->_hx___cacheBitmapRenderer) ));
HXLINE( 706)					if (hasFilters) {
HXLINE( 708)						bool needSecondBitmapData = false;
HXLINE( 709)						bool needCopyOfOriginal = false;
HXLINE( 711)						{
HXLINE( 711)							int _g = 0;
HXDLIN( 711)							::Array< ::Dynamic> _g1 = displayObject->_hx___filters;
HXDLIN( 711)							while((_g < _g1->length)){
HXLINE( 711)								 ::openfl::filters::BitmapFilter filter = _g1->__get(_g).StaticCast<  ::openfl::filters::BitmapFilter >();
HXDLIN( 711)								_g = (_g + 1);
HXLINE( 713)								if (filter->_hx___needSecondBitmapData) {
HXLINE( 715)									needSecondBitmapData = true;
            								}
HXLINE( 717)								if (filter->_hx___preserveObject) {
HXLINE( 719)									needCopyOfOriginal = true;
            								}
            							}
            						}
HXLINE( 723)						 ::openfl::display::BitmapData bitmap = displayObject->_hx___cacheBitmapData;
HXLINE( 724)						 ::openfl::display::BitmapData bitmap2 = null();
HXLINE( 725)						 ::openfl::display::BitmapData bitmap3 = null();
HXLINE( 727)						if (needSecondBitmapData) {
HXLINE( 729)							bool _hx_tmp;
HXDLIN( 729)							bool _hx_tmp1;
HXDLIN( 729)							bool _hx_tmp2;
HXDLIN( 729)							if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData2 )) {
HXLINE( 729)								_hx_tmp2 = ::hx::IsNull( displayObject->_hx___cacheBitmapData2->image );
            							}
            							else {
HXLINE( 729)								_hx_tmp2 = true;
            							}
HXDLIN( 729)							if (!(_hx_tmp2)) {
HXLINE( 729)								_hx_tmp1 = (bitmapWidth > displayObject->_hx___cacheBitmapData2->width);
            							}
            							else {
HXLINE( 729)								_hx_tmp1 = true;
            							}
HXDLIN( 729)							if (!(_hx_tmp1)) {
HXLINE( 729)								_hx_tmp = (bitmapHeight > displayObject->_hx___cacheBitmapData2->height);
            							}
            							else {
HXLINE( 729)								_hx_tmp = true;
            							}
HXDLIN( 729)							if (_hx_tmp) {
HXLINE( 734)								displayObject->_hx___cacheBitmapData2 =  ::openfl::display::BitmapData_obj::__alloc( HX_CTX ,bitmapWidth,bitmapHeight,true,0);
            							}
            							else {
HXLINE( 738)								displayObject->_hx___cacheBitmapData2->fillRect(displayObject->_hx___cacheBitmapData2->rect,0);
            							}
HXLINE( 740)							bitmap2 = displayObject->_hx___cacheBitmapData2;
            						}
            						else {
HXLINE( 744)							bitmap2 = bitmap;
            						}
HXLINE( 747)						if (needCopyOfOriginal) {
HXLINE( 749)							bool _hx_tmp;
HXDLIN( 749)							bool _hx_tmp1;
HXDLIN( 749)							bool _hx_tmp2;
HXDLIN( 749)							if (::hx::IsNotNull( displayObject->_hx___cacheBitmapData3 )) {
HXLINE( 749)								_hx_tmp2 = ::hx::IsNull( displayObject->_hx___cacheBitmapData3->image );
            							}
            							else {
HXLINE( 749)								_hx_tmp2 = true;
            							}
HXDLIN( 749)							if (!(_hx_tmp2)) {
HXLINE( 749)								_hx_tmp1 = (bitmapWidth > displayObject->_hx___cacheBitmapData3->width);
            							}
            							else {
HXLINE( 749)								_hx_tmp1 = true;
            							}
HXDLIN( 749)							if (!(_hx_tmp1)) {
HXLINE( 749)								_hx_tmp = (bitmapHeight > displayObject->_hx___cacheBitmapData3->height);
            							}
            							else {
HXLINE( 749)								_hx_tmp = true;
            							}
HXDLIN( 749)							if (_hx_tmp) {
HXLINE( 754)								displayObject->_hx___cacheBitmapData3 =  ::openfl::display::BitmapData_obj::__alloc( HX_CTX ,bitmapWidth,bitmapHeight,true,0);
            							}
            							else {
HXLINE( 758)								displayObject->_hx___cacheBitmapData3->fillRect(displayObject->_hx___cacheBitmapData3->rect,0);
            							}
HXLINE( 760)							bitmap3 = displayObject->_hx___cacheBitmapData3;
            						}
HXLINE( 763)						if (::hx::IsNull( displayObject->_hx___tempPoint )) {
HXLINE( 763)							displayObject->_hx___tempPoint =  ::openfl::geom::Point_obj::__alloc( HX_CTX ,null(),null());
            						}
HXLINE( 764)						 ::openfl::geom::Point destPoint = displayObject->_hx___tempPoint;
HXLINE( 765)						 ::openfl::display::BitmapData cacheBitmap;
HXDLIN( 765)						 ::openfl::display::BitmapData lastBitmap;
HXLINE( 767)						{
HXLINE( 767)							int _g2 = 0;
HXDLIN( 767)							::Array< ::Dynamic> _g3 = displayObject->_hx___filters;
HXDLIN( 767)							while((_g2 < _g3->length)){
HXLINE( 767)								 ::openfl::filters::BitmapFilter filter = _g3->__get(_g2).StaticCast<  ::openfl::filters::BitmapFilter >();
HXDLIN( 767)								_g2 = (_g2 + 1);
HXLINE( 769)								if (filter->_hx___preserveObject) {
HXLINE( 771)									bitmap3->copyPixels(bitmap,bitmap->rect,destPoint,null(),null(),null());
            								}
HXLINE( 774)								lastBitmap = filter->_hx___applyFilter(bitmap2,bitmap,bitmap->rect,destPoint);
HXLINE( 776)								if (filter->_hx___preserveObject) {
HXLINE( 779)									 ::openfl::geom::ColorTransform _hx_tmp;
HXDLIN( 779)									if (::hx::IsNotNull( displayObject->_hx___objectTransform )) {
HXLINE( 779)										_hx_tmp = displayObject->_hx___objectTransform->_hx___colorTransform;
            									}
            									else {
HXLINE( 779)										_hx_tmp = null();
            									}
HXLINE( 778)									lastBitmap->draw(bitmap3,null(),_hx_tmp,null(),null(),null());
            								}
HXLINE( 781)								filter->_hx___renderDirty = false;
HXLINE( 783)								bool _hx_tmp;
HXDLIN( 783)								if (needSecondBitmapData) {
HXLINE( 783)									_hx_tmp = ::hx::IsInstanceEq( lastBitmap,bitmap2 );
            								}
            								else {
HXLINE( 783)									_hx_tmp = false;
            								}
HXDLIN( 783)								if (_hx_tmp) {
HXLINE( 785)									cacheBitmap = bitmap;
HXLINE( 786)									bitmap = bitmap2;
HXLINE( 787)									bitmap2 = cacheBitmap;
            								}
            							}
            						}
HXLINE( 791)						if (::hx::IsInstanceNotEq( displayObject->_hx___cacheBitmapData,bitmap )) {
HXLINE( 797)							cacheBitmap = displayObject->_hx___cacheBitmapData;
HXLINE( 798)							displayObject->_hx___cacheBitmapData = bitmap;
HXLINE( 799)							displayObject->_hx___cacheBitmapData2 = cacheBitmap;
HXLINE( 800)							displayObject->_hx___cacheBitmap->_hx___bitmapData = displayObject->_hx___cacheBitmapData;
HXLINE( 801)							displayObject->_hx___cacheBitmapRenderer = null();
            						}
HXLINE( 804)						displayObject->_hx___cacheBitmap->_hx___imageVersion = displayObject->_hx___cacheBitmapData->_hx___textureVersion;
            					}
HXLINE( 807)					displayObject->_hx___cacheBitmapColorTransform->_hx___copyFrom(colorTransform);
HXLINE( 809)					if (!(displayObject->_hx___cacheBitmapColorTransform->_hx___isDefault(true))) {
HXLINE( 811)						displayObject->_hx___cacheBitmapColorTransform->alphaMultiplier = ( (Float)(1) );
HXLINE( 812)						displayObject->_hx___cacheBitmapData->colorTransform(displayObject->_hx___cacheBitmapData->rect,displayObject->_hx___cacheBitmapColorTransform);
            					}
            				}
HXLINE( 816)				displayObject->_hx___isCacheBitmapRender = false;
            			}
HXLINE( 819)			bool _hx_tmp10;
HXDLIN( 819)			if (!(updateTransform)) {
HXLINE( 819)				_hx_tmp10 = needRender;
            			}
            			else {
HXLINE( 819)				_hx_tmp10 = true;
            			}
HXDLIN( 819)			if (_hx_tmp10) {
HXLINE( 821)				::openfl::geom::Rectangle_obj::_hx___pool->release(rect);
            			}
HXLINE( 824)			updated = updateTransform;
            		}
            		else {
HXLINE( 826)			if (::hx::IsNotNull( displayObject->_hx___cacheBitmap )) {
HXLINE( 828)				if ((renderer->_hx___type == HX_("dom",82,42,4c,00))) {
HXLINE( 830)					 ::openfl::display::DOMRenderer domRenderer = ( ( ::openfl::display::DOMRenderer)(renderer) );
HXLINE( 831)					domRenderer->_hx___renderDrawableClear(displayObject->_hx___cacheBitmap);
            				}
HXLINE( 834)				displayObject->_hx___cacheBitmap = null();
HXLINE( 835)				displayObject->_hx___cacheBitmapData = null();
HXLINE( 836)				displayObject->_hx___cacheBitmapData2 = null();
HXLINE( 837)				displayObject->_hx___cacheBitmapData3 = null();
HXLINE( 838)				displayObject->_hx___cacheBitmapColorTransform = null();
HXLINE( 839)				displayObject->_hx___cacheBitmapRenderer = null();
HXLINE( 841)				updated = true;
            			}
            		}
HXLINE( 844)		::openfl::geom::ColorTransform_obj::_hx___pool->release(colorTransform);
HXLINE( 846)		bool _hx_tmp2;
HXDLIN( 846)		if (updated) {
HXLINE( 846)			_hx_tmp2 = (displayObject->_hx___drawableType == 7);
            		}
            		else {
HXLINE( 846)			_hx_tmp2 = false;
            		}
HXDLIN( 846)		if (_hx_tmp2) {
HXLINE( 848)			 ::openfl::text::TextField textField = ( ( ::openfl::text::TextField)(displayObject) );
HXLINE( 849)			if (::hx::IsNotNull( textField->_hx___cacheBitmap )) {
HXLINE( 851)				 ::openfl::geom::Matrix fh = textField->_hx___cacheBitmap->_hx___renderTransform;
HXDLIN( 851)				fh->tx = (fh->tx - textField->_hx___offsetX);
HXLINE( 852)				 ::openfl::geom::Matrix fh1 = textField->_hx___cacheBitmap->_hx___renderTransform;
HXDLIN( 852)				fh1->ty = (fh1->ty - textField->_hx___offsetY);
            			}
            		}
HXLINE( 856)		return updated;
            	}


HX_DEFINE_DYNAMIC_FUNC2(DisplayObjectRenderer_obj,_hx___updateCacheBitmap,return )


::hx::ObjectPtr< DisplayObjectRenderer_obj > DisplayObjectRenderer_obj::__new() {
	::hx::ObjectPtr< DisplayObjectRenderer_obj > __this = new DisplayObjectRenderer_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< DisplayObjectRenderer_obj > DisplayObjectRenderer_obj::__alloc(::hx::Ctx *_hx_ctx) {
	DisplayObjectRenderer_obj *__this = (DisplayObjectRenderer_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(DisplayObjectRenderer_obj), true, "openfl.display.DisplayObjectRenderer"));
	*(void **)__this = DisplayObjectRenderer_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

DisplayObjectRenderer_obj::DisplayObjectRenderer_obj()
{
}

void DisplayObjectRenderer_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(DisplayObjectRenderer);
	HX_MARK_MEMBER_NAME(_hx___allowSmoothing,"__allowSmoothing");
	HX_MARK_MEMBER_NAME(_hx___blendMode,"__blendMode");
	HX_MARK_MEMBER_NAME(_hx___cleared,"__cleared");
	HX_MARK_MEMBER_NAME(_hx___context,"__context");
	HX_MARK_MEMBER_NAME(_hx___overrideBlendMode,"__overrideBlendMode");
	HX_MARK_MEMBER_NAME(_hx___pixelRatio,"__pixelRatio");
	HX_MARK_MEMBER_NAME(_hx___roundPixels,"__roundPixels");
	HX_MARK_MEMBER_NAME(_hx___stage,"__stage");
	HX_MARK_MEMBER_NAME(_hx___tempColorTransform,"__tempColorTransform");
	HX_MARK_MEMBER_NAME(_hx___transparent,"__transparent");
	HX_MARK_MEMBER_NAME(_hx___type,"__type");
	HX_MARK_MEMBER_NAME(_hx___worldAlpha,"__worldAlpha");
	HX_MARK_MEMBER_NAME(_hx___worldColorTransform,"__worldColorTransform");
	HX_MARK_MEMBER_NAME(_hx___worldTransform,"__worldTransform");
	 ::openfl::events::EventDispatcher_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void DisplayObjectRenderer_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(_hx___allowSmoothing,"__allowSmoothing");
	HX_VISIT_MEMBER_NAME(_hx___blendMode,"__blendMode");
	HX_VISIT_MEMBER_NAME(_hx___cleared,"__cleared");
	HX_VISIT_MEMBER_NAME(_hx___context,"__context");
	HX_VISIT_MEMBER_NAME(_hx___overrideBlendMode,"__overrideBlendMode");
	HX_VISIT_MEMBER_NAME(_hx___pixelRatio,"__pixelRatio");
	HX_VISIT_MEMBER_NAME(_hx___roundPixels,"__roundPixels");
	HX_VISIT_MEMBER_NAME(_hx___stage,"__stage");
	HX_VISIT_MEMBER_NAME(_hx___tempColorTransform,"__tempColorTransform");
	HX_VISIT_MEMBER_NAME(_hx___transparent,"__transparent");
	HX_VISIT_MEMBER_NAME(_hx___type,"__type");
	HX_VISIT_MEMBER_NAME(_hx___worldAlpha,"__worldAlpha");
	HX_VISIT_MEMBER_NAME(_hx___worldColorTransform,"__worldColorTransform");
	HX_VISIT_MEMBER_NAME(_hx___worldTransform,"__worldTransform");
	 ::openfl::events::EventDispatcher_obj::__Visit(HX_VISIT_ARG);
}

::hx::Val DisplayObjectRenderer_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"__type") ) { return ::hx::Val( _hx___type ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"__stage") ) { return ::hx::Val( _hx___stage ); }
		if (HX_FIELD_EQ(inName,"__clear") ) { return ::hx::Val( _hx___clear_dyn() ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"__render") ) { return ::hx::Val( _hx___render_dyn() ); }
		if (HX_FIELD_EQ(inName,"__resize") ) { return ::hx::Val( _hx___resize_dyn() ); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"__cleared") ) { return ::hx::Val( _hx___cleared ); }
		if (HX_FIELD_EQ(inName,"__context") ) { return ::hx::Val( _hx___context ); }
		if (HX_FIELD_EQ(inName,"__popMask") ) { return ::hx::Val( _hx___popMask_dyn() ); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"__getAlpha") ) { return ::hx::Val( _hx___getAlpha_dyn() ); }
		if (HX_FIELD_EQ(inName,"__pushMask") ) { return ::hx::Val( _hx___pushMask_dyn() ); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"__blendMode") ) { return ::hx::Val( _hx___blendMode ); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"__pixelRatio") ) { return ::hx::Val( _hx___pixelRatio ); }
		if (HX_FIELD_EQ(inName,"__worldAlpha") ) { return ::hx::Val( _hx___worldAlpha ); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"__roundPixels") ) { return ::hx::Val( _hx___roundPixels ); }
		if (HX_FIELD_EQ(inName,"__transparent") ) { return ::hx::Val( _hx___transparent ); }
		if (HX_FIELD_EQ(inName,"__popMaskRect") ) { return ::hx::Val( _hx___popMaskRect_dyn() ); }
		if (HX_FIELD_EQ(inName,"__renderEvent") ) { return ::hx::Val( _hx___renderEvent_dyn() ); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"__pushMaskRect") ) { return ::hx::Val( _hx___pushMaskRect_dyn() ); }
		if (HX_FIELD_EQ(inName,"__setBlendMode") ) { return ::hx::Val( _hx___setBlendMode_dyn() ); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"__popMaskObject") ) { return ::hx::Val( _hx___popMaskObject_dyn() ); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"__allowSmoothing") ) { return ::hx::Val( _hx___allowSmoothing ); }
		if (HX_FIELD_EQ(inName,"__worldTransform") ) { return ::hx::Val( _hx___worldTransform ); }
		if (HX_FIELD_EQ(inName,"__pushMaskObject") ) { return ::hx::Val( _hx___pushMaskObject_dyn() ); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"__overrideBlendMode") ) { return ::hx::Val( _hx___overrideBlendMode ); }
		if (HX_FIELD_EQ(inName,"__getColorTransform") ) { return ::hx::Val( _hx___getColorTransform_dyn() ); }
		if (HX_FIELD_EQ(inName,"__updateCacheBitmap") ) { return ::hx::Val( _hx___updateCacheBitmap_dyn() ); }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"__tempColorTransform") ) { return ::hx::Val( _hx___tempColorTransform ); }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"__worldColorTransform") ) { return ::hx::Val( _hx___worldColorTransform ); }
		if (HX_FIELD_EQ(inName,"__shouldCacheHardware") ) { return ::hx::Val( _hx___shouldCacheHardware_dyn() ); }
		break;
	case 35:
		if (HX_FIELD_EQ(inName,"__shouldCacheHardware_DisplayObject") ) { return ::hx::Val( _hx___shouldCacheHardware_DisplayObject_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val DisplayObjectRenderer_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"__type") ) { _hx___type=inValue.Cast< ::String >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"__stage") ) { _hx___stage=inValue.Cast<  ::openfl::display::Stage >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"__cleared") ) { _hx___cleared=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__context") ) { _hx___context=inValue.Cast<  ::lime::graphics::RenderContext >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"__blendMode") ) { _hx___blendMode=inValue.Cast<  ::Dynamic >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"__pixelRatio") ) { _hx___pixelRatio=inValue.Cast< Float >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__worldAlpha") ) { _hx___worldAlpha=inValue.Cast< Float >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"__roundPixels") ) { _hx___roundPixels=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__transparent") ) { _hx___transparent=inValue.Cast< bool >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"__allowSmoothing") ) { _hx___allowSmoothing=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__worldTransform") ) { _hx___worldTransform=inValue.Cast<  ::openfl::geom::Matrix >(); return inValue; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"__overrideBlendMode") ) { _hx___overrideBlendMode=inValue.Cast<  ::Dynamic >(); return inValue; }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"__tempColorTransform") ) { _hx___tempColorTransform=inValue.Cast<  ::openfl::geom::ColorTransform >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"__worldColorTransform") ) { _hx___worldColorTransform=inValue.Cast<  ::openfl::geom::ColorTransform >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void DisplayObjectRenderer_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("__allowSmoothing",cb,42,a6,9c));
	outFields->push(HX_("__blendMode",34,2d,64,3a));
	outFields->push(HX_("__cleared",0c,58,93,2c));
	outFields->push(HX_("__context",cf,e6,c5,9a));
	outFields->push(HX_("__overrideBlendMode",48,21,da,ac));
	outFields->push(HX_("__pixelRatio",c5,f3,a5,bb));
	outFields->push(HX_("__roundPixels",fb,ca,70,07));
	outFields->push(HX_("__stage",9e,c3,69,ee));
	outFields->push(HX_("__tempColorTransform",dd,84,da,33));
	outFields->push(HX_("__transparent",32,6c,32,6b));
	outFields->push(HX_("__type",da,55,01,fc));
	outFields->push(HX_("__worldAlpha",cc,d2,d6,c5));
	outFields->push(HX_("__worldColorTransform",5b,ce,21,a3));
	outFields->push(HX_("__worldTransform",da,a7,d8,9a));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo DisplayObjectRenderer_obj_sMemberStorageInfo[] = {
	{::hx::fsBool,(int)offsetof(DisplayObjectRenderer_obj,_hx___allowSmoothing),HX_("__allowSmoothing",cb,42,a6,9c)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(DisplayObjectRenderer_obj,_hx___blendMode),HX_("__blendMode",34,2d,64,3a)},
	{::hx::fsBool,(int)offsetof(DisplayObjectRenderer_obj,_hx___cleared),HX_("__cleared",0c,58,93,2c)},
	{::hx::fsObject /*  ::lime::graphics::RenderContext */ ,(int)offsetof(DisplayObjectRenderer_obj,_hx___context),HX_("__context",cf,e6,c5,9a)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(DisplayObjectRenderer_obj,_hx___overrideBlendMode),HX_("__overrideBlendMode",48,21,da,ac)},
	{::hx::fsFloat,(int)offsetof(DisplayObjectRenderer_obj,_hx___pixelRatio),HX_("__pixelRatio",c5,f3,a5,bb)},
	{::hx::fsBool,(int)offsetof(DisplayObjectRenderer_obj,_hx___roundPixels),HX_("__roundPixels",fb,ca,70,07)},
	{::hx::fsObject /*  ::openfl::display::Stage */ ,(int)offsetof(DisplayObjectRenderer_obj,_hx___stage),HX_("__stage",9e,c3,69,ee)},
	{::hx::fsObject /*  ::openfl::geom::ColorTransform */ ,(int)offsetof(DisplayObjectRenderer_obj,_hx___tempColorTransform),HX_("__tempColorTransform",dd,84,da,33)},
	{::hx::fsBool,(int)offsetof(DisplayObjectRenderer_obj,_hx___transparent),HX_("__transparent",32,6c,32,6b)},
	{::hx::fsString,(int)offsetof(DisplayObjectRenderer_obj,_hx___type),HX_("__type",da,55,01,fc)},
	{::hx::fsFloat,(int)offsetof(DisplayObjectRenderer_obj,_hx___worldAlpha),HX_("__worldAlpha",cc,d2,d6,c5)},
	{::hx::fsObject /*  ::openfl::geom::ColorTransform */ ,(int)offsetof(DisplayObjectRenderer_obj,_hx___worldColorTransform),HX_("__worldColorTransform",5b,ce,21,a3)},
	{::hx::fsObject /*  ::openfl::geom::Matrix */ ,(int)offsetof(DisplayObjectRenderer_obj,_hx___worldTransform),HX_("__worldTransform",da,a7,d8,9a)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *DisplayObjectRenderer_obj_sStaticStorageInfo = 0;
#endif

static ::String DisplayObjectRenderer_obj_sMemberFields[] = {
	HX_("__allowSmoothing",cb,42,a6,9c),
	HX_("__blendMode",34,2d,64,3a),
	HX_("__cleared",0c,58,93,2c),
	HX_("__context",cf,e6,c5,9a),
	HX_("__overrideBlendMode",48,21,da,ac),
	HX_("__pixelRatio",c5,f3,a5,bb),
	HX_("__roundPixels",fb,ca,70,07),
	HX_("__stage",9e,c3,69,ee),
	HX_("__tempColorTransform",dd,84,da,33),
	HX_("__transparent",32,6c,32,6b),
	HX_("__type",da,55,01,fc),
	HX_("__worldAlpha",cc,d2,d6,c5),
	HX_("__worldColorTransform",5b,ce,21,a3),
	HX_("__worldTransform",da,a7,d8,9a),
	HX_("__clear",6d,ca,b9,b2),
	HX_("__getAlpha",08,2a,a6,24),
	HX_("__getColorTransform",9f,af,a3,d2),
	HX_("__popMask",fd,b7,5f,c4),
	HX_("__popMaskObject",9c,46,0d,10),
	HX_("__popMaskRect",c1,73,e8,16),
	HX_("__pushMask",06,e7,7f,ba),
	HX_("__pushMaskObject",65,e2,3b,45),
	HX_("__pushMaskRect",4a,5b,e7,a0),
	HX_("__render",76,d6,58,ad),
	HX_("__renderEvent",c4,35,ee,89),
	HX_("__resize",14,c5,aa,b0),
	HX_("__setBlendMode",72,27,48,51),
	HX_("__shouldCacheHardware",b7,af,f5,89),
	HX_("__shouldCacheHardware_DisplayObject",b9,9c,ad,0b),
	HX_("__updateCacheBitmap",28,11,07,27),
	::String(null()) };

::hx::Class DisplayObjectRenderer_obj::__mClass;

void DisplayObjectRenderer_obj::__register()
{
	DisplayObjectRenderer_obj _hx_dummy;
	DisplayObjectRenderer_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.display.DisplayObjectRenderer",5a,1c,ac,3e);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(DisplayObjectRenderer_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< DisplayObjectRenderer_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = DisplayObjectRenderer_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = DisplayObjectRenderer_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void DisplayObjectRenderer_obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_5a81acb3bead7383_43_boot)
HXDLIN(  43)		__mClass->__meta__ =  ::Dynamic(::hx::Anon_obj::Create(1)
            			->setFixed(0,HX_("fields",79,8e,8e,80), ::Dynamic(::hx::Anon_obj::Create(2)
            				->setFixed(0,HX_("__context",cf,e6,c5,9a), ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("SuppressWarnings",0c,d3,d2,00),::cpp::VirtualArray_obj::__new(1)->init(0,HX_("checkstyle:Dynamic",ce,ea,47,3c)))))
            				->setFixed(1,HX_("__type",da,55,01,fc), ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("SuppressWarnings",0c,d3,d2,00),::cpp::VirtualArray_obj::__new(1)->init(0,HX_("checkstyle:Dynamic",ce,ea,47,3c))))))));
            	}
}

} // end namespace openfl
} // end namespace display
