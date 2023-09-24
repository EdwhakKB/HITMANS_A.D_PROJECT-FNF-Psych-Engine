#include <hxcpp.h>

#ifndef INCLUDED_openfl_text__TextFieldAutoSize_TextFieldAutoSize_Impl_
#include <openfl/text/_TextFieldAutoSize/TextFieldAutoSize_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_3979b3584d4ecefb_41_fromString,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_","fromString",0xeb62d059,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_.fromString","openfl/text/TextFieldAutoSize.hx",41,0x2bbbb0a4)
HX_LOCAL_STACK_FRAME(_hx_pos_3979b3584d4ecefb_53_toString,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_","toString",0x3f3737aa,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_.toString","openfl/text/TextFieldAutoSize.hx",53,0x2bbbb0a4)
HX_LOCAL_STACK_FRAME(_hx_pos_3979b3584d4ecefb_18_boot,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_","boot",0x70a91430,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_.boot","openfl/text/TextFieldAutoSize.hx",18,0x2bbbb0a4)
HX_LOCAL_STACK_FRAME(_hx_pos_3979b3584d4ecefb_25_boot,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_","boot",0x70a91430,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_.boot","openfl/text/TextFieldAutoSize.hx",25,0x2bbbb0a4)
HX_LOCAL_STACK_FRAME(_hx_pos_3979b3584d4ecefb_30_boot,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_","boot",0x70a91430,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_.boot","openfl/text/TextFieldAutoSize.hx",30,0x2bbbb0a4)
HX_LOCAL_STACK_FRAME(_hx_pos_3979b3584d4ecefb_37_boot,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_","boot",0x70a91430,"openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_.boot","openfl/text/TextFieldAutoSize.hx",37,0x2bbbb0a4)
namespace openfl{
namespace text{
namespace _TextFieldAutoSize{

void TextFieldAutoSize_Impl__obj::__construct() { }

Dynamic TextFieldAutoSize_Impl__obj::__CreateEmpty() { return new TextFieldAutoSize_Impl__obj; }

void *TextFieldAutoSize_Impl__obj::_hx_vtable = 0;

Dynamic TextFieldAutoSize_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< TextFieldAutoSize_Impl__obj > _hx_result = new TextFieldAutoSize_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool TextFieldAutoSize_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x0013b09e;
}

 ::Dynamic TextFieldAutoSize_Impl__obj::CENTER;

 ::Dynamic TextFieldAutoSize_Impl__obj::LEFT;

 ::Dynamic TextFieldAutoSize_Impl__obj::NONE;

 ::Dynamic TextFieldAutoSize_Impl__obj::RIGHT;

 ::Dynamic TextFieldAutoSize_Impl__obj::fromString(::String value){
            	HX_STACKFRAME(&_hx_pos_3979b3584d4ecefb_41_fromString)
HXDLIN(  41)		::String _hx_switch_0 = value;
            		if (  (_hx_switch_0==HX_("center",d5,25,db,05)) ){
HXLINE(  43)			return 0;
HXDLIN(  43)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("left",07,08,b0,47)) ){
HXLINE(  44)			return 1;
HXDLIN(  44)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("none",b8,12,0a,49)) ){
HXLINE(  45)			return 2;
HXDLIN(  45)			goto _hx_goto_0;
            		}
            		if (  (_hx_switch_0==HX_("right",dc,0b,64,e9)) ){
HXLINE(  46)			return 3;
HXDLIN(  46)			goto _hx_goto_0;
            		}
            		/* default */{
HXLINE(  47)			return null();
            		}
            		_hx_goto_0:;
HXLINE(  41)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextFieldAutoSize_Impl__obj,fromString,return )

::String TextFieldAutoSize_Impl__obj::toString( ::Dynamic this1){
            	HX_STACKFRAME(&_hx_pos_3979b3584d4ecefb_53_toString)
HXDLIN(  53)		 ::Dynamic _hx_switch_0 = this1;
            		if (  (_hx_switch_0==0) ){
HXLINE(  55)			return HX_("center",d5,25,db,05);
HXDLIN(  55)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==1) ){
HXLINE(  56)			return HX_("left",07,08,b0,47);
HXDLIN(  56)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==2) ){
HXLINE(  57)			return HX_("none",b8,12,0a,49);
HXDLIN(  57)			goto _hx_goto_2;
            		}
            		if (  (_hx_switch_0==3) ){
HXLINE(  58)			return HX_("right",dc,0b,64,e9);
HXDLIN(  58)			goto _hx_goto_2;
            		}
            		/* default */{
HXLINE(  59)			return null();
            		}
            		_hx_goto_2:;
