#include <hxcpp.h>

#ifndef INCLUDED_openfl_text__TextFormatAlign_TextFormatAlign_Impl_
#include <openfl/text/_TextFormatAlign/TextFormatAlign_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_52c40939c4ee2936_55_fromString,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_","fromString",0xac8d25d1,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_.fromString","openfl/text/TextFormatAlign.hx",55,0xaa546dc0)
HX_LOCAL_STACK_FRAME(_hx_pos_52c40939c4ee2936_69_toString,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_","toString",0xf3d6bf22,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_.toString","openfl/text/TextFormatAlign.hx",69,0xaa546dc0)
HX_LOCAL_STACK_FRAME(_hx_pos_52c40939c4ee2936_17_boot,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_","boot",0x91217fa8,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_.boot","openfl/text/TextFormatAlign.hx",17,0xaa546dc0)
HX_LOCAL_STACK_FRAME(_hx_pos_52c40939c4ee2936_25_boot,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_","boot",0x91217fa8,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_.boot","openfl/text/TextFormatAlign.hx",25,0xaa546dc0)
HX_LOCAL_STACK_FRAME(_hx_pos_52c40939c4ee2936_31_boot,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_","boot",0x91217fa8,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_.boot","openfl/text/TextFormatAlign.hx",31,0xaa546dc0)
HX_LOCAL_STACK_FRAME(_hx_pos_52c40939c4ee2936_37_boot,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_","boot",0x91217fa8,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_.boot","openfl/text/TextFormatAlign.hx",37,0xaa546dc0)
HX_LOCAL_STACK_FRAME(_hx_pos_52c40939c4ee2936_43_boot,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_","boot",0x91217fa8,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_.boot","openfl/text/TextFormatAlign.hx",43,0xaa546dc0)
HX_LOCAL_STACK_FRAME(_hx_pos_52c40939c4ee2936_51_boot,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_","boot",0x91217fa8,"openfl.text._TextFormatAlign.TextFormatAlign_Impl_.boot","openfl/text/TextFormatAlign.hx",51,0xaa546dc0)
namespace openfl{
namespace text{
namespace _TextFormatAlign{

void TextFormatAlign_Impl__obj::__construct() { }

Dynamic TextFormatAlign_Impl__obj::__CreateEmpty() { return new TextFormatAlign_Impl__obj; }

void *TextFormatAlign_Impl__obj::_hx_vtable = 0;

Dynamic TextFormatAlign_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< TextFormatAlign_Impl__obj > _hx_result = new TextFormatAlign_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool TextFormatAlign_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x1337de42;
}

 ::Dynamic TextFormatAlign_Impl__obj::CENTER;

 ::Dynamic TextFormatAlign_Impl__obj::END;

 ::Dynamic TextFormatAlign_Impl__obj::JUSTIFY;

 ::Dynamic TextFormatAlign_Impl__obj::LEFT;

 ::Dynamic TextFormatAlign_Impl__obj::RIGHT;

 ::Dynamic TextFormatAlign_Impl__obj::START;

 ::Dynamic TextFormatAlign_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_52c40939c4ee2936_55_fromString)
HXDLIN(  55)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("center",d5,25,db,05)) ){
HXLINE(  57)			return 0;
HXDLIN(  57)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("end",db,03,4d,00)) ){
HXLINE(  58)			return 1;
HXDLIN(  58)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("justify",50,df,b5,83)) ){
HXLINE(  59)			return 2;
HXDLIN(  59)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("left",07,08,b0,47)) ){
HXLINE(  60)			return 3;
HXDLIN(  60)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("right",dc,0b,64,e9)) ){
HXLINE(  61)			return 4;
HXDLIN(  61)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("start",62,74,0b,84)) ){
HXLINE(  62)			return 5;
HXDLIN(  62)			goto _hx_goto_0;
            		}
            		/* default */{
HXLINE(  63)			return null();
            		}
            		_hx_goto_0:;
HXLINE(  55)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextFormatAlign_Impl__obj,fromString,return )

::String TextFormatAlign_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_52c40939c4ee2936_69_toString)
HXDLIN(  69)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  71)			return HX_("center",d5,25,db,05);
HXDLIN(  71)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  72)			return HX_("end",db,03,4d,00);
HXDLIN(  72)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==2) ){
HXLINE(  73)			return HX_("justify",50,df,b5,83);
HXDLIN(  73)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==3) ){
HXLINE(  74)			return HX_("left",07,08,b0,47);
HXDLIN(  74)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==4) ){
HXLINE(  75)			return HX_("right",dc,0b,64,e9);
HXDLIN(  75)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==5) ){
HXLINE(  76)			return HX_("start",62,74,0b,84);
HXDLIN(  76)			goto _hx_goto_2;
            		}
            		/* default */{
HXLINE(  77)			return null();
            		}
            		_hx_goto_2:;
