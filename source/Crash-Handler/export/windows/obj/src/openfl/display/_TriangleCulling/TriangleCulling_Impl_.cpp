#include <hxcpp.h>

#ifndef INCLUDED_openfl_display__TriangleCulling_TriangleCulling_Impl_
#include <openfl/display/_TriangleCulling/TriangleCulling_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_187b199ba6956423_48_fromString,"openfl.display._TriangleCulling.TriangleCulling_Impl_","fromString",0x878f171c,"openfl.display._TriangleCulling.TriangleCulling_Impl_.fromString","openfl/display/TriangleCulling.hx",48,0x58d0bba2)
HX_LOCAL_STACK_FRAME(_hx_pos_187b199ba6956423_59_toString,"openfl.display._TriangleCulling.TriangleCulling_Impl_","toString",0x9ce137ad,"openfl.display._TriangleCulling.TriangleCulling_Impl_.toString","openfl/display/TriangleCulling.hx",59,0x58d0bba2)
HX_LOCAL_STACK_FRAME(_hx_pos_187b199ba6956423_33_boot,"openfl.display._TriangleCulling.TriangleCulling_Impl_","boot",0x162c16b3,"openfl.display._TriangleCulling.TriangleCulling_Impl_.boot","openfl/display/TriangleCulling.hx",33,0x58d0bba2)
HX_LOCAL_STACK_FRAME(_hx_pos_187b199ba6956423_38_boot,"openfl.display._TriangleCulling.TriangleCulling_Impl_","boot",0x162c16b3,"openfl.display._TriangleCulling.TriangleCulling_Impl_.boot","openfl/display/TriangleCulling.hx",38,0x58d0bba2)
HX_LOCAL_STACK_FRAME(_hx_pos_187b199ba6956423_44_boot,"openfl.display._TriangleCulling.TriangleCulling_Impl_","boot",0x162c16b3,"openfl.display._TriangleCulling.TriangleCulling_Impl_.boot","openfl/display/TriangleCulling.hx",44,0x58d0bba2)
namespace openfl{
namespace display{
namespace _TriangleCulling{

void TriangleCulling_Impl__obj::__construct() { }

Dynamic TriangleCulling_Impl__obj::__CreateEmpty() { return new TriangleCulling_Impl__obj; }

void *TriangleCulling_Impl__obj::_hx_vtable = 0;

Dynamic TriangleCulling_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< TriangleCulling_Impl__obj > _hx_result = new TriangleCulling_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool TriangleCulling_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x74070d15;
}

 ::Dynamic TriangleCulling_Impl__obj::NEGATIVE;

 ::Dynamic TriangleCulling_Impl__obj::NONE;

 ::Dynamic TriangleCulling_Impl__obj::POSITIVE;

 ::Dynamic TriangleCulling_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_187b199ba6956423_48_fromString)
HXDLIN(  48)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("negative",75,26,42,51)) ){
HXLINE(  50)			return 0;
HXDLIN(  50)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("none",b8,12,0a,49)) ){
HXLINE(  51)			return 1;
HXDLIN(  51)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("positive",b9,a6,fa,ca)) ){
HXLINE(  52)			return 2;
HXDLIN(  52)			goto _hx_goto_0;
            		}
            		/* default */{
HXLINE(  53)			return null();
            		}
            		_hx_goto_0:;
HXLINE(  48)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TriangleCulling_Impl__obj,fromString,return )

::String TriangleCulling_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_187b199ba6956423_59_toString)
HXDLIN(  59)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  61)			return HX_("negative",75,26,42,51);
HXDLIN(  61)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  62)			return HX_("none",b8,12,0a,49);
HXDLIN(  62)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==2) ){
HXLINE(  63)			return HX_("positive",b9,a6,fa,ca);
HXDLIN(  63)			goto _hx_goto_2;
            		}
            		/* default */{
HXLINE(  64)			return null();
            		}
            		_hx_goto_2:;
HXLINE(  59)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TriangleCulling_Impl__obj,toString,return )


TriangleCulling_Impl__obj::TriangleCulling_Impl__obj()
{
}

bool TriangleCulling_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
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
static ::hx::StorageInfo *TriangleCulling_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo TriangleCulling_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TriangleCulling_Impl__obj::NEGATIVE,HX_("NEGATIVE",75,b6,c7,aa)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TriangleCulling_Impl__obj::NONE,HX_("NONE",b8,da,ca,33)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TriangleCulling_Impl__obj::POSITIVE,HX_("POSITIVE",b9,36,80,24)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void TriangleCulling_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(TriangleCulling_Impl__obj::NEGATIVE,"NEGATIVE");
	HX_MARK_MEMBER_NAME(TriangleCulling_Impl__obj::NONE,"NONE");
	HX_MARK_MEMBER_NAME(TriangleCulling_Impl__obj::POSITIVE,"POSITIVE");
};

#ifdef HXCPP_VISIT_ALLOCS
static void TriangleCulling_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(TriangleCulling_Impl__obj::NEGATIVE,"NEGATIVE");
	HX_VISIT_MEMBER_NAME(TriangleCulling_Impl__obj::NONE,"NONE");
	HX_VISIT_MEMBER_NAME(TriangleCulling_Impl__obj::POSITIVE,"POSITIVE");
};

#endif

::hx::Class TriangleCulling_Impl__obj::__mClass;

static ::String TriangleCulling_Impl__obj_sStaticFields[] = {
	HX_("NEGATIVE",75,b6,c7,aa),
	HX_("NONE",b8,da,ca,33),
	HX_("POSITIVE",b9,36,80,24),
	HX_("fromString",db,2d,74,54),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void TriangleCulling_Impl__obj::__register()
{
	TriangleCulling_Impl__obj _hx_dummy;
	TriangleCulling_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.display._TriangleCulling.TriangleCulling_Impl_",8d,dd,ae,4f);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &TriangleCulling_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = TriangleCulling_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(TriangleCulling_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< TriangleCulling_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = TriangleCulling_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = TriangleCulling_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = TriangleCulling_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void TriangleCulling_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_187b199ba6956423_33_boot)
HXDLIN(  33)		NEGATIVE = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_187b199ba6956423_38_boot)
HXDLIN(  38)		NONE = 1;
            	}
{
            	HX_STACKFRAME(&_hx_pos_187b199ba6956423_44_boot)
HXDLIN(  44)		POSITIVE = 2;
            	}
}

} // end namespace openfl
} // end namespace display
} // end namespace _TriangleCulling
