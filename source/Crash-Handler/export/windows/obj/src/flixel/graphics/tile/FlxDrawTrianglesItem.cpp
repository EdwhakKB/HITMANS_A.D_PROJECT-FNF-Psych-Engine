#include <hxcpp.h>

#ifndef INCLUDED_95f339a1d026d52c
#define INCLUDED_95f339a1d026d52c
#include "hxMath.h"
#endif
#ifndef INCLUDED_Std
#include <Std.h>
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
#ifndef INCLUDED_flixel_graphics_FlxGraphic
#include <flixel/graphics/FlxGraphic.h>
#endif
#ifndef INCLUDED_flixel_graphics_frames_FlxFrame
#include <flixel/graphics/frames/FlxFrame.h>
#endif
#ifndef INCLUDED_flixel_graphics_tile_FlxDrawBaseItem
#include <flixel/graphics/tile/FlxDrawBaseItem.h>
#endif
#ifndef INCLUDED_flixel_graphics_tile_FlxDrawItemType
#include <flixel/graphics/tile/FlxDrawItemType.h>
#endif
#ifndef INCLUDED_flixel_graphics_tile_FlxDrawTrianglesItem
#include <flixel/graphics/tile/FlxDrawTrianglesItem.h>
#endif
#ifndef INCLUDED_flixel_graphics_tile_FlxGraphicsShader
#include <flixel/graphics/tile/FlxGraphicsShader.h>
#endif
#ifndef INCLUDED_flixel_math_FlxBasePoint
#include <flixel/math/FlxBasePoint.h>
#endif
#ifndef INCLUDED_flixel_math_FlxMatrix
#include <flixel/math/FlxMatrix.h>
#endif
#ifndef INCLUDED_flixel_math_FlxRect
#include <flixel/math/FlxRect.h>
#endif
#ifndef INCLUDED_flixel_util_FlxPool_flixel_math_FlxBasePoint
#include <flixel/util/FlxPool_flixel_math_FlxBasePoint.h>
#endif
#ifndef INCLUDED_flixel_util_FlxPool_flixel_math_FlxRect
#include <flixel/util/FlxPool_flixel_math_FlxRect.h>
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
#ifndef INCLUDED_flixel_util__FlxColor_FlxColor_Impl_
#include <flixel/util/_FlxColor/FlxColor_Impl_.h>
#endif
#ifndef INCLUDED_openfl__Vector_FloatVector
#include <openfl/_Vector/FloatVector.h>
#endif
#ifndef INCLUDED_openfl__Vector_IVector
#include <openfl/_Vector/IVector.h>
#endif
#ifndef INCLUDED_openfl__Vector_IntVector
#include <openfl/_Vector/IntVector.h>
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
#ifndef INCLUDED_openfl_display_GraphicsShader
#include <openfl/display/GraphicsShader.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_display_Shader
#include <openfl/display/Shader.h>
#endif
#ifndef INCLUDED_openfl_display_ShaderInput_openfl_display_BitmapData
#include <openfl/display/ShaderInput_openfl_display_BitmapData.h>
#endif
#ifndef INCLUDED_openfl_display_ShaderParameter_Bool
#include <openfl/display/ShaderParameter_Bool.h>
#endif
#ifndef INCLUDED_openfl_display_ShaderParameter_Float
#include <openfl/display/ShaderParameter_Float.h>
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

