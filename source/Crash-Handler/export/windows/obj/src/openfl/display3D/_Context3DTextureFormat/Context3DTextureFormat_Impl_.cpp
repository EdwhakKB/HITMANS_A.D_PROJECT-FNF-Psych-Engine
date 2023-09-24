#include <hxcpp.h>

#ifndef INCLUDED_openfl_display3D__Context3DTextureFormat_Context3DTextureFormat_Impl_
#include <openfl/display3D/_Context3DTextureFormat/Context3DTextureFormat_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_ce38ee0aefe74adb_47_fromString,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_","fromString",0xc71d5181,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_.fromString","openfl/display3D/Context3DTextureFormat.hx",47,0xa18085d1)
HX_LOCAL_STACK_FRAME(_hx_pos_ce38ee0aefe74adb_61_toString,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_","toString",0xc7ab9ed2,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_.toString","openfl/display3D/Context3DTextureFormat.hx",61,0xa18085d1)
HX_LOCAL_STACK_FRAME(_hx_pos_ce38ee0aefe74adb_18_boot,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_","boot",0x5fc0c758,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_.boot","openfl/display3D/Context3DTextureFormat.hx",18,0xa18085d1)
HX_LOCAL_STACK_FRAME(_hx_pos_ce38ee0aefe74adb_23_boot,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_","boot",0x5fc0c758,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_.boot","openfl/display3D/Context3DTextureFormat.hx",23,0xa18085d1)
HX_LOCAL_STACK_FRAME(_hx_pos_ce38ee0aefe74adb_28_boot,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_","boot",0x5fc0c758,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_.boot","openfl/display3D/Context3DTextureFormat.hx",28,0xa18085d1)
HX_LOCAL_STACK_FRAME(_hx_pos_ce38ee0aefe74adb_33_boot,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_","boot",0x5fc0c758,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_.boot","openfl/display3D/Context3DTextureFormat.hx",33,0xa18085d1)
HX_LOCAL_STACK_FRAME(_hx_pos_ce38ee0aefe74adb_38_boot,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_","boot",0x5fc0c758,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_.boot","openfl/display3D/Context3DTextureFormat.hx",38,0xa18085d1)
HX_LOCAL_STACK_FRAME(_hx_pos_ce38ee0aefe74adb_43_boot,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_","boot",0x5fc0c758,"openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_.boot","openfl/display3D/Context3DTextureFormat.hx",43,0xa18085d1)
namespace openfl{
namespace display3D{
namespace _Context3DTextureFormat{

void Context3DTextureFormat_Impl__obj::__construct() { }

Dynamic Context3DTextureFormat_Impl__obj::__CreateEmpty() { return new Context3DTextureFormat_Impl__obj; }

void *Context3DTextureFormat_Impl__obj::_hx_vtable = 0;

Dynamic Context3DTextureFormat_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Context3DTextureFormat_Impl__obj > _hx_result = new Context3DTextureFormat_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool Context3DTextureFormat_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x7feceabc;
}

 ::Dynamic Context3DTextureFormat_Impl__obj::BGR_PACKED;

 ::Dynamic Context3DTextureFormat_Impl__obj::BGRA;

 ::Dynamic Context3DTextureFormat_Impl__obj::BGRA_PACKED;

 ::Dynamic Context3DTextureFormat_Impl__obj::COMPRESSED;

 ::Dynamic Context3DTextureFormat_Impl__obj::COMPRESSED_ALPHA;

 ::Dynamic Context3DTextureFormat_Impl__obj::RGBA_HALF_FLOAT;

 ::Dynamic Context3DTextureFormat_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_ce38ee0aefe74adb_47_fromString)
HXDLIN(  47)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("bgrPacked565",6f,69,33,84)) ){
HXLINE(  49)			return 0;
HXDLIN(  49)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("bgra",b4,74,15,41)) ){
HXLINE(  50)			return 1;
HXDLIN(  50)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("bgraPacked4444",4c,10,af,4f)) ){
HXLINE(  51)			return 2;
HXDLIN(  51)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("compressed",81,4c,da,67)) ){
HXLINE(  52)			return 3;
HXDLIN(  52)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("compressedAlpha",1d,d7,1f,4a)) ){
HXLINE(  53)			return 4;
HXDLIN(  53)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("rgbaHalfFloat",95,5b,55,9e)) ){
HXLINE(  54)			return 5;
HXDLIN(  54)			goto _hx_goto_0;
            		}
            		/* default */{
HXLINE(  55)			return null();
            		}
            		_hx_goto_0:;
HXLINE(  47)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Context3DTextureFormat_Impl__obj,fromString,return )

::String Context3DTextureFormat_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_ce38ee0aefe74adb_61_toString)
HXDLIN(  61)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  63)			return HX_("bgrPacked565",6f,69,33,84);
HXDLIN(  63)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  64)			return HX_("bgra",b4,74,15,41);
HXDLIN(  64)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==2) ){
HXLINE(  65)			return HX_("bgraPacked4444",4c,10,af,4f);
HXDLIN(  65)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==3) ){
HXLINE(  66)			return HX_("compressed",81,4c,da,67);
HXDLIN(  66)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==4) ){
HXLINE(  67)			return HX_("compressedAlpha",1d,d7,1f,4a);
HXDLIN(  67)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==5) ){
HXLINE(  68)			return HX_("rgbaHalfFloat",95,5b,55,9e);
HXDLIN(  68)			goto _hx_goto_2;
            		}
            		/* default */{
HXLINE(  69)			return null();
            		}
            		_hx_goto_2:;
