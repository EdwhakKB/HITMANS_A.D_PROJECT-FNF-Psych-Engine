#include <hxcpp.h>

#ifndef INCLUDED_openfl_display3D__Context3DCompareMode_Context3DCompareMode_Impl_
#include <openfl/display3D/_Context3DCompareMode/Context3DCompareMode_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_58_fromString,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","fromString",0x9ed2cd41,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.fromString","openfl/display3D/Context3DCompareMode.hx",58,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_74_toString,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","toString",0xbdb6aa92,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.toString","openfl/display3D/Context3DCompareMode.hx",74,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_19_boot,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","boot",0xb0eaf318,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.boot","openfl/display3D/Context3DCompareMode.hx",19,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_24_boot,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","boot",0xb0eaf318,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.boot","openfl/display3D/Context3DCompareMode.hx",24,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_29_boot,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","boot",0xb0eaf318,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.boot","openfl/display3D/Context3DCompareMode.hx",29,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_34_boot,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","boot",0xb0eaf318,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.boot","openfl/display3D/Context3DCompareMode.hx",34,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_39_boot,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","boot",0xb0eaf318,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.boot","openfl/display3D/Context3DCompareMode.hx",39,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_44_boot,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","boot",0xb0eaf318,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.boot","openfl/display3D/Context3DCompareMode.hx",44,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_49_boot,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","boot",0xb0eaf318,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.boot","openfl/display3D/Context3DCompareMode.hx",49,0x9103941b)
HX_LOCAL_STACK_FRAME(_hx_pos_a405bb176409d231_54_boot,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_","boot",0xb0eaf318,"openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_.boot","openfl/display3D/Context3DCompareMode.hx",54,0x9103941b)
namespace openfl{
namespace display3D{
namespace _Context3DCompareMode{

void Context3DCompareMode_Impl__obj::__construct() { }

Dynamic Context3DCompareMode_Impl__obj::__CreateEmpty() { return new Context3DCompareMode_Impl__obj; }

void *Context3DCompareMode_Impl__obj::_hx_vtable = 0;

Dynamic Context3DCompareMode_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Context3DCompareMode_Impl__obj > _hx_result = new Context3DCompareMode_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool Context3DCompareMode_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x615ecdd4;
}

 ::Dynamic Context3DCompareMode_Impl__obj::ALWAYS;

 ::Dynamic Context3DCompareMode_Impl__obj::EQUAL;

 ::Dynamic Context3DCompareMode_Impl__obj::GREATER;

 ::Dynamic Context3DCompareMode_Impl__obj::GREATER_EQUAL;

 ::Dynamic Context3DCompareMode_Impl__obj::LESS;

 ::Dynamic Context3DCompareMode_Impl__obj::LESS_EQUAL;

 ::Dynamic Context3DCompareMode_Impl__obj::NEVER;

 ::Dynamic Context3DCompareMode_Impl__obj::NOT_EQUAL;

 ::Dynamic Context3DCompareMode_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_58_fromString)
HXDLIN(  58)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("always",cf,0e,d7,46)) ){
HXLINE(  60)			return 0;
HXDLIN(  60)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("equal",b4,cf,82,72)) ){
HXLINE(  61)			return 1;
HXDLIN(  61)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("greater",fa,90,c0,b7)) ){
HXLINE(  62)			return 2;
HXDLIN(  62)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("greaterEqual",5a,e4,1d,8f)) ){
HXLINE(  63)			return 3;
HXDLIN(  63)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("less",59,13,b0,47)) ){
HXLINE(  64)			return 4;
HXDLIN(  64)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("lessEqual",9b,69,9e,3d)) ){
HXLINE(  65)			return 5;
HXDLIN(  65)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("never",8c,3e,30,99)) ){
HXLINE(  66)			return 6;
HXDLIN(  66)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("notEqual",a1,a1,91,02)) ){
HXLINE(  67)			return 7;
HXDLIN(  67)			goto _hx_goto_0;
            		}
            		/* default */{
HXLINE(  68)			return null();
            		}
            		_hx_goto_0:;
HXLINE(  58)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Context3DCompareMode_Impl__obj,fromString,return )

::String Context3DCompareMode_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_74_toString)
HXDLIN(  74)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  76)			return HX_("always",cf,0e,d7,46);
HXDLIN(  76)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  77)			return HX_("equal",b4,cf,82,72);
HXDLIN(  77)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==2) ){
HXLINE(  78)			return HX_("greater",fa,90,c0,b7);
HXDLIN(  78)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==3) ){
HXLINE(  79)			return HX_("greaterEqual",5a,e4,1d,8f);
HXDLIN(  79)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==4) ){
HXLINE(  80)			return HX_("less",59,13,b0,47);
HXDLIN(  80)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==5) ){
HXLINE(  81)			return HX_("lessEqual",9b,69,9e,3d);
HXDLIN(  81)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==6) ){
HXLINE(  82)			return HX_("never",8c,3e,30,99);
HXDLIN(  82)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==7) ){
HXLINE(  83)			return HX_("notEqual",a1,a1,91,02);
HXDLIN(  83)			goto _hx_goto_2;
            		}
            		/* default */{
HXLINE(  84)			return null();
            		}
            		_hx_goto_2:;
HXLINE(  74)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Context3DCompareMode_Impl__obj,toString,return )


