#include <hxcpp.h>

#ifndef INCLUDED_openfl_display3D__Context3DTriangleFace_Context3DTriangleFace_Impl_
#include <openfl/display3D/_Context3DTriangleFace/Context3DTriangleFace_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_c6faaa6b9f0fc2b9_23_fromString,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_","fromString",0x04ef1c93,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_.fromString","openfl/display3D/Context3DTriangleFace.hx",23,0x186e7db4)
HX_LOCAL_STACK_FRAME(_hx_pos_c6faaa6b9f0fc2b9_35_toString,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_","toString",0xd6ea2164,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_.toString","openfl/display3D/Context3DTriangleFace.hx",35,0x186e7db4)
HX_LOCAL_STACK_FRAME(_hx_pos_c6faaa6b9f0fc2b9_16_boot,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_","boot",0xb50218ea,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_.boot","openfl/display3D/Context3DTriangleFace.hx",16,0x186e7db4)
HX_LOCAL_STACK_FRAME(_hx_pos_c6faaa6b9f0fc2b9_17_boot,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_","boot",0xb50218ea,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_.boot","openfl/display3D/Context3DTriangleFace.hx",17,0x186e7db4)
HX_LOCAL_STACK_FRAME(_hx_pos_c6faaa6b9f0fc2b9_18_boot,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_","boot",0xb50218ea,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_.boot","openfl/display3D/Context3DTriangleFace.hx",18,0x186e7db4)
HX_LOCAL_STACK_FRAME(_hx_pos_c6faaa6b9f0fc2b9_19_boot,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_","boot",0xb50218ea,"openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_.boot","openfl/display3D/Context3DTriangleFace.hx",19,0x186e7db4)
namespace openfl{
namespace display3D{
namespace _Context3DTriangleFace{

void Context3DTriangleFace_Impl__obj::__construct() { }

Dynamic Context3DTriangleFace_Impl__obj::__CreateEmpty() { return new Context3DTriangleFace_Impl__obj; }

void *Context3DTriangleFace_Impl__obj::_hx_vtable = 0;

Dynamic Context3DTriangleFace_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Context3DTriangleFace_Impl__obj > _hx_result = new Context3DTriangleFace_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool Context3DTriangleFace_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x4c963b00;
}

 ::Dynamic Context3DTriangleFace_Impl__obj::BACK;

 ::Dynamic Context3DTriangleFace_Impl__obj::FRONT;

 ::Dynamic Context3DTriangleFace_Impl__obj::FRONT_AND_BACK;

 ::Dynamic Context3DTriangleFace_Impl__obj::NONE;

 ::Dynamic Context3DTriangleFace_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_c6faaa6b9f0fc2b9_23_fromString)
HXDLIN(  23)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("back",27,da,10,41)) ){
HXLINE(  25)			return 0;
HXDLIN(  25)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("front",a9,18,8e,06)) ){
HXLINE(  26)			return 1;
HXDLIN(  26)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("frontAndBack",f5,1e,63,ce)) ){
HXLINE(  27)			return 2;
HXDLIN(  27)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("none",b8,12,0a,49)) ){
HXLINE(  28)			return 3;
HXDLIN(  28)			goto _hx_goto_0;
            		}
            		/* default */{
HXLINE(  29)			return null();
            		}
            		_hx_goto_0:;
HXLINE(  23)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Context3DTriangleFace_Impl__obj,fromString,return )

::String Context3DTriangleFace_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_c6faaa6b9f0fc2b9_35_toString)
HXDLIN(  35)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  37)			return HX_("back",27,da,10,41);
HXDLIN(  37)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  38)			return HX_("front",a9,18,8e,06);
HXDLIN(  38)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==2) ){
HXLINE(  39)			return HX_("frontAndBack",f5,1e,63,ce);
HXDLIN(  39)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==3) ){
HXLINE(  40)			return HX_("none",b8,12,0a,49);
HXDLIN(  40)			goto _hx_goto_2;
            		}
            		/* default */{
HXLINE(  41)			return null();
            		}
            		_hx_goto_2:;
HXLINE(  35)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Context3DTriangleFace_Impl__obj,toString,return )


Context3DTriangleFace_Impl__obj::Context3DTriangleFace_Impl__obj()
{
}

bool Context3DTriangleFace_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
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
static ::hx::StorageInfo *Context3DTriangleFace_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo Context3DTriangleFace_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTriangleFace_Impl__obj::BACK,HX_("BACK",27,a2,d1,2b)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTriangleFace_Impl__obj::FRONT,HX_("FRONT",89,50,7c,84)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTriangleFace_Impl__obj::FRONT_AND_BACK,HX_("FRONT_AND_BACK",a5,3d,6a,c1)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTriangleFace_Impl__obj::NONE,HX_("NONE",b8,da,ca,33)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void Context3DTriangleFace_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Context3DTriangleFace_Impl__obj::BACK,"BACK");
	HX_MARK_MEMBER_NAME(Context3DTriangleFace_Impl__obj::FRONT,"FRONT");
	HX_MARK_MEMBER_NAME(Context3DTriangleFace_Impl__obj::FRONT_AND_BACK,"FRONT_AND_BACK");
	HX_MARK_MEMBER_NAME(Context3DTriangleFace_Impl__obj::NONE,"NONE");
};

#ifdef HXCPP_VISIT_ALLOCS
static void Context3DTriangleFace_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Context3DTriangleFace_Impl__obj::BACK,"BACK");
	HX_VISIT_MEMBER_NAME(Context3DTriangleFace_Impl__obj::FRONT,"FRONT");
	HX_VISIT_MEMBER_NAME(Context3DTriangleFace_Impl__obj::FRONT_AND_BACK,"FRONT_AND_BACK");
	HX_VISIT_MEMBER_NAME(Context3DTriangleFace_Impl__obj::NONE,"NONE");
};

#endif

::hx::Class Context3DTriangleFace_Impl__obj::__mClass;

static ::String Context3DTriangleFace_Impl__obj_sStaticFields[] = {
	HX_("BACK",27,a2,d1,2b),
	HX_("FRONT",89,50,7c,84),
	HX_("FRONT_AND_BACK",a5,3d,6a,c1),
	HX_("NONE",b8,da,ca,33),
	HX_("fromString",db,2d,74,54),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void Context3DTriangleFace_Impl__obj::__register()
{
	Context3DTriangleFace_Impl__obj _hx_dummy;
	Context3DTriangleFace_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.display3D._Context3DTriangleFace.Context3DTriangleFace_Impl_",b6,06,e6,8f);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &Context3DTriangleFace_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = Context3DTriangleFace_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(Context3DTriangleFace_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< Context3DTriangleFace_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = Context3DTriangleFace_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Context3DTriangleFace_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Context3DTriangleFace_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void Context3DTriangleFace_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_c6faaa6b9f0fc2b9_16_boot)
HXDLIN(  16)		BACK = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_c6faaa6b9f0fc2b9_17_boot)
HXDLIN(  17)		FRONT = 1;
            	}
{
            	HX_STACKFRAME(&_hx_pos_c6faaa6b9f0fc2b9_18_boot)
HXDLIN(  18)		FRONT_AND_BACK = 2;
            	}
{
            	HX_STACKFRAME(&_hx_pos_c6faaa6b9f0fc2b9_19_boot)
HXDLIN(  19)		NONE = 3;
            	}
}

} // end namespace openfl
} // end namespace display3D
} // end namespace _Context3DTriangleFace