HX_DEFINE_STACK_FRAME(_hx_pos_a928be64e2bd594d_21_new,"flixel.graphics.tile.FlxDrawTrianglesItem","new",0x8669d929,"flixel.graphics.tile.FlxDrawTrianglesItem.new","flixel/graphics/tile/FlxDrawTrianglesItem.hx",21,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_54_render,"flixel.graphics.tile.FlxDrawTrianglesItem","render",0xbf64462d,"flixel.graphics.tile.FlxDrawTrianglesItem.render","flixel/graphics/tile/FlxDrawTrianglesItem.hx",54,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_104_reset,"flixel.graphics.tile.FlxDrawTrianglesItem","reset",0xa508d6d8,"flixel.graphics.tile.FlxDrawTrianglesItem.reset","flixel/graphics/tile/FlxDrawTrianglesItem.hx",104,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_124_dispose,"flixel.graphics.tile.FlxDrawTrianglesItem","dispose",0xf49121e8,"flixel.graphics.tile.FlxDrawTrianglesItem.dispose","flixel/graphics/tile/FlxDrawTrianglesItem.hx",124,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_141_addTriangles,"flixel.graphics.tile.FlxDrawTrianglesItem","addTriangles",0xd3f66861,"flixel.graphics.tile.FlxDrawTrianglesItem.addTriangles","flixel/graphics/tile/FlxDrawTrianglesItem.hx",141,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_263_setParameterValue,"flixel.graphics.tile.FlxDrawTrianglesItem","setParameterValue",0xa7ab92d3,"flixel.graphics.tile.FlxDrawTrianglesItem.setParameterValue","flixel/graphics/tile/FlxDrawTrianglesItem.hx",263,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_297_addQuad,"flixel.graphics.tile.FlxDrawTrianglesItem","addQuad",0xc08c1cd1,"flixel.graphics.tile.FlxDrawTrianglesItem.addQuad","flixel/graphics/tile/FlxDrawTrianglesItem.hx",297,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_382_get_numVertices,"flixel.graphics.tile.FlxDrawTrianglesItem","get_numVertices",0x2e325a3f,"flixel.graphics.tile.FlxDrawTrianglesItem.get_numVertices","flixel/graphics/tile/FlxDrawTrianglesItem.hx",382,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_387_get_numTriangles,"flixel.graphics.tile.FlxDrawTrianglesItem","get_numTriangles",0x542b93a5,"flixel.graphics.tile.FlxDrawTrianglesItem.get_numTriangles","flixel/graphics/tile/FlxDrawTrianglesItem.hx",387,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_270_inflateBounds,"flixel.graphics.tile.FlxDrawTrianglesItem","inflateBounds",0x8ece7465,"flixel.graphics.tile.FlxDrawTrianglesItem.inflateBounds","flixel/graphics/tile/FlxDrawTrianglesItem.hx",270,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_23_boot,"flixel.graphics.tile.FlxDrawTrianglesItem","boot",0x0e4d2b49,"flixel.graphics.tile.FlxDrawTrianglesItem.boot","flixel/graphics/tile/FlxDrawTrianglesItem.hx",23,0x6492a666)
HX_LOCAL_STACK_FRAME(_hx_pos_a928be64e2bd594d_24_boot,"flixel.graphics.tile.FlxDrawTrianglesItem","boot",0x0e4d2b49,"flixel.graphics.tile.FlxDrawTrianglesItem.boot","flixel/graphics/tile/FlxDrawTrianglesItem.hx",24,0x6492a666)
namespace flixel{
namespace graphics{
namespace tile{

void FlxDrawTrianglesItem_obj::__construct(){
            	HX_GC_STACKFRAME(&_hx_pos_a928be64e2bd594d_21_new)
HXLINE(  42)		 ::flixel::math::FlxRect _this = ::flixel::math::FlxRect_obj::_pool->get();
HXDLIN(  42)		_this->x = ( (Float)(0) );
HXDLIN(  42)		_this->y = ( (Float)(0) );
HXDLIN(  42)		_this->width = ( (Float)(0) );
HXDLIN(  42)		_this->height = ( (Float)(0) );
HXDLIN(  42)		 ::flixel::math::FlxRect rect = _this;
HXDLIN(  42)		rect->_inPool = false;
HXDLIN(  42)		this->bounds = rect;
HXLINE(  40)		this->colorsPosition = 0;
HXLINE(  39)		this->indicesPosition = 0;
HXLINE(  38)		this->verticesPosition = 0;
HXLINE(  36)		int length = null();
HXDLIN(  36)		bool fixed = null();
HXDLIN(  36)		::Array< int > array = null();
HXDLIN(  36)		this->colors =  ::openfl::_Vector::IntVector_obj::__alloc( HX_CTX ,length,fixed,array);
HXLINE(  35)		int length1 = null();
HXDLIN(  35)		bool fixed1 = null();
HXDLIN(  35)		::Array< Float > array1 = null();
HXDLIN(  35)		this->uvtData =  ::openfl::_Vector::FloatVector_obj::__alloc( HX_CTX ,length1,fixed1,array1,true);
HXLINE(  34)		int length2 = null();
HXDLIN(  34)		bool fixed2 = null();
HXDLIN(  34)		::Array< int > array2 = null();
HXDLIN(  34)		this->indices =  ::openfl::_Vector::IntVector_obj::__alloc( HX_CTX ,length2,fixed2,array2);
HXLINE(  33)		int length3 = null();
HXDLIN(  33)		bool fixed3 = null();
HXDLIN(  33)		::Array< Float > array3 = null();
HXDLIN(  33)		this->vertices =  ::openfl::_Vector::FloatVector_obj::__alloc( HX_CTX ,length3,fixed3,array3,true);
HXLINE(  46)		super::__construct();
HXLINE(  47)		this->type = ::flixel::graphics::tile::FlxDrawItemType_obj::TRIANGLES_dyn();
HXLINE(  49)		this->alphas = ::Array_obj< Float >::__new(0);
            	}

Dynamic FlxDrawTrianglesItem_obj::__CreateEmpty() { return new FlxDrawTrianglesItem_obj; }

void *FlxDrawTrianglesItem_obj::_hx_vtable = 0;

Dynamic FlxDrawTrianglesItem_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< FlxDrawTrianglesItem_obj > _hx_result = new FlxDrawTrianglesItem_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool FlxDrawTrianglesItem_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x01f7e225) {
		return inClassId==(int)0x00000001 || inClassId==(int)0x01f7e225;
	} else {
		return inClassId==(int)0x1a0ba75d;
	}
}

void FlxDrawTrianglesItem_obj::render( ::flixel::FlxCamera camera){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_54_render)
HXLINE(  55)		if (!(::flixel::FlxG_obj::renderTile)) {
HXLINE(  56)			return;
            		}
HXLINE(  58)		if ((this->get_numTriangles() <= 0)) {
HXLINE(  59)			return;
            		}
HXLINE(  62)		 ::flixel::graphics::tile::FlxGraphicsShader shader;
HXDLIN(  62)		if (::hx::IsNotNull( this->shader )) {
HXLINE(  62)			shader = this->shader;
            		}
            		else {
HXLINE(  62)			shader = this->graphics->shader;
            		}
HXLINE(  63)		shader->bitmap->input = this->graphics->bitmap;
HXLINE(  64)		 ::Dynamic _hx_tmp;
HXDLIN(  64)		bool _hx_tmp1;
HXDLIN(  64)		if (!(camera->antialiasing)) {
HXLINE(  64)			_hx_tmp1 = this->antialiasing;
            		}
            		else {
HXLINE(  64)			_hx_tmp1 = true;
            		}
HXDLIN(  64)		if (_hx_tmp1) {
HXLINE(  64)			_hx_tmp = 4;
            		}
            		else {
HXLINE(  64)			_hx_tmp = 5;
            		}
HXDLIN(  64)		shader->bitmap->filter = _hx_tmp;
HXLINE(  65)		shader->bitmap->wrap = 2;
HXLINE(  66)		shader->alpha->value = this->alphas;
HXLINE(  68)		bool _hx_tmp2;
HXDLIN(  68)		if (!(this->colored)) {
HXLINE(  68)			_hx_tmp2 = this->hasColorOffsets;
            		}
            		else {
HXLINE(  68)			_hx_tmp2 = true;
            		}
HXDLIN(  68)		if (_hx_tmp2) {
HXLINE(  70)			shader->colorMultiplier->value = this->colorMultipliers;
HXLINE(  71)			shader->colorOffset->value = this->colorOffsets;
            		}
HXLINE(  74)		{
HXLINE(  74)			 ::openfl::display::ShaderParameter_Bool parameter = shader->hasTransform;
HXDLIN(  74)			if (::hx::IsNull( parameter->value )) {
HXLINE(  74)				parameter->value = ::Array_obj< bool >::__new(0);
            			}
HXDLIN(  74)			parameter->value[0] = true;
            		}
HXLINE(  75)		{
HXLINE(  75)			 ::openfl::display::ShaderParameter_Bool parameter1 = shader->hasColorTransform;
HXDLIN(  75)			bool value;
HXDLIN(  75)			if (!(this->colored)) {
HXLINE(  75)				value = this->hasColorOffsets;
            			}
            			else {
HXLINE(  75)				value = true;
            			}
HXDLIN(  75)			if (::hx::IsNull( parameter1->value )) {
HXLINE(  75)				parameter1->value = ::Array_obj< bool >::__new(0);
            			}
HXDLIN(  75)			parameter1->value[0] = value;
            		}
HXLINE(  78)		camera->canvas->get_graphics()->overrideBlendMode(this->blend);
HXLINE(  80)		camera->canvas->get_graphics()->beginShaderFill(shader,null());
HXLINE(  86)		camera->canvas->get_graphics()->drawTriangles(this->vertices,this->indices,this->uvtData,1);
HXLINE(  90)		camera->canvas->get_graphics()->endFill();
HXLINE( 100)		this->super::render(camera);
            	}