Context3DCompareMode_Impl__obj::Context3DCompareMode_Impl__obj()
{
}

bool Context3DCompareMode_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
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
static ::hx::StorageInfo *Context3DCompareMode_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo Context3DCompareMode_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DCompareMode_Impl__obj::ALWAYS,HX_("ALWAYS",cf,ba,59,f9)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DCompareMode_Impl__obj::EQUAL,HX_("EQUAL",94,07,71,f0)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DCompareMode_Impl__obj::GREATER,HX_("GREATER",da,64,94,37)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DCompareMode_Impl__obj::GREATER_EQUAL,HX_("GREATER_EQUAL",2f,d3,96,d6)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DCompareMode_Impl__obj::LESS,HX_("LESS",59,db,70,32)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DCompareMode_Impl__obj::LESS_EQUAL,HX_("LESS_EQUAL",ee,b2,55,e4)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DCompareMode_Impl__obj::NEVER,HX_("NEVER",6c,76,1e,17)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DCompareMode_Impl__obj::NOT_EQUAL,HX_("NOT_EQUAL",08,7c,82,7d)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void Context3DCompareMode_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Context3DCompareMode_Impl__obj::ALWAYS,"ALWAYS");
	HX_MARK_MEMBER_NAME(Context3DCompareMode_Impl__obj::EQUAL,"EQUAL");
	HX_MARK_MEMBER_NAME(Context3DCompareMode_Impl__obj::GREATER,"GREATER");
	HX_MARK_MEMBER_NAME(Context3DCompareMode_Impl__obj::GREATER_EQUAL,"GREATER_EQUAL");
	HX_MARK_MEMBER_NAME(Context3DCompareMode_Impl__obj::LESS,"LESS");
	HX_MARK_MEMBER_NAME(Context3DCompareMode_Impl__obj::LESS_EQUAL,"LESS_EQUAL");
	HX_MARK_MEMBER_NAME(Context3DCompareMode_Impl__obj::NEVER,"NEVER");
	HX_MARK_MEMBER_NAME(Context3DCompareMode_Impl__obj::NOT_EQUAL,"NOT_EQUAL");
};

#ifdef HXCPP_VISIT_ALLOCS
static void Context3DCompareMode_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Context3DCompareMode_Impl__obj::ALWAYS,"ALWAYS");
	HX_VISIT_MEMBER_NAME(Context3DCompareMode_Impl__obj::EQUAL,"EQUAL");
	HX_VISIT_MEMBER_NAME(Context3DCompareMode_Impl__obj::GREATER,"GREATER");
	HX_VISIT_MEMBER_NAME(Context3DCompareMode_Impl__obj::GREATER_EQUAL,"GREATER_EQUAL");
	HX_VISIT_MEMBER_NAME(Context3DCompareMode_Impl__obj::LESS,"LESS");
	HX_VISIT_MEMBER_NAME(Context3DCompareMode_Impl__obj::LESS_EQUAL,"LESS_EQUAL");
	HX_VISIT_MEMBER_NAME(Context3DCompareMode_Impl__obj::NEVER,"NEVER");
	HX_VISIT_MEMBER_NAME(Context3DCompareMode_Impl__obj::NOT_EQUAL,"NOT_EQUAL");
};

#endif

::hx::Class Context3DCompareMode_Impl__obj::__mClass;

static ::String Context3DCompareMode_Impl__obj_sStaticFields[] = {
	HX_("ALWAYS",cf,ba,59,f9),
	HX_("EQUAL",94,07,71,f0),
	HX_("GREATER",da,64,94,37),
	HX_("GREATER_EQUAL",2f,d3,96,d6),
	HX_("LESS",59,db,70,32),
	HX_("LESS_EQUAL",ee,b2,55,e4),
	HX_("NEVER",6c,76,1e,17),
	HX_("NOT_EQUAL",08,7c,82,7d),
	HX_("fromString",db,2d,74,54),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void Context3DCompareMode_Impl__obj::__register()
{
	Context3DCompareMode_Impl__obj _hx_dummy;
	Context3DCompareMode_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.display3D._Context3DCompareMode.Context3DCompareMode_Impl_",48,5b,c7,5e);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &Context3DCompareMode_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = Context3DCompareMode_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(Context3DCompareMode_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< Context3DCompareMode_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = Context3DCompareMode_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Context3DCompareMode_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Context3DCompareMode_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void Context3DCompareMode_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_19_boot)
HXDLIN(  19)		ALWAYS = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_24_boot)
HXDLIN(  24)		EQUAL = 1;
            	}
{
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_29_boot)
HXDLIN(  29)		GREATER = 2;
            	}
{
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_34_boot)
HXDLIN(  34)		GREATER_EQUAL = 3;
            	}
{
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_39_boot)
HXDLIN(  39)		LESS = 4;
            	}
{
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_44_boot)
HXDLIN(  44)		LESS_EQUAL = 5;
            	}
{
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_49_boot)
HXDLIN(  49)		NEVER = 6;
            	}
{
            	HX_STACKFRAME(&_hx_pos_a405bb176409d231_54_boot)
HXDLIN(  54)		NOT_EQUAL = 7;
            	}
}

} // end namespace openfl
} // end namespace display3D
} // end namespace _Context3DCompareMode
