#include <hxcpp.h>

#ifndef INCLUDED_openfl_display3D__Context3DBufferUsage_Context3DBufferUsage_Impl_
#include <openfl/display3D/_Context3DBufferUsage/Context3DBufferUsage_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_02fecb2b926e493f_29_fromString,"openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_","fromString",0xbc8bc5e1,"openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_.fromString","openfl/display3D/Context3DBufferUsage.hx",29,0x57541062)
HX_LOCAL_STACK_FRAME(_hx_pos_02fecb2b926e493f_39_toString,"openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_","toString",0xe8f23b32,"openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_.toString","openfl/display3D/Context3DBufferUsage.hx",39,0x57541062)
HX_LOCAL_STACK_FRAME(_hx_pos_02fecb2b926e493f_18_boot,"openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_","boot",0x95a9b3b8,"openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_.boot","openfl/display3D/Context3DBufferUsage.hx",18,0x57541062)
HX_LOCAL_STACK_FRAME(_hx_pos_02fecb2b926e493f_25_boot,"openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_","boot",0x95a9b3b8,"openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_.boot","openfl/display3D/Context3DBufferUsage.hx",25,0x57541062)
namespace openfl{
namespace display3D{
namespace _Context3DBufferUsage{

void Context3DBufferUsage_Impl__obj::__construct() { }

Dynamic Context3DBufferUsage_Impl__obj::__CreateEmpty() { return new Context3DBufferUsage_Impl__obj; }

void *Context3DBufferUsage_Impl__obj::_hx_vtable = 0;

Dynamic Context3DBufferUsage_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Context3DBufferUsage_Impl__obj > _hx_result = new Context3DBufferUsage_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool Context3DBufferUsage_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x43aa3cc6;
}

 ::Dynamic Context3DBufferUsage_Impl__obj::DYNAMIC_DRAW;

 ::Dynamic Context3DBufferUsage_Impl__obj::STATIC_DRAW;

 ::Dynamic Context3DBufferUsage_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_02fecb2b926e493f_29_fromString)
HXDLIN(  29)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("dynamicDraw",23,23,fe,67)) ){
HXLINE(  31)			return 0;
HXDLIN(  31)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("staticDraw",d2,23,1c,a4)) ){
HXLINE(  32)			return 1;
HXDLIN(  32)			goto _hx_goto_0;
            		}
            		/* default */{
HXLINE(  33)			return null();
            		}
            		_hx_goto_0:;
HXLINE(  29)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Context3DBufferUsage_Impl__obj,fromString,return )

::String Context3DBufferUsage_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_02fecb2b926e493f_39_toString)
HXDLIN(  39)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  41)			return HX_("dynamicDraw",23,23,fe,67);
HXDLIN(  41)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  42)			return HX_("staticDraw",d2,23,1c,a4);
HXDLIN(  42)			goto _hx_goto_2;
            		}
            		/* default */{
HXLINE(  43)			return null();
            		}
            		_hx_goto_2:;
HXLINE(  39)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Context3DBufferUsage_Impl__obj,toString,return )


Context3DBufferUsage_Impl__obj::Context3DBufferUsage_Impl__obj()
{
}

bool Context3DBufferUsage_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
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
static ::hx::StorageInfo *Context3DBufferUsage_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo Context3DBufferUsage_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DBufferUsage_Impl__obj::DYNAMIC_DRAW,HX_("DYNAMIC_DRAW",24,04,1f,24)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DBufferUsage_Impl__obj::STATIC_DRAW,HX_("STATIC_DRAW",75,50,2f,ba)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void Context3DBufferUsage_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Context3DBufferUsage_Impl__obj::DYNAMIC_DRAW,"DYNAMIC_DRAW");
	HX_MARK_MEMBER_NAME(Context3DBufferUsage_Impl__obj::STATIC_DRAW,"STATIC_DRAW");
};

#ifdef HXCPP_VISIT_ALLOCS
static void Context3DBufferUsage_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Context3DBufferUsage_Impl__obj::DYNAMIC_DRAW,"DYNAMIC_DRAW");
	HX_VISIT_MEMBER_NAME(Context3DBufferUsage_Impl__obj::STATIC_DRAW,"STATIC_DRAW");
};

#endif

::hx::Class Context3DBufferUsage_Impl__obj::__mClass;

static ::String Context3DBufferUsage_Impl__obj_sStaticFields[] = {
	HX_("DYNAMIC_DRAW",24,04,1f,24),
	HX_("STATIC_DRAW",75,50,2f,ba),
	HX_("fromString",db,2d,74,54),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void Context3DBufferUsage_Impl__obj::__register()
{
	Context3DBufferUsage_Impl__obj _hx_dummy;
	Context3DBufferUsage_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.display3D._Context3DBufferUsage.Context3DBufferUsage_Impl_",a8,5e,c0,c7);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &Context3DBufferUsage_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = Context3DBufferUsage_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(Context3DBufferUsage_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< Context3DBufferUsage_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = Context3DBufferUsage_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Context3DBufferUsage_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Context3DBufferUsage_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void Context3DBufferUsage_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_02fecb2b926e493f_18_boot)
HXDLIN(  18)		DYNAMIC_DRAW = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_02fecb2b926e493f_25_boot)
HXDLIN(  25)		STATIC_DRAW = 1;
            	}
}

} // end namespace openfl
} // end namespace display3D
} // end namespace _Context3DBufferUsage