void FlxDrawTrianglesItem_obj::reset(){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_104_reset)
HXLINE( 105)		this->super::reset();
HXLINE( 106)		{
HXLINE( 106)			::Dynamic this1 = this->vertices;
HXDLIN( 106)			int deleteCount = this->vertices->get_length();
HXDLIN( 106)			::cpp::VirtualArray this2 = ::cpp::VirtualArray_obj::__new(0);
HXDLIN( 106)			this1->__SetField(HX_("__tempIndex",3e,e8,54,22),0,::hx::paccDynamic);
HXDLIN( 106)			{
HXLINE( 106)				int _g_current = 0;
HXDLIN( 106)				::cpp::VirtualArray _g_args = this2;
HXDLIN( 106)				while((_g_current < _g_args->get_length())){
HXLINE( 106)					_g_current = (_g_current + 1);
HXDLIN( 106)					 ::Dynamic item = _g_args->__get((_g_current - 1));
HXDLIN( 106)					( ( ::openfl::_Vector::FloatVector)(this1) )->insertAt(( (int)(this1->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),( (Float)(item) ));
HXDLIN( 106)					::hx::FieldRef((this1).mPtr,HX_("__tempIndex",3e,e8,54,22))++;
            				}
            			}
HXDLIN( 106)			( ( ::openfl::_Vector::FloatVector)(this1) )->splice(( (int)(this1->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),deleteCount);
            		}
HXLINE( 107)		{
HXLINE( 107)			::Dynamic this3 = this->indices;
HXDLIN( 107)			int deleteCount1 = this->indices->get_length();
HXDLIN( 107)			::cpp::VirtualArray this4 = ::cpp::VirtualArray_obj::__new(0);
HXDLIN( 107)			this3->__SetField(HX_("__tempIndex",3e,e8,54,22),0,::hx::paccDynamic);
HXDLIN( 107)			{
HXLINE( 107)				int _g_current1 = 0;
HXDLIN( 107)				::cpp::VirtualArray _g_args1 = this4;
HXDLIN( 107)				while((_g_current1 < _g_args1->get_length())){
HXLINE( 107)					_g_current1 = (_g_current1 + 1);
HXDLIN( 107)					 ::Dynamic item = _g_args1->__get((_g_current1 - 1));
HXDLIN( 107)					( ( ::openfl::_Vector::IntVector)(this3) )->insertAt(( (int)(this3->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),( (int)(item) ));
HXDLIN( 107)					::hx::FieldRef((this3).mPtr,HX_("__tempIndex",3e,e8,54,22))++;
            				}
            			}
HXDLIN( 107)			( ( ::openfl::_Vector::IntVector)(this3) )->splice(( (int)(this3->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),deleteCount1);
            		}
HXLINE( 108)		{
HXLINE( 108)			::Dynamic this5 = this->uvtData;
HXDLIN( 108)			int deleteCount2 = this->uvtData->get_length();
HXDLIN( 108)			::cpp::VirtualArray this6 = ::cpp::VirtualArray_obj::__new(0);
HXDLIN( 108)			this5->__SetField(HX_("__tempIndex",3e,e8,54,22),0,::hx::paccDynamic);
HXDLIN( 108)			{
HXLINE( 108)				int _g_current2 = 0;
HXDLIN( 108)				::cpp::VirtualArray _g_args2 = this6;
HXDLIN( 108)				while((_g_current2 < _g_args2->get_length())){
HXLINE( 108)					_g_current2 = (_g_current2 + 1);
HXDLIN( 108)					 ::Dynamic item = _g_args2->__get((_g_current2 - 1));
HXDLIN( 108)					( ( ::openfl::_Vector::FloatVector)(this5) )->insertAt(( (int)(this5->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),( (Float)(item) ));
HXDLIN( 108)					::hx::FieldRef((this5).mPtr,HX_("__tempIndex",3e,e8,54,22))++;
            				}
            			}
HXDLIN( 108)			( ( ::openfl::_Vector::FloatVector)(this5) )->splice(( (int)(this5->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),deleteCount2);
            		}
HXLINE( 109)		{
HXLINE( 109)			::Dynamic this7 = this->colors;
HXDLIN( 109)			int deleteCount3 = this->colors->get_length();
HXDLIN( 109)			::cpp::VirtualArray this8 = ::cpp::VirtualArray_obj::__new(0);
HXDLIN( 109)			this7->__SetField(HX_("__tempIndex",3e,e8,54,22),0,::hx::paccDynamic);
HXDLIN( 109)			{
HXLINE( 109)				int _g_current3 = 0;
HXDLIN( 109)				::cpp::VirtualArray _g_args3 = this8;
HXDLIN( 109)				while((_g_current3 < _g_args3->get_length())){
HXLINE( 109)					_g_current3 = (_g_current3 + 1);
HXDLIN( 109)					 ::Dynamic item = _g_args3->__get((_g_current3 - 1));
HXDLIN( 109)					( ( ::openfl::_Vector::IntVector)(this7) )->insertAt(( (int)(this7->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),( (int)(item) ));
HXDLIN( 109)					::hx::FieldRef((this7).mPtr,HX_("__tempIndex",3e,e8,54,22))++;
            				}
            			}
HXDLIN( 109)			( ( ::openfl::_Vector::IntVector)(this7) )->splice(( (int)(this7->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),deleteCount3);
            		}
HXLINE( 111)		this->verticesPosition = 0;
HXLINE( 112)		this->indicesPosition = 0;
HXLINE( 113)		this->colorsPosition = 0;
HXLINE( 115)		this->alphas->removeRange(0,this->alphas->length);
HXLINE( 116)		if (::hx::IsNotNull( this->colorMultipliers )) {
HXLINE( 117)			this->colorMultipliers->removeRange(0,this->colorMultipliers->length);
            		}
HXLINE( 118)		if (::hx::IsNotNull( this->colorOffsets )) {
HXLINE( 119)			this->colorOffsets->removeRange(0,this->colorOffsets->length);
            		}
            	}


void FlxDrawTrianglesItem_obj::dispose(){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_124_dispose)
HXLINE( 125)		this->super::dispose();
HXLINE( 127)		this->vertices = null();
HXLINE( 128)		this->indices = null();
HXLINE( 129)		this->uvtData = null();
HXLINE( 130)		this->colors = null();
HXLINE( 131)		this->bounds = null();
HXLINE( 133)		this->alphas = null();
HXLINE( 134)		this->colorMultipliers = null();
HXLINE( 135)		this->colorOffsets = null();
            	}


void FlxDrawTrianglesItem_obj::addTriangles( ::openfl::_Vector::FloatVector vertices, ::openfl::_Vector::IntVector indices, ::openfl::_Vector::FloatVector uvtData, ::openfl::_Vector::IntVector colors, ::flixel::math::FlxBasePoint position, ::flixel::math::FlxRect cameraBounds, ::openfl::geom::ColorTransform transform){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_141_addTriangles)
HXLINE( 142)		if (::hx::IsNull( position )) {
HXLINE( 143)			 ::flixel::math::FlxBasePoint this1 = ::flixel::graphics::tile::FlxDrawTrianglesItem_obj::point;
HXDLIN( 143)			this1->set_x(( (Float)(0) ));
HXDLIN( 143)			this1->set_y(( (Float)(0) ));
HXDLIN( 143)			position = this1;
            		}
HXLINE( 145)		if (::hx::IsNull( cameraBounds )) {
HXLINE( 146)			 ::flixel::math::FlxRect _this = ::flixel::graphics::tile::FlxDrawTrianglesItem_obj::rect;
HXDLIN( 146)			_this->x = ( (Float)(0) );
HXDLIN( 146)			_this->y = ( (Float)(0) );
HXDLIN( 146)			_this->width = ( (Float)(::flixel::FlxG_obj::width) );
HXDLIN( 146)			_this->height = ( (Float)(::flixel::FlxG_obj::height) );
HXDLIN( 146)			cameraBounds = _this;
            		}
HXLINE( 148)		int verticesLength = vertices->get_length();
HXLINE( 149)		int prevVerticesLength = this->vertices->get_length();
HXLINE( 150)		int numberOfVertices = ::Std_obj::_hx_int((( (Float)(verticesLength) ) / ( (Float)(2) )));
HXLINE( 151)		int prevIndicesLength = this->indices->get_length();
HXLINE( 152)		int prevUVTDataLength = this->uvtData->get_length();
HXLINE( 153)		int prevColorsLength = this->colors->get_length();
HXLINE( 154)		int prevNumberOfVertices = this->get_numVertices();
HXLINE( 156)		Float tempX;
HXDLIN( 156)		Float tempY;
HXLINE( 157)		int i = 0;
HXLINE( 158)		int currentVertexPosition = prevVerticesLength;
HXLINE( 160)		while((i < verticesLength)){
HXLINE( 162)			Float position1 = position->x;
HXDLIN( 162)			tempX = (position1 + vertices->get(i));
HXLINE( 163)			Float position2 = position->y;
HXDLIN( 163)			tempY = (position2 + vertices->get((i + 1)));
HXLINE( 165)			{
HXLINE( 165)				currentVertexPosition = (currentVertexPosition + 1);
HXDLIN( 165)				this->vertices->set((currentVertexPosition - 1),tempX);
            			}
HXLINE( 166)			{
HXLINE( 166)				currentVertexPosition = (currentVertexPosition + 1);
HXDLIN( 166)				this->vertices->set((currentVertexPosition - 1),tempY);
            			}
HXLINE( 168)			if ((i == 0)) {
HXLINE( 170)				 ::flixel::math::FlxRect _this = this->bounds;
HXDLIN( 170)				_this->x = tempX;
HXDLIN( 170)				_this->y = tempY;
HXDLIN( 170)				_this->width = ( (Float)(0) );
HXDLIN( 170)				_this->height = ( (Float)(0) );
            			}
            			else {
HXLINE( 174)				 ::flixel::math::FlxRect bounds = this->bounds;
HXDLIN( 174)				if ((tempX < bounds->x)) {
HXLINE( 174)					 ::flixel::math::FlxRect bounds1 = bounds;
HXDLIN( 174)					bounds1->width = (bounds1->width + (bounds->x - tempX));
HXDLIN( 174)					bounds->x = tempX;
            				}
HXDLIN( 174)				if ((tempY < bounds->y)) {
HXLINE( 174)					 ::flixel::math::FlxRect bounds1 = bounds;
HXDLIN( 174)					bounds1->height = (bounds1->height + (bounds->y - tempY));
HXDLIN( 174)					bounds->y = tempY;
            				}
HXDLIN( 174)				if ((tempX > (bounds->x + bounds->width))) {
HXLINE( 174)					bounds->width = (tempX - bounds->x);
            				}
HXDLIN( 174)				if ((tempY > (bounds->y + bounds->height))) {
HXLINE( 174)					bounds->height = (tempY - bounds->y);
            				}
            			}
HXLINE( 177)			i = (i + 2);
            		}
HXLINE( 180)		 ::flixel::math::FlxRect Rect = this->bounds;
HXDLIN( 180)		bool result;
HXDLIN( 180)		bool result1;
HXDLIN( 180)		bool result2;
HXDLIN( 180)		if (((Rect->x + Rect->width) > cameraBounds->x)) {
HXLINE( 180)			result2 = (Rect->x < (cameraBounds->x + cameraBounds->width));
            		}
            		else {
HXLINE( 180)			result2 = false;
            		}
HXDLIN( 180)		if (result2) {
HXLINE( 180)			result1 = ((Rect->y + Rect->height) > cameraBounds->y);
            		}
            		else {
HXLINE( 180)			result1 = false;
            		}
HXDLIN( 180)		if (result1) {
HXLINE( 180)			result = (Rect->y < (cameraBounds->y + cameraBounds->height));
            		}
            		else {
HXLINE( 180)			result = false;
            		}
HXDLIN( 180)		if (Rect->_weak) {
HXLINE( 180)			if (!(Rect->_inPool)) {
HXLINE( 180)				Rect->_inPool = true;
HXDLIN( 180)				Rect->_weak = false;
HXDLIN( 180)				::flixel::math::FlxRect_obj::_pool->putUnsafe(Rect);
            			}
            		}
HXDLIN( 180)		if (!(result)) {
HXLINE( 182)			::Dynamic this1 = this->vertices;
HXDLIN( 182)			::cpp::VirtualArray this2 = ::cpp::VirtualArray_obj::__new(0);
HXDLIN( 182)			this1->__SetField(HX_("__tempIndex",3e,e8,54,22),(this->vertices->get_length() - verticesLength),::hx::paccDynamic);
HXDLIN( 182)			{
HXLINE( 182)				int _g_current = 0;
HXDLIN( 182)				::cpp::VirtualArray _g_args = this2;
HXDLIN( 182)				while((_g_current < _g_args->get_length())){
HXLINE( 182)					_g_current = (_g_current + 1);
HXDLIN( 182)					 ::Dynamic item = _g_args->__get((_g_current - 1));
HXDLIN( 182)					( ( ::openfl::_Vector::FloatVector)(this1) )->insertAt(( (int)(this1->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),( (Float)(item) ));
HXDLIN( 182)					::hx::FieldRef((this1).mPtr,HX_("__tempIndex",3e,e8,54,22))++;
            				}
            			}
HXDLIN( 182)			( ( ::openfl::_Vector::FloatVector)(this1) )->splice(( (int)(this1->__Field(HX_("__tempIndex",3e,e8,54,22),::hx::paccDynamic)) ),verticesLength);
            		}
            		else {
HXLINE( 186)			int uvtDataLength = uvtData->get_length();
HXLINE( 187)			{
HXLINE( 187)				int _g = 0;
HXDLIN( 187)				int _g1 = uvtDataLength;
HXDLIN( 187)				while((_g < _g1)){
HXLINE( 187)					_g = (_g + 1);
HXDLIN( 187)					int i = (_g - 1);
HXLINE( 189)					{
HXLINE( 189)						::Dynamic this1 = this->uvtData;
HXDLIN( 189)						( ( ::openfl::_Vector::FloatVector)(this1) )->set((prevUVTDataLength + i),uvtData->get(i));
            					}
            				}
            			}
HXLINE( 192)			int indicesLength = indices->get_length();
HXLINE( 193)			{
HXLINE( 193)				int _g2 = 0;
HXDLIN( 193)				int _g3 = indicesLength;
HXDLIN( 193)				while((_g2 < _g3)){
HXLINE( 193)					_g2 = (_g2 + 1);
HXDLIN( 193)					int i = (_g2 - 1);
HXLINE( 195)					{
HXLINE( 195)						::Dynamic this1 = this->indices;
HXDLIN( 195)						( ( ::openfl::_Vector::IntVector)(this1) )->set((prevIndicesLength + i),(indices->get(i) + prevNumberOfVertices));
            					}
            				}
            			}
HXLINE( 198)			if (this->colored) {
HXLINE( 200)				{
HXLINE( 200)					int _g = 0;
HXDLIN( 200)					int _g1 = numberOfVertices;
HXDLIN( 200)					while((_g < _g1)){
HXLINE( 200)						_g = (_g + 1);
HXDLIN( 200)						int i = (_g - 1);
HXLINE( 202)						{
HXLINE( 202)							::Dynamic this1 = this->colors;
HXDLIN( 202)							( ( ::openfl::_Vector::IntVector)(this1) )->set((prevColorsLength + i),colors->get(i));
            						}
            					}
            				}
HXLINE( 205)				 ::flixel::graphics::tile::FlxDrawTrianglesItem _hx_tmp = ::hx::ObjectPtr<OBJ_>(this);
HXDLIN( 205)				_hx_tmp->colorsPosition = (_hx_tmp->colorsPosition + numberOfVertices);
            			}
HXLINE( 208)			 ::flixel::graphics::tile::FlxDrawTrianglesItem _hx_tmp = ::hx::ObjectPtr<OBJ_>(this);
HXDLIN( 208)			_hx_tmp->verticesPosition = (_hx_tmp->verticesPosition + verticesLength);
HXLINE( 209)			 ::flixel::graphics::tile::FlxDrawTrianglesItem _hx_tmp1 = ::hx::ObjectPtr<OBJ_>(this);
HXDLIN( 209)			_hx_tmp1->indicesPosition = (_hx_tmp1->indicesPosition + indicesLength);
            		}
HXLINE( 212)		if (position->_weak) {
HXLINE( 212)			position->put();
            		}
HXLINE( 213)		if (cameraBounds->_weak) {
HXLINE( 213)			if (!(cameraBounds->_inPool)) {
HXLINE( 213)				cameraBounds->_inPool = true;
HXDLIN( 213)				cameraBounds->_weak = false;
HXDLIN( 213)				::flixel::math::FlxRect_obj::_pool->putUnsafe(cameraBounds);
            			}
            		}
HXLINE( 216)		{
HXLINE( 216)			int _g = 0;
HXDLIN( 216)			int _g1 = this->get_numTriangles();
HXDLIN( 216)			while((_g < _g1)){
HXLINE( 216)				_g = (_g + 1);
HXDLIN( 216)				int _ = (_g - 1);
HXLINE( 218)				Float _hx_tmp;
HXDLIN( 218)				if (::hx::IsNotNull( transform )) {
HXLINE( 218)					_hx_tmp = transform->alphaMultiplier;
            				}
            				else {
HXLINE( 218)					_hx_tmp = ((Float)1.0);
            				}
HXDLIN( 218)				this->alphas->push(_hx_tmp);
HXLINE( 219)				Float _hx_tmp1;
HXDLIN( 219)				if (::hx::IsNotNull( transform )) {
HXLINE( 219)					_hx_tmp1 = transform->alphaMultiplier;
            				}
            				else {
HXLINE( 219)					_hx_tmp1 = ((Float)1.0);
            				}
HXDLIN( 219)				this->alphas->push(_hx_tmp1);
HXLINE( 220)				Float _hx_tmp2;
HXDLIN( 220)				if (::hx::IsNotNull( transform )) {
HXLINE( 220)					_hx_tmp2 = transform->alphaMultiplier;
            				}
            				else {
HXLINE( 220)					_hx_tmp2 = ((Float)1.0);
            				}
HXDLIN( 220)				this->alphas->push(_hx_tmp2);
            			}
            		}
HXLINE( 223)		bool _hx_tmp;
HXDLIN( 223)		if (!(this->colored)) {
HXLINE( 223)			_hx_tmp = this->hasColorOffsets;
            		}
            		else {
HXLINE( 223)			_hx_tmp = true;
            		}
HXDLIN( 223)		if (_hx_tmp) {
HXLINE( 225)			if (::hx::IsNull( this->colorMultipliers )) {
HXLINE( 226)				this->colorMultipliers = ::Array_obj< Float >::__new(0);
            			}
HXLINE( 228)			if (::hx::IsNull( this->colorOffsets )) {
HXLINE( 229)				this->colorOffsets = ::Array_obj< Float >::__new(0);
            			}
HXLINE( 231)			{
HXLINE( 231)				int _g = 0;
HXDLIN( 231)				int _g1 = (this->get_numTriangles() * 3);
HXDLIN( 231)				while((_g < _g1)){
HXLINE( 231)					_g = (_g + 1);
HXDLIN( 231)					int _ = (_g - 1);
HXLINE( 233)					if (::hx::IsNotNull( transform )) {
HXLINE( 235)						this->colorMultipliers->push(transform->redMultiplier);
HXLINE( 236)						this->colorMultipliers->push(transform->greenMultiplier);
HXLINE( 237)						this->colorMultipliers->push(transform->blueMultiplier);
HXLINE( 239)						this->colorOffsets->push(transform->redOffset);
HXLINE( 240)						this->colorOffsets->push(transform->greenOffset);
HXLINE( 241)						this->colorOffsets->push(transform->blueOffset);
HXLINE( 242)						this->colorOffsets->push(transform->alphaOffset);
            					}
            					else {
HXLINE( 246)						this->colorMultipliers->push(1);
HXLINE( 247)						this->colorMultipliers->push(1);
HXLINE( 248)						this->colorMultipliers->push(1);
HXLINE( 250)						this->colorOffsets->push(0);
HXLINE( 251)						this->colorOffsets->push(0);
HXLINE( 252)						this->colorOffsets->push(0);
HXLINE( 253)						this->colorOffsets->push(0);
            					}
HXLINE( 256)					this->colorMultipliers->push(1);
            				}
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC7(FlxDrawTrianglesItem_obj,addTriangles,(void))

void FlxDrawTrianglesItem_obj::setParameterValue( ::openfl::display::ShaderParameter_Bool parameter,bool value){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_263_setParameterValue)
HXLINE( 264)		if (::hx::IsNull( parameter->value )) {
HXLINE( 265)			parameter->value = ::Array_obj< bool >::__new(0);
            		}
HXLINE( 266)		parameter->value[0] = value;
            	}


HX_DEFINE_DYNAMIC_FUNC2(FlxDrawTrianglesItem_obj,setParameterValue,(void))

void FlxDrawTrianglesItem_obj::addQuad( ::flixel::graphics::frames::FlxFrame frame, ::flixel::math::FlxMatrix matrix, ::openfl::geom::ColorTransform transform){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_297_addQuad)
HXLINE( 298)		int prevVerticesPos = this->verticesPosition;
HXLINE( 299)		int prevIndicesPos = this->indicesPosition;
HXLINE( 300)		int prevColorsPos = this->colorsPosition;
HXLINE( 301)		int prevNumberOfVertices = this->get_numVertices();
HXLINE( 303)		 ::flixel::math::FlxBasePoint point = ::flixel::math::FlxBasePoint_obj::pool->get()->set(( (Float)(0) ),( (Float)(0) ));
HXDLIN( 303)		point->_inPool = false;
HXDLIN( 303)		 ::flixel::math::FlxBasePoint point1 = point;
HXLINE( 304)		{
HXLINE( 304)			Float x1 = (((point1->x * matrix->a) + (point1->y * matrix->c)) + matrix->tx);
HXDLIN( 304)			Float y1 = (((point1->x * matrix->b) + (point1->y * matrix->d)) + matrix->ty);
HXDLIN( 304)			{
HXLINE( 304)				point1->set_x(x1);
HXDLIN( 304)				point1->set_y(y1);
            			}
            		}
HXLINE( 306)		this->vertices->set(prevVerticesPos,point1->x);
HXLINE( 307)		this->vertices->set((prevVerticesPos + 1),point1->y);
HXLINE( 309)		this->uvtData->set(prevVerticesPos,frame->uv->x);
HXLINE( 310)		this->uvtData->set((prevVerticesPos + 1),frame->uv->y);
HXLINE( 312)		{
HXLINE( 312)			point1->set_x(frame->frame->width);
HXDLIN( 312)			point1->set_y(( (Float)(0) ));
            		}
HXLINE( 313)		{
HXLINE( 313)			Float x11 = (((point1->x * matrix->a) + (point1->y * matrix->c)) + matrix->tx);
HXDLIN( 313)			Float y11 = (((point1->x * matrix->b) + (point1->y * matrix->d)) + matrix->ty);
HXDLIN( 313)			{
HXLINE( 313)				point1->set_x(x11);
HXDLIN( 313)				point1->set_y(y11);
            			}
            		}
HXLINE( 315)		this->vertices->set((prevVerticesPos + 2),point1->x);
HXLINE( 316)		this->vertices->set((prevVerticesPos + 3),point1->y);
HXLINE( 318)		this->uvtData->set((prevVerticesPos + 2),frame->uv->width);
HXLINE( 319)		this->uvtData->set((prevVerticesPos + 3),frame->uv->y);
HXLINE( 321)		{
HXLINE( 321)			Float y = frame->frame->height;
HXDLIN( 321)			point1->set_x(frame->frame->width);
HXDLIN( 321)			point1->set_y(y);
            		}
HXLINE( 322)		{
HXLINE( 322)			Float x12 = (((point1->x * matrix->a) + (point1->y * matrix->c)) + matrix->tx);
HXDLIN( 322)			Float y12 = (((point1->x * matrix->b) + (point1->y * matrix->d)) + matrix->ty);
HXDLIN( 322)			{
HXLINE( 322)				point1->set_x(x12);
HXDLIN( 322)				point1->set_y(y12);
            			}
            		}
HXLINE( 324)		this->vertices->set((prevVerticesPos + 4),point1->x);
HXLINE( 325)		this->vertices->set((prevVerticesPos + 5),point1->y);
HXLINE( 327)		this->uvtData->set((prevVerticesPos + 4),frame->uv->width);
HXLINE( 328)		this->uvtData->set((prevVerticesPos + 5),frame->uv->height);
HXLINE( 330)		{
HXLINE( 330)			Float y2 = frame->frame->height;
HXDLIN( 330)			point1->set_x(( (Float)(0) ));
HXDLIN( 330)			point1->set_y(y2);
            		}
HXLINE( 331)		{
HXLINE( 331)			Float x13 = (((point1->x * matrix->a) + (point1->y * matrix->c)) + matrix->tx);
HXDLIN( 331)			Float y13 = (((point1->x * matrix->b) + (point1->y * matrix->d)) + matrix->ty);
HXDLIN( 331)			{
HXLINE( 331)				point1->set_x(x13);
HXDLIN( 331)				point1->set_y(y13);
            			}
            		}
HXLINE( 333)		this->vertices->set((prevVerticesPos + 6),point1->x);
HXLINE( 334)		this->vertices->set((prevVerticesPos + 7),point1->y);
HXLINE( 336)		point1->put();
HXLINE( 338)		this->uvtData->set((prevVerticesPos + 6),frame->uv->x);
HXLINE( 339)		this->uvtData->set((prevVerticesPos + 7),frame->uv->height);
HXLINE( 341)		this->indices->set(prevIndicesPos,prevNumberOfVertices);
HXLINE( 342)		this->indices->set((prevIndicesPos + 1),(prevNumberOfVertices + 1));
HXLINE( 343)		this->indices->set((prevIndicesPos + 2),(prevNumberOfVertices + 2));
HXLINE( 344)		this->indices->set((prevIndicesPos + 3),(prevNumberOfVertices + 2));
HXLINE( 345)		this->indices->set((prevIndicesPos + 4),(prevNumberOfVertices + 3));
HXLINE( 346)		this->indices->set((prevIndicesPos + 5),prevNumberOfVertices);
HXLINE( 348)		if (this->colored) {
HXLINE( 350)			Float red = ((Float)1.0);
HXLINE( 351)			Float green = ((Float)1.0);
HXLINE( 352)			Float blue = ((Float)1.0);
HXLINE( 353)			Float alpha = ((Float)1.0);
HXLINE( 355)			if (::hx::IsNotNull( transform )) {
HXLINE( 357)				red = transform->redMultiplier;
HXLINE( 358)				green = transform->greenMultiplier;
HXLINE( 359)				blue = transform->blueMultiplier;
HXLINE( 362)				alpha = transform->alphaMultiplier;
            			}
HXLINE( 366)			int color = ::flixel::util::_FlxColor::FlxColor_Impl__obj::_new(null());
HXDLIN( 366)			{
HXLINE( 366)				int Value = ::Math_obj::round((red * ( (Float)(255) )));
HXDLIN( 366)				color = (color & -16711681);
HXDLIN( 366)				int color1;
HXDLIN( 366)				if ((Value > 255)) {
HXLINE( 366)					color1 = 255;
            				}
            				else {
HXLINE( 366)					if ((Value < 0)) {
HXLINE( 366)						color1 = 0;
            					}
            					else {
HXLINE( 366)						color1 = Value;
            					}
            				}
HXDLIN( 366)				color = (color | (color1 << 16));
            			}
HXDLIN( 366)			{
HXLINE( 366)				int Value1 = ::Math_obj::round((green * ( (Float)(255) )));
HXDLIN( 366)				color = (color & -65281);
HXDLIN( 366)				int color2;
HXDLIN( 366)				if ((Value1 > 255)) {
HXLINE( 366)					color2 = 255;
            				}
            				else {
HXLINE( 366)					if ((Value1 < 0)) {
HXLINE( 366)						color2 = 0;
            					}
            					else {
HXLINE( 366)						color2 = Value1;
            					}
            				}
HXDLIN( 366)				color = (color | (color2 << 8));
            			}
HXDLIN( 366)			{
HXLINE( 366)				int Value2 = ::Math_obj::round((blue * ( (Float)(255) )));
HXDLIN( 366)				color = (color & -256);
HXDLIN( 366)				int color3;
HXDLIN( 366)				if ((Value2 > 255)) {
HXLINE( 366)					color3 = 255;
            				}
            				else {
HXLINE( 366)					if ((Value2 < 0)) {
HXLINE( 366)						color3 = 0;
            					}
            					else {
HXLINE( 366)						color3 = Value2;
            					}
            				}
HXDLIN( 366)				color = (color | color3);
            			}
HXDLIN( 366)			{
HXLINE( 366)				int Value3 = ::Math_obj::round((alpha * ( (Float)(255) )));
HXDLIN( 366)				color = (color & 16777215);
HXDLIN( 366)				int color4;
HXDLIN( 366)				if ((Value3 > 255)) {
HXLINE( 366)					color4 = 255;
            				}
            				else {
HXLINE( 366)					if ((Value3 < 0)) {
HXLINE( 366)						color4 = 0;
            					}
            					else {
HXLINE( 366)						color4 = Value3;
            					}
            				}
HXDLIN( 366)				color = (color | (color4 << 24));
            			}
HXDLIN( 366)			int color5 = color;
HXLINE( 368)			this->colors->set(prevColorsPos,color5);
HXLINE( 369)			this->colors->set((prevColorsPos + 1),color5);
HXLINE( 370)			this->colors->set((prevColorsPos + 2),color5);
HXLINE( 371)			this->colors->set((prevColorsPos + 3),color5);
HXLINE( 373)			 ::flixel::graphics::tile::FlxDrawTrianglesItem _hx_tmp = ::hx::ObjectPtr<OBJ_>(this);
HXDLIN( 373)			_hx_tmp->colorsPosition = (_hx_tmp->colorsPosition + 4);
            		}
HXLINE( 376)		 ::flixel::graphics::tile::FlxDrawTrianglesItem _hx_tmp = ::hx::ObjectPtr<OBJ_>(this);
HXDLIN( 376)		_hx_tmp->verticesPosition = (_hx_tmp->verticesPosition + 8);
HXLINE( 377)		 ::flixel::graphics::tile::FlxDrawTrianglesItem _hx_tmp1 = ::hx::ObjectPtr<OBJ_>(this);
HXDLIN( 377)		_hx_tmp1->indicesPosition = (_hx_tmp1->indicesPosition + 6);
            	}


int FlxDrawTrianglesItem_obj::get_numVertices(){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_382_get_numVertices)
HXDLIN( 382)		return ::Std_obj::_hx_int((( (Float)(this->vertices->get_length()) ) / ( (Float)(2) )));
            	}


int FlxDrawTrianglesItem_obj::get_numTriangles(){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_387_get_numTriangles)
HXDLIN( 387)		return ::Std_obj::_hx_int((( (Float)(this->indices->get_length()) ) / ( (Float)(3) )));
            	}


 ::flixel::math::FlxBasePoint FlxDrawTrianglesItem_obj::point;

 ::flixel::math::FlxRect FlxDrawTrianglesItem_obj::rect;

 ::flixel::math::FlxRect FlxDrawTrianglesItem_obj::inflateBounds( ::flixel::math::FlxRect bounds,Float x,Float y){
            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_270_inflateBounds)
HXLINE( 271)		if ((x < bounds->x)) {
HXLINE( 273)			 ::flixel::math::FlxRect bounds1 = bounds;
HXDLIN( 273)			bounds1->width = (bounds1->width + (bounds->x - x));
HXLINE( 274)			bounds->x = x;
            		}
HXLINE( 277)		if ((y < bounds->y)) {
HXLINE( 279)			 ::flixel::math::FlxRect bounds1 = bounds;
HXDLIN( 279)			bounds1->height = (bounds1->height + (bounds->y - y));
HXLINE( 280)			bounds->y = y;
            		}
HXLINE( 283)		if ((x > (bounds->x + bounds->width))) {
HXLINE( 285)			bounds->width = (x - bounds->x);
            		}
HXLINE( 288)		if ((y > (bounds->y + bounds->height))) {
HXLINE( 290)			bounds->height = (y - bounds->y);
            		}
HXLINE( 293)		return bounds;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(FlxDrawTrianglesItem_obj,inflateBounds,return )


::hx::ObjectPtr< FlxDrawTrianglesItem_obj > FlxDrawTrianglesItem_obj::__new() {
	::hx::ObjectPtr< FlxDrawTrianglesItem_obj > __this = new FlxDrawTrianglesItem_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< FlxDrawTrianglesItem_obj > FlxDrawTrianglesItem_obj::__alloc(::hx::Ctx *_hx_ctx) {
	FlxDrawTrianglesItem_obj *__this = (FlxDrawTrianglesItem_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(FlxDrawTrianglesItem_obj), true, "flixel.graphics.tile.FlxDrawTrianglesItem"));
	*(void **)__this = FlxDrawTrianglesItem_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

FlxDrawTrianglesItem_obj::FlxDrawTrianglesItem_obj()
{
}

void FlxDrawTrianglesItem_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(FlxDrawTrianglesItem);
	HX_MARK_MEMBER_NAME(shader,"shader");
	HX_MARK_MEMBER_NAME(alphas,"alphas");
	HX_MARK_MEMBER_NAME(colorMultipliers,"colorMultipliers");
	HX_MARK_MEMBER_NAME(colorOffsets,"colorOffsets");
	HX_MARK_MEMBER_NAME(vertices,"vertices");
	HX_MARK_MEMBER_NAME(indices,"indices");
	HX_MARK_MEMBER_NAME(uvtData,"uvtData");
	HX_MARK_MEMBER_NAME(colors,"colors");
	HX_MARK_MEMBER_NAME(verticesPosition,"verticesPosition");
	HX_MARK_MEMBER_NAME(indicesPosition,"indicesPosition");
	HX_MARK_MEMBER_NAME(colorsPosition,"colorsPosition");
	HX_MARK_MEMBER_NAME(bounds,"bounds");
	 ::flixel::graphics::tile::FlxDrawBaseItem_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void FlxDrawTrianglesItem_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(shader,"shader");
	HX_VISIT_MEMBER_NAME(alphas,"alphas");
	HX_VISIT_MEMBER_NAME(colorMultipliers,"colorMultipliers");
	HX_VISIT_MEMBER_NAME(colorOffsets,"colorOffsets");
	HX_VISIT_MEMBER_NAME(vertices,"vertices");
	HX_VISIT_MEMBER_NAME(indices,"indices");
	HX_VISIT_MEMBER_NAME(uvtData,"uvtData");
	HX_VISIT_MEMBER_NAME(colors,"colors");
	HX_VISIT_MEMBER_NAME(verticesPosition,"verticesPosition");
	HX_VISIT_MEMBER_NAME(indicesPosition,"indicesPosition");
	HX_VISIT_MEMBER_NAME(colorsPosition,"colorsPosition");
	HX_VISIT_MEMBER_NAME(bounds,"bounds");
	 ::flixel::graphics::tile::FlxDrawBaseItem_obj::__Visit(HX_VISIT_ARG);
}

::hx::Val FlxDrawTrianglesItem_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"reset") ) { return ::hx::Val( reset_dyn() ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"shader") ) { return ::hx::Val( shader ); }
		if (HX_FIELD_EQ(inName,"alphas") ) { return ::hx::Val( alphas ); }
		if (HX_FIELD_EQ(inName,"colors") ) { return ::hx::Val( colors ); }
		if (HX_FIELD_EQ(inName,"bounds") ) { return ::hx::Val( bounds ); }
		if (HX_FIELD_EQ(inName,"render") ) { return ::hx::Val( render_dyn() ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"indices") ) { return ::hx::Val( indices ); }
		if (HX_FIELD_EQ(inName,"uvtData") ) { return ::hx::Val( uvtData ); }
		if (HX_FIELD_EQ(inName,"dispose") ) { return ::hx::Val( dispose_dyn() ); }
		if (HX_FIELD_EQ(inName,"addQuad") ) { return ::hx::Val( addQuad_dyn() ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"vertices") ) { return ::hx::Val( vertices ); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"colorOffsets") ) { return ::hx::Val( colorOffsets ); }
		if (HX_FIELD_EQ(inName,"addTriangles") ) { return ::hx::Val( addTriangles_dyn() ); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"colorsPosition") ) { return ::hx::Val( colorsPosition ); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"indicesPosition") ) { return ::hx::Val( indicesPosition ); }
		if (HX_FIELD_EQ(inName,"get_numVertices") ) { return ::hx::Val( get_numVertices_dyn() ); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"colorMultipliers") ) { return ::hx::Val( colorMultipliers ); }
		if (HX_FIELD_EQ(inName,"verticesPosition") ) { return ::hx::Val( verticesPosition ); }
		if (HX_FIELD_EQ(inName,"get_numTriangles") ) { return ::hx::Val( get_numTriangles_dyn() ); }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"setParameterValue") ) { return ::hx::Val( setParameterValue_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

bool FlxDrawTrianglesItem_obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"rect") ) { outValue = ( rect ); return true; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"point") ) { outValue = ( point ); return true; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"inflateBounds") ) { outValue = inflateBounds_dyn(); return true; }
	}
	return false;
}