HXLINE(  53)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(TextFieldAutoSize_Impl__obj,toString,return )


TextFieldAutoSize_Impl__obj::TextFieldAutoSize_Impl__obj()
{
}

bool TextFieldAutoSize_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
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
static ::hx::StorageInfo *TextFieldAutoSize_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo TextFieldAutoSize_Impl__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFieldAutoSize_Impl__obj::CENTER,HX_("CENTER",d5,d1,5d,b8)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFieldAutoSize_Impl__obj::LEFT,HX_("LEFT",07,d0,70,32)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFieldAutoSize_Impl__obj::NONE,HX_("NONE",b8,da,ca,33)},
	{::hx::fsObject /*  ::Dynamic */ ,(void *) &TextFieldAutoSize_Impl__obj::RIGHT,HX_("RIGHT",bc,43,52,67)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void TextFieldAutoSize_Impl__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(TextFieldAutoSize_Impl__obj::CENTER,"CENTER");
	HX_MARK_MEMBER_NAME(TextFieldAutoSize_Impl__obj::LEFT,"LEFT");
	HX_MARK_MEMBER_NAME(TextFieldAutoSize_Impl__obj::NONE,"NONE");
	HX_MARK_MEMBER_NAME(TextFieldAutoSize_Impl__obj::RIGHT,"RIGHT");
};

#ifdef HXCPP_VISIT_ALLOCS
static void TextFieldAutoSize_Impl__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(TextFieldAutoSize_Impl__obj::CENTER,"CENTER");
	HX_VISIT_MEMBER_NAME(TextFieldAutoSize_Impl__obj::LEFT,"LEFT");
	HX_VISIT_MEMBER_NAME(TextFieldAutoSize_Impl__obj::NONE,"NONE");
	HX_VISIT_MEMBER_NAME(TextFieldAutoSize_Impl__obj::RIGHT,"RIGHT");
};

#endif

::hx::Class TextFieldAutoSize_Impl__obj::__mClass;

static ::String TextFieldAutoSize_Impl__obj_sStaticFields[] = {
	HX_("CENTER",d5,d1,5d,b8),
	HX_("LEFT",07,d0,70,32),
	HX_("NONE",b8,da,ca,33),
	HX_("RIGHT",bc,43,52,67),
	HX_("fromString",db,2d,74,54),
	HX_("toString",ac,d0,6e,38),
	::String(null())
};

void TextFieldAutoSize_Impl__obj::__register()
{
	TextFieldAutoSize_Impl__obj _hx_dummy;
	TextFieldAutoSize_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("openfl.text._TextFieldAutoSize.TextFieldAutoSize_Impl_",30,d1,ec,bc);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &TextFieldAutoSize_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = TextFieldAutoSize_Impl__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(TextFieldAutoSize_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< TextFieldAutoSize_Impl__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = TextFieldAutoSize_Impl__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = TextFieldAutoSize_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = TextFieldAutoSize_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void TextFieldAutoSize_Impl__obj::__boot()
{
{
            	HX_STACKFRAME(&_hx_pos_3979b3584d4ecefb_18_boot)
HXDLIN(  18)		CENTER = 0;
            	}
{
            	HX_STACKFRAME(&_hx_pos_3979b3584d4ecefb_25_boot)
HXDLIN(  25)		LEFT = 1;
            	}
{
            	HX_STACKFRAME(&_hx_pos_3979b3584d4ecefb_30_boot)
HXDLIN(  30)		NONE = 2;
            	}
{
            	HX_STACKFRAME(&_hx_pos_3979b3584d4ecefb_37_boot)
HXDLIN(  37)		RIGHT = 3;
            	}
}

} // end namespace openfl
} // end namespace text
} // end namespace _TextFieldAutoSize