HXLINE(  69)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextFormatAlign_Impl__obj,toString,return )


TextFormatAlign_Impl__obj::TextFormatAlign_Impl__obj()
{
}

bool TextFormatAlign_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"toString") ) { outValue = toString_dyn(); return true; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"fromString") ) { outValue = fromString_dyn(); return true; }
	}
	return false;
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *TextFormatAlign_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo TextFormatAlign_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFormatAlign_Impl__obj::CENTER,HX_("CENTER",d5,d1,5d,b8)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFormatAlign_Impl__obj::END,HX_("END",bb,9f,34,00)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFormatAlign_Impl__obj::JUSTIFY,HX_("JUSTIFY",30,b3,89,03)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFormatAlign_Impl__obj::LEFT,HX_("LEFT",07,d0,70,32)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFormatAlign_Impl__obj::RIGHT,HX_("RIGHT",bc,43,52,67)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFormatAlign_Impl__obj::START,HX_("START",42,ac,f9,01)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void TextFormatAlign_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(TextFormatAlign_Impl__obj::CENTER,"CENTER");
	HX_MARK_MEMBER_NAME(TextFormatAlign_Impl__obj::END,"END");
	HX_MARK_MEMBER_NAME(TextFormatAlign_Impl__obj::JUSTIFY,"JUSTIFY");
	HX_MARK_MEMBER_NAME(TextFormatAlign_Impl__obj::LEFT,"LEFT");
	HX_MARK_MEMBER_NAME(TextFormatAlign_Impl__obj::RIGHT,"RIGHT");
	HX_MARK_MEMBER_NAME(TextFormatAlign_Impl__obj::START,"START");
};

#ifdef HXCPP_VISIT_ALLOCS
static void TextFormatAlign_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(TextFormatAlign_Impl__obj::CENTER,"CENTER");
	HX_VISIT_MEMBER_NAME(TextFormatAlign_Impl__obj::END,"END");
	HX_VISIT_MEMBER_NAME(TextFormatAlign_Impl__obj::JUSTIFY,"JUSTIFY");
	HX_VISIT_MEMBER_NAME(TextFormatAlign_Impl__obj::LEFT,"LEFT");
	HX_VISIT_MEMBER_NAME(TextFormatAlign_Impl__obj::RIGHT,"RIGHT");
	HX_VISIT_MEMBER_NAME(TextFormatAlign_Impl__obj::START,"START");
};

#endif

::hx::Class TextFormatAlign_Impl__obj::__mClass;

static ::String TextFormatAlign_Impl__obj_sStaticFields[] = {
	HX_("CENTER",d5,d1,5d,b8),
	HX_("END",bb,9f,34,00),
	HX_("JUSTIFY",30,b3,89,03),
	HX_("LEFT",07,d0,70,32),
	HX_("RIGHT",bc,43,52,67),
	HX_("START",42,ac,f9,01),
	HX_("fromString",db,2d,74,54),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void TextFormatAlign_Impl__obj::__register()
{
	TextFormatAlign_Impl__obj _hx_dummy;
	TextFormatAlign_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.text._TextFormatAlign.TextFormatAlign_Impl_",b8,18,3c,d5);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &TextFormatAlign_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = TextFormatAlign_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(TextFormatAlign_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< TextFormatAlign_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = TextFormatAlign_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = TextFormatAlign_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = TextFormatAlign_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void TextFormatAlign_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_52c40939c4ee2936_17_boot)
HXDLIN(  17)		CENTER = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_52c40939c4ee2936_25_boot)
HXDLIN(  25)		END = 1;
            	}
{
            	HX_STACKFRAME(&_hx_pos_52c40939c4ee2936_31_boot)
HXDLIN(  31)		JUSTIFY = 2;
            	}
{
            	HX_STACKFRAME(&_hx_pos_52c40939c4ee2936_37_boot)
HXDLIN(  37)		LEFT = 3;
            	}
{
            	HX_STACKFRAME(&_hx_pos_52c40939c4ee2936_43_boot)
HXDLIN(  43)		RIGHT = 4;
            	}
{
            	HX_STACKFRAME(&_hx_pos_52c40939c4ee2936_51_boot)
HXDLIN(  51)		START = 5;
            	}
}

} // end namespace openfl
} // end namespace text
} // end namespace _TextFormatAlign