::hx::Val FlxDrawTrianglesItem_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"shader") ) { shader=inValue.Cast<  ::flixel::graphics::tile::FlxGraphicsShader >(); return inValue; }
		if (HX_FIELD_EQ(inName,"alphas") ) { alphas=inValue.Cast< ::Array< Float > >(); return inValue; }
		if (HX_FIELD_EQ(inName,"colors") ) { colors=inValue.Cast<  ::openfl::_Vector::IntVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"bounds") ) { bounds=inValue.Cast<  ::flixel::math::FlxRect >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"indices") ) { indices=inValue.Cast<  ::openfl::_Vector::IntVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"uvtData") ) { uvtData=inValue.Cast<  ::openfl::_Vector::FloatVector >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"vertices") ) { vertices=inValue.Cast<  ::openfl::_Vector::FloatVector >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"colorOffsets") ) { colorOffsets=inValue.Cast< ::Array< Float > >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"colorsPosition") ) { colorsPosition=inValue.Cast< int >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"indicesPosition") ) { indicesPosition=inValue.Cast< int >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"colorMultipliers") ) { colorMultipliers=inValue.Cast< ::Array< Float > >(); return inValue; }
		if (HX_FIELD_EQ(inName,"verticesPosition") ) { verticesPosition=inValue.Cast< int >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

bool FlxDrawTrianglesItem_obj::__SetStatic(const ::String &inName,Dynamic &ioValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"rect") ) { rect=ioValue.Cast<  ::flixel::math::FlxRect >(); return true; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"point") ) { point=ioValue.Cast<  ::flixel::math::FlxBasePoint >(); return true; }
	}
	return false;
}

