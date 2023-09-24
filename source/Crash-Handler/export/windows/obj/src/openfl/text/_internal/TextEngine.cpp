#include <hxcpp.h>

#ifndef INCLUDED_95f339a1d026d52c
#define INCLUDED_95f339a1d026d52c
#include "hxMath.h"
#endif
#ifndef INCLUDED_EReg
#include <EReg.h>
#endif
#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_StringTools
#include <StringTools.h>
#endif
#ifndef INCLUDED_haxe_IMap
#include <haxe/IMap.h>
#endif
#ifndef INCLUDED_haxe_Timer
#include <haxe/Timer.h>
#endif
#ifndef INCLUDED_haxe_ds_StringMap
#include <haxe/ds/StringMap.h>
#endif
#ifndef INCLUDED_lime_graphics_opengl_GLObject
#include <lime/graphics/opengl/GLObject.h>
#endif
#ifndef INCLUDED_lime_math_Vector2
#include <lime/math/Vector2.h>
#endif
#ifndef INCLUDED_lime_system_System
#include <lime/system/System.h>
#endif
#ifndef INCLUDED_lime_text_Font
#include <lime/text/Font.h>
#endif
#ifndef INCLUDED_lime_utils_Log
#include <lime/utils/Log.h>
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
#ifndef INCLUDED_openfl__Vector_ObjectVector
#include <openfl/_Vector/ObjectVector.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObject
#include <openfl/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_events_EventDispatcher
#include <openfl/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_IEventDispatcher
#include <openfl/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_geom_Rectangle
#include <openfl/geom/Rectangle.h>
#endif
#ifndef INCLUDED_openfl_text_Font
#include <openfl/text/Font.h>
#endif
#ifndef INCLUDED_openfl_text_TextField
#include <openfl/text/TextField.h>
#endif
#ifndef INCLUDED_openfl_text_TextFormat
#include <openfl/text/TextFormat.h>
#endif
#ifndef INCLUDED_openfl_text__internal_GlyphPosition
#include <openfl/text/_internal/GlyphPosition.h>
#endif
#ifndef INCLUDED_openfl_text__internal_ShapeCache
#include <openfl/text/_internal/ShapeCache.h>
#endif
#ifndef INCLUDED_openfl_text__internal_TextEngine
#include <openfl/text/_internal/TextEngine.h>
#endif
#ifndef INCLUDED_openfl_text__internal_TextFormatRange
#include <openfl/text/_internal/TextFormatRange.h>
#endif
#ifndef INCLUDED_openfl_text__internal_TextLayout
#include <openfl/text/_internal/TextLayout.h>
#endif
#ifndef INCLUDED_openfl_text__internal_TextLayoutGroup
#include <openfl/text/_internal/TextLayoutGroup.h>
#endif
#ifndef INCLUDED_openfl_text__internal__TextEngine_DefaultFontSet
#include <openfl/text/_internal/_TextEngine/DefaultFontSet.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_81873a2f4b2980c0_111_new,"openfl.text._internal.TextEngine","new",0xa9ba7af6,"openfl.text._internal.TextEngine.new","openfl/text/_internal/TextEngine.hx",111,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_175_createRestrictRegexp,"openfl.text._internal.TextEngine","createRestrictRegexp",0x6873dceb,"openfl.text._internal.TextEngine.createRestrictRegexp","openfl/text/_internal/TextEngine.hx",175,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_169_createRestrictRegexp,"openfl.text._internal.TextEngine","createRestrictRegexp",0x6873dceb,"openfl.text._internal.TextEngine.createRestrictRegexp","openfl/text/_internal/TextEngine.hx",169,0xb85e1839)
static const ::String _hx_array_data_7e808804_3[] = {
	HX_("",00,00,00,00),
};
static const bool _hx_array_data_7e808804_4[] = {
	0,
};
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_264_getBounds,"openfl.text._internal.TextEngine","getBounds",0x3ac9cec1,"openfl.text._internal.TextEngine.getBounds","openfl/text/_internal/TextEngine.hx",264,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_552_getLine,"openfl.text._internal.TextEngine","getLine",0xeb547540,"openfl.text._internal.TextEngine.getLine","openfl/text/_internal/TextEngine.hx",552,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_569_getLineBreaks,"openfl.text._internal.TextEngine","getLineBreaks",0x21405c34,"openfl.text._internal.TextEngine.getLineBreaks","openfl/text/_internal/TextEngine.hx",569,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_589_getLineBreakIndex,"openfl.text._internal.TextEngine","getLineBreakIndex",0xa9a1db33,"openfl.text._internal.TextEngine.getLineBreakIndex","openfl/text/_internal/TextEngine.hx",589,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_599_getLineMeasurements,"openfl.text._internal.TextEngine","getLineMeasurements",0x50395657,"openfl.text._internal.TextEngine.getLineMeasurements","openfl/text/_internal/TextEngine.hx",599,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_758_getLayoutGroups,"openfl.text._internal.TextEngine","getLayoutGroups",0x36de2bea,"openfl.text._internal.TextEngine.getLayoutGroups","openfl/text/_internal/TextEngine.hx",758,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1683_restrictText,"openfl.text._internal.TextEngine","restrictText",0x4d5464b3,"openfl.text._internal.TextEngine.restrictText","openfl/text/_internal/TextEngine.hx",1683,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1704_setTextAlignment,"openfl.text._internal.TextEngine","setTextAlignment",0x7bf8ff1e,"openfl.text._internal.TextEngine.setTextAlignment","openfl/text/_internal/TextEngine.hx",1704,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1811_trimText,"openfl.text._internal.TextEngine","trimText",0x8f1ce459,"openfl.text._internal.TextEngine.trimText","openfl/text/_internal/TextEngine.hx",1811,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1826_update,"openfl.text._internal.TextEngine","update",0x02cb1d33,"openfl.text._internal.TextEngine.update","openfl/text/_internal/TextEngine.hx",1826,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1859_get_bottomScrollV,"openfl.text._internal.TextEngine","get_bottomScrollV",0x0563c86b,"openfl.text._internal.TextEngine.get_bottomScrollV","openfl/text/_internal/TextEngine.hx",1859,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1906_get_maxScrollV,"openfl.text._internal.TextEngine","get_maxScrollV",0x5a4206d8,"openfl.text._internal.TextEngine.get_maxScrollV","openfl/text/_internal/TextEngine.hx",1906,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1947_set_restrict,"openfl.text._internal.TextEngine","set_restrict",0xd4c7f563,"openfl.text._internal.TextEngine.set_restrict","openfl/text/_internal/TextEngine.hx",1947,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1968_get_scrollV,"openfl.text._internal.TextEngine","get_scrollV",0x1f66c456,"openfl.text._internal.TextEngine.get_scrollV","openfl/text/_internal/TextEngine.hx",1968,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1980_set_scrollV,"openfl.text._internal.TextEngine","set_scrollV",0x29d3cb62,"openfl.text._internal.TextEngine.set_scrollV","openfl/text/_internal/TextEngine.hx",1980,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_1989_set_text,"openfl.text._internal.TextEngine","set_text",0xa4cb1754,"openfl.text._internal.TextEngine.set_text","openfl/text/_internal/TextEngine.hx",1989,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_202_findFont,"openfl.text._internal.TextEngine","findFont",0xc00da052,"openfl.text._internal.TextEngine.findFont","openfl/text/_internal/TextEngine.hx",202,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_239_findFontVariant,"openfl.text._internal.TextEngine","findFontVariant",0x8f425653,"openfl.text._internal.TextEngine.findFontVariant","openfl/text/_internal/TextEngine.hx",239,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_296_getDefaultFont,"openfl.text._internal.TextEngine","getDefaultFont",0xe66d7b64,"openfl.text._internal.TextEngine.getDefaultFont","openfl/text/_internal/TextEngine.hx",296,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_305_getDefaultFont,"openfl.text._internal.TextEngine","getDefaultFont",0xe66d7b64,"openfl.text._internal.TextEngine.getDefaultFont","openfl/text/_internal/TextEngine.hx",305,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_425_getFormatHeight,"openfl.text._internal.TextEngine","getFormatHeight",0x3ed257ca,"openfl.text._internal.TextEngine.getFormatHeight","openfl/text/_internal/TextEngine.hx",425,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_465_getFont,"openfl.text._internal.TextEngine","getFont",0xe761bb1b,"openfl.text._internal.TextEngine.getFont","openfl/text/_internal/TextEngine.hx",465,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_523_getFontInstance,"openfl.text._internal.TextEngine","getFontInstance",0x7b1da9d0,"openfl.text._internal.TextEngine.getFontInstance","openfl/text/_internal/TextEngine.hx",523,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_38_boot,"openfl.text._internal.TextEngine","boot",0xd18a1cdc,"openfl.text._internal.TextEngine.boot","openfl/text/_internal/TextEngine.hx",38,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_40_boot,"openfl.text._internal.TextEngine","boot",0xd18a1cdc,"openfl.text._internal.TextEngine.boot","openfl/text/_internal/TextEngine.hx",40,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_41_boot,"openfl.text._internal.TextEngine","boot",0xd18a1cdc,"openfl.text._internal.TextEngine.boot","openfl/text/_internal/TextEngine.hx",41,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_42_boot,"openfl.text._internal.TextEngine","boot",0xd18a1cdc,"openfl.text._internal.TextEngine.boot","openfl/text/_internal/TextEngine.hx",42,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_43_boot,"openfl.text._internal.TextEngine","boot",0xd18a1cdc,"openfl.text._internal.TextEngine.boot","openfl/text/_internal/TextEngine.hx",43,0xb85e1839)
HX_LOCAL_STACK_FRAME(_hx_pos_81873a2f4b2980c0_44_boot,"openfl.text._internal.TextEngine","boot",0xd18a1cdc,"openfl.text._internal.TextEngine.boot","openfl/text/_internal/TextEngine.hx",44,0xb85e1839)
namespace openfl{
namespace text{
namespace _internal{

void TextEngine_obj::__construct( ::openfl::text::TextField textField){
            	HX_GC_STACKFRAME(&_hx_pos_81873a2f4b2980c0_111_new)
HXLINE( 112)		this->_hx___shapeCache =  ::openfl::text::_internal::ShapeCache_obj::__alloc( HX_CTX );
HXLINE( 113)		this->textField = textField;
HXLINE( 115)		this->width = ( (Float)(100) );
HXLINE( 116)		this->height = ( (Float)(100) );
HXLINE( 117)		this->set_text(HX_("",00,00,00,00));
HXLINE( 119)		this->bounds =  ::openfl::geom::Rectangle_obj::__alloc( HX_CTX ,0,0,0,0);
HXLINE( 120)		this->textBounds =  ::openfl::geom::Rectangle_obj::__alloc( HX_CTX ,0,0,0,0);
HXLINE( 122)		this->type = 0;
HXLINE( 123)		this->autoSize = 2;
HXLINE( 124)		this->embedFonts = false;
HXLINE( 125)		this->selectable = true;
HXLINE( 126)		this->borderColor = 0;
HXLINE( 127)		this->border = false;
HXLINE( 128)		this->backgroundColor = 16777215;
HXLINE( 129)		this->background = false;
HXLINE( 130)		this->gridFitType = 1;
HXLINE( 131)		this->maxChars = 0;
HXLINE( 132)		this->multiline = false;
HXLINE( 133)		this->numLines = 1;
HXLINE( 134)		this->sharpness = ( (Float)(0) );
HXLINE( 135)		this->scrollH = 0;
HXLINE( 136)		this->set_scrollV(1);
HXLINE( 137)		this->wordWrap = false;
HXLINE( 139)		int length = null();
HXDLIN( 139)		bool fixed = null();
HXDLIN( 139)		::Array< Float > array = null();
HXDLIN( 139)		this->lineAscents =  ::openfl::_Vector::FloatVector_obj::__alloc( HX_CTX ,length,fixed,array,true);
HXLINE( 140)		int length1 = null();
HXDLIN( 140)		bool fixed1 = null();
HXDLIN( 140)		::Array< int > array1 = null();
HXDLIN( 140)		this->lineBreaks =  ::openfl::_Vector::IntVector_obj::__alloc( HX_CTX ,length1,fixed1,array1);
HXLINE( 141)		int length2 = null();
HXDLIN( 141)		bool fixed2 = null();
HXDLIN( 141)		::Array< Float > array2 = null();
HXDLIN( 141)		this->lineDescents =  ::openfl::_Vector::FloatVector_obj::__alloc( HX_CTX ,length2,fixed2,array2,true);
HXLINE( 142)		int length3 = null();
HXDLIN( 142)		bool fixed3 = null();
HXDLIN( 142)		::Array< Float > array3 = null();
HXDLIN( 142)		this->lineLeadings =  ::openfl::_Vector::FloatVector_obj::__alloc( HX_CTX ,length3,fixed3,array3,true);
HXLINE( 143)		int length4 = null();
HXDLIN( 143)		bool fixed4 = null();
HXDLIN( 143)		::Array< Float > array4 = null();
HXDLIN( 143)		this->lineHeights =  ::openfl::_Vector::FloatVector_obj::__alloc( HX_CTX ,length4,fixed4,array4,true);
HXLINE( 144)		int length5 = null();
HXDLIN( 144)		bool fixed5 = null();
HXDLIN( 144)		::Array< Float > array5 = null();
HXDLIN( 144)		this->lineWidths =  ::openfl::_Vector::FloatVector_obj::__alloc( HX_CTX ,length5,fixed5,array5,true);
HXLINE( 145)		int length6 = null();
HXDLIN( 145)		bool fixed6 = null();
HXDLIN( 145)		::Array< ::Dynamic> array6 = null();
HXDLIN( 145)		this->layoutGroups =  ::openfl::_Vector::ObjectVector_obj::__alloc( HX_CTX ,length6,fixed6,array6,true);
HXLINE( 146)		int length7 = null();
HXDLIN( 146)		bool fixed7 = null();
HXDLIN( 146)		::Array< ::Dynamic> array7 = null();
HXDLIN( 146)		this->textFormatRanges =  ::openfl::_Vector::ObjectVector_obj::__alloc( HX_CTX ,length7,fixed7,array7,true);
            	}

Dynamic TextEngine_obj::__CreateEmpty() { return new TextEngine_obj; }

void *TextEngine_obj::_hx_vtable = 0;

Dynamic TextEngine_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< TextEngine_obj > _hx_result = new TextEngine_obj();
	_hx_result->__construct(inArgs[0]);
	return _hx_result;
}

bool TextEngine_obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x2dd5980a;
}

 ::EReg TextEngine_obj::createRestrictRegexp(::String restrict){
            		HX_BEGIN_LOCAL_FUNC_S2(::hx::LocalFunc,_hx_Closure_0,::Array< ::String >,declined,::Array< bool >,accepting) HXARGC(1)
            		::String _hx_run( ::EReg ereg){
            			HX_GC_STACKFRAME(&_hx_pos_81873a2f4b2980c0_175_createRestrictRegexp)
HXLINE( 176)			if (accepting->__get(0)) {
HXLINE( 178)				accepting[0] = !(accepting->__get(0));
HXLINE( 179)				return ereg->matched(1);
            			}
HXLINE( 181)			::Array< ::String > declined1 = declined;
HXDLIN( 181)			int accepted = 0;
HXDLIN( 181)			::String declined2 = declined1->__get(accepted);
HXDLIN( 181)			declined1[accepted] = (declined2 + ereg->matched(1));
HXLINE( 182)			accepting[0] = !(accepting->__get(0));
HXLINE( 183)			return HX_("",00,00,00,00);
            		}
            		HX_END_LOCAL_FUNC1(return)

            	HX_GC_STACKFRAME(&_hx_pos_81873a2f4b2980c0_169_createRestrictRegexp)
HXLINE( 170)		 ::EReg declinedRange =  ::EReg_obj::__alloc( HX_CTX ,HX_("\\^([^\\^]+)",d0,bc,3c,14),HX_("gu",2e,5a,00,00));
HXLINE( 171)		::Array< ::String > declined = ::Array_obj< ::String >::fromData( _hx_array_data_7e808804_3,1);
HXLINE( 173)		::Array< bool > accepting = ::Array_obj< bool >::fromData( _hx_array_data_7e808804_4,1);
HXLINE( 174)		::String accepted = declinedRange->map(restrict, ::Dynamic(new _hx_Closure_0(declined,accepting)));
HXLINE( 186)		::Array< ::String > testRegexpParts = ::Array_obj< ::String >::__new(0);
HXLINE( 188)		if ((accepted.length > 0)) {
HXLINE( 190)			testRegexpParts->push(((HX_("[^",a3,4f,00,00) + accepted) + HX_("]",5d,00,00,00)));
            		}
HXLINE( 193)		if ((declined->__get(0).length > 0)) {
HXLINE( 195)			testRegexpParts->push(((HX_("[",5b,00,00,00) + declined->__get(0)) + HX_("]",5d,00,00,00)));
            		}
HXLINE( 198)		return  ::EReg_obj::__alloc( HX_CTX ,((HX_("(",28,00,00,00) + testRegexpParts->join(HX_("|",7c,00,00,00))) + HX_(")",29,00,00,00)),HX_("g",67,00,00,00));
            	}


HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,createRestrictRegexp,return )

void TextEngine_obj::getBounds(){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_264_getBounds)
HXLINE( 265)		int padding;
HXDLIN( 265)		if (this->border) {
HXLINE( 265)			padding = 1;
            		}
            		else {
HXLINE( 265)			padding = 0;
            		}
HXLINE( 267)		this->bounds->width = (this->width + padding);
HXLINE( 268)		this->bounds->height = (this->height + padding);
HXLINE( 270)		Float x = this->width;
HXDLIN( 270)		Float y = this->height;
HXLINE( 272)		int lastIndex = (this->layoutGroups->get_length() - 1);
HXLINE( 273)		{
HXLINE( 273)			int _g = 0;
HXDLIN( 273)			int _g1 = this->layoutGroups->get_length();
HXDLIN( 273)			while((_g < _g1)){
HXLINE( 273)				_g = (_g + 1);
HXDLIN( 273)				int i = (_g - 1);
HXLINE( 275)				 ::openfl::text::_internal::TextLayoutGroup group = this->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXLINE( 276)				bool _hx_tmp;
HXDLIN( 276)				bool _hx_tmp1;
HXDLIN( 276)				if ((i == lastIndex)) {
HXLINE( 276)					_hx_tmp1 = (group->startIndex == group->endIndex);
            				}
            				else {
HXLINE( 276)					_hx_tmp1 = false;
            				}
HXDLIN( 276)				if (_hx_tmp1) {
HXLINE( 276)					_hx_tmp = ::hx::IsNotEq( this->type,1 );
            				}
            				else {
HXLINE( 276)					_hx_tmp = false;
            				}
HXDLIN( 276)				if (_hx_tmp) {
HXLINE( 279)					continue;
            				}
HXLINE( 281)				if ((group->offsetX < x)) {
HXLINE( 281)					x = group->offsetX;
            				}
HXLINE( 282)				if ((group->offsetY < y)) {
HXLINE( 282)					y = group->offsetY;
            				}
            			}
            		}
HXLINE( 285)		if ((x >= this->width)) {
HXLINE( 285)			x = ( (Float)(2) );
            		}
HXLINE( 286)		if ((y >= this->height)) {
HXLINE( 286)			y = ( (Float)(2) );
            		}
HXLINE( 292)		this->textBounds->setTo(::Math_obj::max((x - ( (Float)(2) )),( (Float)(0) )),::Math_obj::max((y - ( (Float)(2) )),( (Float)(0) )),::Math_obj::min((this->textWidth + 4),(this->bounds->width + 4)),::Math_obj::min((this->textHeight + 4),(this->bounds->height + 4)));
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,getBounds,(void))

::String TextEngine_obj::getLine(int index){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_552_getLine)
HXLINE( 553)		bool _hx_tmp;
HXDLIN( 553)		if ((index >= 0)) {
HXLINE( 553)			_hx_tmp = (index > (this->lineBreaks->get_length() + 1));
            		}
            		else {
HXLINE( 553)			_hx_tmp = true;
            		}
HXDLIN( 553)		if (_hx_tmp) {
HXLINE( 555)			return null();
            		}
HXLINE( 558)		if ((this->lineBreaks->get_length() == 0)) {
HXLINE( 560)			return this->text;
            		}
            		else {
HXLINE( 564)			::String _hx_tmp = this->text;
HXDLIN( 564)			int _hx_tmp1;
HXDLIN( 564)			if ((index > 0)) {
HXLINE( 564)				_hx_tmp1 = this->lineBreaks->get((index - 1));
            			}
            			else {
HXLINE( 564)				_hx_tmp1 = 0;
            			}
HXDLIN( 564)			return _hx_tmp.substring(_hx_tmp1,this->lineBreaks->get(index));
            		}
HXLINE( 558)		return null();
            	}


HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,getLine,return )

void TextEngine_obj::getLineBreaks(){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_569_getLineBreaks)
HXLINE( 570)		this->lineBreaks->set_length(0);
HXLINE( 572)		int index = -1;
HXLINE( 574)		int cr = -1;
HXDLIN( 574)		int lf = -1;
HXLINE( 575)		while((index < this->text.length)){
HXLINE( 577)			lf = this->text.indexOf(HX_("\n",0a,00,00,00),(index + 1));
HXLINE( 578)			cr = this->text.indexOf(HX_("\r",0d,00,00,00),(index + 1));
HXLINE( 580)			if ((cr == -1)) {
HXLINE( 580)				index = lf;
            			}
            			else {
HXLINE( 580)				if ((lf == -1)) {
HXLINE( 580)					index = cr;
            				}
            				else {
HXLINE( 580)					if ((cr < lf)) {
HXLINE( 580)						index = cr;
            					}
            					else {
HXLINE( 580)						index = lf;
            					}
            				}
            			}
HXLINE( 582)			if ((index > -1)) {
HXLINE( 582)				this->lineBreaks->push(index);
            			}
            			else {
HXLINE( 584)				goto _hx_goto_8;
            			}
            		}
            		_hx_goto_8:;
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,getLineBreaks,(void))

int TextEngine_obj::getLineBreakIndex(::hx::Null< int >  __o_startIndex){
            		int startIndex = __o_startIndex.Default(0);
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_589_getLineBreakIndex)
HXLINE( 590)		{
HXLINE( 590)			 ::Dynamic lineBreak = this->lineBreaks->iterator();
HXDLIN( 590)			while(( (bool)(lineBreak->__Field(HX_("hasNext",6d,a5,46,18),::hx::paccDynamic)()) )){
HXLINE( 590)				int lineBreak1 = ( (int)(lineBreak->__Field(HX_("next",f3,84,02,49),::hx::paccDynamic)()) );
HXLINE( 592)				if ((lineBreak1 >= startIndex)) {
HXLINE( 592)					return lineBreak1;
            				}
            			}
            		}
HXLINE( 595)		return -1;
            	}


HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,getLineBreakIndex,return )

void TextEngine_obj::getLineMeasurements(){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_599_getLineMeasurements)
HXLINE( 600)		this->lineAscents->set_length(0);
HXLINE( 601)		this->lineDescents->set_length(0);
HXLINE( 602)		this->lineLeadings->set_length(0);
HXLINE( 603)		this->lineHeights->set_length(0);
HXLINE( 604)		this->lineWidths->set_length(0);
HXLINE( 606)		Float currentLineAscent = ((Float)0.0);
HXLINE( 607)		Float currentLineDescent = ((Float)0.0);
HXLINE( 608)		 ::Dynamic currentLineLeading = null();
HXLINE( 609)		Float currentLineHeight = ((Float)0.0);
HXLINE( 610)		Float currentLineWidth = ((Float)0.0);
HXLINE( 611)		Float currentTextHeight = ((Float)0.0);
HXLINE( 613)		this->textWidth = ( (Float)(0) );
HXLINE( 614)		this->textHeight = ( (Float)(0) );
HXLINE( 615)		this->numLines = 1;
HXLINE( 616)		this->maxScrollH = 0;
HXLINE( 618)		int lastIndex = (this->layoutGroups->get_length() - 1);
HXLINE( 619)		{
HXLINE( 619)			int _g = 0;
HXDLIN( 619)			int _g1 = this->layoutGroups->get_length();
HXDLIN( 619)			while((_g < _g1)){
HXLINE( 619)				_g = (_g + 1);
HXDLIN( 619)				int i = (_g - 1);
HXLINE( 621)				 ::openfl::text::_internal::TextLayoutGroup group = this->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXLINE( 623)				bool _hx_tmp;
HXDLIN( 623)				bool _hx_tmp1;
HXDLIN( 623)				if ((i == lastIndex)) {
HXLINE( 623)					_hx_tmp1 = (group->startIndex == group->endIndex);
            				}
            				else {
HXLINE( 623)					_hx_tmp1 = false;
            				}
HXDLIN( 623)				if (_hx_tmp1) {
HXLINE( 623)					_hx_tmp = ::hx::IsNotEq( this->type,1 );
            				}
            				else {
HXLINE( 623)					_hx_tmp = false;
            				}
HXDLIN( 623)				if (_hx_tmp) {
HXLINE( 626)					continue;
            				}
HXLINE( 629)				while((group->lineIndex > (this->numLines - 1))){
HXLINE( 631)					this->lineAscents->push(currentLineAscent);
HXLINE( 632)					this->lineDescents->push(currentLineDescent);
HXLINE( 633)					{
HXLINE( 633)						Float _hx_tmp;
HXDLIN( 633)						if (::hx::IsNotNull( currentLineLeading )) {
HXLINE( 633)							_hx_tmp = ( (Float)(currentLineLeading) );
            						}
            						else {
HXLINE( 633)							_hx_tmp = ( (Float)(0) );
            						}
HXDLIN( 633)						this->lineLeadings->push(_hx_tmp);
            					}
HXLINE( 634)					this->lineHeights->push(currentLineHeight);
HXLINE( 635)					this->lineWidths->push(currentLineWidth);
HXLINE( 637)					currentLineAscent = ( (Float)(0) );
HXLINE( 638)					currentLineDescent = ( (Float)(0) );
HXLINE( 639)					currentLineLeading = null();
HXLINE( 640)					currentLineHeight = ( (Float)(0) );
HXLINE( 641)					currentLineWidth = ( (Float)(0) );
HXLINE( 643)					this->numLines++;
            				}
HXLINE( 646)				currentLineAscent = ::Math_obj::max(currentLineAscent,group->ascent);
HXLINE( 647)				currentLineDescent = ::Math_obj::max(currentLineDescent,group->descent);
HXLINE( 649)				if (::hx::IsNull( currentLineLeading )) {
HXLINE( 651)					currentLineLeading = group->leading;
            				}
            				else {
HXLINE( 655)					currentLineLeading = ::Std_obj::_hx_int(::Math_obj::max(( (Float)(currentLineLeading) ),( (Float)(group->leading) )));
            				}
HXLINE( 658)				currentLineHeight = ::Math_obj::max(currentLineHeight,group->height);
HXLINE( 659)				currentLineWidth = ((group->offsetX - ( (Float)(2) )) + group->width);
HXLINE( 661)				if ((currentLineWidth > this->textWidth)) {
HXLINE( 663)					this->textWidth = currentLineWidth;
            				}
HXLINE( 666)				currentTextHeight = ( (Float)(::Math_obj::ceil((((group->offsetY - ( (Float)(2) )) + group->ascent) + group->descent))) );
HXLINE( 668)				if ((currentTextHeight > this->textHeight)) {
HXLINE( 670)					this->textHeight = currentTextHeight;
            				}
            			}
            		}
HXLINE( 674)		bool _hx_tmp;
HXDLIN( 674)		bool _hx_tmp1;
HXDLIN( 674)		if ((this->textHeight == 0)) {
HXLINE( 674)			_hx_tmp1 = ::hx::IsNotNull( this->textField );
            		}
            		else {
HXLINE( 674)			_hx_tmp1 = false;
            		}
HXDLIN( 674)		if (_hx_tmp1) {
HXLINE( 674)			_hx_tmp = ::hx::IsEq( this->type,1 );
            		}
            		else {
HXLINE( 674)			_hx_tmp = false;
            		}
HXDLIN( 674)		if (_hx_tmp) {
HXLINE( 676)			 ::openfl::text::TextFormat currentFormat = this->textField->_hx___textFormat;
HXLINE( 677)			Float ascent;
HXDLIN( 677)			Float descent;
HXLINE( 679)			 ::openfl::text::Font font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXLINE( 681)			if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE( 683)				ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXLINE( 684)				descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            			}
            			else {
HXLINE( 686)				bool _hx_tmp;
HXDLIN( 686)				if (::hx::IsNotNull( font )) {
HXLINE( 686)					_hx_tmp = (font->unitsPerEM != 0);
            				}
            				else {
HXLINE( 686)					_hx_tmp = false;
            				}
HXDLIN( 686)				if (_hx_tmp) {
HXLINE( 689)					ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXLINE( 690)					descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            				}
            				else {
HXLINE( 698)					ascent = ( (Float)(currentFormat->size) );
HXLINE( 699)					descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            				}
            			}
HXLINE( 677)			 ::Dynamic leading = currentFormat->leading;
HXDLIN( 677)			int heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXLINE( 706)			currentLineAscent = ascent;
HXLINE( 707)			currentLineDescent = descent;
HXLINE( 708)			currentLineLeading = leading;
HXLINE( 710)			currentTextHeight = ( (Float)(::Math_obj::ceil((ascent + descent))) );
HXLINE( 711)			this->textHeight = currentTextHeight;
            		}
HXLINE( 714)		this->lineAscents->push(currentLineAscent);
HXLINE( 715)		this->lineDescents->push(currentLineDescent);
HXLINE( 716)		{
HXLINE( 716)			Float _hx_tmp2;
HXDLIN( 716)			if (::hx::IsNotNull( currentLineLeading )) {
HXLINE( 716)				_hx_tmp2 = ( (Float)(currentLineLeading) );
            			}
            			else {
HXLINE( 716)				_hx_tmp2 = ( (Float)(0) );
            			}
HXDLIN( 716)			this->lineLeadings->push(_hx_tmp2);
            		}
HXLINE( 717)		this->lineHeights->push(currentLineHeight);
HXLINE( 718)		this->lineWidths->push(currentLineWidth);
HXLINE( 720)		if ((this->numLines == 1)) {
HXLINE( 722)			if (::hx::IsGreater( currentLineLeading,0 )) {
HXLINE( 724)				 ::openfl::text::_internal::TextEngine _hx_tmp = ::hx::ObjectPtr<OBJ_>(this);
HXDLIN( 724)				_hx_tmp->textHeight = (_hx_tmp->textHeight + currentLineLeading);
            			}
            		}
HXLINE( 728)		if (::hx::IsNotEq( this->autoSize,2 )) {
HXLINE( 730)			 ::Dynamic _hx_switch_0 = this->autoSize;
            			if (  (_hx_switch_0==0) ||  (_hx_switch_0==1) ||  (_hx_switch_0==3) ){
HXLINE( 733)				if (!(this->wordWrap)) {
HXLINE( 735)					this->width = (this->textWidth + 4);
            				}
HXLINE( 738)				this->height = (this->textHeight + 4);
HXLINE( 739)				this->bottomScrollV = this->numLines;
HXLINE( 732)				goto _hx_goto_14;
            			}
            			/* default */{
            			}
            			_hx_goto_14:;
            		}
HXLINE( 745)		if ((this->textWidth > (this->width - ( (Float)(4) )))) {
HXLINE( 747)			this->maxScrollH = ::Std_obj::_hx_int(((this->textWidth - this->width) + 4));
            		}
            		else {
HXLINE( 751)			this->maxScrollH = 0;
            		}
HXLINE( 754)		if ((this->scrollH > this->maxScrollH)) {
HXLINE( 754)			this->scrollH = this->maxScrollH;
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,getLineMeasurements,(void))

void TextEngine_obj::getLayoutGroups(){
            	HX_GC_STACKFRAME(&_hx_pos_81873a2f4b2980c0_758_getLayoutGroups)
HXDLIN( 758)		 ::openfl::text::_internal::TextEngine _gthis = ::hx::ObjectPtr<OBJ_>(this);
HXLINE( 759)		this->layoutGroups->set_length(0);
HXLINE( 761)		bool _hx_tmp;
HXDLIN( 761)		if (::hx::IsNotNull( this->text )) {
HXLINE( 761)			_hx_tmp = (this->text == HX_("",00,00,00,00));
            		}
            		else {
HXLINE( 761)			_hx_tmp = true;
            		}
HXDLIN( 761)		if (_hx_tmp) {
HXLINE( 761)			return;
            		}
HXLINE( 763)		int rangeIndex = -1;
HXLINE( 764)		 ::openfl::text::_internal::TextFormatRange formatRange = null();
HXLINE( 765)		 ::lime::text::Font font = null();
HXLINE( 767)		 ::openfl::text::TextFormat currentFormat = ::openfl::text::TextField_obj::_hx___defaultTextFormat->clone();
HXLINE( 770)		int leading = 0;
HXLINE( 771)		Float ascent = ((Float)0.0);
HXDLIN( 771)		Float maxAscent = ((Float)0.0);
HXLINE( 772)		Float descent = ((Float)0.0);
HXLINE( 775)		 ::Dynamic align = 3;
HXLINE( 776)		int blockIndent = 0;
HXLINE( 777)		bool bullet = false;
HXLINE( 778)		int indent = 0;
HXLINE( 779)		int leftMargin = 0;
HXLINE( 780)		int rightMargin = 0;
HXLINE( 781)		bool firstLineOfParagraph = true;
HXLINE( 783)		 ::Dynamic tabStops = null();
HXLINE( 785)		 ::openfl::text::_internal::TextLayoutGroup layoutGroup = null();
HXDLIN( 785)		::Array< ::Dynamic> positions = null();
HXLINE( 786)		Float widthValue = ((Float)0.0);
HXDLIN( 786)		int heightValue = 0;
HXDLIN( 786)		int maxHeightValue = 0;
HXLINE( 787)		int previousSpaceIndex = -2;
HXLINE( 788)		int previousBreakIndex = -1;
HXLINE( 789)		int spaceIndex = this->text.indexOf(HX_(" ",20,00,00,00),null());
HXLINE( 790)		int breakCount = 0;
HXLINE( 791)		int breakIndex;
HXDLIN( 791)		if ((breakCount < this->lineBreaks->get_length())) {
HXLINE( 791)			breakIndex = this->lineBreaks->get(breakCount);
            		}
            		else {
HXLINE( 791)			breakIndex = -1;
            		}
HXLINE( 793)		Float offsetX = ((Float)0.0);
HXLINE( 794)		Float offsetY = ((Float)0.0);
HXLINE( 795)		int textIndex = 0;
HXLINE( 796)		int lineIndex = 0;
HXLINE(1344)		if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1344)			rangeIndex = (rangeIndex + 1);
HXDLIN(1344)			formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1344)			currentFormat->_hx___merge(formatRange->format);
HXDLIN(1344)			font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            		}
HXLINE(1345)		{
HXLINE(1345)			firstLineOfParagraph = true;
HXDLIN(1345)			if (::hx::IsNotNull( currentFormat->align )) {
HXLINE(1345)				align = currentFormat->align;
            			}
            			else {
HXLINE(1345)				align = 3;
            			}
HXDLIN(1345)			if (::hx::IsNotNull( currentFormat->blockIndent )) {
HXLINE(1345)				blockIndent = ( (int)(currentFormat->blockIndent) );
            			}
            			else {
HXLINE(1345)				blockIndent = 0;
            			}
HXDLIN(1345)			if (::hx::IsNotNull( currentFormat->indent )) {
HXLINE(1345)				indent = ( (int)(currentFormat->indent) );
            			}
            			else {
HXLINE(1345)				indent = 0;
            			}
HXDLIN(1345)			if (::hx::IsNotNull( currentFormat->leftMargin )) {
HXLINE(1345)				leftMargin = ( (int)(currentFormat->leftMargin) );
            			}
            			else {
HXLINE(1345)				leftMargin = 0;
            			}
HXDLIN(1345)			if (::hx::IsNotNull( currentFormat->rightMargin )) {
HXLINE(1345)				rightMargin = ( (int)(currentFormat->rightMargin) );
            			}
            			else {
HXLINE(1345)				rightMargin = 0;
            			}
HXDLIN(1345)			bool _hx_tmp1 = ::hx::IsNotNull( currentFormat->bullet );
HXDLIN(1345)			bool _hx_tmp2 = ::hx::IsNotNull( currentFormat->tabStops );
            		}
HXLINE(1346)		{
HXLINE(1346)			if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1346)				ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1346)				descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            			}
            			else {
HXLINE(1346)				bool _hx_tmp;
HXDLIN(1346)				if (::hx::IsNotNull( font )) {
HXLINE(1346)					_hx_tmp = (font->unitsPerEM != 0);
            				}
            				else {
HXLINE(1346)					_hx_tmp = false;
            				}
HXDLIN(1346)				if (_hx_tmp) {
HXLINE(1346)					ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1346)					descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            				}
            				else {
HXLINE(1346)					ascent = ( (Float)(currentFormat->size) );
HXDLIN(1346)					descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            				}
            			}
HXDLIN(1346)			leading = ( (int)(currentFormat->leading) );
HXDLIN(1346)			heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1346)			if ((heightValue > maxHeightValue)) {
HXLINE(1346)				maxHeightValue = heightValue;
            			}
HXDLIN(1346)			if ((ascent > maxAscent)) {
HXLINE(1346)				maxAscent = ascent;
            			}
            		}
HXLINE(1348)		bool wrap;
HXLINE(1349)		int maxLoops = (this->text.length + 1);
HXLINE(1353)		while((textIndex < maxLoops)){
HXLINE(1355)			bool _hx_tmp;
HXDLIN(1355)			if ((breakIndex > -1)) {
HXLINE(1355)				if ((spaceIndex != -1)) {
HXLINE(1355)					_hx_tmp = (breakIndex < spaceIndex);
            				}
            				else {
HXLINE(1355)					_hx_tmp = true;
            				}
            			}
            			else {
HXLINE(1355)				_hx_tmp = false;
            			}
HXDLIN(1355)			if (_hx_tmp) {
HXLINE(1359)				if ((textIndex <= breakIndex)) {
HXLINE(1361)					if ((textIndex >= breakIndex)) {
HXLINE(1361)						positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1361)						widthValue = ( (Float)(0) );
            					}
            					else {
HXLINE(1361)						if ((breakIndex <= formatRange->end)) {
HXLINE(1361)							::String text = _gthis->text;
HXDLIN(1361)							Float letterSpacing = ((Float)0.0);
HXDLIN(1361)							if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1361)								letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            							}
HXDLIN(1361)							if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1361)								_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            							}
HXDLIN(1361)							_gthis->_hx___textLayout->set_text(null());
HXDLIN(1361)							_gthis->_hx___textLayout->set_font(font);
HXDLIN(1361)							if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1361)								_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            							}
HXDLIN(1361)							_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1361)							bool positions1;
HXDLIN(1361)							if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1361)								positions1 = (_gthis->sharpness < 400);
            							}
            							else {
HXLINE(1361)								positions1 = true;
            							}
HXDLIN(1361)							_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1361)							 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1361)							_gthis1->set_text(text.substring(textIndex,breakIndex));
HXDLIN(1361)							if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1361)								positions = _gthis->_hx___textLayout->get_positions();
            							}
            							else {
HXLINE(1361)								positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            							}
HXDLIN(1361)							Float width = ((Float)0.0);
HXDLIN(1361)							{
HXLINE(1361)								int _g = 0;
HXDLIN(1361)								while((_g < positions->length)){
HXLINE(1361)									 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1361)									_g = (_g + 1);
HXDLIN(1361)									width = (width + position->advance->x);
            								}
            							}
HXDLIN(1361)							widthValue = width;
            						}
            						else {
HXLINE(1361)							int tempIndex = textIndex;
HXDLIN(1361)							int tempRangeEnd = formatRange->end;
HXDLIN(1361)							int countRanges = 0;
HXDLIN(1361)							positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1361)							widthValue = ( (Float)(0) );
HXDLIN(1361)							while(true){
HXLINE(1361)								if ((tempIndex != tempRangeEnd)) {
HXLINE(1361)									::String text = _gthis->text;
HXDLIN(1361)									Float letterSpacing = ((Float)0.0);
HXDLIN(1361)									if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1361)										letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            									}
HXDLIN(1361)									if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1361)										_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            									}
HXDLIN(1361)									_gthis->_hx___textLayout->set_text(null());
HXDLIN(1361)									_gthis->_hx___textLayout->set_font(font);
HXDLIN(1361)									if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1361)										_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            									}
HXDLIN(1361)									_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1361)									bool _hx_tmp;
HXDLIN(1361)									if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1361)										_hx_tmp = (_gthis->sharpness < 400);
            									}
            									else {
HXLINE(1361)										_hx_tmp = true;
            									}
HXDLIN(1361)									_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1361)									 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1361)									_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1361)									::Array< ::Dynamic> tempPositions;
HXDLIN(1361)									if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1361)										tempPositions = _gthis->_hx___textLayout->get_positions();
            									}
            									else {
HXLINE(1361)										tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            									}
HXDLIN(1361)									positions = positions->concat(tempPositions);
            								}
HXDLIN(1361)								if ((tempRangeEnd != breakIndex)) {
HXLINE(1361)									bool _hx_tmp;
HXDLIN(1361)									if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1361)										rangeIndex = (rangeIndex + 1);
HXDLIN(1361)										formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1361)										currentFormat->_hx___merge(formatRange->format);
HXDLIN(1361)										font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1361)										_hx_tmp = true;
            									}
            									else {
HXLINE(1361)										_hx_tmp = false;
            									}
HXDLIN(1361)									if (!(_hx_tmp)) {
HXLINE(1361)										::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1361)										goto _hx_goto_18;
            									}
HXDLIN(1361)									tempIndex = tempRangeEnd;
HXDLIN(1361)									if ((breakIndex < formatRange->end)) {
HXLINE(1361)										tempRangeEnd = breakIndex;
            									}
            									else {
HXLINE(1361)										tempRangeEnd = formatRange->end;
            									}
HXDLIN(1361)									countRanges = (countRanges + 1);
            								}
            								else {
HXLINE(1361)									Float width = ((Float)0.0);
HXDLIN(1361)									{
HXLINE(1361)										int _g = 0;
HXDLIN(1361)										while((_g < positions->length)){
HXLINE(1361)											 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1361)											_g = (_g + 1);
HXDLIN(1361)											width = (width + position->advance->x);
            										}
            									}
HXDLIN(1361)									widthValue = width;
HXDLIN(1361)									goto _hx_goto_18;
            								}
            							}
            							_hx_goto_18:;
HXDLIN(1361)							rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1361)							if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1361)								rangeIndex = (rangeIndex + 1);
HXDLIN(1361)								formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1361)								currentFormat->_hx___merge(formatRange->format);
HXDLIN(1361)								font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            							}
            						}
            					}
HXLINE(1362)					{
HXLINE(1362)						bool _hx_tmp;
HXDLIN(1362)						if ((_gthis->width >= 4)) {
HXLINE(1362)							_hx_tmp = _gthis->wordWrap;
            						}
            						else {
HXLINE(1362)							_hx_tmp = false;
            						}
HXDLIN(1362)						if (_hx_tmp) {
HXLINE(1362)							::Array< ::Dynamic> remainingPositions = positions;
HXDLIN(1362)							int bufferCount;
HXDLIN(1362)							int placeIndex;
HXDLIN(1362)							Float positionWidth;
HXDLIN(1362)							 ::openfl::text::_internal::GlyphPosition currentPosition;
HXDLIN(1362)							Float width = ((Float)0.0);
HXDLIN(1362)							{
HXLINE(1362)								int _g = 0;
HXDLIN(1362)								while((_g < remainingPositions->length)){
HXLINE(1362)									 ::openfl::text::_internal::GlyphPosition position = remainingPositions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)									_g = (_g + 1);
HXDLIN(1362)									width = (width + position->advance->x);
            								}
            							}
HXDLIN(1362)							Float tempWidth = width;
HXDLIN(1362)							int i = (remainingPositions->length - 1);
HXDLIN(1362)							while((i >= 0)){
HXLINE(1362)								 ::Dynamic currentCharCode = _gthis->text.charCodeAt((textIndex + i));
HXDLIN(1362)								bool _hx_tmp;
HXDLIN(1362)								if (::hx::IsNotEq( currentCharCode,32 )) {
HXLINE(1362)									_hx_tmp = ::hx::IsNotEq( currentCharCode,9 );
            								}
            								else {
HXLINE(1362)									_hx_tmp = false;
            								}
HXDLIN(1362)								if (_hx_tmp) {
HXLINE(1362)									goto _hx_goto_21;
            								}
HXDLIN(1362)								 ::openfl::text::_internal::GlyphPosition position = remainingPositions->__get(i).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)								tempWidth = (tempWidth - position->advance->x);
HXDLIN(1362)								i = (i - 1);
            							}
            							_hx_goto_21:;
HXDLIN(1362)							while(true){
HXLINE(1362)								bool _hx_tmp;
HXDLIN(1362)								if ((remainingPositions->length > 0)) {
HXLINE(1362)									int _hx_tmp1;
HXDLIN(1362)									if (firstLineOfParagraph) {
HXLINE(1362)										_hx_tmp1 = indent;
            									}
            									else {
HXLINE(1362)										_hx_tmp1 = 0;
            									}
HXDLIN(1362)									_hx_tmp = ((offsetX + tempWidth) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) )));
            								}
            								else {
HXLINE(1362)									_hx_tmp = false;
            								}
HXDLIN(1362)								if (!(_hx_tmp)) {
HXLINE(1362)									goto _hx_goto_22;
            								}
HXDLIN(1362)								bufferCount = 0;
HXDLIN(1362)								i = bufferCount;
HXDLIN(1362)								positionWidth = ((Float)0.0);
HXDLIN(1362)								while(true){
HXLINE(1362)									int _hx_tmp;
HXDLIN(1362)									if (firstLineOfParagraph) {
HXLINE(1362)										_hx_tmp = indent;
            									}
            									else {
HXLINE(1362)										_hx_tmp = 0;
            									}
HXDLIN(1362)									if (!(((offsetX + positionWidth) < (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp)) ))))) {
HXLINE(1362)										goto _hx_goto_23;
            									}
HXDLIN(1362)									currentPosition = remainingPositions->__get(i).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)									if ((currentPosition->advance->x == ((Float)0.0))) {
HXLINE(1362)										i = (i + 1);
HXDLIN(1362)										bufferCount = (bufferCount + 1);
            									}
            									else {
HXLINE(1362)										positionWidth = (positionWidth + currentPosition->advance->x);
HXDLIN(1362)										i = (i + 1);
            									}
            								}
            								_hx_goto_23:;
HXDLIN(1362)								if ((i == bufferCount)) {
HXLINE(1362)									i = (bufferCount + 1);
            								}
            								else {
HXLINE(1362)									while(true){
HXLINE(1362)										bool _hx_tmp;
HXDLIN(1362)										if ((i > 1)) {
HXLINE(1362)											int _hx_tmp1;
HXDLIN(1362)											if (firstLineOfParagraph) {
HXLINE(1362)												_hx_tmp1 = indent;
            											}
            											else {
HXLINE(1362)												_hx_tmp1 = 0;
            											}
HXDLIN(1362)											_hx_tmp = ((offsetX + positionWidth) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) )));
            										}
            										else {
HXLINE(1362)											_hx_tmp = false;
            										}
HXDLIN(1362)										if (!(_hx_tmp)) {
HXLINE(1362)											goto _hx_goto_24;
            										}
HXDLIN(1362)										i = (i - 1);
HXDLIN(1362)										if (((i - bufferCount) > 0)) {
HXLINE(1362)											{
HXLINE(1362)												int endIndex = ((textIndex + i) - bufferCount);
HXDLIN(1362)												if ((textIndex >= endIndex)) {
HXLINE(1362)													positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1362)													widthValue = ( (Float)(0) );
            												}
            												else {
HXLINE(1362)													if ((endIndex <= formatRange->end)) {
HXLINE(1362)														::String text = _gthis->text;
HXDLIN(1362)														Float letterSpacing = ((Float)0.0);
HXDLIN(1362)														if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)															letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            														}
HXDLIN(1362)														if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)															_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            														}
HXDLIN(1362)														_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)														_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)														if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)															_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            														}
HXDLIN(1362)														_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)														bool positions1;
HXDLIN(1362)														if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)															positions1 = (_gthis->sharpness < 400);
            														}
            														else {
HXLINE(1362)															positions1 = true;
            														}
HXDLIN(1362)														_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1362)														 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)														_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1362)														if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)															positions = _gthis->_hx___textLayout->get_positions();
            														}
            														else {
HXLINE(1362)															positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            														}
HXDLIN(1362)														Float width = ((Float)0.0);
HXDLIN(1362)														{
HXLINE(1362)															int _g = 0;
HXDLIN(1362)															while((_g < positions->length)){
HXLINE(1362)																 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)																_g = (_g + 1);
HXDLIN(1362)																width = (width + position->advance->x);
            															}
            														}
HXDLIN(1362)														widthValue = width;
            													}
            													else {
HXLINE(1362)														int tempIndex = textIndex;
HXDLIN(1362)														int tempRangeEnd = formatRange->end;
HXDLIN(1362)														int countRanges = 0;
HXDLIN(1362)														positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1362)														widthValue = ( (Float)(0) );
HXDLIN(1362)														while(true){
HXLINE(1362)															if ((tempIndex != tempRangeEnd)) {
HXLINE(1362)																::String text = _gthis->text;
HXDLIN(1362)																Float letterSpacing = ((Float)0.0);
HXDLIN(1362)																if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)																	letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																}
HXDLIN(1362)																if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)																	_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																}
HXDLIN(1362)																_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)																_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)																if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)																	_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																}
HXDLIN(1362)																_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)																bool _hx_tmp;
HXDLIN(1362)																if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)																	_hx_tmp = (_gthis->sharpness < 400);
            																}
            																else {
HXLINE(1362)																	_hx_tmp = true;
            																}
HXDLIN(1362)																_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1362)																 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)																_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1362)																::Array< ::Dynamic> tempPositions;
HXDLIN(1362)																if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)																	tempPositions = _gthis->_hx___textLayout->get_positions();
            																}
            																else {
HXLINE(1362)																	tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																}
HXDLIN(1362)																positions = positions->concat(tempPositions);
            															}
HXDLIN(1362)															if ((tempRangeEnd != endIndex)) {
HXLINE(1362)																bool _hx_tmp;
HXDLIN(1362)																if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)																	rangeIndex = (rangeIndex + 1);
HXDLIN(1362)																	formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)																	currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)																	font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1362)																	_hx_tmp = true;
            																}
            																else {
HXLINE(1362)																	_hx_tmp = false;
            																}
HXDLIN(1362)																if (!(_hx_tmp)) {
HXLINE(1362)																	::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1362)																	goto _hx_goto_26;
            																}
HXDLIN(1362)																tempIndex = tempRangeEnd;
HXDLIN(1362)																if ((endIndex < formatRange->end)) {
HXLINE(1362)																	tempRangeEnd = endIndex;
            																}
            																else {
HXLINE(1362)																	tempRangeEnd = formatRange->end;
            																}
HXDLIN(1362)																countRanges = (countRanges + 1);
            															}
            															else {
HXLINE(1362)																Float width = ((Float)0.0);
HXDLIN(1362)																{
HXLINE(1362)																	int _g = 0;
HXDLIN(1362)																	while((_g < positions->length)){
HXLINE(1362)																		 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)																		_g = (_g + 1);
HXDLIN(1362)																		width = (width + position->advance->x);
            																	}
            																}
HXDLIN(1362)																widthValue = width;
HXDLIN(1362)																goto _hx_goto_26;
            															}
            														}
            														_hx_goto_26:;
HXDLIN(1362)														rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1362)														if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)															rangeIndex = (rangeIndex + 1);
HXDLIN(1362)															formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)															currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)															font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            														}
            													}
            												}
            											}
HXDLIN(1362)											positionWidth = widthValue;
            										}
            										else {
HXLINE(1362)											i = 1;
HXDLIN(1362)											bufferCount = 0;
HXDLIN(1362)											{
HXLINE(1362)												int endIndex = (textIndex + 1);
HXDLIN(1362)												if ((textIndex >= endIndex)) {
HXLINE(1362)													positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1362)													widthValue = ( (Float)(0) );
            												}
            												else {
HXLINE(1362)													if ((endIndex <= formatRange->end)) {
HXLINE(1362)														::String text = _gthis->text;
HXDLIN(1362)														Float letterSpacing = ((Float)0.0);
HXDLIN(1362)														if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)															letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            														}
HXDLIN(1362)														if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)															_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            														}
HXDLIN(1362)														_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)														_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)														if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)															_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            														}
HXDLIN(1362)														_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)														bool positions1;
HXDLIN(1362)														if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)															positions1 = (_gthis->sharpness < 400);
            														}
            														else {
HXLINE(1362)															positions1 = true;
            														}
HXDLIN(1362)														_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1362)														 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)														_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1362)														if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)															positions = _gthis->_hx___textLayout->get_positions();
            														}
            														else {
HXLINE(1362)															positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            														}
HXDLIN(1362)														Float width = ((Float)0.0);
HXDLIN(1362)														{
HXLINE(1362)															int _g = 0;
HXDLIN(1362)															while((_g < positions->length)){
HXLINE(1362)																 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)																_g = (_g + 1);
HXDLIN(1362)																width = (width + position->advance->x);
            															}
            														}
HXDLIN(1362)														widthValue = width;
            													}
            													else {
HXLINE(1362)														int tempIndex = textIndex;
HXDLIN(1362)														int tempRangeEnd = formatRange->end;
HXDLIN(1362)														int countRanges = 0;
HXDLIN(1362)														positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1362)														widthValue = ( (Float)(0) );
HXDLIN(1362)														while(true){
HXLINE(1362)															if ((tempIndex != tempRangeEnd)) {
HXLINE(1362)																::String text = _gthis->text;
HXDLIN(1362)																Float letterSpacing = ((Float)0.0);
HXDLIN(1362)																if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)																	letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																}
HXDLIN(1362)																if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)																	_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																}
HXDLIN(1362)																_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)																_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)																if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)																	_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																}
HXDLIN(1362)																_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)																bool _hx_tmp;
HXDLIN(1362)																if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)																	_hx_tmp = (_gthis->sharpness < 400);
            																}
            																else {
HXLINE(1362)																	_hx_tmp = true;
            																}
HXDLIN(1362)																_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1362)																 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)																_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1362)																::Array< ::Dynamic> tempPositions;
HXDLIN(1362)																if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)																	tempPositions = _gthis->_hx___textLayout->get_positions();
            																}
            																else {
HXLINE(1362)																	tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																}
HXDLIN(1362)																positions = positions->concat(tempPositions);
            															}
HXDLIN(1362)															if ((tempRangeEnd != endIndex)) {
HXLINE(1362)																bool _hx_tmp;
HXDLIN(1362)																if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)																	rangeIndex = (rangeIndex + 1);
HXDLIN(1362)																	formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)																	currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)																	font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1362)																	_hx_tmp = true;
            																}
            																else {
HXLINE(1362)																	_hx_tmp = false;
            																}
HXDLIN(1362)																if (!(_hx_tmp)) {
HXLINE(1362)																	::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1362)																	goto _hx_goto_29;
            																}
HXDLIN(1362)																tempIndex = tempRangeEnd;
HXDLIN(1362)																if ((endIndex < formatRange->end)) {
HXLINE(1362)																	tempRangeEnd = endIndex;
            																}
            																else {
HXLINE(1362)																	tempRangeEnd = formatRange->end;
            																}
HXDLIN(1362)																countRanges = (countRanges + 1);
            															}
            															else {
HXLINE(1362)																Float width = ((Float)0.0);
HXDLIN(1362)																{
HXLINE(1362)																	int _g = 0;
HXDLIN(1362)																	while((_g < positions->length)){
HXLINE(1362)																		 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)																		_g = (_g + 1);
HXDLIN(1362)																		width = (width + position->advance->x);
            																	}
            																}
HXDLIN(1362)																widthValue = width;
HXDLIN(1362)																goto _hx_goto_29;
            															}
            														}
            														_hx_goto_29:;
HXDLIN(1362)														rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1362)														if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)															rangeIndex = (rangeIndex + 1);
HXDLIN(1362)															formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)															currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)															font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            														}
            													}
            												}
            											}
HXDLIN(1362)											positionWidth = ( (Float)(0) );
            										}
            									}
            									_hx_goto_24:;
            								}
HXDLIN(1362)								placeIndex = ((textIndex + i) - bufferCount);
HXDLIN(1362)								{
HXLINE(1362)									if ((placeIndex <= formatRange->end)) {
HXLINE(1362)										::String text = _gthis->text;
HXDLIN(1362)										Float letterSpacing = ((Float)0.0);
HXDLIN(1362)										if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)											letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            										}
HXDLIN(1362)										if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)											_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)										_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)										if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)											_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)										bool positions1;
HXDLIN(1362)										if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)											positions1 = (_gthis->sharpness < 400);
            										}
            										else {
HXLINE(1362)											positions1 = true;
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1362)										 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)										_gthis1->set_text(text.substring(textIndex,placeIndex));
HXDLIN(1362)										if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)											positions = _gthis->_hx___textLayout->get_positions();
            										}
            										else {
HXLINE(1362)											positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            										}
HXDLIN(1362)										Float width = ((Float)0.0);
HXDLIN(1362)										{
HXLINE(1362)											int _g = 0;
HXDLIN(1362)											while((_g < positions->length)){
HXLINE(1362)												 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)												_g = (_g + 1);
HXDLIN(1362)												width = (width + position->advance->x);
            											}
            										}
HXDLIN(1362)										widthValue = width;
HXDLIN(1362)										bool _hx_tmp;
HXDLIN(1362)										if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1362)											_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            										}
            										else {
HXLINE(1362)											_hx_tmp = true;
            										}
HXDLIN(1362)										if (_hx_tmp) {
HXLINE(1362)											layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,placeIndex);
HXDLIN(1362)											_gthis->layoutGroups->push(layoutGroup);
            										}
            										else {
HXLINE(1362)											layoutGroup->format = formatRange->format;
HXDLIN(1362)											layoutGroup->startIndex = textIndex;
HXDLIN(1362)											layoutGroup->endIndex = placeIndex;
            										}
HXDLIN(1362)										layoutGroup->positions = positions;
HXDLIN(1362)										int _hx_tmp1;
HXDLIN(1362)										if (firstLineOfParagraph) {
HXLINE(1362)											_hx_tmp1 = indent;
            										}
            										else {
HXLINE(1362)											_hx_tmp1 = 0;
            										}
HXDLIN(1362)										layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1362)										layoutGroup->ascent = ascent;
HXDLIN(1362)										layoutGroup->descent = descent;
HXDLIN(1362)										layoutGroup->leading = leading;
HXDLIN(1362)										layoutGroup->lineIndex = lineIndex;
HXDLIN(1362)										layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1362)										layoutGroup->width = widthValue;
HXDLIN(1362)										layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1362)										offsetX = (offsetX + widthValue);
HXDLIN(1362)										if ((placeIndex == formatRange->end)) {
HXLINE(1362)											layoutGroup = null();
HXDLIN(1362)											if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)												rangeIndex = (rangeIndex + 1);
HXDLIN(1362)												formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)												currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)												font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            											}
HXDLIN(1362)											{
HXLINE(1362)												if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1362)													ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1362)													descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            												}
            												else {
HXLINE(1362)													bool _hx_tmp;
HXDLIN(1362)													if (::hx::IsNotNull( font )) {
HXLINE(1362)														_hx_tmp = (font->unitsPerEM != 0);
            													}
            													else {
HXLINE(1362)														_hx_tmp = false;
            													}
HXDLIN(1362)													if (_hx_tmp) {
HXLINE(1362)														ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1362)														descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            													}
            													else {
HXLINE(1362)														ascent = ( (Float)(currentFormat->size) );
HXDLIN(1362)														descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            													}
            												}
HXDLIN(1362)												leading = ( (int)(currentFormat->leading) );
HXDLIN(1362)												heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1362)												if ((heightValue > maxHeightValue)) {
HXLINE(1362)													maxHeightValue = heightValue;
            												}
HXDLIN(1362)												if ((ascent > maxAscent)) {
HXLINE(1362)													maxAscent = ascent;
            												}
            											}
            										}
            									}
            									else {
HXLINE(1362)										while(true){
HXLINE(1362)											int tempRangeEnd;
HXDLIN(1362)											if ((placeIndex < formatRange->end)) {
HXLINE(1362)												tempRangeEnd = placeIndex;
            											}
            											else {
HXLINE(1362)												tempRangeEnd = formatRange->end;
            											}
HXDLIN(1362)											if ((textIndex != tempRangeEnd)) {
HXLINE(1362)												::String text = _gthis->text;
HXDLIN(1362)												Float letterSpacing = ((Float)0.0);
HXDLIN(1362)												if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)													letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            												}
HXDLIN(1362)												if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)													_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            												}
HXDLIN(1362)												_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)												_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)												if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)													_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            												}
HXDLIN(1362)												_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)												bool positions1;
HXDLIN(1362)												if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)													positions1 = (_gthis->sharpness < 400);
            												}
            												else {
HXLINE(1362)													positions1 = true;
            												}
HXDLIN(1362)												_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1362)												 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)												_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1362)												if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)													positions = _gthis->_hx___textLayout->get_positions();
            												}
            												else {
HXLINE(1362)													positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            												}
HXDLIN(1362)												Float width = ((Float)0.0);
HXDLIN(1362)												{
HXLINE(1362)													int _g = 0;
HXDLIN(1362)													while((_g < positions->length)){
HXLINE(1362)														 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)														_g = (_g + 1);
HXDLIN(1362)														width = (width + position->advance->x);
            													}
            												}
HXDLIN(1362)												widthValue = width;
HXDLIN(1362)												bool _hx_tmp;
HXDLIN(1362)												if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1362)													_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            												}
            												else {
HXLINE(1362)													_hx_tmp = true;
            												}
HXDLIN(1362)												if (_hx_tmp) {
HXLINE(1362)													layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1362)													_gthis->layoutGroups->push(layoutGroup);
            												}
            												else {
HXLINE(1362)													layoutGroup->format = formatRange->format;
HXDLIN(1362)													layoutGroup->startIndex = textIndex;
HXDLIN(1362)													layoutGroup->endIndex = tempRangeEnd;
            												}
HXDLIN(1362)												layoutGroup->positions = positions;
HXDLIN(1362)												int _hx_tmp1;
HXDLIN(1362)												if (firstLineOfParagraph) {
HXLINE(1362)													_hx_tmp1 = indent;
            												}
            												else {
HXLINE(1362)													_hx_tmp1 = 0;
            												}
HXDLIN(1362)												layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1362)												layoutGroup->ascent = ascent;
HXDLIN(1362)												layoutGroup->descent = descent;
HXDLIN(1362)												layoutGroup->leading = leading;
HXDLIN(1362)												layoutGroup->lineIndex = lineIndex;
HXDLIN(1362)												layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1362)												layoutGroup->width = widthValue;
HXDLIN(1362)												layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1362)												offsetX = (offsetX + widthValue);
HXDLIN(1362)												textIndex = tempRangeEnd;
            											}
HXDLIN(1362)											if ((tempRangeEnd == formatRange->end)) {
HXLINE(1362)												layoutGroup = null();
            											}
HXDLIN(1362)											if ((tempRangeEnd == placeIndex)) {
HXLINE(1362)												goto _hx_goto_32;
            											}
HXDLIN(1362)											bool _hx_tmp;
HXDLIN(1362)											if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)												rangeIndex = (rangeIndex + 1);
HXDLIN(1362)												formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)												currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)												font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1362)												_hx_tmp = true;
            											}
            											else {
HXLINE(1362)												_hx_tmp = false;
            											}
HXDLIN(1362)											if (!(_hx_tmp)) {
HXLINE(1362)												::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1362)												goto _hx_goto_32;
            											}
HXDLIN(1362)											{
HXLINE(1362)												if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1362)													ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1362)													descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            												}
            												else {
HXLINE(1362)													bool _hx_tmp;
HXDLIN(1362)													if (::hx::IsNotNull( font )) {
HXLINE(1362)														_hx_tmp = (font->unitsPerEM != 0);
            													}
            													else {
HXLINE(1362)														_hx_tmp = false;
            													}
HXDLIN(1362)													if (_hx_tmp) {
HXLINE(1362)														ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1362)														descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            													}
            													else {
HXLINE(1362)														ascent = ( (Float)(currentFormat->size) );
HXDLIN(1362)														descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            													}
            												}
HXDLIN(1362)												leading = ( (int)(currentFormat->leading) );
HXDLIN(1362)												heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1362)												if ((heightValue > maxHeightValue)) {
HXLINE(1362)													maxHeightValue = heightValue;
            												}
HXDLIN(1362)												if ((ascent > maxAscent)) {
HXLINE(1362)													maxAscent = ascent;
            												}
            											}
            										}
            										_hx_goto_32:;
            									}
HXDLIN(1362)									textIndex = placeIndex;
            								}
HXDLIN(1362)								{
HXLINE(1362)									{
HXLINE(1362)										if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1362)											ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1362)											descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            										}
            										else {
HXLINE(1362)											bool _hx_tmp;
HXDLIN(1362)											if (::hx::IsNotNull( font )) {
HXLINE(1362)												_hx_tmp = (font->unitsPerEM != 0);
            											}
            											else {
HXLINE(1362)												_hx_tmp = false;
            											}
HXDLIN(1362)											if (_hx_tmp) {
HXLINE(1362)												ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1362)												descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            											}
            											else {
HXLINE(1362)												ascent = ( (Float)(currentFormat->size) );
HXDLIN(1362)												descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            											}
            										}
HXDLIN(1362)										leading = ( (int)(currentFormat->leading) );
HXDLIN(1362)										heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1362)										if ((heightValue > maxHeightValue)) {
HXLINE(1362)											maxHeightValue = heightValue;
            										}
HXDLIN(1362)										if ((ascent > maxAscent)) {
HXLINE(1362)											maxAscent = ascent;
            										}
            									}
HXDLIN(1362)									int i1 = _gthis->layoutGroups->get_length();
HXDLIN(1362)									while(true){
HXLINE(1362)										i1 = (i1 - 1);
HXDLIN(1362)										if (!((i1 > -1))) {
HXLINE(1362)											goto _hx_goto_34;
            										}
HXDLIN(1362)										 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i1).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1362)										if ((lg->lineIndex < lineIndex)) {
HXLINE(1362)											goto _hx_goto_34;
            										}
HXDLIN(1362)										if ((lg->lineIndex > lineIndex)) {
HXLINE(1362)											continue;
            										}
HXDLIN(1362)										lg->ascent = maxAscent;
HXDLIN(1362)										lg->height = ( (Float)(maxHeightValue) );
            									}
            									_hx_goto_34:;
HXDLIN(1362)									offsetY = (offsetY + maxHeightValue);
HXDLIN(1362)									maxAscent = ((Float)0.0);
HXDLIN(1362)									maxHeightValue = 0;
HXDLIN(1362)									lineIndex = (lineIndex + 1);
HXDLIN(1362)									offsetX = ( (Float)(0) );
HXDLIN(1362)									firstLineOfParagraph = false;
            								}
HXDLIN(1362)								if ((placeIndex >= breakIndex)) {
HXLINE(1362)									positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1362)									widthValue = ( (Float)(0) );
            								}
            								else {
HXLINE(1362)									if ((breakIndex <= formatRange->end)) {
HXLINE(1362)										::String text = _gthis->text;
HXDLIN(1362)										Float letterSpacing = ((Float)0.0);
HXDLIN(1362)										if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)											letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            										}
HXDLIN(1362)										if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)											_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)										_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)										if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)											_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)										bool positions1;
HXDLIN(1362)										if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)											positions1 = (_gthis->sharpness < 400);
            										}
            										else {
HXLINE(1362)											positions1 = true;
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1362)										 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)										_gthis1->set_text(text.substring(placeIndex,breakIndex));
HXDLIN(1362)										if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)											positions = _gthis->_hx___textLayout->get_positions();
            										}
            										else {
HXLINE(1362)											positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            										}
HXDLIN(1362)										Float width = ((Float)0.0);
HXDLIN(1362)										{
HXLINE(1362)											int _g = 0;
HXDLIN(1362)											while((_g < positions->length)){
HXLINE(1362)												 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)												_g = (_g + 1);
HXDLIN(1362)												width = (width + position->advance->x);
            											}
            										}
HXDLIN(1362)										widthValue = width;
            									}
            									else {
HXLINE(1362)										int tempIndex = placeIndex;
HXDLIN(1362)										int tempRangeEnd = formatRange->end;
HXDLIN(1362)										int countRanges = 0;
HXDLIN(1362)										positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1362)										widthValue = ( (Float)(0) );
HXDLIN(1362)										while(true){
HXLINE(1362)											if ((tempIndex != tempRangeEnd)) {
HXLINE(1362)												::String text = _gthis->text;
HXDLIN(1362)												Float letterSpacing = ((Float)0.0);
HXDLIN(1362)												if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)													letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            												}
HXDLIN(1362)												if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)													_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            												}
HXDLIN(1362)												_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)												_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)												if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)													_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            												}
HXDLIN(1362)												_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)												bool _hx_tmp;
HXDLIN(1362)												if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)													_hx_tmp = (_gthis->sharpness < 400);
            												}
            												else {
HXLINE(1362)													_hx_tmp = true;
            												}
HXDLIN(1362)												_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1362)												 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)												_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1362)												::Array< ::Dynamic> tempPositions;
HXDLIN(1362)												if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)													tempPositions = _gthis->_hx___textLayout->get_positions();
            												}
            												else {
HXLINE(1362)													tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            												}
HXDLIN(1362)												positions = positions->concat(tempPositions);
            											}
HXDLIN(1362)											if ((tempRangeEnd != breakIndex)) {
HXLINE(1362)												bool _hx_tmp;
HXDLIN(1362)												if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)													rangeIndex = (rangeIndex + 1);
HXDLIN(1362)													formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)													currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)													font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1362)													_hx_tmp = true;
            												}
            												else {
HXLINE(1362)													_hx_tmp = false;
            												}
HXDLIN(1362)												if (!(_hx_tmp)) {
HXLINE(1362)													::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1362)													goto _hx_goto_36;
            												}
HXDLIN(1362)												tempIndex = tempRangeEnd;
HXDLIN(1362)												if ((breakIndex < formatRange->end)) {
HXLINE(1362)													tempRangeEnd = breakIndex;
            												}
            												else {
HXLINE(1362)													tempRangeEnd = formatRange->end;
            												}
HXDLIN(1362)												countRanges = (countRanges + 1);
            											}
            											else {
HXLINE(1362)												Float width = ((Float)0.0);
HXDLIN(1362)												{
HXLINE(1362)													int _g = 0;
HXDLIN(1362)													while((_g < positions->length)){
HXLINE(1362)														 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)														_g = (_g + 1);
HXDLIN(1362)														width = (width + position->advance->x);
            													}
            												}
HXDLIN(1362)												widthValue = width;
HXDLIN(1362)												goto _hx_goto_36;
            											}
            										}
            										_hx_goto_36:;
HXDLIN(1362)										rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1362)										if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)											rangeIndex = (rangeIndex + 1);
HXDLIN(1362)											formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)											currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)											font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            										}
            									}
            								}
HXDLIN(1362)								remainingPositions = positions;
HXDLIN(1362)								tempWidth = widthValue;
            							}
            							_hx_goto_22:;
            						}
HXDLIN(1362)						{
HXLINE(1362)							if ((breakIndex <= formatRange->end)) {
HXLINE(1362)								::String text = _gthis->text;
HXDLIN(1362)								Float letterSpacing = ((Float)0.0);
HXDLIN(1362)								if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)									letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            								}
HXDLIN(1362)								if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)									_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            								}
HXDLIN(1362)								_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)								_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)								if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)									_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            								}
HXDLIN(1362)								_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)								bool positions1;
HXDLIN(1362)								if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)									positions1 = (_gthis->sharpness < 400);
            								}
            								else {
HXLINE(1362)									positions1 = true;
            								}
HXDLIN(1362)								_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1362)								 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)								_gthis1->set_text(text.substring(textIndex,breakIndex));
HXDLIN(1362)								if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)									positions = _gthis->_hx___textLayout->get_positions();
            								}
            								else {
HXLINE(1362)									positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            								}
HXDLIN(1362)								Float width = ((Float)0.0);
HXDLIN(1362)								{
HXLINE(1362)									int _g = 0;
HXDLIN(1362)									while((_g < positions->length)){
HXLINE(1362)										 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)										_g = (_g + 1);
HXDLIN(1362)										width = (width + position->advance->x);
            									}
            								}
HXDLIN(1362)								widthValue = width;
HXDLIN(1362)								bool _hx_tmp;
HXDLIN(1362)								if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1362)									_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            								}
            								else {
HXLINE(1362)									_hx_tmp = true;
            								}
HXDLIN(1362)								if (_hx_tmp) {
HXLINE(1362)									layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,breakIndex);
HXDLIN(1362)									_gthis->layoutGroups->push(layoutGroup);
            								}
            								else {
HXLINE(1362)									layoutGroup->format = formatRange->format;
HXDLIN(1362)									layoutGroup->startIndex = textIndex;
HXDLIN(1362)									layoutGroup->endIndex = breakIndex;
            								}
HXDLIN(1362)								layoutGroup->positions = positions;
HXDLIN(1362)								int _hx_tmp1;
HXDLIN(1362)								if (firstLineOfParagraph) {
HXLINE(1362)									_hx_tmp1 = indent;
            								}
            								else {
HXLINE(1362)									_hx_tmp1 = 0;
            								}
HXDLIN(1362)								layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1362)								layoutGroup->ascent = ascent;
HXDLIN(1362)								layoutGroup->descent = descent;
HXDLIN(1362)								layoutGroup->leading = leading;
HXDLIN(1362)								layoutGroup->lineIndex = lineIndex;
HXDLIN(1362)								layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1362)								layoutGroup->width = widthValue;
HXDLIN(1362)								layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1362)								offsetX = (offsetX + widthValue);
HXDLIN(1362)								if ((breakIndex == formatRange->end)) {
HXLINE(1362)									layoutGroup = null();
HXDLIN(1362)									if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)										rangeIndex = (rangeIndex + 1);
HXDLIN(1362)										formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)										currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)										font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            									}
HXDLIN(1362)									{
HXLINE(1362)										if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1362)											ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1362)											descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            										}
            										else {
HXLINE(1362)											bool _hx_tmp;
HXDLIN(1362)											if (::hx::IsNotNull( font )) {
HXLINE(1362)												_hx_tmp = (font->unitsPerEM != 0);
            											}
            											else {
HXLINE(1362)												_hx_tmp = false;
            											}
HXDLIN(1362)											if (_hx_tmp) {
HXLINE(1362)												ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1362)												descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            											}
            											else {
HXLINE(1362)												ascent = ( (Float)(currentFormat->size) );
HXDLIN(1362)												descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            											}
            										}
HXDLIN(1362)										leading = ( (int)(currentFormat->leading) );
HXDLIN(1362)										heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1362)										if ((heightValue > maxHeightValue)) {
HXLINE(1362)											maxHeightValue = heightValue;
            										}
HXDLIN(1362)										if ((ascent > maxAscent)) {
HXLINE(1362)											maxAscent = ascent;
            										}
            									}
            								}
            							}
            							else {
HXLINE(1362)								while(true){
HXLINE(1362)									int tempRangeEnd;
HXDLIN(1362)									if ((breakIndex < formatRange->end)) {
HXLINE(1362)										tempRangeEnd = breakIndex;
            									}
            									else {
HXLINE(1362)										tempRangeEnd = formatRange->end;
            									}
HXDLIN(1362)									if ((textIndex != tempRangeEnd)) {
HXLINE(1362)										::String text = _gthis->text;
HXDLIN(1362)										Float letterSpacing = ((Float)0.0);
HXDLIN(1362)										if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1362)											letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            										}
HXDLIN(1362)										if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1362)											_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->set_text(null());
HXDLIN(1362)										_gthis->_hx___textLayout->set_font(font);
HXDLIN(1362)										if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1362)											_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1362)										bool positions1;
HXDLIN(1362)										if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1362)											positions1 = (_gthis->sharpness < 400);
            										}
            										else {
HXLINE(1362)											positions1 = true;
            										}
HXDLIN(1362)										_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1362)										 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1362)										_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1362)										if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1362)											positions = _gthis->_hx___textLayout->get_positions();
            										}
            										else {
HXLINE(1362)											positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            										}
HXDLIN(1362)										Float width = ((Float)0.0);
HXDLIN(1362)										{
HXLINE(1362)											int _g = 0;
HXDLIN(1362)											while((_g < positions->length)){
HXLINE(1362)												 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1362)												_g = (_g + 1);
HXDLIN(1362)												width = (width + position->advance->x);
            											}
            										}
HXDLIN(1362)										widthValue = width;
HXDLIN(1362)										bool _hx_tmp;
HXDLIN(1362)										if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1362)											_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            										}
            										else {
HXLINE(1362)											_hx_tmp = true;
            										}
HXDLIN(1362)										if (_hx_tmp) {
HXLINE(1362)											layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1362)											_gthis->layoutGroups->push(layoutGroup);
            										}
            										else {
HXLINE(1362)											layoutGroup->format = formatRange->format;
HXDLIN(1362)											layoutGroup->startIndex = textIndex;
HXDLIN(1362)											layoutGroup->endIndex = tempRangeEnd;
            										}
HXDLIN(1362)										layoutGroup->positions = positions;
HXDLIN(1362)										int _hx_tmp1;
HXDLIN(1362)										if (firstLineOfParagraph) {
HXLINE(1362)											_hx_tmp1 = indent;
            										}
            										else {
HXLINE(1362)											_hx_tmp1 = 0;
            										}
HXDLIN(1362)										layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1362)										layoutGroup->ascent = ascent;
HXDLIN(1362)										layoutGroup->descent = descent;
HXDLIN(1362)										layoutGroup->leading = leading;
HXDLIN(1362)										layoutGroup->lineIndex = lineIndex;
HXDLIN(1362)										layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1362)										layoutGroup->width = widthValue;
HXDLIN(1362)										layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1362)										offsetX = (offsetX + widthValue);
HXDLIN(1362)										textIndex = tempRangeEnd;
            									}
HXDLIN(1362)									if ((tempRangeEnd == formatRange->end)) {
HXLINE(1362)										layoutGroup = null();
            									}
HXDLIN(1362)									if ((tempRangeEnd == breakIndex)) {
HXLINE(1362)										goto _hx_goto_39;
            									}
HXDLIN(1362)									bool _hx_tmp;
HXDLIN(1362)									if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1362)										rangeIndex = (rangeIndex + 1);
HXDLIN(1362)										formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1362)										currentFormat->_hx___merge(formatRange->format);
HXDLIN(1362)										font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1362)										_hx_tmp = true;
            									}
            									else {
HXLINE(1362)										_hx_tmp = false;
            									}
HXDLIN(1362)									if (!(_hx_tmp)) {
HXLINE(1362)										::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1362)										goto _hx_goto_39;
            									}
HXDLIN(1362)									{
HXLINE(1362)										if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1362)											ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1362)											descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            										}
            										else {
HXLINE(1362)											bool _hx_tmp;
HXDLIN(1362)											if (::hx::IsNotNull( font )) {
HXLINE(1362)												_hx_tmp = (font->unitsPerEM != 0);
            											}
            											else {
HXLINE(1362)												_hx_tmp = false;
            											}
HXDLIN(1362)											if (_hx_tmp) {
HXLINE(1362)												ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1362)												descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            											}
            											else {
HXLINE(1362)												ascent = ( (Float)(currentFormat->size) );
HXDLIN(1362)												descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            											}
            										}
HXDLIN(1362)										leading = ( (int)(currentFormat->leading) );
HXDLIN(1362)										heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1362)										if ((heightValue > maxHeightValue)) {
HXLINE(1362)											maxHeightValue = heightValue;
            										}
HXDLIN(1362)										if ((ascent > maxAscent)) {
HXLINE(1362)											maxAscent = ascent;
            										}
            									}
            								}
            								_hx_goto_39:;
            							}
HXDLIN(1362)							textIndex = breakIndex;
            						}
            					}
HXLINE(1364)					layoutGroup = null();
            				}
            				else {
HXLINE(1366)					bool _hx_tmp;
HXDLIN(1366)					if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1366)						_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            					}
            					else {
HXLINE(1366)						_hx_tmp = false;
            					}
HXDLIN(1366)					if (_hx_tmp) {
HXLINE(1369)						if ((layoutGroup->endIndex == spaceIndex)) {
HXLINE(1371)							 ::openfl::text::_internal::TextLayoutGroup layoutGroup1 = layoutGroup;
HXDLIN(1371)							int index = (layoutGroup->positions->length - 1);
HXDLIN(1371)							Float _hx_tmp;
HXDLIN(1371)							bool _hx_tmp1;
HXDLIN(1371)							if ((index >= 0)) {
HXLINE(1371)								_hx_tmp1 = (index < layoutGroup->positions->length);
            							}
            							else {
HXLINE(1371)								_hx_tmp1 = false;
            							}
HXDLIN(1371)							if (_hx_tmp1) {
HXLINE(1371)								_hx_tmp = layoutGroup->positions->__get(index).StaticCast<  ::openfl::text::_internal::GlyphPosition >()->advance->x;
            							}
            							else {
HXLINE(1371)								_hx_tmp = ( (Float)(0) );
            							}
HXDLIN(1371)							layoutGroup1->width = (layoutGroup1->width - _hx_tmp);
            						}
HXLINE(1374)						layoutGroup = null();
            					}
            				}
HXLINE(1377)				{
HXLINE(1377)					{
HXLINE(1377)						if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1377)							ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1377)							descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            						}
            						else {
HXLINE(1377)							bool _hx_tmp;
HXDLIN(1377)							if (::hx::IsNotNull( font )) {
HXLINE(1377)								_hx_tmp = (font->unitsPerEM != 0);
            							}
            							else {
HXLINE(1377)								_hx_tmp = false;
            							}
HXDLIN(1377)							if (_hx_tmp) {
HXLINE(1377)								ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1377)								descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            							}
            							else {
HXLINE(1377)								ascent = ( (Float)(currentFormat->size) );
HXDLIN(1377)								descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            							}
            						}
HXDLIN(1377)						leading = ( (int)(currentFormat->leading) );
HXDLIN(1377)						heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1377)						if ((heightValue > maxHeightValue)) {
HXLINE(1377)							maxHeightValue = heightValue;
            						}
HXDLIN(1377)						if ((ascent > maxAscent)) {
HXLINE(1377)							maxAscent = ascent;
            						}
            					}
HXDLIN(1377)					int i = _gthis->layoutGroups->get_length();
HXDLIN(1377)					while(true){
HXLINE(1377)						i = (i - 1);
HXDLIN(1377)						if (!((i > -1))) {
HXLINE(1377)							goto _hx_goto_41;
            						}
HXDLIN(1377)						 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1377)						if ((lg->lineIndex < lineIndex)) {
HXLINE(1377)							goto _hx_goto_41;
            						}
HXDLIN(1377)						if ((lg->lineIndex > lineIndex)) {
HXLINE(1377)							continue;
            						}
HXDLIN(1377)						lg->ascent = maxAscent;
HXDLIN(1377)						lg->height = ( (Float)(maxHeightValue) );
            					}
            					_hx_goto_41:;
HXDLIN(1377)					offsetY = (offsetY + maxHeightValue);
HXDLIN(1377)					maxAscent = ((Float)0.0);
HXDLIN(1377)					maxHeightValue = 0;
HXDLIN(1377)					lineIndex = (lineIndex + 1);
HXDLIN(1377)					offsetX = ( (Float)(0) );
HXDLIN(1377)					firstLineOfParagraph = false;
            				}
HXLINE(1380)				if ((formatRange->end == breakIndex)) {
HXLINE(1382)					if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1382)						rangeIndex = (rangeIndex + 1);
HXDLIN(1382)						formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1382)						currentFormat->_hx___merge(formatRange->format);
HXDLIN(1382)						font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            					}
HXLINE(1383)					{
HXLINE(1383)						if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1383)							ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1383)							descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            						}
            						else {
HXLINE(1383)							bool _hx_tmp;
HXDLIN(1383)							if (::hx::IsNotNull( font )) {
HXLINE(1383)								_hx_tmp = (font->unitsPerEM != 0);
            							}
            							else {
HXLINE(1383)								_hx_tmp = false;
            							}
HXDLIN(1383)							if (_hx_tmp) {
HXLINE(1383)								ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1383)								descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            							}
            							else {
HXLINE(1383)								ascent = ( (Float)(currentFormat->size) );
HXDLIN(1383)								descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            							}
            						}
HXDLIN(1383)						leading = ( (int)(currentFormat->leading) );
HXDLIN(1383)						heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1383)						if ((heightValue > maxHeightValue)) {
HXLINE(1383)							maxHeightValue = heightValue;
            						}
HXDLIN(1383)						if ((ascent > maxAscent)) {
HXLINE(1383)							maxAscent = ascent;
            						}
            					}
            				}
HXLINE(1386)				textIndex = (breakIndex + 1);
HXLINE(1387)				previousBreakIndex = breakIndex;
HXLINE(1388)				breakCount = (breakCount + 1);
HXLINE(1389)				if ((breakCount < this->lineBreaks->get_length())) {
HXLINE(1389)					breakIndex = this->lineBreaks->get(breakCount);
            				}
            				else {
HXLINE(1389)					breakIndex = -1;
            				}
HXLINE(1391)				{
HXLINE(1391)					firstLineOfParagraph = true;
HXDLIN(1391)					if (::hx::IsNotNull( currentFormat->align )) {
HXLINE(1391)						align = currentFormat->align;
            					}
            					else {
HXLINE(1391)						align = 3;
            					}
HXDLIN(1391)					if (::hx::IsNotNull( currentFormat->blockIndent )) {
HXLINE(1391)						blockIndent = ( (int)(currentFormat->blockIndent) );
            					}
            					else {
HXLINE(1391)						blockIndent = 0;
            					}
HXDLIN(1391)					if (::hx::IsNotNull( currentFormat->indent )) {
HXLINE(1391)						indent = ( (int)(currentFormat->indent) );
            					}
            					else {
HXLINE(1391)						indent = 0;
            					}
HXDLIN(1391)					if (::hx::IsNotNull( currentFormat->leftMargin )) {
HXLINE(1391)						leftMargin = ( (int)(currentFormat->leftMargin) );
            					}
            					else {
HXLINE(1391)						leftMargin = 0;
            					}
HXDLIN(1391)					if (::hx::IsNotNull( currentFormat->rightMargin )) {
HXLINE(1391)						rightMargin = ( (int)(currentFormat->rightMargin) );
            					}
            					else {
HXLINE(1391)						rightMargin = 0;
            					}
HXDLIN(1391)					bool _hx_tmp = ::hx::IsNotNull( currentFormat->bullet );
HXDLIN(1391)					bool _hx_tmp1 = ::hx::IsNotNull( currentFormat->tabStops );
            				}
            			}
            			else {
HXLINE(1393)				if ((spaceIndex > -1)) {
HXLINE(1397)					bool _hx_tmp;
HXDLIN(1397)					if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1397)						_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            					}
            					else {
HXLINE(1397)						_hx_tmp = false;
            					}
HXDLIN(1397)					if (_hx_tmp) {
HXLINE(1399)						layoutGroup = null();
            					}
HXLINE(1402)					wrap = false;
HXLINE(1404)					while((textIndex < this->text.length)){
HXLINE(1408)						int endIndex = -1;
HXLINE(1410)						if ((spaceIndex == -1)) {
HXLINE(1412)							endIndex = breakIndex;
            						}
            						else {
HXLINE(1416)							endIndex = (spaceIndex + 1);
HXLINE(1418)							bool _hx_tmp;
HXDLIN(1418)							if ((breakIndex > -1)) {
HXLINE(1418)								_hx_tmp = (breakIndex < endIndex);
            							}
            							else {
HXLINE(1418)								_hx_tmp = false;
            							}
HXDLIN(1418)							if (_hx_tmp) {
HXLINE(1420)								endIndex = breakIndex;
            							}
            						}
HXLINE(1424)						if ((endIndex == -1)) {
HXLINE(1426)							endIndex = this->text.length;
            						}
HXLINE(1429)						if ((textIndex >= endIndex)) {
HXLINE(1429)							positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1429)							widthValue = ( (Float)(0) );
            						}
            						else {
HXLINE(1429)							if ((endIndex <= formatRange->end)) {
HXLINE(1429)								::String text = _gthis->text;
HXDLIN(1429)								Float letterSpacing = ((Float)0.0);
HXDLIN(1429)								if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1429)									letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            								}
HXDLIN(1429)								if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1429)									_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            								}
HXDLIN(1429)								_gthis->_hx___textLayout->set_text(null());
HXDLIN(1429)								_gthis->_hx___textLayout->set_font(font);
HXDLIN(1429)								if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1429)									_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            								}
HXDLIN(1429)								_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1429)								bool positions1;
HXDLIN(1429)								if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1429)									positions1 = (_gthis->sharpness < 400);
            								}
            								else {
HXLINE(1429)									positions1 = true;
            								}
HXDLIN(1429)								_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1429)								 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1429)								_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1429)								if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1429)									positions = _gthis->_hx___textLayout->get_positions();
            								}
            								else {
HXLINE(1429)									positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            								}
HXDLIN(1429)								Float width = ((Float)0.0);
HXDLIN(1429)								{
HXLINE(1429)									int _g = 0;
HXDLIN(1429)									while((_g < positions->length)){
HXLINE(1429)										 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1429)										_g = (_g + 1);
HXDLIN(1429)										width = (width + position->advance->x);
            									}
            								}
HXDLIN(1429)								widthValue = width;
            							}
            							else {
HXLINE(1429)								int tempIndex = textIndex;
HXDLIN(1429)								int tempRangeEnd = formatRange->end;
HXDLIN(1429)								int countRanges = 0;
HXDLIN(1429)								positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1429)								widthValue = ( (Float)(0) );
HXDLIN(1429)								while(true){
HXLINE(1429)									if ((tempIndex != tempRangeEnd)) {
HXLINE(1429)										::String text = _gthis->text;
HXDLIN(1429)										Float letterSpacing = ((Float)0.0);
HXDLIN(1429)										if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1429)											letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            										}
HXDLIN(1429)										if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1429)											_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            										}
HXDLIN(1429)										_gthis->_hx___textLayout->set_text(null());
HXDLIN(1429)										_gthis->_hx___textLayout->set_font(font);
HXDLIN(1429)										if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1429)											_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            										}
HXDLIN(1429)										_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1429)										bool _hx_tmp;
HXDLIN(1429)										if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1429)											_hx_tmp = (_gthis->sharpness < 400);
            										}
            										else {
HXLINE(1429)											_hx_tmp = true;
            										}
HXDLIN(1429)										_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1429)										 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1429)										_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1429)										::Array< ::Dynamic> tempPositions;
HXDLIN(1429)										if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1429)											tempPositions = _gthis->_hx___textLayout->get_positions();
            										}
            										else {
HXLINE(1429)											tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            										}
HXDLIN(1429)										positions = positions->concat(tempPositions);
            									}
HXDLIN(1429)									if ((tempRangeEnd != endIndex)) {
HXLINE(1429)										bool _hx_tmp;
HXDLIN(1429)										if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1429)											rangeIndex = (rangeIndex + 1);
HXDLIN(1429)											formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1429)											currentFormat->_hx___merge(formatRange->format);
HXDLIN(1429)											font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1429)											_hx_tmp = true;
            										}
            										else {
HXLINE(1429)											_hx_tmp = false;
            										}
HXDLIN(1429)										if (!(_hx_tmp)) {
HXLINE(1429)											::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1429)											goto _hx_goto_44;
            										}
HXDLIN(1429)										tempIndex = tempRangeEnd;
HXDLIN(1429)										if ((endIndex < formatRange->end)) {
HXLINE(1429)											tempRangeEnd = endIndex;
            										}
            										else {
HXLINE(1429)											tempRangeEnd = formatRange->end;
            										}
HXDLIN(1429)										countRanges = (countRanges + 1);
            									}
            									else {
HXLINE(1429)										Float width = ((Float)0.0);
HXDLIN(1429)										{
HXLINE(1429)											int _g = 0;
HXDLIN(1429)											while((_g < positions->length)){
HXLINE(1429)												 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1429)												_g = (_g + 1);
HXDLIN(1429)												width = (width + position->advance->x);
            											}
            										}
HXDLIN(1429)										widthValue = width;
HXDLIN(1429)										goto _hx_goto_44;
            									}
            								}
            								_hx_goto_44:;
HXDLIN(1429)								rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1429)								if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1429)									rangeIndex = (rangeIndex + 1);
HXDLIN(1429)									formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1429)									currentFormat->_hx___merge(formatRange->format);
HXDLIN(1429)									font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            								}
            							}
            						}
HXLINE(1431)						if (::hx::IsEq( align,2 )) {
HXLINE(1433)							bool _hx_tmp;
HXDLIN(1433)							if ((positions->length > 0)) {
HXLINE(1433)								_hx_tmp = (textIndex == previousSpaceIndex);
            							}
            							else {
HXLINE(1433)								_hx_tmp = false;
            							}
HXDLIN(1433)							if (_hx_tmp) {
HXLINE(1436)								textIndex = (textIndex + 1);
HXLINE(1438)								Float spaceWidth = positions->shift().StaticCast<  ::openfl::text::_internal::GlyphPosition >()->advance->x;
HXLINE(1439)								widthValue = (widthValue - spaceWidth);
HXLINE(1440)								offsetX = (offsetX + spaceWidth);
            							}
HXLINE(1443)							bool _hx_tmp1;
HXDLIN(1443)							if ((positions->length > 0)) {
HXLINE(1443)								_hx_tmp1 = (endIndex == (spaceIndex + 1));
            							}
            							else {
HXLINE(1443)								_hx_tmp1 = false;
            							}
HXDLIN(1443)							if (_hx_tmp1) {
HXLINE(1446)								endIndex = (endIndex - 1);
HXLINE(1448)								Float spaceWidth = positions->pop().StaticCast<  ::openfl::text::_internal::GlyphPosition >()->advance->x;
HXLINE(1449)								widthValue = (widthValue - spaceWidth);
            							}
            						}
HXLINE(1453)						if (this->wordWrap) {
HXLINE(1455)							int _hx_tmp;
HXDLIN(1455)							if (firstLineOfParagraph) {
HXLINE(1455)								_hx_tmp = indent;
            							}
            							else {
HXLINE(1455)								_hx_tmp = 0;
            							}
HXDLIN(1455)							if (((offsetX + widthValue) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp)) )))) {
HXLINE(1457)								wrap = true;
HXLINE(1459)								bool _hx_tmp;
HXDLIN(1459)								if ((positions->length > 0)) {
HXLINE(1459)									_hx_tmp = (endIndex == (spaceIndex + 1));
            								}
            								else {
HXLINE(1459)									_hx_tmp = false;
            								}
HXDLIN(1459)								if (_hx_tmp) {
HXLINE(1463)									 ::openfl::text::_internal::GlyphPosition lastPosition = positions->__get((positions->length - 1)).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXLINE(1464)									Float spaceWidth = lastPosition->advance->x;
HXLINE(1466)									int _hx_tmp;
HXDLIN(1466)									if (firstLineOfParagraph) {
HXLINE(1466)										_hx_tmp = indent;
            									}
            									else {
HXLINE(1466)										_hx_tmp = 0;
            									}
HXDLIN(1466)									if ((((offsetX + widthValue) - spaceWidth) <= (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp)) )))) {
HXLINE(1468)										wrap = false;
            									}
            								}
            							}
            						}
HXLINE(1474)						if (wrap) {
HXLINE(1476)							bool _hx_tmp;
HXDLIN(1476)							if (::hx::IsNotEq( align,2 )) {
HXLINE(1476)								if (::hx::IsNull( layoutGroup )) {
HXLINE(1476)									_hx_tmp = (this->layoutGroups->get_length() > 0);
            								}
            								else {
HXLINE(1476)									_hx_tmp = true;
            								}
            							}
            							else {
HXLINE(1476)								_hx_tmp = false;
            							}
HXDLIN(1476)							if (_hx_tmp) {
HXLINE(1478)								 ::openfl::text::_internal::TextLayoutGroup previous = layoutGroup;
HXLINE(1479)								if (::hx::IsNull( previous )) {
HXLINE(1481)									::Dynamic this1 = this->layoutGroups;
HXDLIN(1481)									previous = ( ( ::openfl::_Vector::ObjectVector)(this1) )->get((this->layoutGroups->get_length() - 1)).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
            								}
HXLINE(1485)								 ::openfl::text::_internal::TextLayoutGroup previous1 = previous;
HXDLIN(1485)								int index = (previous->positions->length - 1);
HXDLIN(1485)								Float _hx_tmp;
HXDLIN(1485)								bool _hx_tmp1;
HXDLIN(1485)								if ((index >= 0)) {
HXLINE(1485)									_hx_tmp1 = (index < previous->positions->length);
            								}
            								else {
HXLINE(1485)									_hx_tmp1 = false;
            								}
HXDLIN(1485)								if (_hx_tmp1) {
HXLINE(1485)									_hx_tmp = previous->positions->__get(index).StaticCast<  ::openfl::text::_internal::GlyphPosition >()->advance->x;
            								}
            								else {
HXLINE(1485)									_hx_tmp = ( (Float)(0) );
            								}
HXDLIN(1485)								previous1->width = (previous1->width - _hx_tmp);
HXLINE(1486)								previous->endIndex--;
            							}
HXLINE(1489)							int i = (this->layoutGroups->get_length() - 1);
HXLINE(1490)							int offsetCount = 0;
HXLINE(1492)							while((i >= 0)){
HXLINE(1494)								layoutGroup = this->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXLINE(1496)								bool _hx_tmp;
HXDLIN(1496)								if ((i > 0)) {
HXLINE(1496)									_hx_tmp = (layoutGroup->startIndex > previousSpaceIndex);
            								}
            								else {
HXLINE(1496)									_hx_tmp = false;
            								}
HXDLIN(1496)								if (_hx_tmp) {
HXLINE(1498)									offsetCount = (offsetCount + 1);
            								}
            								else {
HXLINE(1502)									goto _hx_goto_46;
            								}
HXLINE(1505)								i = (i - 1);
            							}
            							_hx_goto_46:;
HXLINE(1508)							if ((textIndex == (previousSpaceIndex + 1))) {
HXLINE(1510)								{
HXLINE(1510)									if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1510)										ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1510)										descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            									}
            									else {
HXLINE(1510)										bool _hx_tmp;
HXDLIN(1510)										if (::hx::IsNotNull( font )) {
HXLINE(1510)											_hx_tmp = (font->unitsPerEM != 0);
            										}
            										else {
HXLINE(1510)											_hx_tmp = false;
            										}
HXDLIN(1510)										if (_hx_tmp) {
HXLINE(1510)											ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1510)											descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            										}
            										else {
HXLINE(1510)											ascent = ( (Float)(currentFormat->size) );
HXDLIN(1510)											descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            										}
            									}
HXDLIN(1510)									leading = ( (int)(currentFormat->leading) );
HXDLIN(1510)									heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1510)									if ((heightValue > maxHeightValue)) {
HXLINE(1510)										maxHeightValue = heightValue;
            									}
HXDLIN(1510)									if ((ascent > maxAscent)) {
HXLINE(1510)										maxAscent = ascent;
            									}
            								}
HXDLIN(1510)								int i = _gthis->layoutGroups->get_length();
HXDLIN(1510)								while(true){
HXLINE(1510)									i = (i - 1);
HXDLIN(1510)									if (!((i > -1))) {
HXLINE(1510)										goto _hx_goto_47;
            									}
HXDLIN(1510)									 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1510)									if ((lg->lineIndex < lineIndex)) {
HXLINE(1510)										goto _hx_goto_47;
            									}
HXDLIN(1510)									if ((lg->lineIndex > lineIndex)) {
HXLINE(1510)										continue;
            									}
HXDLIN(1510)									lg->ascent = maxAscent;
HXDLIN(1510)									lg->height = ( (Float)(maxHeightValue) );
            								}
            								_hx_goto_47:;
HXDLIN(1510)								offsetY = (offsetY + maxHeightValue);
HXDLIN(1510)								maxAscent = ((Float)0.0);
HXDLIN(1510)								maxHeightValue = 0;
HXDLIN(1510)								lineIndex = (lineIndex + 1);
HXDLIN(1510)								offsetX = ( (Float)(0) );
HXDLIN(1510)								firstLineOfParagraph = false;
            							}
HXLINE(1513)							offsetX = ( (Float)(0) );
HXLINE(1515)							if ((offsetCount > 0)) {
HXLINE(1517)								::Dynamic this1 = this->layoutGroups;
HXDLIN(1517)								Float bumpX = ( ( ::openfl::_Vector::ObjectVector)(this1) )->get((this->layoutGroups->get_length() - offsetCount)).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >()->offsetX;
HXLINE(1519)								{
HXLINE(1519)									int _g = (this->layoutGroups->get_length() - offsetCount);
HXDLIN(1519)									int _g1 = this->layoutGroups->get_length();
HXDLIN(1519)									while((_g < _g1)){
HXLINE(1519)										_g = (_g + 1);
HXDLIN(1519)										int i = (_g - 1);
HXLINE(1521)										layoutGroup = this->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXLINE(1522)										 ::openfl::text::_internal::TextLayoutGroup layoutGroup1 = layoutGroup;
HXDLIN(1522)										layoutGroup1->offsetX = (layoutGroup1->offsetX - bumpX);
HXLINE(1523)										layoutGroup->offsetY = (offsetY + 2);
HXLINE(1524)										layoutGroup->lineIndex = lineIndex;
HXLINE(1525)										offsetX = (offsetX + layoutGroup->width);
            									}
            								}
            							}
HXLINE(1529)							{
HXLINE(1529)								bool _hx_tmp1;
HXDLIN(1529)								if ((_gthis->width >= 4)) {
HXLINE(1529)									_hx_tmp1 = _gthis->wordWrap;
            								}
            								else {
HXLINE(1529)									_hx_tmp1 = false;
            								}
HXDLIN(1529)								if (_hx_tmp1) {
HXLINE(1529)									::Array< ::Dynamic> remainingPositions = positions;
HXDLIN(1529)									int bufferCount;
HXDLIN(1529)									int placeIndex;
HXDLIN(1529)									Float positionWidth;
HXDLIN(1529)									 ::openfl::text::_internal::GlyphPosition currentPosition;
HXDLIN(1529)									Float width = ((Float)0.0);
HXDLIN(1529)									{
HXLINE(1529)										int _g = 0;
HXDLIN(1529)										while((_g < remainingPositions->length)){
HXLINE(1529)											 ::openfl::text::_internal::GlyphPosition position = remainingPositions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)											_g = (_g + 1);
HXDLIN(1529)											width = (width + position->advance->x);
            										}
            									}
HXDLIN(1529)									Float tempWidth = width;
HXDLIN(1529)									int i = (remainingPositions->length - 1);
HXDLIN(1529)									while((i >= 0)){
HXLINE(1529)										 ::Dynamic currentCharCode = _gthis->text.charCodeAt((textIndex + i));
HXDLIN(1529)										bool _hx_tmp;
HXDLIN(1529)										if (::hx::IsNotEq( currentCharCode,32 )) {
HXLINE(1529)											_hx_tmp = ::hx::IsNotEq( currentCharCode,9 );
            										}
            										else {
HXLINE(1529)											_hx_tmp = false;
            										}
HXDLIN(1529)										if (_hx_tmp) {
HXLINE(1529)											goto _hx_goto_50;
            										}
HXDLIN(1529)										 ::openfl::text::_internal::GlyphPosition position = remainingPositions->__get(i).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)										tempWidth = (tempWidth - position->advance->x);
HXDLIN(1529)										i = (i - 1);
            									}
            									_hx_goto_50:;
HXDLIN(1529)									while(true){
HXLINE(1529)										bool _hx_tmp;
HXDLIN(1529)										if ((remainingPositions->length > 0)) {
HXLINE(1529)											int _hx_tmp1;
HXDLIN(1529)											if (firstLineOfParagraph) {
HXLINE(1529)												_hx_tmp1 = indent;
            											}
            											else {
HXLINE(1529)												_hx_tmp1 = 0;
            											}
HXDLIN(1529)											_hx_tmp = ((offsetX + tempWidth) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) )));
            										}
            										else {
HXLINE(1529)											_hx_tmp = false;
            										}
HXDLIN(1529)										if (!(_hx_tmp)) {
HXLINE(1529)											goto _hx_goto_51;
            										}
HXDLIN(1529)										bufferCount = 0;
HXDLIN(1529)										i = bufferCount;
HXDLIN(1529)										positionWidth = ((Float)0.0);
HXDLIN(1529)										while(true){
HXLINE(1529)											int _hx_tmp;
HXDLIN(1529)											if (firstLineOfParagraph) {
HXLINE(1529)												_hx_tmp = indent;
            											}
            											else {
HXLINE(1529)												_hx_tmp = 0;
            											}
HXDLIN(1529)											if (!(((offsetX + positionWidth) < (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp)) ))))) {
HXLINE(1529)												goto _hx_goto_52;
            											}
HXDLIN(1529)											currentPosition = remainingPositions->__get(i).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)											if ((currentPosition->advance->x == ((Float)0.0))) {
HXLINE(1529)												i = (i + 1);
HXDLIN(1529)												bufferCount = (bufferCount + 1);
            											}
            											else {
HXLINE(1529)												positionWidth = (positionWidth + currentPosition->advance->x);
HXDLIN(1529)												i = (i + 1);
            											}
            										}
            										_hx_goto_52:;
HXDLIN(1529)										if ((i == bufferCount)) {
HXLINE(1529)											i = (bufferCount + 1);
            										}
            										else {
HXLINE(1529)											while(true){
HXLINE(1529)												bool _hx_tmp;
HXDLIN(1529)												if ((i > 1)) {
HXLINE(1529)													int _hx_tmp1;
HXDLIN(1529)													if (firstLineOfParagraph) {
HXLINE(1529)														_hx_tmp1 = indent;
            													}
            													else {
HXLINE(1529)														_hx_tmp1 = 0;
            													}
HXDLIN(1529)													_hx_tmp = ((offsetX + positionWidth) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) )));
            												}
            												else {
HXLINE(1529)													_hx_tmp = false;
            												}
HXDLIN(1529)												if (!(_hx_tmp)) {
HXLINE(1529)													goto _hx_goto_53;
            												}
HXDLIN(1529)												i = (i - 1);
HXDLIN(1529)												if (((i - bufferCount) > 0)) {
HXLINE(1529)													{
HXLINE(1529)														int endIndex = ((textIndex + i) - bufferCount);
HXDLIN(1529)														if ((textIndex >= endIndex)) {
HXLINE(1529)															positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1529)															widthValue = ( (Float)(0) );
            														}
            														else {
HXLINE(1529)															if ((endIndex <= formatRange->end)) {
HXLINE(1529)																::String text = _gthis->text;
HXDLIN(1529)																Float letterSpacing = ((Float)0.0);
HXDLIN(1529)																if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)																	letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																}
HXDLIN(1529)																if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)																	_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																}
HXDLIN(1529)																_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)																_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)																if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)																	_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																}
HXDLIN(1529)																_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)																bool positions1;
HXDLIN(1529)																if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)																	positions1 = (_gthis->sharpness < 400);
            																}
            																else {
HXLINE(1529)																	positions1 = true;
            																}
HXDLIN(1529)																_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1529)																 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)																_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1529)																if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)																	positions = _gthis->_hx___textLayout->get_positions();
            																}
            																else {
HXLINE(1529)																	positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																}
HXDLIN(1529)																Float width = ((Float)0.0);
HXDLIN(1529)																{
HXLINE(1529)																	int _g = 0;
HXDLIN(1529)																	while((_g < positions->length)){
HXLINE(1529)																		 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)																		_g = (_g + 1);
HXDLIN(1529)																		width = (width + position->advance->x);
            																	}
            																}
HXDLIN(1529)																widthValue = width;
            															}
            															else {
HXLINE(1529)																int tempIndex = textIndex;
HXDLIN(1529)																int tempRangeEnd = formatRange->end;
HXDLIN(1529)																int countRanges = 0;
HXDLIN(1529)																positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1529)																widthValue = ( (Float)(0) );
HXDLIN(1529)																while(true){
HXLINE(1529)																	if ((tempIndex != tempRangeEnd)) {
HXLINE(1529)																		::String text = _gthis->text;
HXDLIN(1529)																		Float letterSpacing = ((Float)0.0);
HXDLIN(1529)																		if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)																			letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																		}
HXDLIN(1529)																		if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)																			_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																		}
HXDLIN(1529)																		_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)																		_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)																		if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)																			_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																		}
HXDLIN(1529)																		_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)																		bool _hx_tmp;
HXDLIN(1529)																		if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)																			_hx_tmp = (_gthis->sharpness < 400);
            																		}
            																		else {
HXLINE(1529)																			_hx_tmp = true;
            																		}
HXDLIN(1529)																		_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1529)																		 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)																		_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1529)																		::Array< ::Dynamic> tempPositions;
HXDLIN(1529)																		if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)																			tempPositions = _gthis->_hx___textLayout->get_positions();
            																		}
            																		else {
HXLINE(1529)																			tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																		}
HXDLIN(1529)																		positions = positions->concat(tempPositions);
            																	}
HXDLIN(1529)																	if ((tempRangeEnd != endIndex)) {
HXLINE(1529)																		bool _hx_tmp;
HXDLIN(1529)																		if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)																			rangeIndex = (rangeIndex + 1);
HXDLIN(1529)																			formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)																			currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)																			font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1529)																			_hx_tmp = true;
            																		}
            																		else {
HXLINE(1529)																			_hx_tmp = false;
            																		}
HXDLIN(1529)																		if (!(_hx_tmp)) {
HXLINE(1529)																			::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1529)																			goto _hx_goto_55;
            																		}
HXDLIN(1529)																		tempIndex = tempRangeEnd;
HXDLIN(1529)																		if ((endIndex < formatRange->end)) {
HXLINE(1529)																			tempRangeEnd = endIndex;
            																		}
            																		else {
HXLINE(1529)																			tempRangeEnd = formatRange->end;
            																		}
HXDLIN(1529)																		countRanges = (countRanges + 1);
            																	}
            																	else {
HXLINE(1529)																		Float width = ((Float)0.0);
HXDLIN(1529)																		{
HXLINE(1529)																			int _g = 0;
HXDLIN(1529)																			while((_g < positions->length)){
HXLINE(1529)																				 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)																				_g = (_g + 1);
HXDLIN(1529)																				width = (width + position->advance->x);
            																			}
            																		}
HXDLIN(1529)																		widthValue = width;
HXDLIN(1529)																		goto _hx_goto_55;
            																	}
            																}
            																_hx_goto_55:;
HXDLIN(1529)																rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1529)																if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)																	rangeIndex = (rangeIndex + 1);
HXDLIN(1529)																	formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)																	currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)																	font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            																}
            															}
            														}
            													}
HXDLIN(1529)													positionWidth = widthValue;
            												}
            												else {
HXLINE(1529)													i = 1;
HXDLIN(1529)													bufferCount = 0;
HXDLIN(1529)													{
HXLINE(1529)														int endIndex = (textIndex + 1);
HXDLIN(1529)														if ((textIndex >= endIndex)) {
HXLINE(1529)															positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1529)															widthValue = ( (Float)(0) );
            														}
            														else {
HXLINE(1529)															if ((endIndex <= formatRange->end)) {
HXLINE(1529)																::String text = _gthis->text;
HXDLIN(1529)																Float letterSpacing = ((Float)0.0);
HXDLIN(1529)																if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)																	letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																}
HXDLIN(1529)																if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)																	_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																}
HXDLIN(1529)																_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)																_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)																if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)																	_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																}
HXDLIN(1529)																_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)																bool positions1;
HXDLIN(1529)																if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)																	positions1 = (_gthis->sharpness < 400);
            																}
            																else {
HXLINE(1529)																	positions1 = true;
            																}
HXDLIN(1529)																_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1529)																 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)																_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1529)																if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)																	positions = _gthis->_hx___textLayout->get_positions();
            																}
            																else {
HXLINE(1529)																	positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																}
HXDLIN(1529)																Float width = ((Float)0.0);
HXDLIN(1529)																{
HXLINE(1529)																	int _g = 0;
HXDLIN(1529)																	while((_g < positions->length)){
HXLINE(1529)																		 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)																		_g = (_g + 1);
HXDLIN(1529)																		width = (width + position->advance->x);
            																	}
            																}
HXDLIN(1529)																widthValue = width;
            															}
            															else {
HXLINE(1529)																int tempIndex = textIndex;
HXDLIN(1529)																int tempRangeEnd = formatRange->end;
HXDLIN(1529)																int countRanges = 0;
HXDLIN(1529)																positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1529)																widthValue = ( (Float)(0) );
HXDLIN(1529)																while(true){
HXLINE(1529)																	if ((tempIndex != tempRangeEnd)) {
HXLINE(1529)																		::String text = _gthis->text;
HXDLIN(1529)																		Float letterSpacing = ((Float)0.0);
HXDLIN(1529)																		if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)																			letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																		}
HXDLIN(1529)																		if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)																			_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																		}
HXDLIN(1529)																		_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)																		_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)																		if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)																			_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																		}
HXDLIN(1529)																		_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)																		bool _hx_tmp;
HXDLIN(1529)																		if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)																			_hx_tmp = (_gthis->sharpness < 400);
            																		}
            																		else {
HXLINE(1529)																			_hx_tmp = true;
            																		}
HXDLIN(1529)																		_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1529)																		 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)																		_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1529)																		::Array< ::Dynamic> tempPositions;
HXDLIN(1529)																		if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)																			tempPositions = _gthis->_hx___textLayout->get_positions();
            																		}
            																		else {
HXLINE(1529)																			tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																		}
HXDLIN(1529)																		positions = positions->concat(tempPositions);
            																	}
HXDLIN(1529)																	if ((tempRangeEnd != endIndex)) {
HXLINE(1529)																		bool _hx_tmp;
HXDLIN(1529)																		if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)																			rangeIndex = (rangeIndex + 1);
HXDLIN(1529)																			formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)																			currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)																			font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1529)																			_hx_tmp = true;
            																		}
            																		else {
HXLINE(1529)																			_hx_tmp = false;
            																		}
HXDLIN(1529)																		if (!(_hx_tmp)) {
HXLINE(1529)																			::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1529)																			goto _hx_goto_58;
            																		}
HXDLIN(1529)																		tempIndex = tempRangeEnd;
HXDLIN(1529)																		if ((endIndex < formatRange->end)) {
HXLINE(1529)																			tempRangeEnd = endIndex;
            																		}
            																		else {
HXLINE(1529)																			tempRangeEnd = formatRange->end;
            																		}
HXDLIN(1529)																		countRanges = (countRanges + 1);
            																	}
            																	else {
HXLINE(1529)																		Float width = ((Float)0.0);
HXDLIN(1529)																		{
HXLINE(1529)																			int _g = 0;
HXDLIN(1529)																			while((_g < positions->length)){
HXLINE(1529)																				 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)																				_g = (_g + 1);
HXDLIN(1529)																				width = (width + position->advance->x);
            																			}
            																		}
HXDLIN(1529)																		widthValue = width;
HXDLIN(1529)																		goto _hx_goto_58;
            																	}
            																}
            																_hx_goto_58:;
HXDLIN(1529)																rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1529)																if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)																	rangeIndex = (rangeIndex + 1);
HXDLIN(1529)																	formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)																	currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)																	font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            																}
            															}
            														}
            													}
HXDLIN(1529)													positionWidth = ( (Float)(0) );
            												}
            											}
            											_hx_goto_53:;
            										}
HXDLIN(1529)										placeIndex = ((textIndex + i) - bufferCount);
HXDLIN(1529)										{
HXLINE(1529)											if ((placeIndex <= formatRange->end)) {
HXLINE(1529)												::String text = _gthis->text;
HXDLIN(1529)												Float letterSpacing = ((Float)0.0);
HXDLIN(1529)												if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)													letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            												}
HXDLIN(1529)												if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)													_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)												_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)												if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)													_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)												bool positions1;
HXDLIN(1529)												if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)													positions1 = (_gthis->sharpness < 400);
            												}
            												else {
HXLINE(1529)													positions1 = true;
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1529)												 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)												_gthis1->set_text(text.substring(textIndex,placeIndex));
HXDLIN(1529)												if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)													positions = _gthis->_hx___textLayout->get_positions();
            												}
            												else {
HXLINE(1529)													positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            												}
HXDLIN(1529)												Float width = ((Float)0.0);
HXDLIN(1529)												{
HXLINE(1529)													int _g = 0;
HXDLIN(1529)													while((_g < positions->length)){
HXLINE(1529)														 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)														_g = (_g + 1);
HXDLIN(1529)														width = (width + position->advance->x);
            													}
            												}
HXDLIN(1529)												widthValue = width;
HXDLIN(1529)												bool _hx_tmp;
HXDLIN(1529)												if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1529)													_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            												}
            												else {
HXLINE(1529)													_hx_tmp = true;
            												}
HXDLIN(1529)												if (_hx_tmp) {
HXLINE(1529)													layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,placeIndex);
HXDLIN(1529)													_gthis->layoutGroups->push(layoutGroup);
            												}
            												else {
HXLINE(1529)													layoutGroup->format = formatRange->format;
HXDLIN(1529)													layoutGroup->startIndex = textIndex;
HXDLIN(1529)													layoutGroup->endIndex = placeIndex;
            												}
HXDLIN(1529)												layoutGroup->positions = positions;
HXDLIN(1529)												int _hx_tmp1;
HXDLIN(1529)												if (firstLineOfParagraph) {
HXLINE(1529)													_hx_tmp1 = indent;
            												}
            												else {
HXLINE(1529)													_hx_tmp1 = 0;
            												}
HXDLIN(1529)												layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1529)												layoutGroup->ascent = ascent;
HXDLIN(1529)												layoutGroup->descent = descent;
HXDLIN(1529)												layoutGroup->leading = leading;
HXDLIN(1529)												layoutGroup->lineIndex = lineIndex;
HXDLIN(1529)												layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1529)												layoutGroup->width = widthValue;
HXDLIN(1529)												layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1529)												offsetX = (offsetX + widthValue);
HXDLIN(1529)												if ((placeIndex == formatRange->end)) {
HXLINE(1529)													layoutGroup = null();
HXDLIN(1529)													if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)														rangeIndex = (rangeIndex + 1);
HXDLIN(1529)														formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)														currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)														font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            													}
HXDLIN(1529)													{
HXLINE(1529)														if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1529)															ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1529)															descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            														}
            														else {
HXLINE(1529)															bool _hx_tmp;
HXDLIN(1529)															if (::hx::IsNotNull( font )) {
HXLINE(1529)																_hx_tmp = (font->unitsPerEM != 0);
            															}
            															else {
HXLINE(1529)																_hx_tmp = false;
            															}
HXDLIN(1529)															if (_hx_tmp) {
HXLINE(1529)																ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1529)																descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            															}
            															else {
HXLINE(1529)																ascent = ( (Float)(currentFormat->size) );
HXDLIN(1529)																descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            															}
            														}
HXDLIN(1529)														leading = ( (int)(currentFormat->leading) );
HXDLIN(1529)														heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1529)														if ((heightValue > maxHeightValue)) {
HXLINE(1529)															maxHeightValue = heightValue;
            														}
HXDLIN(1529)														if ((ascent > maxAscent)) {
HXLINE(1529)															maxAscent = ascent;
            														}
            													}
            												}
            											}
            											else {
HXLINE(1529)												while(true){
HXLINE(1529)													int tempRangeEnd;
HXDLIN(1529)													if ((placeIndex < formatRange->end)) {
HXLINE(1529)														tempRangeEnd = placeIndex;
            													}
            													else {
HXLINE(1529)														tempRangeEnd = formatRange->end;
            													}
HXDLIN(1529)													if ((textIndex != tempRangeEnd)) {
HXLINE(1529)														::String text = _gthis->text;
HXDLIN(1529)														Float letterSpacing = ((Float)0.0);
HXDLIN(1529)														if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)															letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            														}
HXDLIN(1529)														if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)															_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            														}
HXDLIN(1529)														_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)														_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)														if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)															_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            														}
HXDLIN(1529)														_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)														bool positions1;
HXDLIN(1529)														if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)															positions1 = (_gthis->sharpness < 400);
            														}
            														else {
HXLINE(1529)															positions1 = true;
            														}
HXDLIN(1529)														_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1529)														 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)														_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1529)														if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)															positions = _gthis->_hx___textLayout->get_positions();
            														}
            														else {
HXLINE(1529)															positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            														}
HXDLIN(1529)														Float width = ((Float)0.0);
HXDLIN(1529)														{
HXLINE(1529)															int _g = 0;
HXDLIN(1529)															while((_g < positions->length)){
HXLINE(1529)																 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)																_g = (_g + 1);
HXDLIN(1529)																width = (width + position->advance->x);
            															}
            														}
HXDLIN(1529)														widthValue = width;
HXDLIN(1529)														bool _hx_tmp;
HXDLIN(1529)														if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1529)															_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            														}
            														else {
HXLINE(1529)															_hx_tmp = true;
            														}
HXDLIN(1529)														if (_hx_tmp) {
HXLINE(1529)															layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1529)															_gthis->layoutGroups->push(layoutGroup);
            														}
            														else {
HXLINE(1529)															layoutGroup->format = formatRange->format;
HXDLIN(1529)															layoutGroup->startIndex = textIndex;
HXDLIN(1529)															layoutGroup->endIndex = tempRangeEnd;
            														}
HXDLIN(1529)														layoutGroup->positions = positions;
HXDLIN(1529)														int _hx_tmp1;
HXDLIN(1529)														if (firstLineOfParagraph) {
HXLINE(1529)															_hx_tmp1 = indent;
            														}
            														else {
HXLINE(1529)															_hx_tmp1 = 0;
            														}
HXDLIN(1529)														layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1529)														layoutGroup->ascent = ascent;
HXDLIN(1529)														layoutGroup->descent = descent;
HXDLIN(1529)														layoutGroup->leading = leading;
HXDLIN(1529)														layoutGroup->lineIndex = lineIndex;
HXDLIN(1529)														layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1529)														layoutGroup->width = widthValue;
HXDLIN(1529)														layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1529)														offsetX = (offsetX + widthValue);
HXDLIN(1529)														textIndex = tempRangeEnd;
            													}
HXDLIN(1529)													if ((tempRangeEnd == formatRange->end)) {
HXLINE(1529)														layoutGroup = null();
            													}
HXDLIN(1529)													if ((tempRangeEnd == placeIndex)) {
HXLINE(1529)														goto _hx_goto_61;
            													}
HXDLIN(1529)													bool _hx_tmp;
HXDLIN(1529)													if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)														rangeIndex = (rangeIndex + 1);
HXDLIN(1529)														formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)														currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)														font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1529)														_hx_tmp = true;
            													}
            													else {
HXLINE(1529)														_hx_tmp = false;
            													}
HXDLIN(1529)													if (!(_hx_tmp)) {
HXLINE(1529)														::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1529)														goto _hx_goto_61;
            													}
HXDLIN(1529)													{
HXLINE(1529)														if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1529)															ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1529)															descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            														}
            														else {
HXLINE(1529)															bool _hx_tmp;
HXDLIN(1529)															if (::hx::IsNotNull( font )) {
HXLINE(1529)																_hx_tmp = (font->unitsPerEM != 0);
            															}
            															else {
HXLINE(1529)																_hx_tmp = false;
            															}
HXDLIN(1529)															if (_hx_tmp) {
HXLINE(1529)																ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1529)																descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            															}
            															else {
HXLINE(1529)																ascent = ( (Float)(currentFormat->size) );
HXDLIN(1529)																descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            															}
            														}
HXDLIN(1529)														leading = ( (int)(currentFormat->leading) );
HXDLIN(1529)														heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1529)														if ((heightValue > maxHeightValue)) {
HXLINE(1529)															maxHeightValue = heightValue;
            														}
HXDLIN(1529)														if ((ascent > maxAscent)) {
HXLINE(1529)															maxAscent = ascent;
            														}
            													}
            												}
            												_hx_goto_61:;
            											}
HXDLIN(1529)											textIndex = placeIndex;
            										}
HXDLIN(1529)										{
HXLINE(1529)											{
HXLINE(1529)												if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1529)													ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1529)													descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            												}
            												else {
HXLINE(1529)													bool _hx_tmp;
HXDLIN(1529)													if (::hx::IsNotNull( font )) {
HXLINE(1529)														_hx_tmp = (font->unitsPerEM != 0);
            													}
            													else {
HXLINE(1529)														_hx_tmp = false;
            													}
HXDLIN(1529)													if (_hx_tmp) {
HXLINE(1529)														ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1529)														descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            													}
            													else {
HXLINE(1529)														ascent = ( (Float)(currentFormat->size) );
HXDLIN(1529)														descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            													}
            												}
HXDLIN(1529)												leading = ( (int)(currentFormat->leading) );
HXDLIN(1529)												heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1529)												if ((heightValue > maxHeightValue)) {
HXLINE(1529)													maxHeightValue = heightValue;
            												}
HXDLIN(1529)												if ((ascent > maxAscent)) {
HXLINE(1529)													maxAscent = ascent;
            												}
            											}
HXDLIN(1529)											int i1 = _gthis->layoutGroups->get_length();
HXDLIN(1529)											while(true){
HXLINE(1529)												i1 = (i1 - 1);
HXDLIN(1529)												if (!((i1 > -1))) {
HXLINE(1529)													goto _hx_goto_63;
            												}
HXDLIN(1529)												 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i1).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1529)												if ((lg->lineIndex < lineIndex)) {
HXLINE(1529)													goto _hx_goto_63;
            												}
HXDLIN(1529)												if ((lg->lineIndex > lineIndex)) {
HXLINE(1529)													continue;
            												}
HXDLIN(1529)												lg->ascent = maxAscent;
HXDLIN(1529)												lg->height = ( (Float)(maxHeightValue) );
            											}
            											_hx_goto_63:;
HXDLIN(1529)											offsetY = (offsetY + maxHeightValue);
HXDLIN(1529)											maxAscent = ((Float)0.0);
HXDLIN(1529)											maxHeightValue = 0;
HXDLIN(1529)											lineIndex = (lineIndex + 1);
HXDLIN(1529)											offsetX = ( (Float)(0) );
HXDLIN(1529)											firstLineOfParagraph = false;
            										}
HXDLIN(1529)										if ((placeIndex >= endIndex)) {
HXLINE(1529)											positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1529)											widthValue = ( (Float)(0) );
            										}
            										else {
HXLINE(1529)											if ((endIndex <= formatRange->end)) {
HXLINE(1529)												::String text = _gthis->text;
HXDLIN(1529)												Float letterSpacing = ((Float)0.0);
HXDLIN(1529)												if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)													letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            												}
HXDLIN(1529)												if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)													_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)												_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)												if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)													_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)												bool positions1;
HXDLIN(1529)												if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)													positions1 = (_gthis->sharpness < 400);
            												}
            												else {
HXLINE(1529)													positions1 = true;
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1529)												 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)												_gthis1->set_text(text.substring(placeIndex,endIndex));
HXDLIN(1529)												if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)													positions = _gthis->_hx___textLayout->get_positions();
            												}
            												else {
HXLINE(1529)													positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            												}
HXDLIN(1529)												Float width = ((Float)0.0);
HXDLIN(1529)												{
HXLINE(1529)													int _g = 0;
HXDLIN(1529)													while((_g < positions->length)){
HXLINE(1529)														 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)														_g = (_g + 1);
HXDLIN(1529)														width = (width + position->advance->x);
            													}
            												}
HXDLIN(1529)												widthValue = width;
            											}
            											else {
HXLINE(1529)												int tempIndex = placeIndex;
HXDLIN(1529)												int tempRangeEnd = formatRange->end;
HXDLIN(1529)												int countRanges = 0;
HXDLIN(1529)												positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1529)												widthValue = ( (Float)(0) );
HXDLIN(1529)												while(true){
HXLINE(1529)													if ((tempIndex != tempRangeEnd)) {
HXLINE(1529)														::String text = _gthis->text;
HXDLIN(1529)														Float letterSpacing = ((Float)0.0);
HXDLIN(1529)														if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)															letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            														}
HXDLIN(1529)														if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)															_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            														}
HXDLIN(1529)														_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)														_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)														if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)															_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            														}
HXDLIN(1529)														_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)														bool _hx_tmp;
HXDLIN(1529)														if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)															_hx_tmp = (_gthis->sharpness < 400);
            														}
            														else {
HXLINE(1529)															_hx_tmp = true;
            														}
HXDLIN(1529)														_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1529)														 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)														_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1529)														::Array< ::Dynamic> tempPositions;
HXDLIN(1529)														if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)															tempPositions = _gthis->_hx___textLayout->get_positions();
            														}
            														else {
HXLINE(1529)															tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            														}
HXDLIN(1529)														positions = positions->concat(tempPositions);
            													}
HXDLIN(1529)													if ((tempRangeEnd != endIndex)) {
HXLINE(1529)														bool _hx_tmp;
HXDLIN(1529)														if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)															rangeIndex = (rangeIndex + 1);
HXDLIN(1529)															formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)															currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)															font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1529)															_hx_tmp = true;
            														}
            														else {
HXLINE(1529)															_hx_tmp = false;
            														}
HXDLIN(1529)														if (!(_hx_tmp)) {
HXLINE(1529)															::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1529)															goto _hx_goto_65;
            														}
HXDLIN(1529)														tempIndex = tempRangeEnd;
HXDLIN(1529)														if ((endIndex < formatRange->end)) {
HXLINE(1529)															tempRangeEnd = endIndex;
            														}
            														else {
HXLINE(1529)															tempRangeEnd = formatRange->end;
            														}
HXDLIN(1529)														countRanges = (countRanges + 1);
            													}
            													else {
HXLINE(1529)														Float width = ((Float)0.0);
HXDLIN(1529)														{
HXLINE(1529)															int _g = 0;
HXDLIN(1529)															while((_g < positions->length)){
HXLINE(1529)																 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)																_g = (_g + 1);
HXDLIN(1529)																width = (width + position->advance->x);
            															}
            														}
HXDLIN(1529)														widthValue = width;
HXDLIN(1529)														goto _hx_goto_65;
            													}
            												}
            												_hx_goto_65:;
HXDLIN(1529)												rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1529)												if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)													rangeIndex = (rangeIndex + 1);
HXDLIN(1529)													formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)													currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)													font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            												}
            											}
            										}
HXDLIN(1529)										remainingPositions = positions;
HXDLIN(1529)										tempWidth = widthValue;
            									}
            									_hx_goto_51:;
            								}
HXDLIN(1529)								{
HXLINE(1529)									if ((endIndex <= formatRange->end)) {
HXLINE(1529)										::String text = _gthis->text;
HXDLIN(1529)										Float letterSpacing = ((Float)0.0);
HXDLIN(1529)										if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)											letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            										}
HXDLIN(1529)										if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)											_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            										}
HXDLIN(1529)										_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)										_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)										if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)											_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            										}
HXDLIN(1529)										_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)										bool positions1;
HXDLIN(1529)										if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)											positions1 = (_gthis->sharpness < 400);
            										}
            										else {
HXLINE(1529)											positions1 = true;
            										}
HXDLIN(1529)										_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1529)										 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)										_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1529)										if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)											positions = _gthis->_hx___textLayout->get_positions();
            										}
            										else {
HXLINE(1529)											positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            										}
HXDLIN(1529)										Float width = ((Float)0.0);
HXDLIN(1529)										{
HXLINE(1529)											int _g = 0;
HXDLIN(1529)											while((_g < positions->length)){
HXLINE(1529)												 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)												_g = (_g + 1);
HXDLIN(1529)												width = (width + position->advance->x);
            											}
            										}
HXDLIN(1529)										widthValue = width;
HXDLIN(1529)										bool _hx_tmp;
HXDLIN(1529)										if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1529)											_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            										}
            										else {
HXLINE(1529)											_hx_tmp = true;
            										}
HXDLIN(1529)										if (_hx_tmp) {
HXLINE(1529)											layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,endIndex);
HXDLIN(1529)											_gthis->layoutGroups->push(layoutGroup);
            										}
            										else {
HXLINE(1529)											layoutGroup->format = formatRange->format;
HXDLIN(1529)											layoutGroup->startIndex = textIndex;
HXDLIN(1529)											layoutGroup->endIndex = endIndex;
            										}
HXDLIN(1529)										layoutGroup->positions = positions;
HXDLIN(1529)										int _hx_tmp1;
HXDLIN(1529)										if (firstLineOfParagraph) {
HXLINE(1529)											_hx_tmp1 = indent;
            										}
            										else {
HXLINE(1529)											_hx_tmp1 = 0;
            										}
HXDLIN(1529)										layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1529)										layoutGroup->ascent = ascent;
HXDLIN(1529)										layoutGroup->descent = descent;
HXDLIN(1529)										layoutGroup->leading = leading;
HXDLIN(1529)										layoutGroup->lineIndex = lineIndex;
HXDLIN(1529)										layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1529)										layoutGroup->width = widthValue;
HXDLIN(1529)										layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1529)										offsetX = (offsetX + widthValue);
HXDLIN(1529)										if ((endIndex == formatRange->end)) {
HXLINE(1529)											layoutGroup = null();
HXDLIN(1529)											if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)												rangeIndex = (rangeIndex + 1);
HXDLIN(1529)												formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)												currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)												font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            											}
HXDLIN(1529)											{
HXLINE(1529)												if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1529)													ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1529)													descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            												}
            												else {
HXLINE(1529)													bool _hx_tmp;
HXDLIN(1529)													if (::hx::IsNotNull( font )) {
HXLINE(1529)														_hx_tmp = (font->unitsPerEM != 0);
            													}
            													else {
HXLINE(1529)														_hx_tmp = false;
            													}
HXDLIN(1529)													if (_hx_tmp) {
HXLINE(1529)														ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1529)														descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            													}
            													else {
HXLINE(1529)														ascent = ( (Float)(currentFormat->size) );
HXDLIN(1529)														descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            													}
            												}
HXDLIN(1529)												leading = ( (int)(currentFormat->leading) );
HXDLIN(1529)												heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1529)												if ((heightValue > maxHeightValue)) {
HXLINE(1529)													maxHeightValue = heightValue;
            												}
HXDLIN(1529)												if ((ascent > maxAscent)) {
HXLINE(1529)													maxAscent = ascent;
            												}
            											}
            										}
            									}
            									else {
HXLINE(1529)										while(true){
HXLINE(1529)											int tempRangeEnd;
HXDLIN(1529)											if ((endIndex < formatRange->end)) {
HXLINE(1529)												tempRangeEnd = endIndex;
            											}
            											else {
HXLINE(1529)												tempRangeEnd = formatRange->end;
            											}
HXDLIN(1529)											if ((textIndex != tempRangeEnd)) {
HXLINE(1529)												::String text = _gthis->text;
HXDLIN(1529)												Float letterSpacing = ((Float)0.0);
HXDLIN(1529)												if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1529)													letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            												}
HXDLIN(1529)												if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1529)													_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->set_text(null());
HXDLIN(1529)												_gthis->_hx___textLayout->set_font(font);
HXDLIN(1529)												if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1529)													_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1529)												bool positions1;
HXDLIN(1529)												if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1529)													positions1 = (_gthis->sharpness < 400);
            												}
            												else {
HXLINE(1529)													positions1 = true;
            												}
HXDLIN(1529)												_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1529)												 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1529)												_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1529)												if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1529)													positions = _gthis->_hx___textLayout->get_positions();
            												}
            												else {
HXLINE(1529)													positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            												}
HXDLIN(1529)												Float width = ((Float)0.0);
HXDLIN(1529)												{
HXLINE(1529)													int _g = 0;
HXDLIN(1529)													while((_g < positions->length)){
HXLINE(1529)														 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1529)														_g = (_g + 1);
HXDLIN(1529)														width = (width + position->advance->x);
            													}
            												}
HXDLIN(1529)												widthValue = width;
HXDLIN(1529)												bool _hx_tmp;
HXDLIN(1529)												if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1529)													_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            												}
            												else {
HXLINE(1529)													_hx_tmp = true;
            												}
HXDLIN(1529)												if (_hx_tmp) {
HXLINE(1529)													layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1529)													_gthis->layoutGroups->push(layoutGroup);
            												}
            												else {
HXLINE(1529)													layoutGroup->format = formatRange->format;
HXDLIN(1529)													layoutGroup->startIndex = textIndex;
HXDLIN(1529)													layoutGroup->endIndex = tempRangeEnd;
            												}
HXDLIN(1529)												layoutGroup->positions = positions;
HXDLIN(1529)												int _hx_tmp1;
HXDLIN(1529)												if (firstLineOfParagraph) {
HXLINE(1529)													_hx_tmp1 = indent;
            												}
            												else {
HXLINE(1529)													_hx_tmp1 = 0;
            												}
HXDLIN(1529)												layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1529)												layoutGroup->ascent = ascent;
HXDLIN(1529)												layoutGroup->descent = descent;
HXDLIN(1529)												layoutGroup->leading = leading;
HXDLIN(1529)												layoutGroup->lineIndex = lineIndex;
HXDLIN(1529)												layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1529)												layoutGroup->width = widthValue;
HXDLIN(1529)												layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1529)												offsetX = (offsetX + widthValue);
HXDLIN(1529)												textIndex = tempRangeEnd;
            											}
HXDLIN(1529)											if ((tempRangeEnd == formatRange->end)) {
HXLINE(1529)												layoutGroup = null();
            											}
HXDLIN(1529)											if ((tempRangeEnd == endIndex)) {
HXLINE(1529)												goto _hx_goto_68;
            											}
HXDLIN(1529)											bool _hx_tmp;
HXDLIN(1529)											if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1529)												rangeIndex = (rangeIndex + 1);
HXDLIN(1529)												formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1529)												currentFormat->_hx___merge(formatRange->format);
HXDLIN(1529)												font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1529)												_hx_tmp = true;
            											}
            											else {
HXLINE(1529)												_hx_tmp = false;
            											}
HXDLIN(1529)											if (!(_hx_tmp)) {
HXLINE(1529)												::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1529)												goto _hx_goto_68;
            											}
HXDLIN(1529)											{
HXLINE(1529)												if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1529)													ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1529)													descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            												}
            												else {
HXLINE(1529)													bool _hx_tmp;
HXDLIN(1529)													if (::hx::IsNotNull( font )) {
HXLINE(1529)														_hx_tmp = (font->unitsPerEM != 0);
            													}
            													else {
HXLINE(1529)														_hx_tmp = false;
            													}
HXDLIN(1529)													if (_hx_tmp) {
HXLINE(1529)														ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1529)														descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            													}
            													else {
HXLINE(1529)														ascent = ( (Float)(currentFormat->size) );
HXDLIN(1529)														descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            													}
            												}
HXDLIN(1529)												leading = ( (int)(currentFormat->leading) );
HXDLIN(1529)												heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1529)												if ((heightValue > maxHeightValue)) {
HXLINE(1529)													maxHeightValue = heightValue;
            												}
HXDLIN(1529)												if ((ascent > maxAscent)) {
HXLINE(1529)													maxAscent = ascent;
            												}
            											}
            										}
            										_hx_goto_68:;
            									}
HXDLIN(1529)									textIndex = endIndex;
            								}
            							}
HXLINE(1531)							wrap = false;
            						}
            						else {
HXLINE(1535)							bool _hx_tmp;
HXDLIN(1535)							bool _hx_tmp1;
HXDLIN(1535)							if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1535)								_hx_tmp1 = (textIndex == spaceIndex);
            							}
            							else {
HXLINE(1535)								_hx_tmp1 = false;
            							}
HXDLIN(1535)							if (_hx_tmp1) {
HXLINE(1535)								_hx_tmp = (previousSpaceIndex != (spaceIndex - 1));
            							}
            							else {
HXLINE(1535)								_hx_tmp = false;
            							}
HXDLIN(1535)							if (_hx_tmp) {
HXLINE(1538)								if (::hx::IsNotEq( align,2 )) {
HXLINE(1540)									layoutGroup->endIndex = spaceIndex;
HXLINE(1541)									layoutGroup->positions = layoutGroup->positions->concat(positions);
HXLINE(1542)									 ::openfl::text::_internal::TextLayoutGroup layoutGroup1 = layoutGroup;
HXDLIN(1542)									layoutGroup1->width = (layoutGroup1->width + widthValue);
            								}
HXLINE(1544)								offsetX = (offsetX + widthValue);
HXLINE(1546)								textIndex = endIndex;
            							}
            							else {
HXLINE(1548)								bool _hx_tmp;
HXDLIN(1548)								if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1548)									_hx_tmp = ::hx::IsEq( align,2 );
            								}
            								else {
HXLINE(1548)									_hx_tmp = true;
            								}
HXDLIN(1548)								if (_hx_tmp) {
HXLINE(1550)									{
HXLINE(1550)										bool _hx_tmp;
HXDLIN(1550)										if ((_gthis->width >= 4)) {
HXLINE(1550)											_hx_tmp = _gthis->wordWrap;
            										}
            										else {
HXLINE(1550)											_hx_tmp = false;
            										}
HXDLIN(1550)										if (_hx_tmp) {
HXLINE(1550)											::Array< ::Dynamic> remainingPositions = positions;
HXDLIN(1550)											int bufferCount;
HXDLIN(1550)											int placeIndex;
HXDLIN(1550)											Float positionWidth;
HXDLIN(1550)											 ::openfl::text::_internal::GlyphPosition currentPosition;
HXDLIN(1550)											Float width = ((Float)0.0);
HXDLIN(1550)											{
HXLINE(1550)												int _g = 0;
HXDLIN(1550)												while((_g < remainingPositions->length)){
HXLINE(1550)													 ::openfl::text::_internal::GlyphPosition position = remainingPositions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)													_g = (_g + 1);
HXDLIN(1550)													width = (width + position->advance->x);
            												}
            											}
HXDLIN(1550)											Float tempWidth = width;
HXDLIN(1550)											int i = (remainingPositions->length - 1);
HXDLIN(1550)											while((i >= 0)){
HXLINE(1550)												 ::Dynamic currentCharCode = _gthis->text.charCodeAt((textIndex + i));
HXDLIN(1550)												bool _hx_tmp;
HXDLIN(1550)												if (::hx::IsNotEq( currentCharCode,32 )) {
HXLINE(1550)													_hx_tmp = ::hx::IsNotEq( currentCharCode,9 );
            												}
            												else {
HXLINE(1550)													_hx_tmp = false;
            												}
HXDLIN(1550)												if (_hx_tmp) {
HXLINE(1550)													goto _hx_goto_71;
            												}
HXDLIN(1550)												 ::openfl::text::_internal::GlyphPosition position = remainingPositions->__get(i).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)												tempWidth = (tempWidth - position->advance->x);
HXDLIN(1550)												i = (i - 1);
            											}
            											_hx_goto_71:;
HXDLIN(1550)											while(true){
HXLINE(1550)												bool _hx_tmp;
HXDLIN(1550)												if ((remainingPositions->length > 0)) {
HXLINE(1550)													int _hx_tmp1;
HXDLIN(1550)													if (firstLineOfParagraph) {
HXLINE(1550)														_hx_tmp1 = indent;
            													}
            													else {
HXLINE(1550)														_hx_tmp1 = 0;
            													}
HXDLIN(1550)													_hx_tmp = ((offsetX + tempWidth) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) )));
            												}
            												else {
HXLINE(1550)													_hx_tmp = false;
            												}
HXDLIN(1550)												if (!(_hx_tmp)) {
HXLINE(1550)													goto _hx_goto_72;
            												}
HXDLIN(1550)												bufferCount = 0;
HXDLIN(1550)												i = bufferCount;
HXDLIN(1550)												positionWidth = ((Float)0.0);
HXDLIN(1550)												while(true){
HXLINE(1550)													int _hx_tmp;
HXDLIN(1550)													if (firstLineOfParagraph) {
HXLINE(1550)														_hx_tmp = indent;
            													}
            													else {
HXLINE(1550)														_hx_tmp = 0;
            													}
HXDLIN(1550)													if (!(((offsetX + positionWidth) < (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp)) ))))) {
HXLINE(1550)														goto _hx_goto_73;
            													}
HXDLIN(1550)													currentPosition = remainingPositions->__get(i).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)													if ((currentPosition->advance->x == ((Float)0.0))) {
HXLINE(1550)														i = (i + 1);
HXDLIN(1550)														bufferCount = (bufferCount + 1);
            													}
            													else {
HXLINE(1550)														positionWidth = (positionWidth + currentPosition->advance->x);
HXDLIN(1550)														i = (i + 1);
            													}
            												}
            												_hx_goto_73:;
HXDLIN(1550)												if ((i == bufferCount)) {
HXLINE(1550)													i = (bufferCount + 1);
            												}
            												else {
HXLINE(1550)													while(true){
HXLINE(1550)														bool _hx_tmp;
HXDLIN(1550)														if ((i > 1)) {
HXLINE(1550)															int _hx_tmp1;
HXDLIN(1550)															if (firstLineOfParagraph) {
HXLINE(1550)																_hx_tmp1 = indent;
            															}
            															else {
HXLINE(1550)																_hx_tmp1 = 0;
            															}
HXDLIN(1550)															_hx_tmp = ((offsetX + positionWidth) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) )));
            														}
            														else {
HXLINE(1550)															_hx_tmp = false;
            														}
HXDLIN(1550)														if (!(_hx_tmp)) {
HXLINE(1550)															goto _hx_goto_74;
            														}
HXDLIN(1550)														i = (i - 1);
HXDLIN(1550)														if (((i - bufferCount) > 0)) {
HXLINE(1550)															{
HXLINE(1550)																int endIndex = ((textIndex + i) - bufferCount);
HXDLIN(1550)																if ((textIndex >= endIndex)) {
HXLINE(1550)																	positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1550)																	widthValue = ( (Float)(0) );
            																}
            																else {
HXLINE(1550)																	if ((endIndex <= formatRange->end)) {
HXLINE(1550)																		::String text = _gthis->text;
HXDLIN(1550)																		Float letterSpacing = ((Float)0.0);
HXDLIN(1550)																		if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)																			letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																		}
HXDLIN(1550)																		if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)																			_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																		}
HXDLIN(1550)																		_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)																		_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)																		if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)																			_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																		}
HXDLIN(1550)																		_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)																		bool positions1;
HXDLIN(1550)																		if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)																			positions1 = (_gthis->sharpness < 400);
            																		}
            																		else {
HXLINE(1550)																			positions1 = true;
            																		}
HXDLIN(1550)																		_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1550)																		 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)																		_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1550)																		if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)																			positions = _gthis->_hx___textLayout->get_positions();
            																		}
            																		else {
HXLINE(1550)																			positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																		}
HXDLIN(1550)																		Float width = ((Float)0.0);
HXDLIN(1550)																		{
HXLINE(1550)																			int _g = 0;
HXDLIN(1550)																			while((_g < positions->length)){
HXLINE(1550)																				 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																				_g = (_g + 1);
HXDLIN(1550)																				width = (width + position->advance->x);
            																			}
            																		}
HXDLIN(1550)																		widthValue = width;
            																	}
            																	else {
HXLINE(1550)																		int tempIndex = textIndex;
HXDLIN(1550)																		int tempRangeEnd = formatRange->end;
HXDLIN(1550)																		int countRanges = 0;
HXDLIN(1550)																		positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1550)																		widthValue = ( (Float)(0) );
HXDLIN(1550)																		while(true){
HXLINE(1550)																			if ((tempIndex != tempRangeEnd)) {
HXLINE(1550)																				::String text = _gthis->text;
HXDLIN(1550)																				Float letterSpacing = ((Float)0.0);
HXDLIN(1550)																				if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)																					letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																				}
HXDLIN(1550)																				if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)																					_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																				}
HXDLIN(1550)																				_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)																				_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)																				if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)																					_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																				}
HXDLIN(1550)																				_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)																				bool _hx_tmp;
HXDLIN(1550)																				if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)																					_hx_tmp = (_gthis->sharpness < 400);
            																				}
            																				else {
HXLINE(1550)																					_hx_tmp = true;
            																				}
HXDLIN(1550)																				_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1550)																				 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)																				_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1550)																				::Array< ::Dynamic> tempPositions;
HXDLIN(1550)																				if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)																					tempPositions = _gthis->_hx___textLayout->get_positions();
            																				}
            																				else {
HXLINE(1550)																					tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																				}
HXDLIN(1550)																				positions = positions->concat(tempPositions);
            																			}
HXDLIN(1550)																			if ((tempRangeEnd != endIndex)) {
HXLINE(1550)																				bool _hx_tmp;
HXDLIN(1550)																				if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)																					rangeIndex = (rangeIndex + 1);
HXDLIN(1550)																					formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)																					currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)																					font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1550)																					_hx_tmp = true;
            																				}
            																				else {
HXLINE(1550)																					_hx_tmp = false;
            																				}
HXDLIN(1550)																				if (!(_hx_tmp)) {
HXLINE(1550)																					::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1550)																					goto _hx_goto_76;
            																				}
HXDLIN(1550)																				tempIndex = tempRangeEnd;
HXDLIN(1550)																				if ((endIndex < formatRange->end)) {
HXLINE(1550)																					tempRangeEnd = endIndex;
            																				}
            																				else {
HXLINE(1550)																					tempRangeEnd = formatRange->end;
            																				}
HXDLIN(1550)																				countRanges = (countRanges + 1);
            																			}
            																			else {
HXLINE(1550)																				Float width = ((Float)0.0);
HXDLIN(1550)																				{
HXLINE(1550)																					int _g = 0;
HXDLIN(1550)																					while((_g < positions->length)){
HXLINE(1550)																						 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																						_g = (_g + 1);
HXDLIN(1550)																						width = (width + position->advance->x);
            																					}
            																				}
HXDLIN(1550)																				widthValue = width;
HXDLIN(1550)																				goto _hx_goto_76;
            																			}
            																		}
            																		_hx_goto_76:;
HXDLIN(1550)																		rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1550)																		if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)																			rangeIndex = (rangeIndex + 1);
HXDLIN(1550)																			formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)																			currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)																			font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            																		}
            																	}
            																}
            															}
HXDLIN(1550)															positionWidth = widthValue;
            														}
            														else {
HXLINE(1550)															i = 1;
HXDLIN(1550)															bufferCount = 0;
HXDLIN(1550)															{
HXLINE(1550)																int endIndex = (textIndex + 1);
HXDLIN(1550)																if ((textIndex >= endIndex)) {
HXLINE(1550)																	positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1550)																	widthValue = ( (Float)(0) );
            																}
            																else {
HXLINE(1550)																	if ((endIndex <= formatRange->end)) {
HXLINE(1550)																		::String text = _gthis->text;
HXDLIN(1550)																		Float letterSpacing = ((Float)0.0);
HXDLIN(1550)																		if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)																			letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																		}
HXDLIN(1550)																		if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)																			_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																		}
HXDLIN(1550)																		_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)																		_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)																		if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)																			_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																		}
HXDLIN(1550)																		_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)																		bool positions1;
HXDLIN(1550)																		if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)																			positions1 = (_gthis->sharpness < 400);
            																		}
            																		else {
HXLINE(1550)																			positions1 = true;
            																		}
HXDLIN(1550)																		_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1550)																		 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)																		_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1550)																		if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)																			positions = _gthis->_hx___textLayout->get_positions();
            																		}
            																		else {
HXLINE(1550)																			positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																		}
HXDLIN(1550)																		Float width = ((Float)0.0);
HXDLIN(1550)																		{
HXLINE(1550)																			int _g = 0;
HXDLIN(1550)																			while((_g < positions->length)){
HXLINE(1550)																				 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																				_g = (_g + 1);
HXDLIN(1550)																				width = (width + position->advance->x);
            																			}
            																		}
HXDLIN(1550)																		widthValue = width;
            																	}
            																	else {
HXLINE(1550)																		int tempIndex = textIndex;
HXDLIN(1550)																		int tempRangeEnd = formatRange->end;
HXDLIN(1550)																		int countRanges = 0;
HXDLIN(1550)																		positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1550)																		widthValue = ( (Float)(0) );
HXDLIN(1550)																		while(true){
HXLINE(1550)																			if ((tempIndex != tempRangeEnd)) {
HXLINE(1550)																				::String text = _gthis->text;
HXDLIN(1550)																				Float letterSpacing = ((Float)0.0);
HXDLIN(1550)																				if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)																					letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																				}
HXDLIN(1550)																				if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)																					_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																				}
HXDLIN(1550)																				_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)																				_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)																				if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)																					_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																				}
HXDLIN(1550)																				_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)																				bool _hx_tmp;
HXDLIN(1550)																				if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)																					_hx_tmp = (_gthis->sharpness < 400);
            																				}
            																				else {
HXLINE(1550)																					_hx_tmp = true;
            																				}
HXDLIN(1550)																				_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1550)																				 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)																				_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1550)																				::Array< ::Dynamic> tempPositions;
HXDLIN(1550)																				if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)																					tempPositions = _gthis->_hx___textLayout->get_positions();
            																				}
            																				else {
HXLINE(1550)																					tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																				}
HXDLIN(1550)																				positions = positions->concat(tempPositions);
            																			}
HXDLIN(1550)																			if ((tempRangeEnd != endIndex)) {
HXLINE(1550)																				bool _hx_tmp;
HXDLIN(1550)																				if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)																					rangeIndex = (rangeIndex + 1);
HXDLIN(1550)																					formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)																					currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)																					font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1550)																					_hx_tmp = true;
            																				}
            																				else {
HXLINE(1550)																					_hx_tmp = false;
            																				}
HXDLIN(1550)																				if (!(_hx_tmp)) {
HXLINE(1550)																					::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1550)																					goto _hx_goto_79;
            																				}
HXDLIN(1550)																				tempIndex = tempRangeEnd;
HXDLIN(1550)																				if ((endIndex < formatRange->end)) {
HXLINE(1550)																					tempRangeEnd = endIndex;
            																				}
            																				else {
HXLINE(1550)																					tempRangeEnd = formatRange->end;
            																				}
HXDLIN(1550)																				countRanges = (countRanges + 1);
            																			}
            																			else {
HXLINE(1550)																				Float width = ((Float)0.0);
HXDLIN(1550)																				{
HXLINE(1550)																					int _g = 0;
HXDLIN(1550)																					while((_g < positions->length)){
HXLINE(1550)																						 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																						_g = (_g + 1);
HXDLIN(1550)																						width = (width + position->advance->x);
            																					}
            																				}
HXDLIN(1550)																				widthValue = width;
HXDLIN(1550)																				goto _hx_goto_79;
            																			}
            																		}
            																		_hx_goto_79:;
HXDLIN(1550)																		rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1550)																		if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)																			rangeIndex = (rangeIndex + 1);
HXDLIN(1550)																			formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)																			currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)																			font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            																		}
            																	}
            																}
            															}
HXDLIN(1550)															positionWidth = ( (Float)(0) );
            														}
            													}
            													_hx_goto_74:;
            												}
HXDLIN(1550)												placeIndex = ((textIndex + i) - bufferCount);
HXDLIN(1550)												{
HXLINE(1550)													if ((placeIndex <= formatRange->end)) {
HXLINE(1550)														::String text = _gthis->text;
HXDLIN(1550)														Float letterSpacing = ((Float)0.0);
HXDLIN(1550)														if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)															letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            														}
HXDLIN(1550)														if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)															_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)														_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)														if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)															_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)														bool positions1;
HXDLIN(1550)														if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)															positions1 = (_gthis->sharpness < 400);
            														}
            														else {
HXLINE(1550)															positions1 = true;
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1550)														 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)														_gthis1->set_text(text.substring(textIndex,placeIndex));
HXDLIN(1550)														if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)															positions = _gthis->_hx___textLayout->get_positions();
            														}
            														else {
HXLINE(1550)															positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            														}
HXDLIN(1550)														Float width = ((Float)0.0);
HXDLIN(1550)														{
HXLINE(1550)															int _g = 0;
HXDLIN(1550)															while((_g < positions->length)){
HXLINE(1550)																 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																_g = (_g + 1);
HXDLIN(1550)																width = (width + position->advance->x);
            															}
            														}
HXDLIN(1550)														widthValue = width;
HXDLIN(1550)														bool _hx_tmp;
HXDLIN(1550)														if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1550)															_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            														}
            														else {
HXLINE(1550)															_hx_tmp = true;
            														}
HXDLIN(1550)														if (_hx_tmp) {
HXLINE(1550)															layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,placeIndex);
HXDLIN(1550)															_gthis->layoutGroups->push(layoutGroup);
            														}
            														else {
HXLINE(1550)															layoutGroup->format = formatRange->format;
HXDLIN(1550)															layoutGroup->startIndex = textIndex;
HXDLIN(1550)															layoutGroup->endIndex = placeIndex;
            														}
HXDLIN(1550)														layoutGroup->positions = positions;
HXDLIN(1550)														int _hx_tmp1;
HXDLIN(1550)														if (firstLineOfParagraph) {
HXLINE(1550)															_hx_tmp1 = indent;
            														}
            														else {
HXLINE(1550)															_hx_tmp1 = 0;
            														}
HXDLIN(1550)														layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1550)														layoutGroup->ascent = ascent;
HXDLIN(1550)														layoutGroup->descent = descent;
HXDLIN(1550)														layoutGroup->leading = leading;
HXDLIN(1550)														layoutGroup->lineIndex = lineIndex;
HXDLIN(1550)														layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1550)														layoutGroup->width = widthValue;
HXDLIN(1550)														layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1550)														offsetX = (offsetX + widthValue);
HXDLIN(1550)														if ((placeIndex == formatRange->end)) {
HXLINE(1550)															layoutGroup = null();
HXDLIN(1550)															if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)																rangeIndex = (rangeIndex + 1);
HXDLIN(1550)																formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)																currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)																font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            															}
HXDLIN(1550)															{
HXLINE(1550)																if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1550)																	ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1550)																	descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            																}
            																else {
HXLINE(1550)																	bool _hx_tmp;
HXDLIN(1550)																	if (::hx::IsNotNull( font )) {
HXLINE(1550)																		_hx_tmp = (font->unitsPerEM != 0);
            																	}
            																	else {
HXLINE(1550)																		_hx_tmp = false;
            																	}
HXDLIN(1550)																	if (_hx_tmp) {
HXLINE(1550)																		ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1550)																		descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            																	}
            																	else {
HXLINE(1550)																		ascent = ( (Float)(currentFormat->size) );
HXDLIN(1550)																		descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            																	}
            																}
HXDLIN(1550)																leading = ( (int)(currentFormat->leading) );
HXDLIN(1550)																heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1550)																if ((heightValue > maxHeightValue)) {
HXLINE(1550)																	maxHeightValue = heightValue;
            																}
HXDLIN(1550)																if ((ascent > maxAscent)) {
HXLINE(1550)																	maxAscent = ascent;
            																}
            															}
            														}
            													}
            													else {
HXLINE(1550)														while(true){
HXLINE(1550)															int tempRangeEnd;
HXDLIN(1550)															if ((placeIndex < formatRange->end)) {
HXLINE(1550)																tempRangeEnd = placeIndex;
            															}
            															else {
HXLINE(1550)																tempRangeEnd = formatRange->end;
            															}
HXDLIN(1550)															if ((textIndex != tempRangeEnd)) {
HXLINE(1550)																::String text = _gthis->text;
HXDLIN(1550)																Float letterSpacing = ((Float)0.0);
HXDLIN(1550)																if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)																	letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																}
HXDLIN(1550)																if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)																	_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																}
HXDLIN(1550)																_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)																_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)																if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)																	_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																}
HXDLIN(1550)																_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)																bool positions1;
HXDLIN(1550)																if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)																	positions1 = (_gthis->sharpness < 400);
            																}
            																else {
HXLINE(1550)																	positions1 = true;
            																}
HXDLIN(1550)																_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1550)																 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)																_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1550)																if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)																	positions = _gthis->_hx___textLayout->get_positions();
            																}
            																else {
HXLINE(1550)																	positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																}
HXDLIN(1550)																Float width = ((Float)0.0);
HXDLIN(1550)																{
HXLINE(1550)																	int _g = 0;
HXDLIN(1550)																	while((_g < positions->length)){
HXLINE(1550)																		 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																		_g = (_g + 1);
HXDLIN(1550)																		width = (width + position->advance->x);
            																	}
            																}
HXDLIN(1550)																widthValue = width;
HXDLIN(1550)																bool _hx_tmp;
HXDLIN(1550)																if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1550)																	_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            																}
            																else {
HXLINE(1550)																	_hx_tmp = true;
            																}
HXDLIN(1550)																if (_hx_tmp) {
HXLINE(1550)																	layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1550)																	_gthis->layoutGroups->push(layoutGroup);
            																}
            																else {
HXLINE(1550)																	layoutGroup->format = formatRange->format;
HXDLIN(1550)																	layoutGroup->startIndex = textIndex;
HXDLIN(1550)																	layoutGroup->endIndex = tempRangeEnd;
            																}
HXDLIN(1550)																layoutGroup->positions = positions;
HXDLIN(1550)																int _hx_tmp1;
HXDLIN(1550)																if (firstLineOfParagraph) {
HXLINE(1550)																	_hx_tmp1 = indent;
            																}
            																else {
HXLINE(1550)																	_hx_tmp1 = 0;
            																}
HXDLIN(1550)																layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1550)																layoutGroup->ascent = ascent;
HXDLIN(1550)																layoutGroup->descent = descent;
HXDLIN(1550)																layoutGroup->leading = leading;
HXDLIN(1550)																layoutGroup->lineIndex = lineIndex;
HXDLIN(1550)																layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1550)																layoutGroup->width = widthValue;
HXDLIN(1550)																layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1550)																offsetX = (offsetX + widthValue);
HXDLIN(1550)																textIndex = tempRangeEnd;
            															}
HXDLIN(1550)															if ((tempRangeEnd == formatRange->end)) {
HXLINE(1550)																layoutGroup = null();
            															}
HXDLIN(1550)															if ((tempRangeEnd == placeIndex)) {
HXLINE(1550)																goto _hx_goto_82;
            															}
HXDLIN(1550)															bool _hx_tmp;
HXDLIN(1550)															if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)																rangeIndex = (rangeIndex + 1);
HXDLIN(1550)																formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)																currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)																font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1550)																_hx_tmp = true;
            															}
            															else {
HXLINE(1550)																_hx_tmp = false;
            															}
HXDLIN(1550)															if (!(_hx_tmp)) {
HXLINE(1550)																::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1550)																goto _hx_goto_82;
            															}
HXDLIN(1550)															{
HXLINE(1550)																if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1550)																	ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1550)																	descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            																}
            																else {
HXLINE(1550)																	bool _hx_tmp;
HXDLIN(1550)																	if (::hx::IsNotNull( font )) {
HXLINE(1550)																		_hx_tmp = (font->unitsPerEM != 0);
            																	}
            																	else {
HXLINE(1550)																		_hx_tmp = false;
            																	}
HXDLIN(1550)																	if (_hx_tmp) {
HXLINE(1550)																		ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1550)																		descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            																	}
            																	else {
HXLINE(1550)																		ascent = ( (Float)(currentFormat->size) );
HXDLIN(1550)																		descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            																	}
            																}
HXDLIN(1550)																leading = ( (int)(currentFormat->leading) );
HXDLIN(1550)																heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1550)																if ((heightValue > maxHeightValue)) {
HXLINE(1550)																	maxHeightValue = heightValue;
            																}
HXDLIN(1550)																if ((ascent > maxAscent)) {
HXLINE(1550)																	maxAscent = ascent;
            																}
            															}
            														}
            														_hx_goto_82:;
            													}
HXDLIN(1550)													textIndex = placeIndex;
            												}
HXDLIN(1550)												{
HXLINE(1550)													{
HXLINE(1550)														if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1550)															ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1550)															descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            														}
            														else {
HXLINE(1550)															bool _hx_tmp;
HXDLIN(1550)															if (::hx::IsNotNull( font )) {
HXLINE(1550)																_hx_tmp = (font->unitsPerEM != 0);
            															}
            															else {
HXLINE(1550)																_hx_tmp = false;
            															}
HXDLIN(1550)															if (_hx_tmp) {
HXLINE(1550)																ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1550)																descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            															}
            															else {
HXLINE(1550)																ascent = ( (Float)(currentFormat->size) );
HXDLIN(1550)																descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            															}
            														}
HXDLIN(1550)														leading = ( (int)(currentFormat->leading) );
HXDLIN(1550)														heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1550)														if ((heightValue > maxHeightValue)) {
HXLINE(1550)															maxHeightValue = heightValue;
            														}
HXDLIN(1550)														if ((ascent > maxAscent)) {
HXLINE(1550)															maxAscent = ascent;
            														}
            													}
HXDLIN(1550)													int i1 = _gthis->layoutGroups->get_length();
HXDLIN(1550)													while(true){
HXLINE(1550)														i1 = (i1 - 1);
HXDLIN(1550)														if (!((i1 > -1))) {
HXLINE(1550)															goto _hx_goto_84;
            														}
HXDLIN(1550)														 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i1).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1550)														if ((lg->lineIndex < lineIndex)) {
HXLINE(1550)															goto _hx_goto_84;
            														}
HXDLIN(1550)														if ((lg->lineIndex > lineIndex)) {
HXLINE(1550)															continue;
            														}
HXDLIN(1550)														lg->ascent = maxAscent;
HXDLIN(1550)														lg->height = ( (Float)(maxHeightValue) );
            													}
            													_hx_goto_84:;
HXDLIN(1550)													offsetY = (offsetY + maxHeightValue);
HXDLIN(1550)													maxAscent = ((Float)0.0);
HXDLIN(1550)													maxHeightValue = 0;
HXDLIN(1550)													lineIndex = (lineIndex + 1);
HXDLIN(1550)													offsetX = ( (Float)(0) );
HXDLIN(1550)													firstLineOfParagraph = false;
            												}
HXDLIN(1550)												if ((placeIndex >= endIndex)) {
HXLINE(1550)													positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1550)													widthValue = ( (Float)(0) );
            												}
            												else {
HXLINE(1550)													if ((endIndex <= formatRange->end)) {
HXLINE(1550)														::String text = _gthis->text;
HXDLIN(1550)														Float letterSpacing = ((Float)0.0);
HXDLIN(1550)														if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)															letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            														}
HXDLIN(1550)														if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)															_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)														_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)														if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)															_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)														bool positions1;
HXDLIN(1550)														if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)															positions1 = (_gthis->sharpness < 400);
            														}
            														else {
HXLINE(1550)															positions1 = true;
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1550)														 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)														_gthis1->set_text(text.substring(placeIndex,endIndex));
HXDLIN(1550)														if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)															positions = _gthis->_hx___textLayout->get_positions();
            														}
            														else {
HXLINE(1550)															positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            														}
HXDLIN(1550)														Float width = ((Float)0.0);
HXDLIN(1550)														{
HXLINE(1550)															int _g = 0;
HXDLIN(1550)															while((_g < positions->length)){
HXLINE(1550)																 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																_g = (_g + 1);
HXDLIN(1550)																width = (width + position->advance->x);
            															}
            														}
HXDLIN(1550)														widthValue = width;
            													}
            													else {
HXLINE(1550)														int tempIndex = placeIndex;
HXDLIN(1550)														int tempRangeEnd = formatRange->end;
HXDLIN(1550)														int countRanges = 0;
HXDLIN(1550)														positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1550)														widthValue = ( (Float)(0) );
HXDLIN(1550)														while(true){
HXLINE(1550)															if ((tempIndex != tempRangeEnd)) {
HXLINE(1550)																::String text = _gthis->text;
HXDLIN(1550)																Float letterSpacing = ((Float)0.0);
HXDLIN(1550)																if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)																	letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																}
HXDLIN(1550)																if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)																	_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																}
HXDLIN(1550)																_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)																_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)																if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)																	_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																}
HXDLIN(1550)																_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)																bool _hx_tmp;
HXDLIN(1550)																if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)																	_hx_tmp = (_gthis->sharpness < 400);
            																}
            																else {
HXLINE(1550)																	_hx_tmp = true;
            																}
HXDLIN(1550)																_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1550)																 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)																_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1550)																::Array< ::Dynamic> tempPositions;
HXDLIN(1550)																if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)																	tempPositions = _gthis->_hx___textLayout->get_positions();
            																}
            																else {
HXLINE(1550)																	tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																}
HXDLIN(1550)																positions = positions->concat(tempPositions);
            															}
HXDLIN(1550)															if ((tempRangeEnd != endIndex)) {
HXLINE(1550)																bool _hx_tmp;
HXDLIN(1550)																if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)																	rangeIndex = (rangeIndex + 1);
HXDLIN(1550)																	formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)																	currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)																	font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1550)																	_hx_tmp = true;
            																}
            																else {
HXLINE(1550)																	_hx_tmp = false;
            																}
HXDLIN(1550)																if (!(_hx_tmp)) {
HXLINE(1550)																	::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1550)																	goto _hx_goto_86;
            																}
HXDLIN(1550)																tempIndex = tempRangeEnd;
HXDLIN(1550)																if ((endIndex < formatRange->end)) {
HXLINE(1550)																	tempRangeEnd = endIndex;
            																}
            																else {
HXLINE(1550)																	tempRangeEnd = formatRange->end;
            																}
HXDLIN(1550)																countRanges = (countRanges + 1);
            															}
            															else {
HXLINE(1550)																Float width = ((Float)0.0);
HXDLIN(1550)																{
HXLINE(1550)																	int _g = 0;
HXDLIN(1550)																	while((_g < positions->length)){
HXLINE(1550)																		 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																		_g = (_g + 1);
HXDLIN(1550)																		width = (width + position->advance->x);
            																	}
            																}
HXDLIN(1550)																widthValue = width;
HXDLIN(1550)																goto _hx_goto_86;
            															}
            														}
            														_hx_goto_86:;
HXDLIN(1550)														rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1550)														if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)															rangeIndex = (rangeIndex + 1);
HXDLIN(1550)															formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)															currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)															font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            														}
            													}
            												}
HXDLIN(1550)												remainingPositions = positions;
HXDLIN(1550)												tempWidth = widthValue;
            											}
            											_hx_goto_72:;
            										}
HXDLIN(1550)										{
HXLINE(1550)											if ((endIndex <= formatRange->end)) {
HXLINE(1550)												::String text = _gthis->text;
HXDLIN(1550)												Float letterSpacing = ((Float)0.0);
HXDLIN(1550)												if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)													letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            												}
HXDLIN(1550)												if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)													_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            												}
HXDLIN(1550)												_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)												_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)												if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)													_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            												}
HXDLIN(1550)												_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)												bool positions1;
HXDLIN(1550)												if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)													positions1 = (_gthis->sharpness < 400);
            												}
            												else {
HXLINE(1550)													positions1 = true;
            												}
HXDLIN(1550)												_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1550)												 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)												_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1550)												if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)													positions = _gthis->_hx___textLayout->get_positions();
            												}
            												else {
HXLINE(1550)													positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            												}
HXDLIN(1550)												Float width = ((Float)0.0);
HXDLIN(1550)												{
HXLINE(1550)													int _g = 0;
HXDLIN(1550)													while((_g < positions->length)){
HXLINE(1550)														 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)														_g = (_g + 1);
HXDLIN(1550)														width = (width + position->advance->x);
            													}
            												}
HXDLIN(1550)												widthValue = width;
HXDLIN(1550)												bool _hx_tmp;
HXDLIN(1550)												if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1550)													_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            												}
            												else {
HXLINE(1550)													_hx_tmp = true;
            												}
HXDLIN(1550)												if (_hx_tmp) {
HXLINE(1550)													layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,endIndex);
HXDLIN(1550)													_gthis->layoutGroups->push(layoutGroup);
            												}
            												else {
HXLINE(1550)													layoutGroup->format = formatRange->format;
HXDLIN(1550)													layoutGroup->startIndex = textIndex;
HXDLIN(1550)													layoutGroup->endIndex = endIndex;
            												}
HXDLIN(1550)												layoutGroup->positions = positions;
HXDLIN(1550)												int _hx_tmp1;
HXDLIN(1550)												if (firstLineOfParagraph) {
HXLINE(1550)													_hx_tmp1 = indent;
            												}
            												else {
HXLINE(1550)													_hx_tmp1 = 0;
            												}
HXDLIN(1550)												layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1550)												layoutGroup->ascent = ascent;
HXDLIN(1550)												layoutGroup->descent = descent;
HXDLIN(1550)												layoutGroup->leading = leading;
HXDLIN(1550)												layoutGroup->lineIndex = lineIndex;
HXDLIN(1550)												layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1550)												layoutGroup->width = widthValue;
HXDLIN(1550)												layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1550)												offsetX = (offsetX + widthValue);
HXDLIN(1550)												if ((endIndex == formatRange->end)) {
HXLINE(1550)													layoutGroup = null();
HXDLIN(1550)													if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)														rangeIndex = (rangeIndex + 1);
HXDLIN(1550)														formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)														currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)														font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            													}
HXDLIN(1550)													{
HXLINE(1550)														if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1550)															ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1550)															descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            														}
            														else {
HXLINE(1550)															bool _hx_tmp;
HXDLIN(1550)															if (::hx::IsNotNull( font )) {
HXLINE(1550)																_hx_tmp = (font->unitsPerEM != 0);
            															}
            															else {
HXLINE(1550)																_hx_tmp = false;
            															}
HXDLIN(1550)															if (_hx_tmp) {
HXLINE(1550)																ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1550)																descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            															}
            															else {
HXLINE(1550)																ascent = ( (Float)(currentFormat->size) );
HXDLIN(1550)																descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            															}
            														}
HXDLIN(1550)														leading = ( (int)(currentFormat->leading) );
HXDLIN(1550)														heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1550)														if ((heightValue > maxHeightValue)) {
HXLINE(1550)															maxHeightValue = heightValue;
            														}
HXDLIN(1550)														if ((ascent > maxAscent)) {
HXLINE(1550)															maxAscent = ascent;
            														}
            													}
            												}
            											}
            											else {
HXLINE(1550)												while(true){
HXLINE(1550)													int tempRangeEnd;
HXDLIN(1550)													if ((endIndex < formatRange->end)) {
HXLINE(1550)														tempRangeEnd = endIndex;
            													}
            													else {
HXLINE(1550)														tempRangeEnd = formatRange->end;
            													}
HXDLIN(1550)													if ((textIndex != tempRangeEnd)) {
HXLINE(1550)														::String text = _gthis->text;
HXDLIN(1550)														Float letterSpacing = ((Float)0.0);
HXDLIN(1550)														if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1550)															letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            														}
HXDLIN(1550)														if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1550)															_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->set_text(null());
HXDLIN(1550)														_gthis->_hx___textLayout->set_font(font);
HXDLIN(1550)														if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1550)															_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1550)														bool positions1;
HXDLIN(1550)														if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1550)															positions1 = (_gthis->sharpness < 400);
            														}
            														else {
HXLINE(1550)															positions1 = true;
            														}
HXDLIN(1550)														_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1550)														 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1550)														_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1550)														if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1550)															positions = _gthis->_hx___textLayout->get_positions();
            														}
            														else {
HXLINE(1550)															positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            														}
HXDLIN(1550)														Float width = ((Float)0.0);
HXDLIN(1550)														{
HXLINE(1550)															int _g = 0;
HXDLIN(1550)															while((_g < positions->length)){
HXLINE(1550)																 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1550)																_g = (_g + 1);
HXDLIN(1550)																width = (width + position->advance->x);
            															}
            														}
HXDLIN(1550)														widthValue = width;
HXDLIN(1550)														bool _hx_tmp;
HXDLIN(1550)														if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1550)															_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            														}
            														else {
HXLINE(1550)															_hx_tmp = true;
            														}
HXDLIN(1550)														if (_hx_tmp) {
HXLINE(1550)															layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1550)															_gthis->layoutGroups->push(layoutGroup);
            														}
            														else {
HXLINE(1550)															layoutGroup->format = formatRange->format;
HXDLIN(1550)															layoutGroup->startIndex = textIndex;
HXDLIN(1550)															layoutGroup->endIndex = tempRangeEnd;
            														}
HXDLIN(1550)														layoutGroup->positions = positions;
HXDLIN(1550)														int _hx_tmp1;
HXDLIN(1550)														if (firstLineOfParagraph) {
HXLINE(1550)															_hx_tmp1 = indent;
            														}
            														else {
HXLINE(1550)															_hx_tmp1 = 0;
            														}
HXDLIN(1550)														layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1550)														layoutGroup->ascent = ascent;
HXDLIN(1550)														layoutGroup->descent = descent;
HXDLIN(1550)														layoutGroup->leading = leading;
HXDLIN(1550)														layoutGroup->lineIndex = lineIndex;
HXDLIN(1550)														layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1550)														layoutGroup->width = widthValue;
HXDLIN(1550)														layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1550)														offsetX = (offsetX + widthValue);
HXDLIN(1550)														textIndex = tempRangeEnd;
            													}
HXDLIN(1550)													if ((tempRangeEnd == formatRange->end)) {
HXLINE(1550)														layoutGroup = null();
            													}
HXDLIN(1550)													if ((tempRangeEnd == endIndex)) {
HXLINE(1550)														goto _hx_goto_89;
            													}
HXDLIN(1550)													bool _hx_tmp;
HXDLIN(1550)													if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1550)														rangeIndex = (rangeIndex + 1);
HXDLIN(1550)														formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1550)														currentFormat->_hx___merge(formatRange->format);
HXDLIN(1550)														font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1550)														_hx_tmp = true;
            													}
            													else {
HXLINE(1550)														_hx_tmp = false;
            													}
HXDLIN(1550)													if (!(_hx_tmp)) {
HXLINE(1550)														::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1550)														goto _hx_goto_89;
            													}
HXDLIN(1550)													{
HXLINE(1550)														if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1550)															ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1550)															descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            														}
            														else {
HXLINE(1550)															bool _hx_tmp;
HXDLIN(1550)															if (::hx::IsNotNull( font )) {
HXLINE(1550)																_hx_tmp = (font->unitsPerEM != 0);
            															}
            															else {
HXLINE(1550)																_hx_tmp = false;
            															}
HXDLIN(1550)															if (_hx_tmp) {
HXLINE(1550)																ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1550)																descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            															}
            															else {
HXLINE(1550)																ascent = ( (Float)(currentFormat->size) );
HXDLIN(1550)																descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            															}
            														}
HXDLIN(1550)														leading = ( (int)(currentFormat->leading) );
HXDLIN(1550)														heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1550)														if ((heightValue > maxHeightValue)) {
HXLINE(1550)															maxHeightValue = heightValue;
            														}
HXDLIN(1550)														if ((ascent > maxAscent)) {
HXLINE(1550)															maxAscent = ascent;
            														}
            													}
            												}
            												_hx_goto_89:;
            											}
HXDLIN(1550)											textIndex = endIndex;
            										}
            									}
HXLINE(1551)									if ((endIndex == this->text.length)) {
HXLINE(1551)										{
HXLINE(1551)											if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1551)												ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1551)												descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            											}
            											else {
HXLINE(1551)												bool _hx_tmp;
HXDLIN(1551)												if (::hx::IsNotNull( font )) {
HXLINE(1551)													_hx_tmp = (font->unitsPerEM != 0);
            												}
            												else {
HXLINE(1551)													_hx_tmp = false;
            												}
HXDLIN(1551)												if (_hx_tmp) {
HXLINE(1551)													ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1551)													descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            												}
            												else {
HXLINE(1551)													ascent = ( (Float)(currentFormat->size) );
HXDLIN(1551)													descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            												}
            											}
HXDLIN(1551)											leading = ( (int)(currentFormat->leading) );
HXDLIN(1551)											heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1551)											if ((heightValue > maxHeightValue)) {
HXLINE(1551)												maxHeightValue = heightValue;
            											}
HXDLIN(1551)											if ((ascent > maxAscent)) {
HXLINE(1551)												maxAscent = ascent;
            											}
            										}
HXDLIN(1551)										int i = _gthis->layoutGroups->get_length();
HXDLIN(1551)										while(true){
HXLINE(1551)											i = (i - 1);
HXDLIN(1551)											if (!((i > -1))) {
HXLINE(1551)												goto _hx_goto_91;
            											}
HXDLIN(1551)											 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1551)											if ((lg->lineIndex < lineIndex)) {
HXLINE(1551)												goto _hx_goto_91;
            											}
HXDLIN(1551)											if ((lg->lineIndex > lineIndex)) {
HXLINE(1551)												continue;
            											}
HXDLIN(1551)											lg->ascent = maxAscent;
HXDLIN(1551)											lg->height = ( (Float)(maxHeightValue) );
            										}
            										_hx_goto_91:;
HXDLIN(1551)										offsetY = (offsetY + maxHeightValue);
HXDLIN(1551)										maxAscent = ((Float)0.0);
HXDLIN(1551)										maxHeightValue = 0;
HXDLIN(1551)										lineIndex = (lineIndex + 1);
HXDLIN(1551)										offsetX = ( (Float)(0) );
HXDLIN(1551)										firstLineOfParagraph = false;
            									}
            								}
            								else {
HXLINE(1555)									int tempRangeEnd;
HXDLIN(1555)									if ((endIndex < formatRange->end)) {
HXLINE(1555)										tempRangeEnd = endIndex;
            									}
            									else {
HXLINE(1555)										tempRangeEnd = formatRange->end;
            									}
HXLINE(1557)									if ((tempRangeEnd < endIndex)) {
HXLINE(1559)										::String text = this->text;
HXDLIN(1559)										Float letterSpacing = ((Float)0.0);
HXDLIN(1559)										if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1559)											letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            										}
HXDLIN(1559)										if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1559)											_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            										}
HXDLIN(1559)										_gthis->_hx___textLayout->set_text(null());
HXDLIN(1559)										_gthis->_hx___textLayout->set_font(font);
HXDLIN(1559)										if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1559)											_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            										}
HXDLIN(1559)										_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1559)										bool positions1;
HXDLIN(1559)										if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1559)											positions1 = (_gthis->sharpness < 400);
            										}
            										else {
HXLINE(1559)											positions1 = true;
            										}
HXDLIN(1559)										_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1559)										 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1559)										_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1559)										if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1559)											positions = _gthis->_hx___textLayout->get_positions();
            										}
            										else {
HXLINE(1559)											positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            										}
HXLINE(1560)										Float width = ((Float)0.0);
HXDLIN(1560)										{
HXLINE(1560)											int _g = 0;
HXDLIN(1560)											while((_g < positions->length)){
HXLINE(1560)												 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1560)												_g = (_g + 1);
HXDLIN(1560)												width = (width + position->advance->x);
            											}
            										}
HXDLIN(1560)										widthValue = width;
            									}
HXLINE(1563)									layoutGroup->endIndex = tempRangeEnd;
HXLINE(1564)									layoutGroup->positions = layoutGroup->positions->concat(positions);
HXLINE(1565)									 ::openfl::text::_internal::TextLayoutGroup layoutGroup1 = layoutGroup;
HXDLIN(1565)									layoutGroup1->width = (layoutGroup1->width + widthValue);
HXLINE(1567)									offsetX = (offsetX + widthValue);
HXLINE(1569)									if ((tempRangeEnd == formatRange->end)) {
HXLINE(1571)										layoutGroup = null();
HXLINE(1572)										if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1572)											rangeIndex = (rangeIndex + 1);
HXDLIN(1572)											formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1572)											currentFormat->_hx___merge(formatRange->format);
HXDLIN(1572)											font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            										}
HXLINE(1573)										{
HXLINE(1573)											if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1573)												ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1573)												descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            											}
            											else {
HXLINE(1573)												bool _hx_tmp;
HXDLIN(1573)												if (::hx::IsNotNull( font )) {
HXLINE(1573)													_hx_tmp = (font->unitsPerEM != 0);
            												}
            												else {
HXLINE(1573)													_hx_tmp = false;
            												}
HXDLIN(1573)												if (_hx_tmp) {
HXLINE(1573)													ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1573)													descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            												}
            												else {
HXLINE(1573)													ascent = ( (Float)(currentFormat->size) );
HXDLIN(1573)													descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            												}
            											}
HXDLIN(1573)											leading = ( (int)(currentFormat->leading) );
HXDLIN(1573)											heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1573)											if ((heightValue > maxHeightValue)) {
HXLINE(1573)												maxHeightValue = heightValue;
            											}
HXDLIN(1573)											if ((ascent > maxAscent)) {
HXLINE(1573)												maxAscent = ascent;
            											}
            										}
HXLINE(1575)										textIndex = tempRangeEnd;
HXLINE(1577)										if ((tempRangeEnd != endIndex)) {
HXLINE(1579)											if ((endIndex <= formatRange->end)) {
HXLINE(1579)												::String text = _gthis->text;
HXDLIN(1579)												Float letterSpacing = ((Float)0.0);
HXDLIN(1579)												if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1579)													letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            												}
HXDLIN(1579)												if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1579)													_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            												}
HXDLIN(1579)												_gthis->_hx___textLayout->set_text(null());
HXDLIN(1579)												_gthis->_hx___textLayout->set_font(font);
HXDLIN(1579)												if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1579)													_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            												}
HXDLIN(1579)												_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1579)												bool positions1;
HXDLIN(1579)												if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1579)													positions1 = (_gthis->sharpness < 400);
            												}
            												else {
HXLINE(1579)													positions1 = true;
            												}
HXDLIN(1579)												_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1579)												 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1579)												_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1579)												if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1579)													positions = _gthis->_hx___textLayout->get_positions();
            												}
            												else {
HXLINE(1579)													positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            												}
HXDLIN(1579)												Float width = ((Float)0.0);
HXDLIN(1579)												{
HXLINE(1579)													int _g = 0;
HXDLIN(1579)													while((_g < positions->length)){
HXLINE(1579)														 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1579)														_g = (_g + 1);
HXDLIN(1579)														width = (width + position->advance->x);
            													}
            												}
HXDLIN(1579)												widthValue = width;
HXDLIN(1579)												bool _hx_tmp;
HXDLIN(1579)												if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1579)													_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            												}
            												else {
HXLINE(1579)													_hx_tmp = true;
            												}
HXDLIN(1579)												if (_hx_tmp) {
HXLINE(1579)													layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,endIndex);
HXDLIN(1579)													_gthis->layoutGroups->push(layoutGroup);
            												}
            												else {
HXLINE(1579)													layoutGroup->format = formatRange->format;
HXDLIN(1579)													layoutGroup->startIndex = textIndex;
HXDLIN(1579)													layoutGroup->endIndex = endIndex;
            												}
HXDLIN(1579)												layoutGroup->positions = positions;
HXDLIN(1579)												int _hx_tmp1;
HXDLIN(1579)												if (firstLineOfParagraph) {
HXLINE(1579)													_hx_tmp1 = indent;
            												}
            												else {
HXLINE(1579)													_hx_tmp1 = 0;
            												}
HXDLIN(1579)												layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1579)												layoutGroup->ascent = ascent;
HXDLIN(1579)												layoutGroup->descent = descent;
HXDLIN(1579)												layoutGroup->leading = leading;
HXDLIN(1579)												layoutGroup->lineIndex = lineIndex;
HXDLIN(1579)												layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1579)												layoutGroup->width = widthValue;
HXDLIN(1579)												layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1579)												offsetX = (offsetX + widthValue);
HXDLIN(1579)												if ((endIndex == formatRange->end)) {
HXLINE(1579)													layoutGroup = null();
HXDLIN(1579)													if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1579)														rangeIndex = (rangeIndex + 1);
HXDLIN(1579)														formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1579)														currentFormat->_hx___merge(formatRange->format);
HXDLIN(1579)														font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            													}
HXDLIN(1579)													{
HXLINE(1579)														if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1579)															ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1579)															descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            														}
            														else {
HXLINE(1579)															bool _hx_tmp;
HXDLIN(1579)															if (::hx::IsNotNull( font )) {
HXLINE(1579)																_hx_tmp = (font->unitsPerEM != 0);
            															}
            															else {
HXLINE(1579)																_hx_tmp = false;
            															}
HXDLIN(1579)															if (_hx_tmp) {
HXLINE(1579)																ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1579)																descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            															}
            															else {
HXLINE(1579)																ascent = ( (Float)(currentFormat->size) );
HXDLIN(1579)																descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            															}
            														}
HXDLIN(1579)														leading = ( (int)(currentFormat->leading) );
HXDLIN(1579)														heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1579)														if ((heightValue > maxHeightValue)) {
HXLINE(1579)															maxHeightValue = heightValue;
            														}
HXDLIN(1579)														if ((ascent > maxAscent)) {
HXLINE(1579)															maxAscent = ascent;
            														}
            													}
            												}
            											}
            											else {
HXLINE(1579)												while(true){
HXLINE(1579)													int tempRangeEnd;
HXDLIN(1579)													if ((endIndex < formatRange->end)) {
HXLINE(1579)														tempRangeEnd = endIndex;
            													}
            													else {
HXLINE(1579)														tempRangeEnd = formatRange->end;
            													}
HXDLIN(1579)													if ((textIndex != tempRangeEnd)) {
HXLINE(1579)														::String text = _gthis->text;
HXDLIN(1579)														Float letterSpacing = ((Float)0.0);
HXDLIN(1579)														if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1579)															letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            														}
HXDLIN(1579)														if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1579)															_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            														}
HXDLIN(1579)														_gthis->_hx___textLayout->set_text(null());
HXDLIN(1579)														_gthis->_hx___textLayout->set_font(font);
HXDLIN(1579)														if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1579)															_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            														}
HXDLIN(1579)														_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1579)														bool positions1;
HXDLIN(1579)														if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1579)															positions1 = (_gthis->sharpness < 400);
            														}
            														else {
HXLINE(1579)															positions1 = true;
            														}
HXDLIN(1579)														_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1579)														 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1579)														_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1579)														if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1579)															positions = _gthis->_hx___textLayout->get_positions();
            														}
            														else {
HXLINE(1579)															positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            														}
HXDLIN(1579)														Float width = ((Float)0.0);
HXDLIN(1579)														{
HXLINE(1579)															int _g = 0;
HXDLIN(1579)															while((_g < positions->length)){
HXLINE(1579)																 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1579)																_g = (_g + 1);
HXDLIN(1579)																width = (width + position->advance->x);
            															}
            														}
HXDLIN(1579)														widthValue = width;
HXDLIN(1579)														bool _hx_tmp;
HXDLIN(1579)														if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1579)															_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            														}
            														else {
HXLINE(1579)															_hx_tmp = true;
            														}
HXDLIN(1579)														if (_hx_tmp) {
HXLINE(1579)															layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1579)															_gthis->layoutGroups->push(layoutGroup);
            														}
            														else {
HXLINE(1579)															layoutGroup->format = formatRange->format;
HXDLIN(1579)															layoutGroup->startIndex = textIndex;
HXDLIN(1579)															layoutGroup->endIndex = tempRangeEnd;
            														}
HXDLIN(1579)														layoutGroup->positions = positions;
HXDLIN(1579)														int _hx_tmp1;
HXDLIN(1579)														if (firstLineOfParagraph) {
HXLINE(1579)															_hx_tmp1 = indent;
            														}
            														else {
HXLINE(1579)															_hx_tmp1 = 0;
            														}
HXDLIN(1579)														layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1579)														layoutGroup->ascent = ascent;
HXDLIN(1579)														layoutGroup->descent = descent;
HXDLIN(1579)														layoutGroup->leading = leading;
HXDLIN(1579)														layoutGroup->lineIndex = lineIndex;
HXDLIN(1579)														layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1579)														layoutGroup->width = widthValue;
HXDLIN(1579)														layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1579)														offsetX = (offsetX + widthValue);
HXDLIN(1579)														textIndex = tempRangeEnd;
            													}
HXDLIN(1579)													if ((tempRangeEnd == formatRange->end)) {
HXLINE(1579)														layoutGroup = null();
            													}
HXDLIN(1579)													if ((tempRangeEnd == endIndex)) {
HXLINE(1579)														goto _hx_goto_94;
            													}
HXDLIN(1579)													bool _hx_tmp;
HXDLIN(1579)													if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1579)														rangeIndex = (rangeIndex + 1);
HXDLIN(1579)														formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1579)														currentFormat->_hx___merge(formatRange->format);
HXDLIN(1579)														font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1579)														_hx_tmp = true;
            													}
            													else {
HXLINE(1579)														_hx_tmp = false;
            													}
HXDLIN(1579)													if (!(_hx_tmp)) {
HXLINE(1579)														::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1579)														goto _hx_goto_94;
            													}
HXDLIN(1579)													{
HXLINE(1579)														if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1579)															ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1579)															descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            														}
            														else {
HXLINE(1579)															bool _hx_tmp;
HXDLIN(1579)															if (::hx::IsNotNull( font )) {
HXLINE(1579)																_hx_tmp = (font->unitsPerEM != 0);
            															}
            															else {
HXLINE(1579)																_hx_tmp = false;
            															}
HXDLIN(1579)															if (_hx_tmp) {
HXLINE(1579)																ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1579)																descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            															}
            															else {
HXLINE(1579)																ascent = ( (Float)(currentFormat->size) );
HXDLIN(1579)																descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            															}
            														}
HXDLIN(1579)														leading = ( (int)(currentFormat->leading) );
HXDLIN(1579)														heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1579)														if ((heightValue > maxHeightValue)) {
HXLINE(1579)															maxHeightValue = heightValue;
            														}
HXDLIN(1579)														if ((ascent > maxAscent)) {
HXLINE(1579)															maxAscent = ascent;
            														}
            													}
            												}
            												_hx_goto_94:;
            											}
HXDLIN(1579)											textIndex = endIndex;
            										}
            									}
HXLINE(1585)									if ((breakIndex == endIndex)) {
HXLINE(1585)										endIndex = (endIndex + 1);
            									}
HXLINE(1587)									textIndex = endIndex;
HXLINE(1589)									if ((endIndex == this->text.length)) {
HXLINE(1591)										{
HXLINE(1591)											{
HXLINE(1591)												if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1591)													ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1591)													descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            												}
            												else {
HXLINE(1591)													bool _hx_tmp;
HXDLIN(1591)													if (::hx::IsNotNull( font )) {
HXLINE(1591)														_hx_tmp = (font->unitsPerEM != 0);
            													}
            													else {
HXLINE(1591)														_hx_tmp = false;
            													}
HXDLIN(1591)													if (_hx_tmp) {
HXLINE(1591)														ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1591)														descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            													}
            													else {
HXLINE(1591)														ascent = ( (Float)(currentFormat->size) );
HXDLIN(1591)														descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            													}
            												}
HXDLIN(1591)												leading = ( (int)(currentFormat->leading) );
HXDLIN(1591)												heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1591)												if ((heightValue > maxHeightValue)) {
HXLINE(1591)													maxHeightValue = heightValue;
            												}
HXDLIN(1591)												if ((ascent > maxAscent)) {
HXLINE(1591)													maxAscent = ascent;
            												}
            											}
HXDLIN(1591)											int i = _gthis->layoutGroups->get_length();
HXDLIN(1591)											while(true){
HXLINE(1591)												i = (i - 1);
HXDLIN(1591)												if (!((i > -1))) {
HXLINE(1591)													goto _hx_goto_96;
            												}
HXDLIN(1591)												 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1591)												if ((lg->lineIndex < lineIndex)) {
HXLINE(1591)													goto _hx_goto_96;
            												}
HXDLIN(1591)												if ((lg->lineIndex > lineIndex)) {
HXLINE(1591)													continue;
            												}
HXDLIN(1591)												lg->ascent = maxAscent;
HXDLIN(1591)												lg->height = ( (Float)(maxHeightValue) );
            											}
            											_hx_goto_96:;
HXDLIN(1591)											offsetY = (offsetY + maxHeightValue);
HXDLIN(1591)											maxAscent = ((Float)0.0);
HXDLIN(1591)											maxHeightValue = 0;
HXDLIN(1591)											lineIndex = (lineIndex + 1);
HXDLIN(1591)											offsetX = ( (Float)(0) );
HXDLIN(1591)											firstLineOfParagraph = false;
            										}
HXLINE(1593)										if ((breakIndex != -1)) {
HXLINE(1595)											previousBreakIndex = breakIndex;
HXLINE(1596)											breakCount = (breakCount + 1);
HXLINE(1597)											if ((breakCount < this->lineBreaks->get_length())) {
HXLINE(1597)												breakIndex = this->lineBreaks->get(breakCount);
            											}
            											else {
HXLINE(1597)												breakIndex = -1;
            											}
            										}
            									}
            								}
            							}
            						}
HXLINE(1603)						int nextSpaceIndex = this->text.indexOf(HX_(" ",20,00,00,00),textIndex);
HXLINE(1608)						if ((breakIndex == previousSpaceIndex)) {
HXLINE(1610)							layoutGroup->endIndex = breakIndex;
HXLINE(1612)							if ((((breakIndex - layoutGroup->startIndex) - layoutGroup->positions->length) < 0)) {
HXLINE(1615)								layoutGroup->positions->push(null());
            							}
HXLINE(1618)							textIndex = (breakIndex + 1);
            						}
HXLINE(1621)						previousSpaceIndex = spaceIndex;
HXLINE(1622)						spaceIndex = nextSpaceIndex;
HXLINE(1624)						bool _hx_tmp;
HXDLIN(1624)						bool _hx_tmp1;
HXDLIN(1624)						bool _hx_tmp2;
HXDLIN(1624)						if ((breakIndex > -1)) {
HXLINE(1624)							_hx_tmp2 = (breakIndex <= textIndex);
            						}
            						else {
HXLINE(1624)							_hx_tmp2 = false;
            						}
HXDLIN(1624)						if (_hx_tmp2) {
HXLINE(1624)							if ((spaceIndex <= breakIndex)) {
HXLINE(1624)								_hx_tmp1 = (spaceIndex == -1);
            							}
            							else {
HXLINE(1624)								_hx_tmp1 = true;
            							}
            						}
            						else {
HXLINE(1624)							_hx_tmp1 = false;
            						}
HXDLIN(1624)						if (!(_hx_tmp1)) {
HXLINE(1624)							_hx_tmp = (textIndex > this->text.length);
            						}
            						else {
HXLINE(1624)							_hx_tmp = true;
            						}
HXDLIN(1624)						if (_hx_tmp) {
HXLINE(1627)							goto _hx_goto_42;
            						}
            					}
            					_hx_goto_42:;
            				}
            				else {
HXLINE(1633)					if ((textIndex < this->text.length)) {
HXLINE(1636)						{
HXLINE(1636)							int endIndex = this->text.length;
HXDLIN(1636)							if ((textIndex >= endIndex)) {
HXLINE(1636)								positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1636)								widthValue = ( (Float)(0) );
            							}
            							else {
HXLINE(1636)								if ((endIndex <= formatRange->end)) {
HXLINE(1636)									::String text = _gthis->text;
HXDLIN(1636)									Float letterSpacing = ((Float)0.0);
HXDLIN(1636)									if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1636)										letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            									}
HXDLIN(1636)									if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1636)										_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            									}
HXDLIN(1636)									_gthis->_hx___textLayout->set_text(null());
HXDLIN(1636)									_gthis->_hx___textLayout->set_font(font);
HXDLIN(1636)									if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1636)										_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            									}
HXDLIN(1636)									_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1636)									bool positions1;
HXDLIN(1636)									if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1636)										positions1 = (_gthis->sharpness < 400);
            									}
            									else {
HXLINE(1636)										positions1 = true;
            									}
HXDLIN(1636)									_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1636)									 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1636)									_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1636)									if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1636)										positions = _gthis->_hx___textLayout->get_positions();
            									}
            									else {
HXLINE(1636)										positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            									}
HXDLIN(1636)									Float width = ((Float)0.0);
HXDLIN(1636)									{
HXLINE(1636)										int _g = 0;
HXDLIN(1636)										while((_g < positions->length)){
HXLINE(1636)											 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1636)											_g = (_g + 1);
HXDLIN(1636)											width = (width + position->advance->x);
            										}
            									}
HXDLIN(1636)									widthValue = width;
            								}
            								else {
HXLINE(1636)									int tempIndex = textIndex;
HXDLIN(1636)									int tempRangeEnd = formatRange->end;
HXDLIN(1636)									int countRanges = 0;
HXDLIN(1636)									positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1636)									widthValue = ( (Float)(0) );
HXDLIN(1636)									while(true){
HXLINE(1636)										if ((tempIndex != tempRangeEnd)) {
HXLINE(1636)											::String text = _gthis->text;
HXDLIN(1636)											Float letterSpacing = ((Float)0.0);
HXDLIN(1636)											if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1636)												letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            											}
HXDLIN(1636)											if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1636)												_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            											}
HXDLIN(1636)											_gthis->_hx___textLayout->set_text(null());
HXDLIN(1636)											_gthis->_hx___textLayout->set_font(font);
HXDLIN(1636)											if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1636)												_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            											}
HXDLIN(1636)											_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1636)											bool _hx_tmp;
HXDLIN(1636)											if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1636)												_hx_tmp = (_gthis->sharpness < 400);
            											}
            											else {
HXLINE(1636)												_hx_tmp = true;
            											}
HXDLIN(1636)											_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1636)											 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1636)											_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1636)											::Array< ::Dynamic> tempPositions;
HXDLIN(1636)											if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1636)												tempPositions = _gthis->_hx___textLayout->get_positions();
            											}
            											else {
HXLINE(1636)												tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            											}
HXDLIN(1636)											positions = positions->concat(tempPositions);
            										}
HXDLIN(1636)										if ((tempRangeEnd != endIndex)) {
HXLINE(1636)											bool _hx_tmp;
HXDLIN(1636)											if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1636)												rangeIndex = (rangeIndex + 1);
HXDLIN(1636)												formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1636)												currentFormat->_hx___merge(formatRange->format);
HXDLIN(1636)												font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1636)												_hx_tmp = true;
            											}
            											else {
HXLINE(1636)												_hx_tmp = false;
            											}
HXDLIN(1636)											if (!(_hx_tmp)) {
HXLINE(1636)												::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1636)												goto _hx_goto_98;
            											}
HXDLIN(1636)											tempIndex = tempRangeEnd;
HXDLIN(1636)											if ((endIndex < formatRange->end)) {
HXLINE(1636)												tempRangeEnd = endIndex;
            											}
            											else {
HXLINE(1636)												tempRangeEnd = formatRange->end;
            											}
HXDLIN(1636)											countRanges = (countRanges + 1);
            										}
            										else {
HXLINE(1636)											Float width = ((Float)0.0);
HXDLIN(1636)											{
HXLINE(1636)												int _g = 0;
HXDLIN(1636)												while((_g < positions->length)){
HXLINE(1636)													 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1636)													_g = (_g + 1);
HXDLIN(1636)													width = (width + position->advance->x);
            												}
            											}
HXDLIN(1636)											widthValue = width;
HXDLIN(1636)											goto _hx_goto_98;
            										}
            									}
            									_hx_goto_98:;
HXDLIN(1636)									rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1636)									if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1636)										rangeIndex = (rangeIndex + 1);
HXDLIN(1636)										formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1636)										currentFormat->_hx___merge(formatRange->format);
HXDLIN(1636)										font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            									}
            								}
            							}
            						}
HXLINE(1637)						{
HXLINE(1637)							int endIndex1 = this->text.length;
HXDLIN(1637)							bool _hx_tmp;
HXDLIN(1637)							if ((_gthis->width >= 4)) {
HXLINE(1637)								_hx_tmp = _gthis->wordWrap;
            							}
            							else {
HXLINE(1637)								_hx_tmp = false;
            							}
HXDLIN(1637)							if (_hx_tmp) {
HXLINE(1637)								::Array< ::Dynamic> remainingPositions = positions;
HXDLIN(1637)								int bufferCount;
HXDLIN(1637)								int placeIndex;
HXDLIN(1637)								Float positionWidth;
HXDLIN(1637)								 ::openfl::text::_internal::GlyphPosition currentPosition;
HXDLIN(1637)								Float width = ((Float)0.0);
HXDLIN(1637)								{
HXLINE(1637)									int _g = 0;
HXDLIN(1637)									while((_g < remainingPositions->length)){
HXLINE(1637)										 ::openfl::text::_internal::GlyphPosition position = remainingPositions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)										_g = (_g + 1);
HXDLIN(1637)										width = (width + position->advance->x);
            									}
            								}
HXDLIN(1637)								Float tempWidth = width;
HXDLIN(1637)								int i = (remainingPositions->length - 1);
HXDLIN(1637)								while((i >= 0)){
HXLINE(1637)									 ::Dynamic currentCharCode = _gthis->text.charCodeAt((textIndex + i));
HXDLIN(1637)									bool _hx_tmp;
HXDLIN(1637)									if (::hx::IsNotEq( currentCharCode,32 )) {
HXLINE(1637)										_hx_tmp = ::hx::IsNotEq( currentCharCode,9 );
            									}
            									else {
HXLINE(1637)										_hx_tmp = false;
            									}
HXDLIN(1637)									if (_hx_tmp) {
HXLINE(1637)										goto _hx_goto_101;
            									}
HXDLIN(1637)									 ::openfl::text::_internal::GlyphPosition position = remainingPositions->__get(i).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)									tempWidth = (tempWidth - position->advance->x);
HXDLIN(1637)									i = (i - 1);
            								}
            								_hx_goto_101:;
HXDLIN(1637)								while(true){
HXLINE(1637)									bool _hx_tmp;
HXDLIN(1637)									if ((remainingPositions->length > 0)) {
HXLINE(1637)										int _hx_tmp1;
HXDLIN(1637)										if (firstLineOfParagraph) {
HXLINE(1637)											_hx_tmp1 = indent;
            										}
            										else {
HXLINE(1637)											_hx_tmp1 = 0;
            										}
HXDLIN(1637)										_hx_tmp = ((offsetX + tempWidth) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) )));
            									}
            									else {
HXLINE(1637)										_hx_tmp = false;
            									}
HXDLIN(1637)									if (!(_hx_tmp)) {
HXLINE(1637)										goto _hx_goto_102;
            									}
HXDLIN(1637)									bufferCount = 0;
HXDLIN(1637)									i = bufferCount;
HXDLIN(1637)									positionWidth = ((Float)0.0);
HXDLIN(1637)									while(true){
HXLINE(1637)										int _hx_tmp;
HXDLIN(1637)										if (firstLineOfParagraph) {
HXLINE(1637)											_hx_tmp = indent;
            										}
            										else {
HXLINE(1637)											_hx_tmp = 0;
            										}
HXDLIN(1637)										if (!(((offsetX + positionWidth) < (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp)) ))))) {
HXLINE(1637)											goto _hx_goto_103;
            										}
HXDLIN(1637)										currentPosition = remainingPositions->__get(i).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)										if ((currentPosition->advance->x == ((Float)0.0))) {
HXLINE(1637)											i = (i + 1);
HXDLIN(1637)											bufferCount = (bufferCount + 1);
            										}
            										else {
HXLINE(1637)											positionWidth = (positionWidth + currentPosition->advance->x);
HXDLIN(1637)											i = (i + 1);
            										}
            									}
            									_hx_goto_103:;
HXDLIN(1637)									if ((i == bufferCount)) {
HXLINE(1637)										i = (bufferCount + 1);
            									}
            									else {
HXLINE(1637)										while(true){
HXLINE(1637)											bool _hx_tmp;
HXDLIN(1637)											if ((i > 1)) {
HXLINE(1637)												int _hx_tmp1;
HXDLIN(1637)												if (firstLineOfParagraph) {
HXLINE(1637)													_hx_tmp1 = indent;
            												}
            												else {
HXLINE(1637)													_hx_tmp1 = 0;
            												}
HXDLIN(1637)												_hx_tmp = ((offsetX + positionWidth) > (((_gthis->width - ( (Float)(2) )) - ( (Float)(rightMargin) )) - ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) )));
            											}
            											else {
HXLINE(1637)												_hx_tmp = false;
            											}
HXDLIN(1637)											if (!(_hx_tmp)) {
HXLINE(1637)												goto _hx_goto_104;
            											}
HXDLIN(1637)											i = (i - 1);
HXDLIN(1637)											if (((i - bufferCount) > 0)) {
HXLINE(1637)												{
HXLINE(1637)													int endIndex = ((textIndex + i) - bufferCount);
HXDLIN(1637)													if ((textIndex >= endIndex)) {
HXLINE(1637)														positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1637)														widthValue = ( (Float)(0) );
            													}
            													else {
HXLINE(1637)														if ((endIndex <= formatRange->end)) {
HXLINE(1637)															::String text = _gthis->text;
HXDLIN(1637)															Float letterSpacing = ((Float)0.0);
HXDLIN(1637)															if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)																letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            															}
HXDLIN(1637)															if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)																_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            															}
HXDLIN(1637)															_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)															_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)															if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)																_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            															}
HXDLIN(1637)															_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)															bool positions1;
HXDLIN(1637)															if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)																positions1 = (_gthis->sharpness < 400);
            															}
            															else {
HXLINE(1637)																positions1 = true;
            															}
HXDLIN(1637)															_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1637)															 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)															_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1637)															if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)																positions = _gthis->_hx___textLayout->get_positions();
            															}
            															else {
HXLINE(1637)																positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            															}
HXDLIN(1637)															Float width = ((Float)0.0);
HXDLIN(1637)															{
HXLINE(1637)																int _g = 0;
HXDLIN(1637)																while((_g < positions->length)){
HXLINE(1637)																	 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)																	_g = (_g + 1);
HXDLIN(1637)																	width = (width + position->advance->x);
            																}
            															}
HXDLIN(1637)															widthValue = width;
            														}
            														else {
HXLINE(1637)															int tempIndex = textIndex;
HXDLIN(1637)															int tempRangeEnd = formatRange->end;
HXDLIN(1637)															int countRanges = 0;
HXDLIN(1637)															positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1637)															widthValue = ( (Float)(0) );
HXDLIN(1637)															while(true){
HXLINE(1637)																if ((tempIndex != tempRangeEnd)) {
HXLINE(1637)																	::String text = _gthis->text;
HXDLIN(1637)																	Float letterSpacing = ((Float)0.0);
HXDLIN(1637)																	if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)																		letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																	}
HXDLIN(1637)																	if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)																		_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																	}
HXDLIN(1637)																	_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)																	_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)																	if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)																		_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																	}
HXDLIN(1637)																	_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)																	bool _hx_tmp;
HXDLIN(1637)																	if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)																		_hx_tmp = (_gthis->sharpness < 400);
            																	}
            																	else {
HXLINE(1637)																		_hx_tmp = true;
            																	}
HXDLIN(1637)																	_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1637)																	 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)																	_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1637)																	::Array< ::Dynamic> tempPositions;
HXDLIN(1637)																	if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)																		tempPositions = _gthis->_hx___textLayout->get_positions();
            																	}
            																	else {
HXLINE(1637)																		tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																	}
HXDLIN(1637)																	positions = positions->concat(tempPositions);
            																}
HXDLIN(1637)																if ((tempRangeEnd != endIndex)) {
HXLINE(1637)																	bool _hx_tmp;
HXDLIN(1637)																	if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)																		rangeIndex = (rangeIndex + 1);
HXDLIN(1637)																		formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)																		currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)																		font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1637)																		_hx_tmp = true;
            																	}
            																	else {
HXLINE(1637)																		_hx_tmp = false;
            																	}
HXDLIN(1637)																	if (!(_hx_tmp)) {
HXLINE(1637)																		::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1637)																		goto _hx_goto_106;
            																	}
HXDLIN(1637)																	tempIndex = tempRangeEnd;
HXDLIN(1637)																	if ((endIndex < formatRange->end)) {
HXLINE(1637)																		tempRangeEnd = endIndex;
            																	}
            																	else {
HXLINE(1637)																		tempRangeEnd = formatRange->end;
            																	}
HXDLIN(1637)																	countRanges = (countRanges + 1);
            																}
            																else {
HXLINE(1637)																	Float width = ((Float)0.0);
HXDLIN(1637)																	{
HXLINE(1637)																		int _g = 0;
HXDLIN(1637)																		while((_g < positions->length)){
HXLINE(1637)																			 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)																			_g = (_g + 1);
HXDLIN(1637)																			width = (width + position->advance->x);
            																		}
            																	}
HXDLIN(1637)																	widthValue = width;
HXDLIN(1637)																	goto _hx_goto_106;
            																}
            															}
            															_hx_goto_106:;
HXDLIN(1637)															rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1637)															if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)																rangeIndex = (rangeIndex + 1);
HXDLIN(1637)																formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)																currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)																font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            															}
            														}
            													}
            												}
HXDLIN(1637)												positionWidth = widthValue;
            											}
            											else {
HXLINE(1637)												i = 1;
HXDLIN(1637)												bufferCount = 0;
HXDLIN(1637)												{
HXLINE(1637)													int endIndex = (textIndex + 1);
HXDLIN(1637)													if ((textIndex >= endIndex)) {
HXLINE(1637)														positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1637)														widthValue = ( (Float)(0) );
            													}
            													else {
HXLINE(1637)														if ((endIndex <= formatRange->end)) {
HXLINE(1637)															::String text = _gthis->text;
HXDLIN(1637)															Float letterSpacing = ((Float)0.0);
HXDLIN(1637)															if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)																letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            															}
HXDLIN(1637)															if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)																_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            															}
HXDLIN(1637)															_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)															_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)															if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)																_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            															}
HXDLIN(1637)															_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)															bool positions1;
HXDLIN(1637)															if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)																positions1 = (_gthis->sharpness < 400);
            															}
            															else {
HXLINE(1637)																positions1 = true;
            															}
HXDLIN(1637)															_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1637)															 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)															_gthis1->set_text(text.substring(textIndex,endIndex));
HXDLIN(1637)															if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)																positions = _gthis->_hx___textLayout->get_positions();
            															}
            															else {
HXLINE(1637)																positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            															}
HXDLIN(1637)															Float width = ((Float)0.0);
HXDLIN(1637)															{
HXLINE(1637)																int _g = 0;
HXDLIN(1637)																while((_g < positions->length)){
HXLINE(1637)																	 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)																	_g = (_g + 1);
HXDLIN(1637)																	width = (width + position->advance->x);
            																}
            															}
HXDLIN(1637)															widthValue = width;
            														}
            														else {
HXLINE(1637)															int tempIndex = textIndex;
HXDLIN(1637)															int tempRangeEnd = formatRange->end;
HXDLIN(1637)															int countRanges = 0;
HXDLIN(1637)															positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1637)															widthValue = ( (Float)(0) );
HXDLIN(1637)															while(true){
HXLINE(1637)																if ((tempIndex != tempRangeEnd)) {
HXLINE(1637)																	::String text = _gthis->text;
HXDLIN(1637)																	Float letterSpacing = ((Float)0.0);
HXDLIN(1637)																	if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)																		letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            																	}
HXDLIN(1637)																	if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)																		_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            																	}
HXDLIN(1637)																	_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)																	_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)																	if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)																		_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            																	}
HXDLIN(1637)																	_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)																	bool _hx_tmp;
HXDLIN(1637)																	if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)																		_hx_tmp = (_gthis->sharpness < 400);
            																	}
            																	else {
HXLINE(1637)																		_hx_tmp = true;
            																	}
HXDLIN(1637)																	_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1637)																	 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)																	_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1637)																	::Array< ::Dynamic> tempPositions;
HXDLIN(1637)																	if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)																		tempPositions = _gthis->_hx___textLayout->get_positions();
            																	}
            																	else {
HXLINE(1637)																		tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            																	}
HXDLIN(1637)																	positions = positions->concat(tempPositions);
            																}
HXDLIN(1637)																if ((tempRangeEnd != endIndex)) {
HXLINE(1637)																	bool _hx_tmp;
HXDLIN(1637)																	if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)																		rangeIndex = (rangeIndex + 1);
HXDLIN(1637)																		formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)																		currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)																		font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1637)																		_hx_tmp = true;
            																	}
            																	else {
HXLINE(1637)																		_hx_tmp = false;
            																	}
HXDLIN(1637)																	if (!(_hx_tmp)) {
HXLINE(1637)																		::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1637)																		goto _hx_goto_109;
            																	}
HXDLIN(1637)																	tempIndex = tempRangeEnd;
HXDLIN(1637)																	if ((endIndex < formatRange->end)) {
HXLINE(1637)																		tempRangeEnd = endIndex;
            																	}
            																	else {
HXLINE(1637)																		tempRangeEnd = formatRange->end;
            																	}
HXDLIN(1637)																	countRanges = (countRanges + 1);
            																}
            																else {
HXLINE(1637)																	Float width = ((Float)0.0);
HXDLIN(1637)																	{
HXLINE(1637)																		int _g = 0;
HXDLIN(1637)																		while((_g < positions->length)){
HXLINE(1637)																			 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)																			_g = (_g + 1);
HXDLIN(1637)																			width = (width + position->advance->x);
            																		}
            																	}
HXDLIN(1637)																	widthValue = width;
HXDLIN(1637)																	goto _hx_goto_109;
            																}
            															}
            															_hx_goto_109:;
HXDLIN(1637)															rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1637)															if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)																rangeIndex = (rangeIndex + 1);
HXDLIN(1637)																formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)																currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)																font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            															}
            														}
            													}
            												}
HXDLIN(1637)												positionWidth = ( (Float)(0) );
            											}
            										}
            										_hx_goto_104:;
            									}
HXDLIN(1637)									placeIndex = ((textIndex + i) - bufferCount);
HXDLIN(1637)									{
HXLINE(1637)										if ((placeIndex <= formatRange->end)) {
HXLINE(1637)											::String text = _gthis->text;
HXDLIN(1637)											Float letterSpacing = ((Float)0.0);
HXDLIN(1637)											if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)												letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            											}
HXDLIN(1637)											if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)												_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)											_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)											if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)												_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)											bool positions1;
HXDLIN(1637)											if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)												positions1 = (_gthis->sharpness < 400);
            											}
            											else {
HXLINE(1637)												positions1 = true;
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1637)											 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)											_gthis1->set_text(text.substring(textIndex,placeIndex));
HXDLIN(1637)											if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)												positions = _gthis->_hx___textLayout->get_positions();
            											}
            											else {
HXLINE(1637)												positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            											}
HXDLIN(1637)											Float width = ((Float)0.0);
HXDLIN(1637)											{
HXLINE(1637)												int _g = 0;
HXDLIN(1637)												while((_g < positions->length)){
HXLINE(1637)													 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)													_g = (_g + 1);
HXDLIN(1637)													width = (width + position->advance->x);
            												}
            											}
HXDLIN(1637)											widthValue = width;
HXDLIN(1637)											bool _hx_tmp;
HXDLIN(1637)											if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1637)												_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            											}
            											else {
HXLINE(1637)												_hx_tmp = true;
            											}
HXDLIN(1637)											if (_hx_tmp) {
HXLINE(1637)												layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,placeIndex);
HXDLIN(1637)												_gthis->layoutGroups->push(layoutGroup);
            											}
            											else {
HXLINE(1637)												layoutGroup->format = formatRange->format;
HXDLIN(1637)												layoutGroup->startIndex = textIndex;
HXDLIN(1637)												layoutGroup->endIndex = placeIndex;
            											}
HXDLIN(1637)											layoutGroup->positions = positions;
HXDLIN(1637)											int _hx_tmp1;
HXDLIN(1637)											if (firstLineOfParagraph) {
HXLINE(1637)												_hx_tmp1 = indent;
            											}
            											else {
HXLINE(1637)												_hx_tmp1 = 0;
            											}
HXDLIN(1637)											layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1637)											layoutGroup->ascent = ascent;
HXDLIN(1637)											layoutGroup->descent = descent;
HXDLIN(1637)											layoutGroup->leading = leading;
HXDLIN(1637)											layoutGroup->lineIndex = lineIndex;
HXDLIN(1637)											layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1637)											layoutGroup->width = widthValue;
HXDLIN(1637)											layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1637)											offsetX = (offsetX + widthValue);
HXDLIN(1637)											if ((placeIndex == formatRange->end)) {
HXLINE(1637)												layoutGroup = null();
HXDLIN(1637)												if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)													rangeIndex = (rangeIndex + 1);
HXDLIN(1637)													formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)													currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)													font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            												}
HXDLIN(1637)												{
HXLINE(1637)													if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1637)														ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1637)														descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            													}
            													else {
HXLINE(1637)														bool _hx_tmp;
HXDLIN(1637)														if (::hx::IsNotNull( font )) {
HXLINE(1637)															_hx_tmp = (font->unitsPerEM != 0);
            														}
            														else {
HXLINE(1637)															_hx_tmp = false;
            														}
HXDLIN(1637)														if (_hx_tmp) {
HXLINE(1637)															ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1637)															descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            														}
            														else {
HXLINE(1637)															ascent = ( (Float)(currentFormat->size) );
HXDLIN(1637)															descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            														}
            													}
HXDLIN(1637)													leading = ( (int)(currentFormat->leading) );
HXDLIN(1637)													heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1637)													if ((heightValue > maxHeightValue)) {
HXLINE(1637)														maxHeightValue = heightValue;
            													}
HXDLIN(1637)													if ((ascent > maxAscent)) {
HXLINE(1637)														maxAscent = ascent;
            													}
            												}
            											}
            										}
            										else {
HXLINE(1637)											while(true){
HXLINE(1637)												int tempRangeEnd;
HXDLIN(1637)												if ((placeIndex < formatRange->end)) {
HXLINE(1637)													tempRangeEnd = placeIndex;
            												}
            												else {
HXLINE(1637)													tempRangeEnd = formatRange->end;
            												}
HXDLIN(1637)												if ((textIndex != tempRangeEnd)) {
HXLINE(1637)													::String text = _gthis->text;
HXDLIN(1637)													Float letterSpacing = ((Float)0.0);
HXDLIN(1637)													if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)														letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            													}
HXDLIN(1637)													if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)														_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            													}
HXDLIN(1637)													_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)													_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)													if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)														_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            													}
HXDLIN(1637)													_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)													bool positions1;
HXDLIN(1637)													if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)														positions1 = (_gthis->sharpness < 400);
            													}
            													else {
HXLINE(1637)														positions1 = true;
            													}
HXDLIN(1637)													_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1637)													 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)													_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1637)													if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)														positions = _gthis->_hx___textLayout->get_positions();
            													}
            													else {
HXLINE(1637)														positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            													}
HXDLIN(1637)													Float width = ((Float)0.0);
HXDLIN(1637)													{
HXLINE(1637)														int _g = 0;
HXDLIN(1637)														while((_g < positions->length)){
HXLINE(1637)															 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)															_g = (_g + 1);
HXDLIN(1637)															width = (width + position->advance->x);
            														}
            													}
HXDLIN(1637)													widthValue = width;
HXDLIN(1637)													bool _hx_tmp;
HXDLIN(1637)													if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1637)														_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            													}
            													else {
HXLINE(1637)														_hx_tmp = true;
            													}
HXDLIN(1637)													if (_hx_tmp) {
HXLINE(1637)														layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1637)														_gthis->layoutGroups->push(layoutGroup);
            													}
            													else {
HXLINE(1637)														layoutGroup->format = formatRange->format;
HXDLIN(1637)														layoutGroup->startIndex = textIndex;
HXDLIN(1637)														layoutGroup->endIndex = tempRangeEnd;
            													}
HXDLIN(1637)													layoutGroup->positions = positions;
HXDLIN(1637)													int _hx_tmp1;
HXDLIN(1637)													if (firstLineOfParagraph) {
HXLINE(1637)														_hx_tmp1 = indent;
            													}
            													else {
HXLINE(1637)														_hx_tmp1 = 0;
            													}
HXDLIN(1637)													layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1637)													layoutGroup->ascent = ascent;
HXDLIN(1637)													layoutGroup->descent = descent;
HXDLIN(1637)													layoutGroup->leading = leading;
HXDLIN(1637)													layoutGroup->lineIndex = lineIndex;
HXDLIN(1637)													layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1637)													layoutGroup->width = widthValue;
HXDLIN(1637)													layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1637)													offsetX = (offsetX + widthValue);
HXDLIN(1637)													textIndex = tempRangeEnd;
            												}
HXDLIN(1637)												if ((tempRangeEnd == formatRange->end)) {
HXLINE(1637)													layoutGroup = null();
            												}
HXDLIN(1637)												if ((tempRangeEnd == placeIndex)) {
HXLINE(1637)													goto _hx_goto_112;
            												}
HXDLIN(1637)												bool _hx_tmp;
HXDLIN(1637)												if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)													rangeIndex = (rangeIndex + 1);
HXDLIN(1637)													formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)													currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)													font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1637)													_hx_tmp = true;
            												}
            												else {
HXLINE(1637)													_hx_tmp = false;
            												}
HXDLIN(1637)												if (!(_hx_tmp)) {
HXLINE(1637)													::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1637)													goto _hx_goto_112;
            												}
HXDLIN(1637)												{
HXLINE(1637)													if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1637)														ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1637)														descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            													}
            													else {
HXLINE(1637)														bool _hx_tmp;
HXDLIN(1637)														if (::hx::IsNotNull( font )) {
HXLINE(1637)															_hx_tmp = (font->unitsPerEM != 0);
            														}
            														else {
HXLINE(1637)															_hx_tmp = false;
            														}
HXDLIN(1637)														if (_hx_tmp) {
HXLINE(1637)															ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1637)															descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            														}
            														else {
HXLINE(1637)															ascent = ( (Float)(currentFormat->size) );
HXDLIN(1637)															descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            														}
            													}
HXDLIN(1637)													leading = ( (int)(currentFormat->leading) );
HXDLIN(1637)													heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1637)													if ((heightValue > maxHeightValue)) {
HXLINE(1637)														maxHeightValue = heightValue;
            													}
HXDLIN(1637)													if ((ascent > maxAscent)) {
HXLINE(1637)														maxAscent = ascent;
            													}
            												}
            											}
            											_hx_goto_112:;
            										}
HXDLIN(1637)										textIndex = placeIndex;
            									}
HXDLIN(1637)									{
HXLINE(1637)										{
HXLINE(1637)											if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1637)												ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1637)												descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            											}
            											else {
HXLINE(1637)												bool _hx_tmp;
HXDLIN(1637)												if (::hx::IsNotNull( font )) {
HXLINE(1637)													_hx_tmp = (font->unitsPerEM != 0);
            												}
            												else {
HXLINE(1637)													_hx_tmp = false;
            												}
HXDLIN(1637)												if (_hx_tmp) {
HXLINE(1637)													ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1637)													descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            												}
            												else {
HXLINE(1637)													ascent = ( (Float)(currentFormat->size) );
HXDLIN(1637)													descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            												}
            											}
HXDLIN(1637)											leading = ( (int)(currentFormat->leading) );
HXDLIN(1637)											heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1637)											if ((heightValue > maxHeightValue)) {
HXLINE(1637)												maxHeightValue = heightValue;
            											}
HXDLIN(1637)											if ((ascent > maxAscent)) {
HXLINE(1637)												maxAscent = ascent;
            											}
            										}
HXDLIN(1637)										int i1 = _gthis->layoutGroups->get_length();
HXDLIN(1637)										while(true){
HXLINE(1637)											i1 = (i1 - 1);
HXDLIN(1637)											if (!((i1 > -1))) {
HXLINE(1637)												goto _hx_goto_114;
            											}
HXDLIN(1637)											 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i1).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1637)											if ((lg->lineIndex < lineIndex)) {
HXLINE(1637)												goto _hx_goto_114;
            											}
HXDLIN(1637)											if ((lg->lineIndex > lineIndex)) {
HXLINE(1637)												continue;
            											}
HXDLIN(1637)											lg->ascent = maxAscent;
HXDLIN(1637)											lg->height = ( (Float)(maxHeightValue) );
            										}
            										_hx_goto_114:;
HXDLIN(1637)										offsetY = (offsetY + maxHeightValue);
HXDLIN(1637)										maxAscent = ((Float)0.0);
HXDLIN(1637)										maxHeightValue = 0;
HXDLIN(1637)										lineIndex = (lineIndex + 1);
HXDLIN(1637)										offsetX = ( (Float)(0) );
HXDLIN(1637)										firstLineOfParagraph = false;
            									}
HXDLIN(1637)									if ((placeIndex >= endIndex1)) {
HXLINE(1637)										positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1637)										widthValue = ( (Float)(0) );
            									}
            									else {
HXLINE(1637)										if ((endIndex1 <= formatRange->end)) {
HXLINE(1637)											::String text = _gthis->text;
HXDLIN(1637)											Float letterSpacing = ((Float)0.0);
HXDLIN(1637)											if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)												letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            											}
HXDLIN(1637)											if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)												_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)											_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)											if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)												_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)											bool positions1;
HXDLIN(1637)											if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)												positions1 = (_gthis->sharpness < 400);
            											}
            											else {
HXLINE(1637)												positions1 = true;
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1637)											 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)											_gthis1->set_text(text.substring(placeIndex,endIndex1));
HXDLIN(1637)											if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)												positions = _gthis->_hx___textLayout->get_positions();
            											}
            											else {
HXLINE(1637)												positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            											}
HXDLIN(1637)											Float width = ((Float)0.0);
HXDLIN(1637)											{
HXLINE(1637)												int _g = 0;
HXDLIN(1637)												while((_g < positions->length)){
HXLINE(1637)													 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)													_g = (_g + 1);
HXDLIN(1637)													width = (width + position->advance->x);
            												}
            											}
HXDLIN(1637)											widthValue = width;
            										}
            										else {
HXLINE(1637)											int tempIndex = placeIndex;
HXDLIN(1637)											int tempRangeEnd = formatRange->end;
HXDLIN(1637)											int countRanges = 0;
HXDLIN(1637)											positions = ::Array_obj< ::Dynamic>::__new(0);
HXDLIN(1637)											widthValue = ( (Float)(0) );
HXDLIN(1637)											while(true){
HXLINE(1637)												if ((tempIndex != tempRangeEnd)) {
HXLINE(1637)													::String text = _gthis->text;
HXDLIN(1637)													Float letterSpacing = ((Float)0.0);
HXDLIN(1637)													if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)														letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            													}
HXDLIN(1637)													if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)														_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            													}
HXDLIN(1637)													_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)													_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)													if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)														_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            													}
HXDLIN(1637)													_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)													bool _hx_tmp;
HXDLIN(1637)													if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)														_hx_tmp = (_gthis->sharpness < 400);
            													}
            													else {
HXLINE(1637)														_hx_tmp = true;
            													}
HXDLIN(1637)													_gthis->_hx___textLayout->autoHint = _hx_tmp;
HXDLIN(1637)													 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)													_gthis1->set_text(text.substring(tempIndex,tempRangeEnd));
HXDLIN(1637)													::Array< ::Dynamic> tempPositions;
HXDLIN(1637)													if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)														tempPositions = _gthis->_hx___textLayout->get_positions();
            													}
            													else {
HXLINE(1637)														tempPositions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            													}
HXDLIN(1637)													positions = positions->concat(tempPositions);
            												}
HXDLIN(1637)												if ((tempRangeEnd != endIndex1)) {
HXLINE(1637)													bool _hx_tmp;
HXDLIN(1637)													if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)														rangeIndex = (rangeIndex + 1);
HXDLIN(1637)														formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)														currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)														font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1637)														_hx_tmp = true;
            													}
            													else {
HXLINE(1637)														_hx_tmp = false;
            													}
HXDLIN(1637)													if (!(_hx_tmp)) {
HXLINE(1637)														::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1104,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1637)														goto _hx_goto_116;
            													}
HXDLIN(1637)													tempIndex = tempRangeEnd;
HXDLIN(1637)													if ((endIndex1 < formatRange->end)) {
HXLINE(1637)														tempRangeEnd = endIndex1;
            													}
            													else {
HXLINE(1637)														tempRangeEnd = formatRange->end;
            													}
HXDLIN(1637)													countRanges = (countRanges + 1);
            												}
            												else {
HXLINE(1637)													Float width = ((Float)0.0);
HXDLIN(1637)													{
HXLINE(1637)														int _g = 0;
HXDLIN(1637)														while((_g < positions->length)){
HXLINE(1637)															 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)															_g = (_g + 1);
HXDLIN(1637)															width = (width + position->advance->x);
            														}
            													}
HXDLIN(1637)													widthValue = width;
HXDLIN(1637)													goto _hx_goto_116;
            												}
            											}
            											_hx_goto_116:;
HXDLIN(1637)											rangeIndex = (rangeIndex - (countRanges + 1));
HXDLIN(1637)											if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)												rangeIndex = (rangeIndex + 1);
HXDLIN(1637)												formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)												currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)												font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            											}
            										}
            									}
HXDLIN(1637)									remainingPositions = positions;
HXDLIN(1637)									tempWidth = widthValue;
            								}
            								_hx_goto_102:;
            							}
HXDLIN(1637)							{
HXLINE(1637)								if ((endIndex1 <= formatRange->end)) {
HXLINE(1637)									::String text = _gthis->text;
HXDLIN(1637)									Float letterSpacing = ((Float)0.0);
HXDLIN(1637)									if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)										letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            									}
HXDLIN(1637)									if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)										_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            									}
HXDLIN(1637)									_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)									_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)									if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)										_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            									}
HXDLIN(1637)									_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)									bool positions1;
HXDLIN(1637)									if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)										positions1 = (_gthis->sharpness < 400);
            									}
            									else {
HXLINE(1637)										positions1 = true;
            									}
HXDLIN(1637)									_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1637)									 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)									_gthis1->set_text(text.substring(textIndex,endIndex1));
HXDLIN(1637)									if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)										positions = _gthis->_hx___textLayout->get_positions();
            									}
            									else {
HXLINE(1637)										positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            									}
HXDLIN(1637)									Float width = ((Float)0.0);
HXDLIN(1637)									{
HXLINE(1637)										int _g = 0;
HXDLIN(1637)										while((_g < positions->length)){
HXLINE(1637)											 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)											_g = (_g + 1);
HXDLIN(1637)											width = (width + position->advance->x);
            										}
            									}
HXDLIN(1637)									widthValue = width;
HXDLIN(1637)									bool _hx_tmp;
HXDLIN(1637)									if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1637)										_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            									}
            									else {
HXLINE(1637)										_hx_tmp = true;
            									}
HXDLIN(1637)									if (_hx_tmp) {
HXLINE(1637)										layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,endIndex1);
HXDLIN(1637)										_gthis->layoutGroups->push(layoutGroup);
            									}
            									else {
HXLINE(1637)										layoutGroup->format = formatRange->format;
HXDLIN(1637)										layoutGroup->startIndex = textIndex;
HXDLIN(1637)										layoutGroup->endIndex = endIndex1;
            									}
HXDLIN(1637)									layoutGroup->positions = positions;
HXDLIN(1637)									int _hx_tmp1;
HXDLIN(1637)									if (firstLineOfParagraph) {
HXLINE(1637)										_hx_tmp1 = indent;
            									}
            									else {
HXLINE(1637)										_hx_tmp1 = 0;
            									}
HXDLIN(1637)									layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1637)									layoutGroup->ascent = ascent;
HXDLIN(1637)									layoutGroup->descent = descent;
HXDLIN(1637)									layoutGroup->leading = leading;
HXDLIN(1637)									layoutGroup->lineIndex = lineIndex;
HXDLIN(1637)									layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1637)									layoutGroup->width = widthValue;
HXDLIN(1637)									layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1637)									offsetX = (offsetX + widthValue);
HXDLIN(1637)									if ((endIndex1 == formatRange->end)) {
HXLINE(1637)										layoutGroup = null();
HXDLIN(1637)										if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)											rangeIndex = (rangeIndex + 1);
HXDLIN(1637)											formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)											currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)											font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
            										}
HXDLIN(1637)										{
HXLINE(1637)											if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1637)												ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1637)												descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            											}
            											else {
HXLINE(1637)												bool _hx_tmp;
HXDLIN(1637)												if (::hx::IsNotNull( font )) {
HXLINE(1637)													_hx_tmp = (font->unitsPerEM != 0);
            												}
            												else {
HXLINE(1637)													_hx_tmp = false;
            												}
HXDLIN(1637)												if (_hx_tmp) {
HXLINE(1637)													ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1637)													descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            												}
            												else {
HXLINE(1637)													ascent = ( (Float)(currentFormat->size) );
HXDLIN(1637)													descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            												}
            											}
HXDLIN(1637)											leading = ( (int)(currentFormat->leading) );
HXDLIN(1637)											heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1637)											if ((heightValue > maxHeightValue)) {
HXLINE(1637)												maxHeightValue = heightValue;
            											}
HXDLIN(1637)											if ((ascent > maxAscent)) {
HXLINE(1637)												maxAscent = ascent;
            											}
            										}
            									}
            								}
            								else {
HXLINE(1637)									while(true){
HXLINE(1637)										int tempRangeEnd;
HXDLIN(1637)										if ((endIndex1 < formatRange->end)) {
HXLINE(1637)											tempRangeEnd = endIndex1;
            										}
            										else {
HXLINE(1637)											tempRangeEnd = formatRange->end;
            										}
HXDLIN(1637)										if ((textIndex != tempRangeEnd)) {
HXLINE(1637)											::String text = _gthis->text;
HXDLIN(1637)											Float letterSpacing = ((Float)0.0);
HXDLIN(1637)											if (::hx::IsNotNull( formatRange->format->letterSpacing )) {
HXLINE(1637)												letterSpacing = ( (Float)(formatRange->format->letterSpacing) );
            											}
HXDLIN(1637)											if (::hx::IsNull( _gthis->_hx___textLayout )) {
HXLINE(1637)												_gthis->_hx___textLayout =  ::openfl::text::_internal::TextLayout_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null(),null());
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->set_text(null());
HXDLIN(1637)											_gthis->_hx___textLayout->set_font(font);
HXDLIN(1637)											if (::hx::IsNotNull( formatRange->format->size )) {
HXLINE(1637)												_gthis->_hx___textLayout->set_size(( (int)(formatRange->format->size) ));
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->letterSpacing = letterSpacing;
HXDLIN(1637)											bool positions1;
HXDLIN(1637)											if (::hx::IsEq( _gthis->antiAliasType,0 )) {
HXLINE(1637)												positions1 = (_gthis->sharpness < 400);
            											}
            											else {
HXLINE(1637)												positions1 = true;
            											}
HXDLIN(1637)											_gthis->_hx___textLayout->autoHint = positions1;
HXDLIN(1637)											 ::openfl::text::_internal::TextLayout _gthis1 = _gthis->_hx___textLayout;
HXDLIN(1637)											_gthis1->set_text(text.substring(textIndex,tempRangeEnd));
HXDLIN(1637)											if (::hx::IsEq( currentFormat->align,2 )) {
HXLINE(1637)												positions = _gthis->_hx___textLayout->get_positions();
            											}
            											else {
HXLINE(1637)												positions = _gthis->_hx___shapeCache->cache(formatRange,_gthis->_hx___textLayout);
            											}
HXDLIN(1637)											Float width = ((Float)0.0);
HXDLIN(1637)											{
HXLINE(1637)												int _g = 0;
HXDLIN(1637)												while((_g < positions->length)){
HXLINE(1637)													 ::openfl::text::_internal::GlyphPosition position = positions->__get(_g).StaticCast<  ::openfl::text::_internal::GlyphPosition >();
HXDLIN(1637)													_g = (_g + 1);
HXDLIN(1637)													width = (width + position->advance->x);
            												}
            											}
HXDLIN(1637)											widthValue = width;
HXDLIN(1637)											bool _hx_tmp;
HXDLIN(1637)											if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1637)												_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            											}
            											else {
HXLINE(1637)												_hx_tmp = true;
            											}
HXDLIN(1637)											if (_hx_tmp) {
HXLINE(1637)												layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,textIndex,tempRangeEnd);
HXDLIN(1637)												_gthis->layoutGroups->push(layoutGroup);
            											}
            											else {
HXLINE(1637)												layoutGroup->format = formatRange->format;
HXDLIN(1637)												layoutGroup->startIndex = textIndex;
HXDLIN(1637)												layoutGroup->endIndex = tempRangeEnd;
            											}
HXDLIN(1637)											layoutGroup->positions = positions;
HXDLIN(1637)											int _hx_tmp1;
HXDLIN(1637)											if (firstLineOfParagraph) {
HXLINE(1637)												_hx_tmp1 = indent;
            											}
            											else {
HXLINE(1637)												_hx_tmp1 = 0;
            											}
HXDLIN(1637)											layoutGroup->offsetX = (offsetX + ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) ));
HXDLIN(1637)											layoutGroup->ascent = ascent;
HXDLIN(1637)											layoutGroup->descent = descent;
HXDLIN(1637)											layoutGroup->leading = leading;
HXDLIN(1637)											layoutGroup->lineIndex = lineIndex;
HXDLIN(1637)											layoutGroup->offsetY = (offsetY + 2);
HXDLIN(1637)											layoutGroup->width = widthValue;
HXDLIN(1637)											layoutGroup->height = ( (Float)(heightValue) );
HXDLIN(1637)											offsetX = (offsetX + widthValue);
HXDLIN(1637)											textIndex = tempRangeEnd;
            										}
HXDLIN(1637)										if ((tempRangeEnd == formatRange->end)) {
HXLINE(1637)											layoutGroup = null();
            										}
HXDLIN(1637)										if ((tempRangeEnd == endIndex1)) {
HXLINE(1637)											goto _hx_goto_119;
            										}
HXDLIN(1637)										bool _hx_tmp;
HXDLIN(1637)										if ((rangeIndex < (_gthis->textFormatRanges->get_length() - 1))) {
HXLINE(1637)											rangeIndex = (rangeIndex + 1);
HXDLIN(1637)											formatRange = _gthis->textFormatRanges->get(rangeIndex).StaticCast<  ::openfl::text::_internal::TextFormatRange >();
HXDLIN(1637)											currentFormat->_hx___merge(formatRange->format);
HXDLIN(1637)											font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(currentFormat);
HXDLIN(1637)											_hx_tmp = true;
            										}
            										else {
HXLINE(1637)											_hx_tmp = false;
            										}
HXDLIN(1637)										if (!(_hx_tmp)) {
HXLINE(1637)											::lime::utils::Log_obj::warn(HX_("You found a bug in OpenFL's text code! Please save a copy of your project and contact Joshua Granick (@singmajesty) so we can fix this.",08,e2,e2,42),::hx::SourceInfo(HX_("openfl/text/_internal/TextEngine.hx",39,18,5e,b8),1192,HX_("openfl.text._internal.TextEngine",04,88,80,7e),HX_("getLayoutGroups",54,f8,56,5a)));
HXDLIN(1637)											goto _hx_goto_119;
            										}
HXDLIN(1637)										{
HXLINE(1637)											if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1637)												ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1637)												descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            											}
            											else {
HXLINE(1637)												bool _hx_tmp;
HXDLIN(1637)												if (::hx::IsNotNull( font )) {
HXLINE(1637)													_hx_tmp = (font->unitsPerEM != 0);
            												}
            												else {
HXLINE(1637)													_hx_tmp = false;
            												}
HXDLIN(1637)												if (_hx_tmp) {
HXLINE(1637)													ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1637)													descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            												}
            												else {
HXLINE(1637)													ascent = ( (Float)(currentFormat->size) );
HXDLIN(1637)													descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            												}
            											}
HXDLIN(1637)											leading = ( (int)(currentFormat->leading) );
HXDLIN(1637)											heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1637)											if ((heightValue > maxHeightValue)) {
HXLINE(1637)												maxHeightValue = heightValue;
            											}
HXDLIN(1637)											if ((ascent > maxAscent)) {
HXLINE(1637)												maxAscent = ascent;
            											}
            										}
            									}
            									_hx_goto_119:;
            								}
HXDLIN(1637)								textIndex = endIndex1;
            							}
            						}
HXLINE(1639)						{
HXLINE(1639)							{
HXLINE(1639)								if (::hx::IsNotNull( currentFormat->_hx___ascent )) {
HXLINE(1639)									ascent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___ascent) ));
HXDLIN(1639)									descent = (( (Float)(currentFormat->size) ) * ( (Float)(currentFormat->_hx___descent) ));
            								}
            								else {
HXLINE(1639)									bool _hx_tmp;
HXDLIN(1639)									if (::hx::IsNotNull( font )) {
HXLINE(1639)										_hx_tmp = (font->unitsPerEM != 0);
            									}
            									else {
HXLINE(1639)										_hx_tmp = false;
            									}
HXDLIN(1639)									if (_hx_tmp) {
HXLINE(1639)										ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) ));
HXDLIN(1639)										descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(currentFormat->size) )));
            									}
            									else {
HXLINE(1639)										ascent = ( (Float)(currentFormat->size) );
HXDLIN(1639)										descent = (( (Float)(currentFormat->size) ) * ((Float)0.185));
            									}
            								}
HXDLIN(1639)								leading = ( (int)(currentFormat->leading) );
HXDLIN(1639)								heightValue = ::Math_obj::ceil(((ascent + descent) + leading));
HXDLIN(1639)								if ((heightValue > maxHeightValue)) {
HXLINE(1639)									maxHeightValue = heightValue;
            								}
HXDLIN(1639)								if ((ascent > maxAscent)) {
HXLINE(1639)									maxAscent = ascent;
            								}
            							}
HXDLIN(1639)							int i = _gthis->layoutGroups->get_length();
HXDLIN(1639)							while(true){
HXLINE(1639)								i = (i - 1);
HXDLIN(1639)								if (!((i > -1))) {
HXLINE(1639)									goto _hx_goto_121;
            								}
HXDLIN(1639)								 ::openfl::text::_internal::TextLayoutGroup lg = _gthis->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1639)								if ((lg->lineIndex < lineIndex)) {
HXLINE(1639)									goto _hx_goto_121;
            								}
HXDLIN(1639)								if ((lg->lineIndex > lineIndex)) {
HXLINE(1639)									continue;
            								}
HXDLIN(1639)								lg->ascent = maxAscent;
HXDLIN(1639)								lg->height = ( (Float)(maxHeightValue) );
            							}
            							_hx_goto_121:;
HXDLIN(1639)							offsetY = (offsetY + maxHeightValue);
HXDLIN(1639)							maxAscent = ((Float)0.0);
HXDLIN(1639)							maxHeightValue = 0;
HXDLIN(1639)							lineIndex = (lineIndex + 1);
HXDLIN(1639)							offsetX = ( (Float)(0) );
HXDLIN(1639)							firstLineOfParagraph = false;
            						}
            					}
HXLINE(1642)					textIndex = (textIndex + 1);
            				}
            			}
            		}
HXLINE(1647)		bool _hx_tmp3;
HXDLIN(1647)		if ((previousBreakIndex == (textIndex - 2))) {
HXLINE(1647)			_hx_tmp3 = (previousBreakIndex > -1);
            		}
            		else {
HXLINE(1647)			_hx_tmp3 = false;
            		}
HXDLIN(1647)		if (_hx_tmp3) {
HXLINE(1649)			{
HXLINE(1649)				int startIndex = (textIndex - 1);
HXDLIN(1649)				int endIndex = (textIndex - 1);
HXDLIN(1649)				bool _hx_tmp;
HXDLIN(1649)				if (::hx::IsNotNull( layoutGroup )) {
HXLINE(1649)					_hx_tmp = (layoutGroup->startIndex != layoutGroup->endIndex);
            				}
            				else {
HXLINE(1649)					_hx_tmp = true;
            				}
HXDLIN(1649)				if (_hx_tmp) {
HXLINE(1649)					layoutGroup =  ::openfl::text::_internal::TextLayoutGroup_obj::__alloc( HX_CTX ,formatRange->format,startIndex,endIndex);
HXDLIN(1649)					_gthis->layoutGroups->push(layoutGroup);
            				}
            				else {
HXLINE(1649)					layoutGroup->format = formatRange->format;
HXDLIN(1649)					layoutGroup->startIndex = startIndex;
HXDLIN(1649)					layoutGroup->endIndex = endIndex;
            				}
            			}
HXLINE(1651)			layoutGroup->positions = ::Array_obj< ::Dynamic>::__new(0);
HXLINE(1652)			layoutGroup->ascent = ascent;
HXLINE(1653)			layoutGroup->descent = descent;
HXLINE(1654)			layoutGroup->leading = leading;
HXLINE(1655)			layoutGroup->lineIndex = lineIndex;
HXLINE(1656)			int _hx_tmp1;
HXDLIN(1656)			if (firstLineOfParagraph) {
HXLINE(1656)				_hx_tmp1 = indent;
            			}
            			else {
HXLINE(1656)				_hx_tmp1 = 0;
            			}
HXDLIN(1656)			layoutGroup->offsetX = ( (Float)((((2 + leftMargin) + blockIndent) + _hx_tmp1)) );
HXLINE(1657)			layoutGroup->offsetY = (offsetY + 2);
HXLINE(1658)			layoutGroup->width = ( (Float)(0) );
HXLINE(1659)			layoutGroup->height = ( (Float)(heightValue) );
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,getLayoutGroups,(void))

::String TextEngine_obj::restrictText(::String value){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1683_restrictText)
HXLINE(1684)		if (::hx::IsNull( value )) {
HXLINE(1686)			return value;
            		}
HXLINE(1689)		if (::hx::IsNotNull( this->_hx___restrictRegexp )) {
HXLINE(1691)			value = this->_hx___restrictRegexp->split(value)->join(HX_("",00,00,00,00));
            		}
HXLINE(1700)		return value;
            	}


HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,restrictText,return )

void TextEngine_obj::setTextAlignment(){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1704_setTextAlignment)
HXLINE(1705)		int lineIndex = -1;
HXLINE(1706)		Float offsetX = ((Float)0.0);
HXLINE(1707)		Float totalWidth = (this->width - ( (Float)(4) ));
HXLINE(1708)		 ::openfl::text::_internal::TextLayoutGroup group;
HXDLIN(1708)		int lineLength;
HXLINE(1709)		bool lineMeasurementsDirty = false;
HXLINE(1711)		{
HXLINE(1711)			int _g = 0;
HXDLIN(1711)			int _g1 = this->layoutGroups->get_length();
HXDLIN(1711)			while((_g < _g1)){
HXLINE(1711)				_g = (_g + 1);
HXDLIN(1711)				int i = (_g - 1);
HXLINE(1713)				group = this->layoutGroups->get(i).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXLINE(1715)				if ((group->lineIndex != lineIndex)) {
HXLINE(1717)					lineIndex = group->lineIndex;
HXLINE(1718)					totalWidth = ((this->width - ( (Float)(4) )) - ( (Float)(group->format->rightMargin) ));
HXLINE(1720)					 ::Dynamic _hx_switch_0 = group->format->align;
            					if (  (_hx_switch_0==0) ){
HXLINE(1723)						if ((this->lineWidths->get(lineIndex) < totalWidth)) {
HXLINE(1725)							offsetX = ( (Float)(::Math_obj::round(((totalWidth - this->lineWidths->get(lineIndex)) / ( (Float)(2) )))) );
            						}
            						else {
HXLINE(1729)							offsetX = ( (Float)(0) );
            						}
HXLINE(1723)						goto _hx_goto_125;
            					}
            					if (  (_hx_switch_0==2) ){
HXLINE(1743)						if ((this->lineWidths->get(lineIndex) < totalWidth)) {
HXLINE(1745)							lineLength = 1;
HXLINE(1747)							{
HXLINE(1747)								int _g = (i + 1);
HXDLIN(1747)								int _g1 = this->layoutGroups->get_length();
HXDLIN(1747)								while((_g < _g1)){
HXLINE(1747)									_g = (_g + 1);
HXDLIN(1747)									int j = (_g - 1);
HXLINE(1749)									if ((this->layoutGroups->get(j).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >()->lineIndex == lineIndex)) {
HXLINE(1751)										bool _hx_tmp;
HXDLIN(1751)										if ((j != 0)) {
HXLINE(1751)											::String _hx_tmp1 = this->text;
HXDLIN(1751)											_hx_tmp = ::hx::IsEq( _hx_tmp1.charCodeAt((this->layoutGroups->get(j).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >()->startIndex - 1)),32 );
            										}
            										else {
HXLINE(1751)											_hx_tmp = true;
            										}
HXDLIN(1751)										if (_hx_tmp) {
HXLINE(1753)											lineLength = (lineLength + 1);
            										}
            									}
            									else {
HXLINE(1758)										goto _hx_goto_126;
            									}
            								}
            								_hx_goto_126:;
            							}
HXLINE(1762)							if ((lineLength > 1)) {
HXLINE(1764)								group = this->layoutGroups->get(((i + lineLength) - 1)).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXLINE(1766)								 ::Dynamic endChar = this->text.charCodeAt(group->endIndex);
HXLINE(1767)								bool _hx_tmp;
HXDLIN(1767)								bool _hx_tmp1;
HXDLIN(1767)								if ((group->endIndex < this->text.length)) {
HXLINE(1767)									_hx_tmp1 = ::hx::IsNotEq( endChar,10 );
            								}
            								else {
HXLINE(1767)									_hx_tmp1 = false;
            								}
HXDLIN(1767)								if (_hx_tmp1) {
HXLINE(1767)									_hx_tmp = ::hx::IsNotEq( endChar,13 );
            								}
            								else {
HXLINE(1767)									_hx_tmp = false;
            								}
HXDLIN(1767)								if (_hx_tmp) {
HXLINE(1769)									offsetX = ((totalWidth - this->lineWidths->get(lineIndex)) / ( (Float)((lineLength - 1)) ));
HXLINE(1770)									lineMeasurementsDirty = true;
HXLINE(1772)									int j = 1;
HXLINE(1773)									while(true){
HXLINE(1782)										 ::openfl::text::_internal::TextLayoutGroup fh = this->layoutGroups->get((i + j)).StaticCast<  ::openfl::text::_internal::TextLayoutGroup >();
HXDLIN(1782)										fh->offsetX = (fh->offsetX + (offsetX * ( (Float)(j) )));
HXLINE(1784)										j = (j + 1);
HXLINE(1773)										if (!((j < lineLength))) {
HXLINE(1773)											goto _hx_goto_127;
            										}
            									}
            									_hx_goto_127:;
            								}
            							}
            						}
HXLINE(1789)						offsetX = ( (Float)(0) );
HXLINE(1742)						goto _hx_goto_125;
            					}
            					if (  (_hx_switch_0==4) ){
HXLINE(1733)						if ((this->lineWidths->get(lineIndex) < totalWidth)) {
HXLINE(1735)							offsetX = ( (Float)(::Math_obj::round((totalWidth - this->lineWidths->get(lineIndex)))) );
            						}
            						else {
HXLINE(1739)							offsetX = ( (Float)(0) );
            						}
HXLINE(1733)						goto _hx_goto_125;
            					}
            					/* default */{
HXLINE(1792)						offsetX = ( (Float)(0) );
            					}
            					_hx_goto_125:;
            				}
HXLINE(1796)				if ((offsetX > 0)) {
HXLINE(1798)					 ::openfl::text::_internal::TextLayoutGroup group1 = group;
HXDLIN(1798)					group1->offsetX = (group1->offsetX + offsetX);
            				}
            			}
            		}
HXLINE(1802)		if (lineMeasurementsDirty) {
HXLINE(1806)			this->getLineMeasurements();
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,setTextAlignment,(void))

::String TextEngine_obj::trimText(::String value){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1811_trimText)
HXLINE(1812)		if (::hx::IsNull( value )) {
HXLINE(1814)			return value;
            		}
HXLINE(1817)		bool _hx_tmp;
HXDLIN(1817)		if ((this->maxChars > 0)) {
HXLINE(1817)			_hx_tmp = (value.length > this->maxChars);
            		}
            		else {
HXLINE(1817)			_hx_tmp = false;
            		}
HXDLIN(1817)		if (_hx_tmp) {
HXLINE(1819)			value = value.substr(0,this->maxChars);
            		}
HXLINE(1822)		return value;
            	}


HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,trimText,return )

void TextEngine_obj::update(){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1826_update)
HXLINE(1827)		bool _hx_tmp;
HXDLIN(1827)		if (::hx::IsNotNull( this->text )) {
HXLINE(1827)			_hx_tmp = (this->textFormatRanges->get_length() == 0);
            		}
            		else {
HXLINE(1827)			_hx_tmp = true;
            		}
HXDLIN(1827)		if (_hx_tmp) {
HXLINE(1829)			this->lineAscents->set_length(0);
HXLINE(1830)			this->lineBreaks->set_length(0);
HXLINE(1831)			this->lineDescents->set_length(0);
HXLINE(1832)			this->lineLeadings->set_length(0);
HXLINE(1833)			this->lineHeights->set_length(0);
HXLINE(1834)			this->lineWidths->set_length(0);
HXLINE(1835)			this->layoutGroups->set_length(0);
HXLINE(1837)			this->textWidth = ( (Float)(0) );
HXLINE(1838)			this->textHeight = ( (Float)(0) );
HXLINE(1839)			this->numLines = 1;
HXLINE(1840)			this->maxScrollH = 0;
HXLINE(1841)			this->maxScrollV = 1;
HXLINE(1842)			this->bottomScrollV = 1;
            		}
            		else {
HXLINE(1846)			this->getLineBreaks();
HXLINE(1847)			this->getLayoutGroups();
HXLINE(1848)			this->getLineMeasurements();
HXLINE(1849)			this->setTextAlignment();
            		}
HXLINE(1852)		this->getBounds();
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,update,(void))

int TextEngine_obj::get_bottomScrollV(){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1859_get_bottomScrollV)
HXDLIN(1859)		bool _hx_tmp;
HXDLIN(1859)		if ((this->numLines != 1)) {
HXDLIN(1859)			_hx_tmp = ::hx::IsNull( this->lineHeights );
            		}
            		else {
HXDLIN(1859)			_hx_tmp = true;
            		}
HXDLIN(1859)		if (_hx_tmp) {
HXLINE(1861)			return 1;
            		}
            		else {
HXLINE(1865)			int ret = this->lineHeights->get_length();
HXLINE(1867)			Float tempHeight;
HXDLIN(1867)			if ((this->lineLeadings->get_length() == ret)) {
HXLINE(1867)				tempHeight = -(this->lineLeadings->get((ret - 1)));
            			}
            			else {
HXLINE(1867)				tempHeight = ((Float)0.0);
            			}
HXLINE(1869)			{
HXLINE(1869)				int _g;
HXDLIN(1869)				if ((this->get_scrollV() > 0)) {
HXLINE(1869)					_g = this->get_scrollV();
            				}
            				else {
HXLINE(1869)					_g = 1;
            				}
HXDLIN(1869)				int _g1 = (_g - 1);
HXDLIN(1869)				int _g2 = this->lineHeights->get_length();
HXDLIN(1869)				while((_g1 < _g2)){
HXLINE(1869)					_g1 = (_g1 + 1);
HXDLIN(1869)					int i = (_g1 - 1);
HXLINE(1871)					Float lineHeight = this->lineHeights->get(i);
HXLINE(1873)					tempHeight = (tempHeight + lineHeight);
HXLINE(1875)					if ((tempHeight > (this->height - ( (Float)(4) )))) {
HXLINE(1877)						int ret1;
HXDLIN(1877)						if (((tempHeight - this->height) >= 0)) {
HXLINE(1877)							ret1 = 0;
            						}
            						else {
HXLINE(1877)							ret1 = 1;
            						}
HXDLIN(1877)						ret = (i + ret1);
HXLINE(1878)						goto _hx_goto_131;
            					}
            				}
            				_hx_goto_131:;
            			}
HXLINE(1893)			if ((ret < this->get_scrollV())) {
HXLINE(1893)				return this->get_scrollV();
            			}
HXLINE(1899)			return ret;
            		}
HXLINE(1859)		return 0;
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,get_bottomScrollV,return )

int TextEngine_obj::get_maxScrollV(){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1906_get_maxScrollV)
HXDLIN(1906)		bool _hx_tmp;
HXDLIN(1906)		if ((this->numLines != 1)) {
HXDLIN(1906)			_hx_tmp = ::hx::IsNull( this->lineHeights );
            		}
            		else {
HXDLIN(1906)			_hx_tmp = true;
            		}
HXDLIN(1906)		if (_hx_tmp) {
HXLINE(1908)			return 1;
            		}
            		else {
HXLINE(1912)			int i = (this->numLines - 1);
HXDLIN(1912)			Float tempHeight = ((Float)0.0);
HXLINE(1913)			int j = i;
HXLINE(1916)			while((i >= 0)){
HXLINE(1918)				tempHeight = (tempHeight + this->lineHeights->get(i));
HXLINE(1920)				if ((tempHeight > (this->height - ( (Float)(4) )))) {
HXLINE(1922)					int i1;
HXDLIN(1922)					if (((tempHeight - this->height) < 0)) {
HXLINE(1922)						i1 = 1;
            					}
            					else {
HXLINE(1922)						i1 = 2;
            					}
HXDLIN(1922)					i = (i + i1);
HXLINE(1923)					goto _hx_goto_133;
            				}
HXLINE(1925)				i = (i - 1);
            			}
            			_hx_goto_133:;
HXLINE(1941)			if ((i < 1)) {
HXLINE(1941)				return 1;
            			}
HXLINE(1942)			return i;
            		}
HXLINE(1906)		return 0;
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,get_maxScrollV,return )

::String TextEngine_obj::set_restrict(::String value){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1947_set_restrict)
HXLINE(1948)		if ((this->restrict == value)) {
HXLINE(1950)			return this->restrict;
            		}
HXLINE(1953)		this->restrict = value;
HXLINE(1955)		bool _hx_tmp;
HXDLIN(1955)		if (::hx::IsNotNull( this->restrict )) {
HXLINE(1955)			_hx_tmp = (this->restrict.length == 0);
            		}
            		else {
HXLINE(1955)			_hx_tmp = true;
            		}
HXDLIN(1955)		if (_hx_tmp) {
HXLINE(1957)			this->_hx___restrictRegexp = null();
            		}
            		else {
HXLINE(1961)			this->_hx___restrictRegexp = this->createRestrictRegexp(value);
            		}
HXLINE(1964)		return this->restrict;
            	}


HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,set_restrict,return )

int TextEngine_obj::get_scrollV(){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1968_get_scrollV)
HXLINE(1969)		bool _hx_tmp;
HXDLIN(1969)		if ((this->numLines != 1)) {
HXLINE(1969)			_hx_tmp = ::hx::IsNull( this->lineHeights );
            		}
            		else {
HXLINE(1969)			_hx_tmp = true;
            		}
HXDLIN(1969)		if (_hx_tmp) {
HXLINE(1969)			return 1;
            		}
HXLINE(1971)		int max = this->get_maxScrollV();
HXLINE(1974)		if ((this->scrollV > max)) {
HXLINE(1974)			return max;
            		}
HXLINE(1976)		return this->scrollV;
            	}


HX_DEFINE_DYNAMIC_FUNC0(TextEngine_obj,get_scrollV,return )

int TextEngine_obj::set_scrollV(int value){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1980_set_scrollV)
HXLINE(1981)		if ((value < 1)) {
HXLINE(1981)			value = 1;
            		}
            		else {
HXLINE(1982)			if ((value > this->get_maxScrollV())) {
HXLINE(1982)				value = this->get_maxScrollV();
            			}
            		}
HXLINE(1984)		return (this->scrollV = value);
            	}


HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,set_scrollV,return )

::String TextEngine_obj::set_text(::String value){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_1989_set_text)
HXDLIN(1989)		return (this->text = value);
            	}


HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,set_text,return )

int TextEngine_obj::GUTTER;

int TextEngine_obj::UTF8_TAB;

int TextEngine_obj::UTF8_ENDLINE;

int TextEngine_obj::UTF8_SPACE;

int TextEngine_obj::UTF8_HYPHEN;

 ::haxe::ds::StringMap TextEngine_obj::_hx___defaultFonts;

 ::openfl::text::Font TextEngine_obj::findFont(::String name){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_202_findFont)
HXLINE( 206)		{
HXLINE( 206)			int _g = 0;
HXDLIN( 206)			::Array< ::Dynamic> _g1 = ::openfl::text::Font_obj::_hx___registeredFonts;
HXDLIN( 206)			while((_g < _g1->length)){
HXLINE( 206)				 ::openfl::text::Font registeredFont = _g1->__get(_g).StaticCast<  ::openfl::text::Font >();
HXDLIN( 206)				_g = (_g + 1);
HXLINE( 208)				if (::hx::IsNull( registeredFont )) {
HXLINE( 208)					continue;
            				}
HXLINE( 210)				bool _hx_tmp;
HXDLIN( 210)				if ((registeredFont->name != name)) {
HXLINE( 211)					if (::hx::IsNotNull( registeredFont->_hx___fontPath )) {
HXLINE( 212)						if ((registeredFont->_hx___fontPath != name)) {
HXLINE( 210)							_hx_tmp = (registeredFont->_hx___fontPathWithoutDirectory == name);
            						}
            						else {
HXLINE( 210)							_hx_tmp = true;
            						}
            					}
            					else {
HXLINE( 210)						_hx_tmp = false;
            					}
            				}
            				else {
HXLINE( 210)					_hx_tmp = true;
            				}
HXDLIN( 210)				if (_hx_tmp) {
HXLINE( 214)					if (registeredFont->_hx___initialize()) {
HXLINE( 216)						return registeredFont;
            					}
            				}
            			}
            		}
HXLINE( 225)		 ::openfl::text::Font font = ::openfl::text::Font_obj::fromFile(name);
HXLINE( 227)		if (::hx::IsNotNull( font )) {
HXLINE( 229)			::openfl::text::Font_obj::_hx___registeredFonts->push(font);
HXLINE( 230)			::openfl::text::Font_obj::_hx___fontByName->set(font->name,font);
HXLINE( 231)			return font;
            		}
HXLINE( 235)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,findFont,return )

 ::openfl::text::Font TextEngine_obj::findFontVariant( ::openfl::text::TextFormat format){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_239_findFontVariant)
HXLINE( 240)		::String fontName = format->font;
HXLINE( 241)		 ::Dynamic bold = format->bold;
HXLINE( 242)		 ::Dynamic italic = format->italic;
HXLINE( 244)		if (::hx::IsNull( fontName )) {
HXLINE( 244)			fontName = HX_("_serif",be,66,15,76);
            		}
HXLINE( 245)		::String fontNamePrefix = ::StringTools_obj::replace(::StringTools_obj::replace(fontName,HX_(" Normal",67,be,ac,97),HX_("",00,00,00,00)),HX_(" Regular",1c,be,27,76),HX_("",00,00,00,00));
HXLINE( 247)		bool _hx_tmp;
HXDLIN( 247)		bool _hx_tmp1;
HXDLIN( 247)		if (( (bool)(bold) )) {
HXLINE( 247)			_hx_tmp1 = ( (bool)(italic) );
            		}
            		else {
HXLINE( 247)			_hx_tmp1 = false;
            		}
HXDLIN( 247)		if (_hx_tmp1) {
HXLINE( 247)			_hx_tmp = ::openfl::text::Font_obj::_hx___fontByName->exists((fontNamePrefix + HX_(" Bold Italic",0b,b0,c3,94)));
            		}
            		else {
HXLINE( 247)			_hx_tmp = false;
            		}
HXDLIN( 247)		if (_hx_tmp) {
HXLINE( 249)			return ::openfl::text::_internal::TextEngine_obj::findFont((fontNamePrefix + HX_(" Bold Italic",0b,b0,c3,94)));
            		}
            		else {
HXLINE( 251)			bool _hx_tmp;
HXDLIN( 251)			if (( (bool)(bold) )) {
HXLINE( 251)				_hx_tmp = ::openfl::text::Font_obj::_hx___fontByName->exists((fontNamePrefix + HX_(" Bold",c5,3d,c7,98)));
            			}
            			else {
HXLINE( 251)				_hx_tmp = false;
            			}
HXDLIN( 251)			if (_hx_tmp) {
HXLINE( 253)				return ::openfl::text::_internal::TextEngine_obj::findFont((fontNamePrefix + HX_(" Bold",c5,3d,c7,98)));
            			}
            			else {
HXLINE( 255)				bool _hx_tmp;
HXDLIN( 255)				if (( (bool)(italic) )) {
HXLINE( 255)					_hx_tmp = ::openfl::text::Font_obj::_hx___fontByName->exists((fontNamePrefix + HX_(" Italic",30,7b,a7,6d)));
            				}
            				else {
HXLINE( 255)					_hx_tmp = false;
            				}
HXDLIN( 255)				if (_hx_tmp) {
HXLINE( 257)					return ::openfl::text::_internal::TextEngine_obj::findFont((fontNamePrefix + HX_(" Italic",30,7b,a7,6d)));
            				}
            			}
            		}
HXLINE( 260)		return ::openfl::text::_internal::TextEngine_obj::findFont(fontName);
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,findFontVariant,return )

 ::openfl::text::Font TextEngine_obj::getDefaultFont(::String name,bool bold,bool italic){
            	HX_GC_STACKFRAME(&_hx_pos_81873a2f4b2980c0_296_getDefaultFont)
HXLINE( 297)		if (::hx::IsNull( ::openfl::text::_internal::TextEngine_obj::_hx___defaultFonts )) {
            			HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_0) HXARGC(1)
            			 ::openfl::text::Font _hx_run(::Array< ::String > list){
            				HX_GC_STACKFRAME(&_hx_pos_81873a2f4b2980c0_305_getDefaultFont)
HXLINE( 306)				 ::openfl::text::Font font = null();
HXLINE( 307)				{
HXLINE( 307)					int _g = 0;
HXDLIN( 307)					while((_g < list->length)){
HXLINE( 307)						::String path = list->__get(_g);
HXDLIN( 307)						_g = (_g + 1);
HXLINE( 309)						font = ::openfl::text::_internal::TextEngine_obj::findFont(path);
HXLINE( 310)						if (::hx::IsNotNull( font )) {
HXLINE( 310)							goto _hx_goto_142;
            						}
            					}
            					_hx_goto_142:;
            				}
HXLINE( 312)				return font;
            			}
            			HX_END_LOCAL_FUNC1(return)

HXLINE( 299)			::openfl::text::_internal::TextEngine_obj::_hx___defaultFonts =  ::haxe::ds::StringMap_obj::__alloc( HX_CTX );
HXLINE( 302)			::String systemFontDirectory = ::lime::_hx_system::System_obj::get_fontsDirectory();
HXLINE( 304)			 ::Dynamic processFontList =  ::Dynamic(new _hx_Closure_0());
HXLINE( 316)			{
HXLINE( 316)				::Dynamic this1 = ::openfl::text::_internal::TextEngine_obj::_hx___defaultFonts;
HXLINE( 317)				 ::openfl::text::Font value = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/arial.ttf",2c,34,8e,d8)));
HXDLIN( 317)				 ::openfl::text::Font value1 = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/arialbd.ttf",ee,27,90,25)));
HXLINE( 318)				 ::openfl::text::Font value2 = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/ariali.ttf",2d,c9,3e,6e)));
HXLINE( 316)				( ( ::haxe::ds::StringMap)(this1) )->set(HX_("_sans",32,a0,5e,ff), ::openfl::text::_internal::_TextEngine::DefaultFontSet_obj::__alloc( HX_CTX ,value,value1,value2,::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/arialbi.ttf",73,0e,91,06)))));
            			}
HXLINE( 320)			{
HXLINE( 320)				::Dynamic this2 = ::openfl::text::_internal::TextEngine_obj::_hx___defaultFonts;
HXLINE( 321)				 ::openfl::text::Font value3 = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/times.ttf",2f,58,44,c5)));
HXDLIN( 321)				 ::openfl::text::Font value4 = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/timesbd.ttf",b1,92,19,47)));
HXLINE( 322)				 ::openfl::text::Font value5 = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/timesi.ttf",ca,27,e8,a0)));
HXLINE( 320)				( ( ::haxe::ds::StringMap)(this2) )->set(HX_("_serif",be,66,15,76), ::openfl::text::_internal::_TextEngine::DefaultFontSet_obj::__alloc( HX_CTX ,value3,value4,value5,::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/timesbi.ttf",36,79,1a,28)))));
            			}
HXLINE( 324)			{
HXLINE( 324)				::Dynamic this3 = ::openfl::text::_internal::TextEngine_obj::_hx___defaultFonts;
HXLINE( 325)				 ::openfl::text::Font value6 = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/cour.ttf",30,7b,d2,6a)));
HXDLIN( 325)				 ::openfl::text::Font value7 = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/courbd.ttf",f2,37,b7,06)));
HXLINE( 326)				 ::openfl::text::Font value8 = ::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/couri.ttf",a9,a5,b8,d7)));
HXLINE( 324)				( ( ::haxe::ds::StringMap)(this3) )->set(HX_("_typewriter",0c,5e,52,94), ::openfl::text::_internal::_TextEngine::DefaultFontSet_obj::__alloc( HX_CTX ,value6,value7,value8,::openfl::text::_internal::TextEngine_obj::findFont((systemFontDirectory + HX_("/courbi.ttf",77,1e,b8,e7)))));
            			}
            		}
HXLINE( 418)		 ::openfl::text::_internal::_TextEngine::DefaultFontSet fontSet = ( ( ::openfl::text::_internal::_TextEngine::DefaultFontSet)(::openfl::text::_internal::TextEngine_obj::_hx___defaultFonts->get(name)) );
HXLINE( 419)		if (::hx::IsNull( fontSet )) {
HXLINE( 419)			return null();
            		}
HXLINE( 421)		bool _hx_tmp;
HXDLIN( 421)		bool _hx_tmp1;
HXDLIN( 421)		if (bold) {
HXLINE( 421)			_hx_tmp1 = italic;
            		}
            		else {
HXLINE( 421)			_hx_tmp1 = false;
            		}
HXDLIN( 421)		if (_hx_tmp1) {
HXLINE( 421)			_hx_tmp = ::hx::IsNotNull( fontSet->boldItalic );
            		}
            		else {
HXLINE( 421)			_hx_tmp = false;
            		}
HXDLIN( 421)		if (_hx_tmp) {
HXLINE( 421)			return fontSet->boldItalic;
            		}
            		else {
HXLINE( 421)			bool _hx_tmp;
HXDLIN( 421)			if (italic) {
HXLINE( 421)				_hx_tmp = ::hx::IsNotNull( fontSet->italic );
            			}
            			else {
HXLINE( 421)				_hx_tmp = false;
            			}
HXDLIN( 421)			if (_hx_tmp) {
HXLINE( 421)				return fontSet->italic;
            			}
            			else {
HXLINE( 421)				bool _hx_tmp;
HXDLIN( 421)				if (bold) {
HXLINE( 421)					_hx_tmp = ::hx::IsNotNull( fontSet->bold );
            				}
            				else {
HXLINE( 421)					_hx_tmp = false;
            				}
HXDLIN( 421)				if (_hx_tmp) {
HXLINE( 421)					return fontSet->bold;
            				}
            				else {
HXLINE( 421)					return fontSet->normal;
            				}
            			}
            		}
HXDLIN( 421)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(TextEngine_obj,getDefaultFont,return )

Float TextEngine_obj::getFormatHeight( ::openfl::text::TextFormat format){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_425_getFormatHeight)
HXLINE( 426)		Float ascent;
HXDLIN( 426)		Float descent;
HXLINE( 436)		 ::openfl::text::Font font = ::openfl::text::_internal::TextEngine_obj::getFontInstance(format);
HXLINE( 438)		if (::hx::IsNotNull( format->_hx___ascent )) {
HXLINE( 440)			ascent = (( (Float)(format->size) ) * ( (Float)(format->_hx___ascent) ));
HXLINE( 441)			descent = (( (Float)(format->size) ) * ( (Float)(format->_hx___descent) ));
            		}
            		else {
HXLINE( 443)			bool _hx_tmp;
HXDLIN( 443)			if (::hx::IsNotNull( font )) {
HXLINE( 443)				_hx_tmp = (font->unitsPerEM != 0);
            			}
            			else {
HXLINE( 443)				_hx_tmp = false;
            			}
HXDLIN( 443)			if (_hx_tmp) {
HXLINE( 446)				ascent = ((( (Float)(font->ascender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(format->size) ));
HXLINE( 447)				descent = ::Math_obj::abs(((( (Float)(font->descender) ) / ( (Float)(font->unitsPerEM) )) * ( (Float)(format->size) )));
            			}
            			else {
HXLINE( 455)				ascent = ( (Float)(format->size) );
HXLINE( 456)				descent = (( (Float)(format->size) ) * ((Float)0.185));
            			}
            		}
HXLINE( 426)		int leading = ( (int)(format->leading) );
HXLINE( 461)		return ((ascent + descent) + leading);
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,getFormatHeight,return )

::String TextEngine_obj::getFont( ::openfl::text::TextFormat format){
            	HX_GC_STACKFRAME(&_hx_pos_81873a2f4b2980c0_465_getFont)
HXLINE( 466)		::String fontName = format->font;
HXLINE( 467)		 ::Dynamic bold = format->bold;
HXLINE( 468)		 ::Dynamic italic = format->italic;
HXLINE( 470)		if (::hx::IsNull( fontName )) {
HXLINE( 470)			fontName = HX_("_serif",be,66,15,76);
            		}
HXLINE( 471)		::String fontNamePrefix = ::StringTools_obj::replace(::StringTools_obj::replace(fontName,HX_(" Normal",67,be,ac,97),HX_("",00,00,00,00)),HX_(" Regular",1c,be,27,76),HX_("",00,00,00,00));
HXLINE( 473)		bool _hx_tmp;
HXDLIN( 473)		bool _hx_tmp1;
HXDLIN( 473)		if (( (bool)(bold) )) {
HXLINE( 473)			_hx_tmp1 = ( (bool)(italic) );
            		}
            		else {
HXLINE( 473)			_hx_tmp1 = false;
            		}
HXDLIN( 473)		if (_hx_tmp1) {
HXLINE( 473)			_hx_tmp = ::openfl::text::Font_obj::_hx___fontByName->exists((fontNamePrefix + HX_(" Bold Italic",0b,b0,c3,94)));
            		}
            		else {
HXLINE( 473)			_hx_tmp = false;
            		}
HXDLIN( 473)		if (_hx_tmp) {
HXLINE( 475)			fontName = (fontNamePrefix + HX_(" Bold Italic",0b,b0,c3,94));
HXLINE( 476)			bold = false;
HXLINE( 477)			italic = false;
            		}
            		else {
HXLINE( 479)			bool _hx_tmp;
HXDLIN( 479)			if (( (bool)(bold) )) {
HXLINE( 479)				_hx_tmp = ::openfl::text::Font_obj::_hx___fontByName->exists((fontNamePrefix + HX_(" Bold",c5,3d,c7,98)));
            			}
            			else {
HXLINE( 479)				_hx_tmp = false;
            			}
HXDLIN( 479)			if (_hx_tmp) {
HXLINE( 481)				fontName = (fontNamePrefix + HX_(" Bold",c5,3d,c7,98));
HXLINE( 482)				bold = false;
            			}
            			else {
HXLINE( 484)				bool _hx_tmp;
HXDLIN( 484)				if (( (bool)(italic) )) {
HXLINE( 484)					_hx_tmp = ::openfl::text::Font_obj::_hx___fontByName->exists((fontNamePrefix + HX_(" Italic",30,7b,a7,6d)));
            				}
            				else {
HXLINE( 484)					_hx_tmp = false;
            				}
HXDLIN( 484)				if (_hx_tmp) {
HXLINE( 486)					fontName = (fontNamePrefix + HX_(" Italic",30,7b,a7,6d));
HXLINE( 487)					italic = false;
            				}
            				else {
HXLINE( 493)					bool _hx_tmp;
HXDLIN( 493)					if (( (bool)(bold) )) {
HXLINE( 493)						if ((fontName.indexOf(HX_(" Bold ",bb,ce,8e,15),null()) <= -1)) {
HXLINE( 493)							_hx_tmp = ::StringTools_obj::endsWith(fontName,HX_(" Bold",c5,3d,c7,98));
            						}
            						else {
HXLINE( 493)							_hx_tmp = true;
            						}
            					}
            					else {
HXLINE( 493)						_hx_tmp = false;
            					}
HXDLIN( 493)					if (_hx_tmp) {
HXLINE( 495)						bold = false;
            					}
HXLINE( 498)					bool _hx_tmp1;
HXDLIN( 498)					if (( (bool)(italic) )) {
HXLINE( 498)						if ((fontName.indexOf(HX_(" Italic ",f0,4e,e4,84),null()) <= -1)) {
HXLINE( 498)							_hx_tmp1 = ::StringTools_obj::endsWith(fontName,HX_(" Italic",30,7b,a7,6d));
            						}
            						else {
HXLINE( 498)							_hx_tmp1 = true;
            						}
            					}
            					else {
HXLINE( 498)						_hx_tmp1 = false;
            					}
HXDLIN( 498)					if (_hx_tmp1) {
HXLINE( 500)						italic = false;
            					}
            				}
            			}
            		}
HXLINE( 504)		::String font;
HXDLIN( 504)		if (( (bool)(italic) )) {
HXLINE( 504)			font = HX_("italic ",30,e3,44,91);
            		}
            		else {
HXLINE( 504)			font = HX_("normal ",19,70,da,2b);
            		}
HXLINE( 505)		font = (font + HX_("normal ",19,70,da,2b));
HXLINE( 506)		::String font1;
HXDLIN( 506)		if (( (bool)(bold) )) {
HXLINE( 506)			font1 = HX_("bold ",fb,d2,f5,b6);
            		}
            		else {
HXLINE( 506)			font1 = HX_("normal ",19,70,da,2b);
            		}
HXDLIN( 506)		font = (font + font1);
HXLINE( 507)		font = (font + (format->size + HX_("px",08,62,00,00)));
HXLINE( 509)		font = (font + ((HX_("/",2f,00,00,00) + (format->size + 3)) + HX_("px ",18,65,55,00)));
HXLINE( 511)		::String font2;
HXDLIN( 511)		::String _hx_switch_0 = fontName;
            		if (  (_hx_switch_0==HX_("_sans",32,a0,5e,ff)) ){
HXLINE( 511)			font2 = HX_("sans-serif",c3,60,fb,08);
HXDLIN( 511)			goto _hx_goto_146;
            		}
            		if (  (_hx_switch_0==HX_("_serif",be,66,15,76)) ){
HXLINE( 511)			font2 = HX_("serif",7d,1f,2e,7a);
HXDLIN( 511)			goto _hx_goto_146;
            		}
            		if (  (_hx_switch_0==HX_("_typewriter",0c,5e,52,94)) ){
HXLINE( 511)			font2 = HX_("monospace",c3,d1,e5,5e);
HXDLIN( 511)			goto _hx_goto_146;
            		}
            		/* default */{
HXLINE( 511)			font2 = ((HX_("'",27,00,00,00) +  ::EReg_obj::__alloc( HX_CTX ,HX_("^[\\s'\"]+(.*)[\\s'\"]+$",eb,e4,eb,f5),HX_("",00,00,00,00))->replace(fontName,HX_("$1",8d,1f,00,00))) + HX_("'",27,00,00,00));
            		}
            		_hx_goto_146:;
HXDLIN( 511)		font = (font + (HX_("",00,00,00,00) + font2));
HXLINE( 519)		return font;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,getFont,return )

 ::openfl::text::Font TextEngine_obj::getFontInstance( ::openfl::text::TextFormat format){
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_523_getFontInstance)
HXLINE( 527)		 ::openfl::text::Font instance = null();
HXLINE( 528)		 ::Dynamic fontList = null();
HXLINE( 530)		bool _hx_tmp;
HXDLIN( 530)		if (::hx::IsNotNull( format )) {
HXLINE( 530)			_hx_tmp = ::hx::IsNotNull( format->font );
            		}
            		else {
HXLINE( 530)			_hx_tmp = false;
            		}
HXDLIN( 530)		if (_hx_tmp) {
HXLINE( 532)			::String _hx_switch_0 = format->font;
            			if (  (_hx_switch_0==HX_("_sans",32,a0,5e,ff)) ||  (_hx_switch_0==HX_("_serif",be,66,15,76)) ||  (_hx_switch_0==HX_("_typewriter",0c,5e,52,94)) ){
HXLINE( 535)				instance = ::openfl::text::_internal::TextEngine_obj::getDefaultFont(format->font,( (bool)(format->bold) ),( (bool)(format->italic) ));
HXLINE( 536)				if (::hx::IsNotNull( instance )) {
HXLINE( 536)					return instance;
            				}
HXLINE( 534)				goto _hx_goto_148;
            			}
            			/* default */{
            			}
            			_hx_goto_148:;
HXLINE( 540)			instance = ::openfl::text::_internal::TextEngine_obj::findFontVariant(format);
HXLINE( 541)			if (::hx::IsNotNull( instance )) {
HXLINE( 541)				return instance;
            			}
            		}
HXLINE( 544)		instance = ::openfl::text::_internal::TextEngine_obj::getDefaultFont(HX_("_serif",be,66,15,76),( (bool)(format->bold) ),( (bool)(format->italic) ));
HXLINE( 545)		if (::hx::IsNotNull( instance )) {
HXLINE( 545)			return instance;
            		}
HXLINE( 548)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextEngine_obj,getFontInstance,return )


::hx::ObjectPtr< TextEngine_obj > TextEngine_obj::__new( ::openfl::text::TextField textField) {
	::hx::ObjectPtr< TextEngine_obj > __this = new TextEngine_obj();
	__this->__construct(textField);
	return __this;
}

::hx::ObjectPtr< TextEngine_obj > TextEngine_obj::__alloc(::hx::Ctx *_hx_ctx, ::openfl::text::TextField textField) {
	TextEngine_obj *__this = (TextEngine_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(TextEngine_obj), true, "openfl.text._internal.TextEngine"));
	*(void **)__this = TextEngine_obj::_hx_vtable;
	__this->__construct(textField);
	return __this;
}

TextEngine_obj::TextEngine_obj()
{
}

void TextEngine_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(TextEngine);
	HX_MARK_MEMBER_NAME(antiAliasType,"antiAliasType");
	HX_MARK_MEMBER_NAME(autoSize,"autoSize");
	HX_MARK_MEMBER_NAME(background,"background");
	HX_MARK_MEMBER_NAME(backgroundColor,"backgroundColor");
	HX_MARK_MEMBER_NAME(border,"border");
	HX_MARK_MEMBER_NAME(borderColor,"borderColor");
	HX_MARK_MEMBER_NAME(bottomScrollV,"bottomScrollV");
	HX_MARK_MEMBER_NAME(bounds,"bounds");
	HX_MARK_MEMBER_NAME(caretIndex,"caretIndex");
	HX_MARK_MEMBER_NAME(embedFonts,"embedFonts");
	HX_MARK_MEMBER_NAME(gridFitType,"gridFitType");
	HX_MARK_MEMBER_NAME(height,"height");
	HX_MARK_MEMBER_NAME(layoutGroups,"layoutGroups");
	HX_MARK_MEMBER_NAME(lineAscents,"lineAscents");
	HX_MARK_MEMBER_NAME(lineBreaks,"lineBreaks");
	HX_MARK_MEMBER_NAME(lineDescents,"lineDescents");
	HX_MARK_MEMBER_NAME(lineLeadings,"lineLeadings");
	HX_MARK_MEMBER_NAME(lineHeights,"lineHeights");
	HX_MARK_MEMBER_NAME(lineWidths,"lineWidths");
	HX_MARK_MEMBER_NAME(maxChars,"maxChars");
	HX_MARK_MEMBER_NAME(maxScrollH,"maxScrollH");
	HX_MARK_MEMBER_NAME(maxScrollV,"maxScrollV");
	HX_MARK_MEMBER_NAME(multiline,"multiline");
	HX_MARK_MEMBER_NAME(numLines,"numLines");
	HX_MARK_MEMBER_NAME(restrict,"restrict");
	HX_MARK_MEMBER_NAME(scrollH,"scrollH");
	HX_MARK_MEMBER_NAME(scrollV,"scrollV");
	HX_MARK_MEMBER_NAME(selectable,"selectable");
	HX_MARK_MEMBER_NAME(sharpness,"sharpness");
	HX_MARK_MEMBER_NAME(text,"text");
	HX_MARK_MEMBER_NAME(textBounds,"textBounds");
	HX_MARK_MEMBER_NAME(textHeight,"textHeight");
	HX_MARK_MEMBER_NAME(textFormatRanges,"textFormatRanges");
	HX_MARK_MEMBER_NAME(textWidth,"textWidth");
	HX_MARK_MEMBER_NAME(type,"type");
	HX_MARK_MEMBER_NAME(width,"width");
	HX_MARK_MEMBER_NAME(wordWrap,"wordWrap");
	HX_MARK_MEMBER_NAME(textField,"textField");
	HX_MARK_MEMBER_NAME(_hx___cursorTimer,"__cursorTimer");
	HX_MARK_MEMBER_NAME(_hx___hasFocus,"__hasFocus");
	HX_MARK_MEMBER_NAME(_hx___isKeyDown,"__isKeyDown");
	HX_MARK_MEMBER_NAME(_hx___measuredHeight,"__measuredHeight");
	HX_MARK_MEMBER_NAME(_hx___measuredWidth,"__measuredWidth");
	HX_MARK_MEMBER_NAME(_hx___restrictRegexp,"__restrictRegexp");
	HX_MARK_MEMBER_NAME(_hx___selectionStart,"__selectionStart");
	HX_MARK_MEMBER_NAME(_hx___shapeCache,"__shapeCache");
	HX_MARK_MEMBER_NAME(_hx___showCursor,"__showCursor");
	HX_MARK_MEMBER_NAME(_hx___textFormat,"__textFormat");
	HX_MARK_MEMBER_NAME(_hx___textLayout,"__textLayout");
	HX_MARK_MEMBER_NAME(_hx___texture,"__texture");
	HX_MARK_MEMBER_NAME(_hx___useIntAdvances,"__useIntAdvances");
	HX_MARK_MEMBER_NAME(_hx___cairoFont,"__cairoFont");
	HX_MARK_MEMBER_NAME(_hx___font,"__font");
	HX_MARK_END_CLASS();
}

void TextEngine_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(antiAliasType,"antiAliasType");
	HX_VISIT_MEMBER_NAME(autoSize,"autoSize");
	HX_VISIT_MEMBER_NAME(background,"background");
	HX_VISIT_MEMBER_NAME(backgroundColor,"backgroundColor");
	HX_VISIT_MEMBER_NAME(border,"border");
	HX_VISIT_MEMBER_NAME(borderColor,"borderColor");
	HX_VISIT_MEMBER_NAME(bottomScrollV,"bottomScrollV");
	HX_VISIT_MEMBER_NAME(bounds,"bounds");
	HX_VISIT_MEMBER_NAME(caretIndex,"caretIndex");
	HX_VISIT_MEMBER_NAME(embedFonts,"embedFonts");
	HX_VISIT_MEMBER_NAME(gridFitType,"gridFitType");
	HX_VISIT_MEMBER_NAME(height,"height");
	HX_VISIT_MEMBER_NAME(layoutGroups,"layoutGroups");
	HX_VISIT_MEMBER_NAME(lineAscents,"lineAscents");
	HX_VISIT_MEMBER_NAME(lineBreaks,"lineBreaks");
	HX_VISIT_MEMBER_NAME(lineDescents,"lineDescents");
	HX_VISIT_MEMBER_NAME(lineLeadings,"lineLeadings");
	HX_VISIT_MEMBER_NAME(lineHeights,"lineHeights");
	HX_VISIT_MEMBER_NAME(lineWidths,"lineWidths");
	HX_VISIT_MEMBER_NAME(maxChars,"maxChars");
	HX_VISIT_MEMBER_NAME(maxScrollH,"maxScrollH");
	HX_VISIT_MEMBER_NAME(maxScrollV,"maxScrollV");
	HX_VISIT_MEMBER_NAME(multiline,"multiline");
	HX_VISIT_MEMBER_NAME(numLines,"numLines");
	HX_VISIT_MEMBER_NAME(restrict,"restrict");
	HX_VISIT_MEMBER_NAME(scrollH,"scrollH");
	HX_VISIT_MEMBER_NAME(scrollV,"scrollV");
	HX_VISIT_MEMBER_NAME(selectable,"selectable");
	HX_VISIT_MEMBER_NAME(sharpness,"sharpness");
	HX_VISIT_MEMBER_NAME(text,"text");
	HX_VISIT_MEMBER_NAME(textBounds,"textBounds");
	HX_VISIT_MEMBER_NAME(textHeight,"textHeight");
	HX_VISIT_MEMBER_NAME(textFormatRanges,"textFormatRanges");
	HX_VISIT_MEMBER_NAME(textWidth,"textWidth");
	HX_VISIT_MEMBER_NAME(type,"type");
	HX_VISIT_MEMBER_NAME(width,"width");
	HX_VISIT_MEMBER_NAME(wordWrap,"wordWrap");
	HX_VISIT_MEMBER_NAME(textField,"textField");
	HX_VISIT_MEMBER_NAME(_hx___cursorTimer,"__cursorTimer");
	HX_VISIT_MEMBER_NAME(_hx___hasFocus,"__hasFocus");
	HX_VISIT_MEMBER_NAME(_hx___isKeyDown,"__isKeyDown");
	HX_VISIT_MEMBER_NAME(_hx___measuredHeight,"__measuredHeight");
	HX_VISIT_MEMBER_NAME(_hx___measuredWidth,"__measuredWidth");
	HX_VISIT_MEMBER_NAME(_hx___restrictRegexp,"__restrictRegexp");
	HX_VISIT_MEMBER_NAME(_hx___selectionStart,"__selectionStart");
	HX_VISIT_MEMBER_NAME(_hx___shapeCache,"__shapeCache");
	HX_VISIT_MEMBER_NAME(_hx___showCursor,"__showCursor");
	HX_VISIT_MEMBER_NAME(_hx___textFormat,"__textFormat");
	HX_VISIT_MEMBER_NAME(_hx___textLayout,"__textLayout");
	HX_VISIT_MEMBER_NAME(_hx___texture,"__texture");
	HX_VISIT_MEMBER_NAME(_hx___useIntAdvances,"__useIntAdvances");
	HX_VISIT_MEMBER_NAME(_hx___cairoFont,"__cairoFont");
	HX_VISIT_MEMBER_NAME(_hx___font,"__font");
}

::hx::Val TextEngine_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"text") ) { return ::hx::Val( text ); }
		if (HX_FIELD_EQ(inName,"type") ) { return ::hx::Val( type ); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"width") ) { return ::hx::Val( width ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"border") ) { return ::hx::Val( border ); }
		if (HX_FIELD_EQ(inName,"bounds") ) { return ::hx::Val( bounds ); }
		if (HX_FIELD_EQ(inName,"height") ) { return ::hx::Val( height ); }
		if (HX_FIELD_EQ(inName,"__font") ) { return ::hx::Val( _hx___font ); }
		if (HX_FIELD_EQ(inName,"update") ) { return ::hx::Val( update_dyn() ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"scrollH") ) { return ::hx::Val( scrollH ); }
		if (HX_FIELD_EQ(inName,"scrollV") ) { return ::hx::Val( inCallProp == ::hx::paccAlways ? get_scrollV() : scrollV ); }
		if (HX_FIELD_EQ(inName,"getLine") ) { return ::hx::Val( getLine_dyn() ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"autoSize") ) { return ::hx::Val( autoSize ); }
		if (HX_FIELD_EQ(inName,"maxChars") ) { return ::hx::Val( maxChars ); }
		if (HX_FIELD_EQ(inName,"numLines") ) { return ::hx::Val( numLines ); }
		if (HX_FIELD_EQ(inName,"restrict") ) { return ::hx::Val( restrict ); }
		if (HX_FIELD_EQ(inName,"wordWrap") ) { return ::hx::Val( wordWrap ); }
		if (HX_FIELD_EQ(inName,"trimText") ) { return ::hx::Val( trimText_dyn() ); }
		if (HX_FIELD_EQ(inName,"set_text") ) { return ::hx::Val( set_text_dyn() ); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"multiline") ) { return ::hx::Val( multiline ); }
		if (HX_FIELD_EQ(inName,"sharpness") ) { return ::hx::Val( sharpness ); }
		if (HX_FIELD_EQ(inName,"textWidth") ) { return ::hx::Val( textWidth ); }
		if (HX_FIELD_EQ(inName,"textField") ) { return ::hx::Val( textField ); }
		if (HX_FIELD_EQ(inName,"__texture") ) { return ::hx::Val( _hx___texture ); }
		if (HX_FIELD_EQ(inName,"getBounds") ) { return ::hx::Val( getBounds_dyn() ); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"background") ) { return ::hx::Val( background ); }
		if (HX_FIELD_EQ(inName,"caretIndex") ) { return ::hx::Val( caretIndex ); }
		if (HX_FIELD_EQ(inName,"embedFonts") ) { return ::hx::Val( embedFonts ); }
		if (HX_FIELD_EQ(inName,"lineBreaks") ) { return ::hx::Val( lineBreaks ); }
		if (HX_FIELD_EQ(inName,"lineWidths") ) { return ::hx::Val( lineWidths ); }
		if (HX_FIELD_EQ(inName,"maxScrollH") ) { return ::hx::Val( maxScrollH ); }
		if (HX_FIELD_EQ(inName,"maxScrollV") ) { return ::hx::Val( inCallProp == ::hx::paccAlways ? get_maxScrollV() : maxScrollV ); }
		if (HX_FIELD_EQ(inName,"selectable") ) { return ::hx::Val( selectable ); }
		if (HX_FIELD_EQ(inName,"textBounds") ) { return ::hx::Val( textBounds ); }
		if (HX_FIELD_EQ(inName,"textHeight") ) { return ::hx::Val( textHeight ); }
		if (HX_FIELD_EQ(inName,"__hasFocus") ) { return ::hx::Val( _hx___hasFocus ); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"borderColor") ) { return ::hx::Val( borderColor ); }
		if (HX_FIELD_EQ(inName,"gridFitType") ) { return ::hx::Val( gridFitType ); }
		if (HX_FIELD_EQ(inName,"lineAscents") ) { return ::hx::Val( lineAscents ); }
		if (HX_FIELD_EQ(inName,"lineHeights") ) { return ::hx::Val( lineHeights ); }
		if (HX_FIELD_EQ(inName,"__isKeyDown") ) { return ::hx::Val( _hx___isKeyDown ); }
		if (HX_FIELD_EQ(inName,"__cairoFont") ) { return ::hx::Val( _hx___cairoFont ); }
		if (HX_FIELD_EQ(inName,"get_scrollV") ) { return ::hx::Val( get_scrollV_dyn() ); }
		if (HX_FIELD_EQ(inName,"set_scrollV") ) { return ::hx::Val( set_scrollV_dyn() ); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"layoutGroups") ) { return ::hx::Val( layoutGroups ); }
		if (HX_FIELD_EQ(inName,"lineDescents") ) { return ::hx::Val( lineDescents ); }
		if (HX_FIELD_EQ(inName,"lineLeadings") ) { return ::hx::Val( lineLeadings ); }
		if (HX_FIELD_EQ(inName,"__shapeCache") ) { return ::hx::Val( _hx___shapeCache ); }
		if (HX_FIELD_EQ(inName,"__showCursor") ) { return ::hx::Val( _hx___showCursor ); }
		if (HX_FIELD_EQ(inName,"__textFormat") ) { return ::hx::Val( _hx___textFormat ); }
		if (HX_FIELD_EQ(inName,"__textLayout") ) { return ::hx::Val( _hx___textLayout ); }
		if (HX_FIELD_EQ(inName,"restrictText") ) { return ::hx::Val( restrictText_dyn() ); }
		if (HX_FIELD_EQ(inName,"set_restrict") ) { return ::hx::Val( set_restrict_dyn() ); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"antiAliasType") ) { return ::hx::Val( antiAliasType ); }
		if (HX_FIELD_EQ(inName,"bottomScrollV") ) { return ::hx::Val( inCallProp == ::hx::paccAlways ? get_bottomScrollV() : bottomScrollV ); }
		if (HX_FIELD_EQ(inName,"__cursorTimer") ) { return ::hx::Val( _hx___cursorTimer ); }
		if (HX_FIELD_EQ(inName,"getLineBreaks") ) { return ::hx::Val( getLineBreaks_dyn() ); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"get_maxScrollV") ) { return ::hx::Val( get_maxScrollV_dyn() ); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"backgroundColor") ) { return ::hx::Val( backgroundColor ); }
		if (HX_FIELD_EQ(inName,"__measuredWidth") ) { return ::hx::Val( _hx___measuredWidth ); }
		if (HX_FIELD_EQ(inName,"getLayoutGroups") ) { return ::hx::Val( getLayoutGroups_dyn() ); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"textFormatRanges") ) { return ::hx::Val( textFormatRanges ); }
		if (HX_FIELD_EQ(inName,"__measuredHeight") ) { return ::hx::Val( _hx___measuredHeight ); }
		if (HX_FIELD_EQ(inName,"__restrictRegexp") ) { return ::hx::Val( _hx___restrictRegexp ); }
		if (HX_FIELD_EQ(inName,"__selectionStart") ) { return ::hx::Val( _hx___selectionStart ); }
		if (HX_FIELD_EQ(inName,"__useIntAdvances") ) { return ::hx::Val( _hx___useIntAdvances ); }
		if (HX_FIELD_EQ(inName,"setTextAlignment") ) { return ::hx::Val( setTextAlignment_dyn() ); }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"getLineBreakIndex") ) { return ::hx::Val( getLineBreakIndex_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_bottomScrollV") ) { return ::hx::Val( get_bottomScrollV_dyn() ); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"getLineMeasurements") ) { return ::hx::Val( getLineMeasurements_dyn() ); }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"createRestrictRegexp") ) { return ::hx::Val( createRestrictRegexp_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

bool TextEngine_obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 7:
		if (HX_FIELD_EQ(inName,"getFont") ) { outValue = getFont_dyn(); return true; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"findFont") ) { outValue = findFont_dyn(); return true; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"__defaultFonts") ) { outValue = ( _hx___defaultFonts ); return true; }
		if (HX_FIELD_EQ(inName,"getDefaultFont") ) { outValue = getDefaultFont_dyn(); return true; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"findFontVariant") ) { outValue = findFontVariant_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"getFormatHeight") ) { outValue = getFormatHeight_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"getFontInstance") ) { outValue = getFontInstance_dyn(); return true; }
	}
	return false;
}

::hx::Val TextEngine_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"text") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( set_text(inValue.Cast< ::String >()) );text=inValue.Cast< ::String >(); return inValue; }
		if (HX_FIELD_EQ(inName,"type") ) { type=inValue.Cast<  ::Dynamic >(); return inValue; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"width") ) { width=inValue.Cast< Float >(); return inValue; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"border") ) { border=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"bounds") ) { bounds=inValue.Cast<  ::openfl::geom::Rectangle >(); return inValue; }
		if (HX_FIELD_EQ(inName,"height") ) { height=inValue.Cast< Float >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__font") ) { _hx___font=inValue.Cast<  ::openfl::text::Font >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"scrollH") ) { scrollH=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"scrollV") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( set_scrollV(inValue.Cast< int >()) );scrollV=inValue.Cast< int >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"autoSize") ) { autoSize=inValue.Cast<  ::Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"maxChars") ) { maxChars=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"numLines") ) { numLines=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"restrict") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( set_restrict(inValue.Cast< ::String >()) );restrict=inValue.Cast< ::String >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wordWrap") ) { wordWrap=inValue.Cast< bool >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"multiline") ) { multiline=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"sharpness") ) { sharpness=inValue.Cast< Float >(); return inValue; }
		if (HX_FIELD_EQ(inName,"textWidth") ) { textWidth=inValue.Cast< Float >(); return inValue; }
		if (HX_FIELD_EQ(inName,"textField") ) { textField=inValue.Cast<  ::openfl::text::TextField >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__texture") ) { _hx___texture=inValue.Cast<  ::lime::graphics::opengl::GLObject >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"background") ) { background=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"caretIndex") ) { caretIndex=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"embedFonts") ) { embedFonts=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"lineBreaks") ) { lineBreaks=inValue.Cast<  ::openfl::_Vector::IntVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"lineWidths") ) { lineWidths=inValue.Cast<  ::openfl::_Vector::FloatVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"maxScrollH") ) { maxScrollH=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"maxScrollV") ) { maxScrollV=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"selectable") ) { selectable=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"textBounds") ) { textBounds=inValue.Cast<  ::openfl::geom::Rectangle >(); return inValue; }
		if (HX_FIELD_EQ(inName,"textHeight") ) { textHeight=inValue.Cast< Float >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__hasFocus") ) { _hx___hasFocus=inValue.Cast< bool >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"borderColor") ) { borderColor=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"gridFitType") ) { gridFitType=inValue.Cast<  ::Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"lineAscents") ) { lineAscents=inValue.Cast<  ::openfl::_Vector::FloatVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"lineHeights") ) { lineHeights=inValue.Cast<  ::openfl::_Vector::FloatVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__isKeyDown") ) { _hx___isKeyDown=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__cairoFont") ) { _hx___cairoFont=inValue.Cast<  ::Dynamic >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"layoutGroups") ) { layoutGroups=inValue.Cast<  ::openfl::_Vector::ObjectVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"lineDescents") ) { lineDescents=inValue.Cast<  ::openfl::_Vector::FloatVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"lineLeadings") ) { lineLeadings=inValue.Cast<  ::openfl::_Vector::FloatVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__shapeCache") ) { _hx___shapeCache=inValue.Cast<  ::openfl::text::_internal::ShapeCache >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__showCursor") ) { _hx___showCursor=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__textFormat") ) { _hx___textFormat=inValue.Cast<  ::openfl::text::TextFormat >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__textLayout") ) { _hx___textLayout=inValue.Cast<  ::openfl::text::_internal::TextLayout >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"antiAliasType") ) { antiAliasType=inValue.Cast<  ::Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"bottomScrollV") ) { bottomScrollV=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__cursorTimer") ) { _hx___cursorTimer=inValue.Cast<  ::haxe::Timer >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"backgroundColor") ) { backgroundColor=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__measuredWidth") ) { _hx___measuredWidth=inValue.Cast< int >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"textFormatRanges") ) { textFormatRanges=inValue.Cast<  ::openfl::_Vector::ObjectVector >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__measuredHeight") ) { _hx___measuredHeight=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__restrictRegexp") ) { _hx___restrictRegexp=inValue.Cast<  ::EReg >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__selectionStart") ) { _hx___selectionStart=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"__useIntAdvances") ) { _hx___useIntAdvances=inValue.Cast<  ::Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

bool TextEngine_obj::__SetStatic(const ::String &inName,Dynamic &ioValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 14:
		if (HX_FIELD_EQ(inName,"__defaultFonts") ) { _hx___defaultFonts=ioValue.Cast<  ::haxe::ds::StringMap >(); return true; }
	}
	return false;
}

void TextEngine_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("antiAliasType",68,c4,fa,e7));
	outFields->push(HX_("autoSize",d0,8f,79,2f));
	outFields->push(HX_("background",ee,93,1d,26));
	outFields->push(HX_("backgroundColor",95,4e,47,0d));
	outFields->push(HX_("border",ec,4c,1a,64));
	outFields->push(HX_("borderColor",d7,3c,d5,d6));
	outFields->push(HX_("bottomScrollV",fe,f7,87,8b));
	outFields->push(HX_("bounds",75,86,1d,66));
	outFields->push(HX_("caretIndex",8f,b6,5b,dd));
	outFields->push(HX_("embedFonts",2b,c7,e1,8e));
	outFields->push(HX_("gridFitType",05,f3,13,b4));
	outFields->push(HX_("height",e7,07,4c,02));
	outFields->push(HX_("layoutGroups",9e,a2,6c,37));
	outFields->push(HX_("lineAscents",45,0c,c2,3e));
	outFields->push(HX_("lineBreaks",e8,fd,5b,ea));
	outFields->push(HX_("lineDescents",0d,ad,64,49));
	outFields->push(HX_("lineLeadings",01,23,97,76));
	outFields->push(HX_("lineHeights",18,99,8e,3e));
	outFields->push(HX_("lineWidths",c1,8a,a4,20));
	outFields->push(HX_("maxChars",99,ef,d0,ef));
	outFields->push(HX_("maxScrollH",57,ad,fc,9a));
	outFields->push(HX_("maxScrollV",65,ad,fc,9a));
	outFields->push(HX_("multiline",ed,d2,11,9e));
	outFields->push(HX_("numLines",d9,f1,11,32));
	outFields->push(HX_("restrict",3c,cb,9e,f1));
	outFields->push(HX_("scrollH",9b,33,d8,30));
	outFields->push(HX_("scrollV",a9,33,d8,30));
	outFields->push(HX_("selectable",96,b6,2a,c4));
	outFields->push(HX_("sharpness",81,22,25,1b));
	outFields->push(HX_("text",ad,cc,f9,4c));
	outFields->push(HX_("textBounds",02,07,0e,9d));
	outFields->push(HX_("textHeight",74,88,3c,39));
	outFields->push(HX_("textFormatRanges",fa,0e,49,a2));
	outFields->push(HX_("textWidth",19,46,50,63));
	outFields->push(HX_("type",ba,f2,08,4d));
	outFields->push(HX_("width",06,b6,62,ca));
	outFields->push(HX_("wordWrap",b4,14,db,00));
	outFields->push(HX_("textField",cd,24,81,99));
	outFields->push(HX_("__cursorTimer",ef,59,8f,e1));
	outFields->push(HX_("__hasFocus",3e,1d,1a,34));
	outFields->push(HX_("__isKeyDown",b7,2f,72,ce));
	outFields->push(HX_("__measuredHeight",ed,b6,23,42));
	outFields->push(HX_("__measuredWidth",c0,49,ec,02));
	outFields->push(HX_("__restrictRegexp",45,9f,ae,a9));
	outFields->push(HX_("__selectionStart",96,e3,b9,43));
	outFields->push(HX_("__shapeCache",81,aa,e8,5f));
	outFields->push(HX_("__showCursor",d3,ae,f0,e0));
	outFields->push(HX_("__textFormat",e4,8a,12,6d));
	outFields->push(HX_("__textLayout",57,aa,3c,c8));
	outFields->push(HX_("__texture",bb,19,2f,20));
	outFields->push(HX_("__useIntAdvances",d9,17,72,7d));
	outFields->push(HX_("__cairoFont",57,e7,b5,28));
	outFields->push(HX_("__font",ef,c0,b8,f2));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo TextEngine_obj_sMemberStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(TextEngine_obj,antiAliasType),HX_("antiAliasType",68,c4,fa,e7)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(TextEngine_obj,autoSize),HX_("autoSize",d0,8f,79,2f)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,background),HX_("background",ee,93,1d,26)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,backgroundColor),HX_("backgroundColor",95,4e,47,0d)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,border),HX_("border",ec,4c,1a,64)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,borderColor),HX_("borderColor",d7,3c,d5,d6)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,bottomScrollV),HX_("bottomScrollV",fe,f7,87,8b)},
	{::hx::fsObject /*  ::openfl::geom::Rectangle */ ,(int)offsetof(TextEngine_obj,bounds),HX_("bounds",75,86,1d,66)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,caretIndex),HX_("caretIndex",8f,b6,5b,dd)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,embedFonts),HX_("embedFonts",2b,c7,e1,8e)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(TextEngine_obj,gridFitType),HX_("gridFitType",05,f3,13,b4)},
	{::hx::fsFloat,(int)offsetof(TextEngine_obj,height),HX_("height",e7,07,4c,02)},
	{::hx::fsObject /*  ::openfl::_Vector::ObjectVector */ ,(int)offsetof(TextEngine_obj,layoutGroups),HX_("layoutGroups",9e,a2,6c,37)},
	{::hx::fsObject /*  ::openfl::_Vector::FloatVector */ ,(int)offsetof(TextEngine_obj,lineAscents),HX_("lineAscents",45,0c,c2,3e)},
	{::hx::fsObject /*  ::openfl::_Vector::IntVector */ ,(int)offsetof(TextEngine_obj,lineBreaks),HX_("lineBreaks",e8,fd,5b,ea)},
	{::hx::fsObject /*  ::openfl::_Vector::FloatVector */ ,(int)offsetof(TextEngine_obj,lineDescents),HX_("lineDescents",0d,ad,64,49)},
	{::hx::fsObject /*  ::openfl::_Vector::FloatVector */ ,(int)offsetof(TextEngine_obj,lineLeadings),HX_("lineLeadings",01,23,97,76)},
	{::hx::fsObject /*  ::openfl::_Vector::FloatVector */ ,(int)offsetof(TextEngine_obj,lineHeights),HX_("lineHeights",18,99,8e,3e)},
	{::hx::fsObject /*  ::openfl::_Vector::FloatVector */ ,(int)offsetof(TextEngine_obj,lineWidths),HX_("lineWidths",c1,8a,a4,20)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,maxChars),HX_("maxChars",99,ef,d0,ef)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,maxScrollH),HX_("maxScrollH",57,ad,fc,9a)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,maxScrollV),HX_("maxScrollV",65,ad,fc,9a)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,multiline),HX_("multiline",ed,d2,11,9e)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,numLines),HX_("numLines",d9,f1,11,32)},
	{::hx::fsString,(int)offsetof(TextEngine_obj,restrict),HX_("restrict",3c,cb,9e,f1)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,scrollH),HX_("scrollH",9b,33,d8,30)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,scrollV),HX_("scrollV",a9,33,d8,30)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,selectable),HX_("selectable",96,b6,2a,c4)},
	{::hx::fsFloat,(int)offsetof(TextEngine_obj,sharpness),HX_("sharpness",81,22,25,1b)},
	{::hx::fsString,(int)offsetof(TextEngine_obj,text),HX_("text",ad,cc,f9,4c)},
	{::hx::fsObject /*  ::openfl::geom::Rectangle */ ,(int)offsetof(TextEngine_obj,textBounds),HX_("textBounds",02,07,0e,9d)},
	{::hx::fsFloat,(int)offsetof(TextEngine_obj,textHeight),HX_("textHeight",74,88,3c,39)},
	{::hx::fsObject /*  ::openfl::_Vector::ObjectVector */ ,(int)offsetof(TextEngine_obj,textFormatRanges),HX_("textFormatRanges",fa,0e,49,a2)},
	{::hx::fsFloat,(int)offsetof(TextEngine_obj,textWidth),HX_("textWidth",19,46,50,63)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(TextEngine_obj,type),HX_("type",ba,f2,08,4d)},
	{::hx::fsFloat,(int)offsetof(TextEngine_obj,width),HX_("width",06,b6,62,ca)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,wordWrap),HX_("wordWrap",b4,14,db,00)},
	{::hx::fsObject /*  ::openfl::text::TextField */ ,(int)offsetof(TextEngine_obj,textField),HX_("textField",cd,24,81,99)},
	{::hx::fsObject /*  ::haxe::Timer */ ,(int)offsetof(TextEngine_obj,_hx___cursorTimer),HX_("__cursorTimer",ef,59,8f,e1)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,_hx___hasFocus),HX_("__hasFocus",3e,1d,1a,34)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,_hx___isKeyDown),HX_("__isKeyDown",b7,2f,72,ce)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,_hx___measuredHeight),HX_("__measuredHeight",ed,b6,23,42)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,_hx___measuredWidth),HX_("__measuredWidth",c0,49,ec,02)},
	{::hx::fsObject /*  ::EReg */ ,(int)offsetof(TextEngine_obj,_hx___restrictRegexp),HX_("__restrictRegexp",45,9f,ae,a9)},
	{::hx::fsInt,(int)offsetof(TextEngine_obj,_hx___selectionStart),HX_("__selectionStart",96,e3,b9,43)},
	{::hx::fsObject /*  ::openfl::text::_internal::ShapeCache */ ,(int)offsetof(TextEngine_obj,_hx___shapeCache),HX_("__shapeCache",81,aa,e8,5f)},
	{::hx::fsBool,(int)offsetof(TextEngine_obj,_hx___showCursor),HX_("__showCursor",d3,ae,f0,e0)},
	{::hx::fsObject /*  ::openfl::text::TextFormat */ ,(int)offsetof(TextEngine_obj,_hx___textFormat),HX_("__textFormat",e4,8a,12,6d)},
	{::hx::fsObject /*  ::openfl::text::_internal::TextLayout */ ,(int)offsetof(TextEngine_obj,_hx___textLayout),HX_("__textLayout",57,aa,3c,c8)},
	{::hx::fsObject /*  ::lime::graphics::opengl::GLObject */ ,(int)offsetof(TextEngine_obj,_hx___texture),HX_("__texture",bb,19,2f,20)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(TextEngine_obj,_hx___useIntAdvances),HX_("__useIntAdvances",d9,17,72,7d)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(TextEngine_obj,_hx___cairoFont),HX_("__cairoFont",57,e7,b5,28)},
	{::hx::fsObject /*  ::openfl::text::Font */ ,(int)offsetof(TextEngine_obj,_hx___font),HX_("__font",ef,c0,b8,f2)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo TextEngine_obj_sStaticStorageInfo[] = {
	{::hx::fsInt,(void *) &TextEngine_obj::GUTTER,HX_("GUTTER",1b,d3,2b,8c)},
	{::hx::fsInt,(void *) &TextEngine_obj::UTF8_TAB,HX_("UTF8_TAB",07,d5,41,1d)},
	{::hx::fsInt,(void *) &TextEngine_obj::UTF8_ENDLINE,HX_("UTF8_ENDLINE",01,29,41,cf)},
	{::hx::fsInt,(void *) &TextEngine_obj::UTF8_SPACE,HX_("UTF8_SPACE",f8,7b,a9,c7)},
	{::hx::fsInt,(void *) &TextEngine_obj::UTF8_HYPHEN,HX_("UTF8_HYPHEN",60,3c,3f,bf)},
	{::hx::fsObject /*  ::haxe::ds::StringMap */ ,(void *) &TextEngine_obj::_hx___defaultFonts,HX_("__defaultFonts",63,76,ad,da)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static ::String TextEngine_obj_sMemberFields[] = {
	HX_("antiAliasType",68,c4,fa,e7),
	HX_("autoSize",d0,8f,79,2f),
	HX_("background",ee,93,1d,26),
	HX_("backgroundColor",95,4e,47,0d),
	HX_("border",ec,4c,1a,64),
	HX_("borderColor",d7,3c,d5,d6),
	HX_("bottomScrollV",fe,f7,87,8b),
	HX_("bounds",75,86,1d,66),
	HX_("caretIndex",8f,b6,5b,dd),
	HX_("embedFonts",2b,c7,e1,8e),
	HX_("gridFitType",05,f3,13,b4),
	HX_("height",e7,07,4c,02),
	HX_("layoutGroups",9e,a2,6c,37),
	HX_("lineAscents",45,0c,c2,3e),
	HX_("lineBreaks",e8,fd,5b,ea),
	HX_("lineDescents",0d,ad,64,49),
	HX_("lineLeadings",01,23,97,76),
	HX_("lineHeights",18,99,8e,3e),
	HX_("lineWidths",c1,8a,a4,20),
	HX_("maxChars",99,ef,d0,ef),
	HX_("maxScrollH",57,ad,fc,9a),
	HX_("maxScrollV",65,ad,fc,9a),
	HX_("multiline",ed,d2,11,9e),
	HX_("numLines",d9,f1,11,32),
	HX_("restrict",3c,cb,9e,f1),
	HX_("scrollH",9b,33,d8,30),
	HX_("scrollV",a9,33,d8,30),
	HX_("selectable",96,b6,2a,c4),
	HX_("sharpness",81,22,25,1b),
	HX_("text",ad,cc,f9,4c),
	HX_("textBounds",02,07,0e,9d),
	HX_("textHeight",74,88,3c,39),
	HX_("textFormatRanges",fa,0e,49,a2),
	HX_("textWidth",19,46,50,63),
	HX_("type",ba,f2,08,4d),
	HX_("width",06,b6,62,ca),
	HX_("wordWrap",b4,14,db,00),
	HX_("textField",cd,24,81,99),
	HX_("__cursorTimer",ef,59,8f,e1),
	HX_("__hasFocus",3e,1d,1a,34),
	HX_("__isKeyDown",b7,2f,72,ce),
	HX_("__measuredHeight",ed,b6,23,42),
	HX_("__measuredWidth",c0,49,ec,02),
	HX_("__restrictRegexp",45,9f,ae,a9),
	HX_("__selectionStart",96,e3,b9,43),
	HX_("__shapeCache",81,aa,e8,5f),
	HX_("__showCursor",d3,ae,f0,e0),
	HX_("__textFormat",e4,8a,12,6d),
	HX_("__textLayout",57,aa,3c,c8),
	HX_("__texture",bb,19,2f,20),
	HX_("__useIntAdvances",d9,17,72,7d),
	HX_("__cairoFont",57,e7,b5,28),
	HX_("__font",ef,c0,b8,f2),
	HX_("createRestrictRegexp",41,d0,6b,e1),
	HX_("getBounds",ab,0f,74,e2),
	HX_("getLine",aa,c7,35,1a),
	HX_("getLineBreaks",1e,5a,ce,46),
	HX_("getLineBreakIndex",1d,16,36,36),
	HX_("getLineMeasurements",c1,9f,81,56),
	HX_("getLayoutGroups",54,f8,56,5a),
	HX_("restrictText",09,12,3e,34),
	HX_("setTextAlignment",74,0f,33,62),
	HX_("trimText",af,ae,63,65),
	HX_("update",09,86,05,87),
	HX_("get_bottomScrollV",55,03,f8,91),
	HX_("get_maxScrollV",ae,35,f2,10),
	HX_("set_restrict",b9,a2,b1,bb),
	HX_("get_scrollV",c0,93,d2,b6),
	HX_("set_scrollV",cc,9a,3f,c1),
	HX_("set_text",aa,e1,11,7b),
	::String(null()) };

static void TextEngine_obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(TextEngine_obj::GUTTER,"GUTTER");
	HX_MARK_MEMBER_NAME(TextEngine_obj::UTF8_TAB,"UTF8_TAB");
	HX_MARK_MEMBER_NAME(TextEngine_obj::UTF8_ENDLINE,"UTF8_ENDLINE");
	HX_MARK_MEMBER_NAME(TextEngine_obj::UTF8_SPACE,"UTF8_SPACE");
	HX_MARK_MEMBER_NAME(TextEngine_obj::UTF8_HYPHEN,"UTF8_HYPHEN");
	HX_MARK_MEMBER_NAME(TextEngine_obj::_hx___defaultFonts,"__defaultFonts");
};

#ifdef HXCPP_VISIT_ALLOCS
static void TextEngine_obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(TextEngine_obj::GUTTER,"GUTTER");
	HX_VISIT_MEMBER_NAME(TextEngine_obj::UTF8_TAB,"UTF8_TAB");
	HX_VISIT_MEMBER_NAME(TextEngine_obj::UTF8_ENDLINE,"UTF8_ENDLINE");
	HX_VISIT_MEMBER_NAME(TextEngine_obj::UTF8_SPACE,"UTF8_SPACE");
	HX_VISIT_MEMBER_NAME(TextEngine_obj::UTF8_HYPHEN,"UTF8_HYPHEN");
	HX_VISIT_MEMBER_NAME(TextEngine_obj::_hx___defaultFonts,"__defaultFonts");
};

#endif

::hx::Class TextEngine_obj::__mClass;

static ::String TextEngine_obj_sStaticFields[] = {
	HX_("GUTTER",1b,d3,2b,8c),
	HX_("UTF8_TAB",07,d5,41,1d),
	HX_("UTF8_ENDLINE",01,29,41,cf),
	HX_("UTF8_SPACE",f8,7b,a9,c7),
	HX_("UTF8_HYPHEN",60,3c,3f,bf),
	HX_("__defaultFonts",63,76,ad,da),
	HX_("findFont",a8,6a,54,96),
	HX_("findFontVariant",bd,22,bb,b2),
	HX_("getDefaultFont",3a,aa,1d,9d),
	HX_("getFormatHeight",34,24,4b,62),
	HX_("getFont",85,0d,43,16),
	HX_("getFontInstance",3a,76,96,9e),
	::String(null())
};

void TextEngine_obj::__register()
{
	TextEngine_obj _hx_dummy;
	TextEngine_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.text._internal.TextEngine",04,88,80,7e);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &TextEngine_obj::__GetStatic;
	__mClass->mSetStaticField = &TextEngine_obj::__SetStatic;
	__mClass->mMarkFunc = TextEngine_obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(TextEngine_obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(TextEngine_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< TextEngine_obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = TextEngine_obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = TextEngine_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = TextEngine_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void TextEngine_obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_38_boot)
HXDLIN(  38)		__mClass->__meta__ =  ::Dynamic(::hx::Anon_obj::Create(2)
            			->setFixed(0,HX_("fields",79,8e,8e,80), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("__cairoFont",57,e7,b5,28), ::Dynamic(::hx::Anon_obj::Create(1)
            					->setFixed(0,HX_("SuppressWarnings",0c,d3,d2,00),::cpp::VirtualArray_obj::__new(1)->init(0,HX_("checkstyle:Dynamic",ce,ea,47,3c)))))))
            			->setFixed(1,HX_("obj",f7,8f,54,00), ::Dynamic(::hx::Anon_obj::Create(1)
            				->setFixed(0,HX_("SuppressWarnings",0c,d3,d2,00),::cpp::VirtualArray_obj::__new(1)->init(0,HX_("checkstyle:FieldDocComment",70,56,1b,20))))));
            	}
{
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_40_boot)
HXDLIN(  40)		GUTTER = 2;
            	}
{
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_41_boot)
HXDLIN(  41)		UTF8_TAB = 9;
            	}
{
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_42_boot)
HXDLIN(  42)		UTF8_ENDLINE = 10;
            	}
{
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_43_boot)
HXDLIN(  43)		UTF8_SPACE = 32;
            	}
{
            	HX_STACKFRAME(&_hx_pos_81873a2f4b2980c0_44_boot)
HXDLIN(  44)		UTF8_HYPHEN = 45;
            	}
}

} // end namespace openfl
} // end namespace text
} // end namespace _internal