HXLINE(  61)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Context3DTextureFormat_Impl__obj,toString,return )


Context3DTextureFormat_Impl__obj::Context3DTextureFormat_Impl__obj()
{
}

bool Context3DTextureFormat_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
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
static ::hx::StorageInfo *Context3DTextureFormat_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo Context3DTextureFormat_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTextureFormat_Impl__obj::BGR_PACKED,HX_("BGR_PACKED",ca,a9,e1,6a)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTextureFormat_Impl__obj::BGRA,HX_("BGRA",b4,3c,d6,2b)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTextureFormat_Impl__obj::BGRA_PACKED,HX_("BGRA_PACKED",e3,96,b3,a9)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTextureFormat_Impl__obj::COMPRESSED,HX_("COMPRESSED",81,c0,e3,59)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTextureFormat_Impl__obj::COMPRESSED_ALPHA,HX_("COMPRESSED_ALPHA",c0,bd,f0,0e)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &Context3DTextureFormat_Impl__obj::RGBA_HALF_FLOAT,HX_("RGBA_HALF_FLOAT",9b,47,f2,b0)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void Context3DTextureFormat_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Context3DTextureFormat_Impl__obj::BGR_PACKED,"BGR_PACKED");
	HX_MARK_MEMBER_NAME(Context3DTextureFormat_Impl__obj::BGRA,"BGRA");
	HX_MARK_MEMBER_NAME(Context3DTextureFormat_Impl__obj::BGRA_PACKED,"BGRA_PACKED");
	HX_MARK_MEMBER_NAME(Context3DTextureFormat_Impl__obj::COMPRESSED,"COMPRESSED");
	HX_MARK_MEMBER_NAME(Context3DTextureFormat_Impl__obj::COMPRESSED_ALPHA,"COMPRESSED_ALPHA");
	HX_MARK_MEMBER_NAME(Context3DTextureFormat_Impl__obj::RGBA_HALF_FLOAT,"RGBA_HALF_FLOAT");
};

#ifdef HXCPP_VISIT_ALLOCS
static void Context3DTextureFormat_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Context3DTextureFormat_Impl__obj::BGR_PACKED,"BGR_PACKED");
	HX_VISIT_MEMBER_NAME(Context3DTextureFormat_Impl__obj::BGRA,"BGRA");
	HX_VISIT_MEMBER_NAME(Context3DTextureFormat_Impl__obj::BGRA_PACKED,"BGRA_PACKED");
	HX_VISIT_MEMBER_NAME(Context3DTextureFormat_Impl__obj::COMPRESSED,"COMPRESSED");
	HX_VISIT_MEMBER_NAME(Context3DTextureFormat_Impl__obj::COMPRESSED_ALPHA,"COMPRESSED_ALPHA");
	HX_VISIT_MEMBER_NAME(Context3DTextureFormat_Impl__obj::RGBA_HALF_FLOAT,"RGBA_HALF_FLOAT");
};

#endif

::hx::Class Context3DTextureFormat_Impl__obj::__mClass;

static ::String Context3DTextureFormat_Impl__obj_sStaticFields[] = {
	HX_("BGR_PACKED",ca,a9,e1,6a),
	HX_("BGRA",b4,3c,d6,2b),
	HX_("BGRA_PACKED",e3,96,b3,a9),
	HX_("COMPRESSED",81,c0,e3,59),
	HX_("COMPRESSED_ALPHA",c0,bd,f0,0e),
	HX_("RGBA_HALF_FLOAT",9b,47,f2,b0),
	HX_("fromString",db,2d,74,54),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void Context3DTextureFormat_Impl__obj::__register()
{
	Context3DTextureFormat_Impl__obj _hx_dummy;
	Context3DTextureFormat_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.display3D._Context3DTextureFormat.Context3DTextureFormat_Impl_",08,ef,41,50);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &Context3DTextureFormat_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = Context3DTextureFormat_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(Context3DTextureFormat_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< Context3DTextureFormat_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = Context3DTextureFormat_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Context3DTextureFormat_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Context3DTextureFormat_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void Context3DTextureFormat_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_ce38ee0aefe74adb_18_boot)
HXDLIN(  18)		BGR_PACKED = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_ce38ee0aefe74adb_23_boot)
HXDLIN(  23)		BGRA = 1;
            	}
{
            	HX_STACKFRAME(&_hx_pos_ce38ee0aefe74adb_28_boot)
HXDLIN(  28)		BGRA_PACKED = 2;
            	}
{
            	HX_STACKFRAME(&_hx_pos_ce38ee0aefe74adb_33_boot)
HXDLIN(  33)		COMPRESSED = 3;
            	}
{
            	HX_STACKFRAME(&_hx_pos_ce38ee0aefe74adb_38_boot)
HXDLIN(  38)		COMPRESSED_ALPHA = 4;
            	}
{
            	HX_STACKFRAME(&_hx_pos_ce38ee0aefe74adb_43_boot)
HXDLIN(  43)		RGBA_HALF_FLOAT = 5;
            	}
}

} // end namespace openfl
} // end namespace display3D
} // end namespace _Context3DTextureFormat
