#include <hxcpp.h>

#ifndef INCLUDED_openfl_display__GradientType_GradientType_Impl_
#include <openfl/display/_GradientType/GradientType_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_b8cb0a95bea7ff48_27_fromInt,"openfl.display._GradientType.GradientType_Impl_","fromInt",0xbb719b10,"openfl.display._GradientType.GradientType_Impl_.fromInt","openfl/display/GradientType.hx",27,0xadf6e848)
HX_LOCAL_STACK_FRAME(_hx_pos_b8cb0a95bea7ff48_32_fromString,"openfl.display._GradientType.GradientType_Impl_","fromString",0x32cb6550,"openfl.display._GradientType.GradientType_Impl_.fromString","openfl/display/GradientType.hx",32,0xadf6e848)
HX_LOCAL_STACK_FRAME(_hx_pos_b8cb0a95bea7ff48_42_toInt,"openfl.display._GradientType.GradientType_Impl_","toInt",0x5e8fbadf,"openfl.display._GradientType.GradientType_Impl_.toInt","openfl/display/GradientType.hx",42,0xadf6e848)
HX_LOCAL_STACK_FRAME(_hx_pos_b8cb0a95bea7ff48_47_toString,"openfl.display._GradientType.GradientType_Impl_","toString",0xdcddd0e1,"openfl.display._GradientType.GradientType_Impl_.toString","openfl/display/GradientType.hx",47,0xadf6e848)
HX_LOCAL_STACK_FRAME(_hx_pos_b8cb0a95bea7ff48_18_boot,"openfl.display._GradientType.GradientType_Impl_","boot",0xb7af05e7,"openfl.display._GradientType.GradientType_Impl_.boot","openfl/display/GradientType.hx",18,0xadf6e848)
HX_LOCAL_STACK_FRAME(_hx_pos_b8cb0a95bea7ff48_23_boot,"openfl.display._GradientType.GradientType_Impl_","boot",0xb7af05e7,"openfl.display._GradientType.GradientType_Impl_.boot","openfl/display/GradientType.hx",23,0xadf6e848)
namespace openfl{
namespace display{
namespace _GradientType{

void GradientType_Impl__obj::__construct() { }

Dynamic GradientType_Impl__obj::__CreateEmpty() { return new GradientType_Impl__obj; }

void *GradientType_Impl__obj::_hx_vtable = 0;

Dynamic GradientType_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< GradientType_Impl__obj > _hx_result = new GradientType_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool GradientType_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x55fdcb61;
}

 ::Dynamic GradientType_Impl__obj::LINEAR;

 ::Dynamic GradientType_Impl__obj::RADIAL;

 ::Dynamic GradientType_Impl__obj::fromInt( ::Dynamic value){
            	HX_STACKFRAME(&_hx_pos_b8cb0a95bea7ff48_27_fromInt)
HXDLIN(  27)		return value;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(GradientType_Impl__obj,fromInt,return )

 ::Dynamic GradientType_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_b8cb0a95bea7ff48_32_fromString)
HXDLIN(  32)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("linear",e5,51,a0,ec)) ){
HXLINE(  34)			return 0;
HXDLIN(  34)			goto _hx_goto_1;
            		}
            		if (  (_hx_switch_0==HX_("radial",df,be,f6,b0)) ){
HXLINE(  35)			return 1;
HXDLIN(  35)			goto _hx_goto_1;
            		}
            		/* default */{
HXLINE(  36)			return null();
            		}
            		_hx_goto_1:;
HXLINE(  32)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(GradientType_Impl__obj,fromString,return )

 ::Dynamic GradientType_Impl__obj::toInt( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_b8cb0a95bea7ff48_42_toInt)
HXDLIN(  42)		return this1;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(GradientType_Impl__obj,toInt,return )

::String GradientType_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_b8cb0a95bea7ff48_47_toString)
HXDLIN(  47)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  49)			return HX_("linear",e5,51,a0,ec);
HXDLIN(  49)			goto _hx_goto_4;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  50)			return HX_("radial",df,be,f6,b0);
HXDLIN(  50)			goto _hx_goto_4;
            		}
            		/* default */{
HXLINE(  51)			return null();
            		}
            		_hx_goto_4:;
HXLINE(  47)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(GradientType_Impl__obj,toString,return )


GradientType_Impl__obj::GradientType_Impl__obj()
{
}

bool GradientType_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"toInt") ) { outValue = toInt_dyn(); return true; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"fromInt") ) { outValue = fromInt_dyn(); return true; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"toString") ) { outValue = toString_dyn(); return true; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"fromString") ) { outValue = fromString_dyn(); return true; }
	}
	return false;
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *GradientType_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo GradientType_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &GradientType_Impl__obj::LINEAR,HX_("LINEAR",e5,fd,22,9f)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &GradientType_Impl__obj::RADIAL,HX_("RADIAL",df,6a,79,63)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void GradientType_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(GradientType_Impl__obj::LINEAR,"LINEAR");
	HX_MARK_MEMBER_NAME(GradientType_Impl__obj::RADIAL,"RADIAL");
};

#ifdef HXCPP_VISIT_ALLOCS
static void GradientType_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(GradientType_Impl__obj::LINEAR,"LINEAR");
	HX_VISIT_MEMBER_NAME(GradientType_Impl__obj::RADIAL,"RADIAL");
};

#endif

::hx::Class GradientType_Impl__obj::__mClass;

static ::String GradientType_Impl__obj_sStaticFields[] = {
	HX_("LINEAR",e5,fd,22,9f),
	HX_("RADIAL",df,6a,79,63),
	HX_("fromInt",a5,dd,fa,57),
	HX_("fromString",db,2d,74,54),
	HX_("toInt",34,be,11,14),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void GradientType_Impl__obj::__register()
{
	GradientType_Impl__obj _hx_dummy;
	GradientType_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.display._GradientType.GradientType_Impl_",d9,3a,fa,11);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &GradientType_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = GradientType_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(GradientType_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< GradientType_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = GradientType_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = GradientType_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = GradientType_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void GradientType_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_b8cb0a95bea7ff48_18_boot)
HXDLIN(  18)		LINEAR = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_b8cb0a95bea7ff48_23_boot)
HXDLIN(  23)		RADIAL = 1;
            	}
}

} // end namespace openfl
} // end namespace display
} // end namespace _GradientType
