#include <hxcpp.h>

#ifndef INCLUDED_openfl_text__FontStyle_FontStyle_Impl_
#include <openfl/text/_FontStyle/FontStyle_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_2a9064c0a4b35973_42_fromString,"openfl.text._FontStyle.FontStyle_Impl_","fromString",0x9783fd8f,"openfl.text._FontStyle.FontStyle_Impl_.fromString","openfl/text/FontStyle.hx",42,0x6b07f79f)
HX_LOCAL_STACK_FRAME(_hx_pos_2a9064c0a4b35973_54_toString,"openfl.text._FontStyle.FontStyle_Impl_","toString",0x0cd38b60,"openfl.text._FontStyle.FontStyle_Impl_.toString","openfl/text/FontStyle.hx",54,0x6b07f79f)
HX_LOCAL_STACK_FRAME(_hx_pos_2a9064c0a4b35973_17_boot,"openfl.text._FontStyle.FontStyle_Impl_","boot",0x44f7d4e6,"openfl.text._FontStyle.FontStyle_Impl_.boot","openfl/text/FontStyle.hx",17,0x6b07f79f)
HX_LOCAL_STACK_FRAME(_hx_pos_2a9064c0a4b35973_24_boot,"openfl.text._FontStyle.FontStyle_Impl_","boot",0x44f7d4e6,"openfl.text._FontStyle.FontStyle_Impl_.boot","openfl/text/FontStyle.hx",24,0x6b07f79f)
HX_LOCAL_STACK_FRAME(_hx_pos_2a9064c0a4b35973_31_boot,"openfl.text._FontStyle.FontStyle_Impl_","boot",0x44f7d4e6,"openfl.text._FontStyle.FontStyle_Impl_.boot","openfl/text/FontStyle.hx",31,0x6b07f79f)
HX_LOCAL_STACK_FRAME(_hx_pos_2a9064c0a4b35973_38_boot,"openfl.text._FontStyle.FontStyle_Impl_","boot",0x44f7d4e6,"openfl.text._FontStyle.FontStyle_Impl_.boot","openfl/text/FontStyle.hx",38,0x6b07f79f)
namespace openfl{
namespace text{
namespace _FontStyle{

void FontStyle_Impl__obj::__construct() { }

Dynamic FontStyle_Impl__obj::__CreateEmpty() { return new FontStyle_Impl__obj; }

void *FontStyle_Impl__obj::_hx_vtable = 0;

Dynamic FontStyle_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< FontStyle_Impl__obj > _hx_result = new FontStyle_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool FontStyle_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x778d69be;
}

 ::Dynamic FontStyle_Impl__obj::BOLD;

 ::Dynamic FontStyle_Impl__obj::BOLD_ITALIC;

 ::Dynamic FontStyle_Impl__obj::ITALIC;

 ::Dynamic FontStyle_Impl__obj::REGULAR;

 ::Dynamic FontStyle_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_2a9064c0a4b35973_42_fromString)
HXDLIN(  42)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("bold",85,81,1b,41)) ){
HXLINE(  44)			return 0;
HXDLIN(  44)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("boldItalic",55,96,d1,ad)) ){
HXLINE(  45)			return 1;
HXDLIN(  45)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("italic",f0,2e,64,06)) ){
HXLINE(  46)			return 2;
HXDLIN(  46)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("regular",5c,52,88,82)) ){
HXLINE(  47)			return 3;
HXDLIN(  47)			goto _hx_goto_0;
            		}
            		/* default */{
HXLINE(  48)			return null();
            		}
            		_hx_goto_0:;
HXLINE(  42)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(FontStyle_Impl__obj,fromString,return )

::String FontStyle_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_2a9064c0a4b35973_54_toString)
HXDLIN(  54)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  56)			return HX_("bold",85,81,1b,41);
HXDLIN(  56)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  57)			return HX_("boldItalic",55,96,d1,ad);
HXDLIN(  57)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==2) ){
HXLINE(  58)			return HX_("italic",f0,2e,64,06);
HXDLIN(  58)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==3) ){
HXLINE(  59)			return HX_("regular",5c,52,88,82);
HXDLIN(  59)			goto _hx_goto_2;
            		}
            		/* default */{
HXLINE(  60)			return null();
            		}
            		_hx_goto_2:;
HXLINE(  54)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(FontStyle_Impl__obj,toString,return )


FontStyle_Impl__obj::FontStyle_Impl__obj()
{
}

bool FontStyle_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
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
static ::hx::StorageInfo *FontStyle_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo FontStyle_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &FontStyle_Impl__obj::BOLD,HX_("BOLD",85,49,dc,2b)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &FontStyle_Impl__obj::BOLD_ITALIC,HX_("BOLD_ITALIC",aa,0d,c2,88)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &FontStyle_Impl__obj::ITALIC,HX_("ITALIC",f0,da,e6,b8)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &FontStyle_Impl__obj::REGULAR,HX_("REGULAR",3c,26,5c,02)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void FontStyle_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(FontStyle_Impl__obj::BOLD,"BOLD");
	HX_MARK_MEMBER_NAME(FontStyle_Impl__obj::BOLD_ITALIC,"BOLD_ITALIC");
	HX_MARK_MEMBER_NAME(FontStyle_Impl__obj::ITALIC,"ITALIC");
	HX_MARK_MEMBER_NAME(FontStyle_Impl__obj::REGULAR,"REGULAR");
};

#ifdef HXCPP_VISIT_ALLOCS
static void FontStyle_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(FontStyle_Impl__obj::BOLD,"BOLD");
	HX_VISIT_MEMBER_NAME(FontStyle_Impl__obj::BOLD_ITALIC,"BOLD_ITALIC");
	HX_VISIT_MEMBER_NAME(FontStyle_Impl__obj::ITALIC,"ITALIC");
	HX_VISIT_MEMBER_NAME(FontStyle_Impl__obj::REGULAR,"REGULAR");
};

#endif

::hx::Class FontStyle_Impl__obj::__mClass;

static ::String FontStyle_Impl__obj_sStaticFields[] = {
	HX_("BOLD",85,49,dc,2b),
	HX_("BOLD_ITALIC",aa,0d,c2,88),
	HX_("ITALIC",f0,da,e6,b8),
	HX_("REGULAR",3c,26,5c,02),
	HX_("fromString",db,2d,74,54),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void FontStyle_Impl__obj::__register()
{
	FontStyle_Impl__obj _hx_dummy;
	FontStyle_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.text._FontStyle.FontStyle_Impl_",3a,cc,41,0b);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &FontStyle_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = FontStyle_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(FontStyle_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< FontStyle_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = FontStyle_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = FontStyle_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = FontStyle_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void FontStyle_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_2a9064c0a4b35973_17_boot)
HXDLIN(  17)		BOLD = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_2a9064c0a4b35973_24_boot)
HXDLIN(  24)		BOLD_ITALIC = 1;
            	}
{
            	HX_STACKFRAME(&_hx_pos_2a9064c0a4b35973_31_boot)
HXDLIN(  31)		ITALIC = 2;
            	}
{
            	HX_STACKFRAME(&_hx_pos_2a9064c0a4b35973_38_boot)
HXDLIN(  38)		REGULAR = 3;
            	}
}

} // end namespace openfl
} // end namespace text
} // end namespace _FontStyle