void FlxDrawTrianglesItem_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("shader",25,bf,20,1d));
	outFields->push(HX_("alphas",55,cb,3b,42));
	outFields->push(HX_("colorMultipliers",2f,d5,72,20));
	outFields->push(HX_("colorOffsets",5d,02,bc,00));
	outFields->push(HX_("vertices",f9,bf,15,6a));
	outFields->push(HX_("indices",27,47,54,e3));
	outFields->push(HX_("uvtData",bd,a6,23,27));
	outFields->push(HX_("colors",b0,c5,86,c6));
	outFields->push(HX_("verticesPosition",c2,3d,e8,f5));
	outFields->push(HX_("indicesPosition",f0,a2,e6,12));
	outFields->push(HX_("colorsPosition",79,52,f8,2c));
	outFields->push(HX_("bounds",75,86,1d,66));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo FlxDrawTrianglesItem_obj_sMemberStorageInfo[] = {
	{::hx::fsObject /*  ::flixel::graphics::tile::FlxGraphicsShader */ ,(int)offsetof(FlxDrawTrianglesItem_obj,shader),HX_("shader",25,bf,20,1d)},
	{::hx::fsObject /* ::Array< Float > */ ,(int)offsetof(FlxDrawTrianglesItem_obj,alphas),HX_("alphas",55,cb,3b,42)},
	{::hx::fsObject /* ::Array< Float > */ ,(int)offsetof(FlxDrawTrianglesItem_obj,colorMultipliers),HX_("colorMultipliers",2f,d5,72,20)},
	{::hx::fsObject /* ::Array< Float > */ ,(int)offsetof(FlxDrawTrianglesItem_obj,colorOffsets),HX_("colorOffsets",5d,02,bc,00)},
	{::hx::fsObject /*  ::openfl::_Vector::FloatVector */ ,(int)offsetof(FlxDrawTrianglesItem_obj,vertices),HX_("vertices",f9,bf,15,6a)},
	{::hx::fsObject /*  ::openfl::_Vector::IntVector */ ,(int)offsetof(FlxDrawTrianglesItem_obj,indices),HX_("indices",27,47,54,e3)},
	{::hx::fsObject /*  ::openfl::_Vector::FloatVector */ ,(int)offsetof(FlxDrawTrianglesItem_obj,uvtData),HX_("uvtData",bd,a6,23,27)},
	{::hx::fsObject /*  ::openfl::_Vector::IntVector */ ,(int)offsetof(FlxDrawTrianglesItem_obj,colors),HX_("colors",b0,c5,86,c6)},
	{::hx::fsInt,(int)offsetof(FlxDrawTrianglesItem_obj,verticesPosition),HX_("verticesPosition",c2,3d,e8,f5)},
	{::hx::fsInt,(int)offsetof(FlxDrawTrianglesItem_obj,indicesPosition),HX_("indicesPosition",f0,a2,e6,12)},
	{::hx::fsInt,(int)offsetof(FlxDrawTrianglesItem_obj,colorsPosition),HX_("colorsPosition",79,52,f8,2c)},
	{::hx::fsObject /*  ::flixel::math::FlxRect */ ,(int)offsetof(FlxDrawTrianglesItem_obj,bounds),HX_("bounds",75,86,1d,66)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo FlxDrawTrianglesItem_obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::flixel::math::FlxBasePoint */ ,(void *) &FlxDrawTrianglesItem_obj::point,HX_("point",50,b4,8f,c6)},
	{::hx::fsObject /*  ::flixel::math::FlxRect */ ,(void *) &FlxDrawTrianglesItem_obj::rect,HX_("rect",24,4d,a7,4b)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static ::String FlxDrawTrianglesItem_obj_sMemberFields[] = {
	HX_("shader",25,bf,20,1d),
	HX_("alphas",55,cb,3b,42),
	HX_("colorMultipliers",2f,d5,72,20),
	HX_("colorOffsets",5d,02,bc,00),
	HX_("vertices",f9,bf,15,6a),
	HX_("indices",27,47,54,e3),
	HX_("uvtData",bd,a6,23,27),
	HX_("colors",b0,c5,86,c6),
	HX_("verticesPosition",c2,3d,e8,f5),
	HX_("indicesPosition",f0,a2,e6,12),
	HX_("colorsPosition",79,52,f8,2c),
	HX_("bounds",75,86,1d,66),
	HX_("render",56,6b,29,05),
	HX_("reset",cf,49,c8,e6),
	HX_("dispose",9f,80,4c,bb),
	HX_("addTriangles",4a,52,95,7e),
	HX_("setParameterValue",4a,1c,87,10),
	HX_("addQuad",88,7b,47,87),
	HX_("get_numVertices",f6,c7,0d,17),
	HX_("get_numTriangles",0e,26,50,2b),
	::String(null()) };

static void FlxDrawTrianglesItem_obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(FlxDrawTrianglesItem_obj::point,"point");
	HX_MARK_MEMBER_NAME(FlxDrawTrianglesItem_obj::rect,"rect");
};

#ifdef HXCPP_VISIT_ALLOCS
static void FlxDrawTrianglesItem_obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(FlxDrawTrianglesItem_obj::point,"point");
	HX_VISIT_MEMBER_NAME(FlxDrawTrianglesItem_obj::rect,"rect");
};

#endif

::hx::Class FlxDrawTrianglesItem_obj::__mClass;

static ::String FlxDrawTrianglesItem_obj_sStaticFields[] = {
	HX_("point",50,b4,8f,c6),
	HX_("rect",24,4d,a7,4b),
	HX_("inflateBounds",5c,36,3c,2f),
	::String(null())
};

void FlxDrawTrianglesItem_obj::__register()
{
	FlxDrawTrianglesItem_obj _hx_dummy;
	FlxDrawTrianglesItem_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.graphics.tile.FlxDrawTrianglesItem",b7,10,12,af);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &FlxDrawTrianglesItem_obj::__GetStatic;
	__mClass->mSetStaticField = &FlxDrawTrianglesItem_obj::__SetStatic;
	__mClass->mMarkFunc = FlxDrawTrianglesItem_obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(FlxDrawTrianglesItem_obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(FlxDrawTrianglesItem_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< FlxDrawTrianglesItem_obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = FlxDrawTrianglesItem_obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = FlxDrawTrianglesItem_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = FlxDrawTrianglesItem_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void FlxDrawTrianglesItem_obj::__boot()
{
{
            		HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_0) HXARGC(0)
            		 ::flixel::math::FlxBasePoint _hx_run(){
            			HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_23_boot)
HXDLIN(  23)			 ::flixel::math::FlxBasePoint point = ::flixel::math::FlxBasePoint_obj::pool->get()->set(( (Float)(0) ),( (Float)(0) ));
HXDLIN(  23)			point->_inPool = false;
HXDLIN(  23)			return point;
            		}
            		HX_END_LOCAL_FUNC0(return)

            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_23_boot)
HXDLIN(  23)		point = ( ( ::flixel::math::FlxBasePoint)( ::Dynamic(new _hx_Closure_0())()) );
            	}
{
            		HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_0) HXARGC(0)
            		 ::flixel::math::FlxRect _hx_run(){
            			HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_24_boot)
HXDLIN(  24)			 ::flixel::math::FlxRect _this = ::flixel::math::FlxRect_obj::_pool->get();
HXDLIN(  24)			_this->x = ( (Float)(0) );
HXDLIN(  24)			_this->y = ( (Float)(0) );
HXDLIN(  24)			_this->width = ( (Float)(0) );
HXDLIN(  24)			_this->height = ( (Float)(0) );
HXDLIN(  24)			 ::flixel::math::FlxRect rect = _this;
HXDLIN(  24)			rect->_inPool = false;
HXDLIN(  24)			return rect;
            		}
            		HX_END_LOCAL_FUNC0(return)

            	HX_STACKFRAME(&_hx_pos_a928be64e2bd594d_24_boot)
HXDLIN(  24)		rect = ( ( ::flixel::math::FlxRect)( ::Dynamic(new _hx_Closure_0())()) );
            	}
}

} // end namespace flixel
} // end namespace graphics
} // end namespace tile
