#include <hxcpp.h>

#ifndef INCLUDED_ManifestResources
#include <ManifestResources.h>
#endif
#ifndef INCLUDED___ASSET__OPENFL__assets_fonts_vcr_ttf1
#include <__ASSET__OPENFL__assets_fonts_vcr_ttf1.h>
#endif
#ifndef INCLUDED_lime_text_Font
#include <lime/text/Font.h>
#endif
#ifndef INCLUDED_openfl_text_Font
#include <openfl/text/Font.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_79f2046db1fa6d5d_227_new,"__ASSET__OPENFL__assets_fonts_vcr_ttf1","new",0x074e64ae,"__ASSET__OPENFL__assets_fonts_vcr_ttf1.new","ManifestResources.hx",227,0xf77aa668)

void __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::__construct(){
            	HX_STACKFRAME(&_hx_pos_79f2046db1fa6d5d_227_new)
HXDLIN( 227)		this->_hx___fontPath = (::ManifestResources_obj::rootPath + HX_("assets/fonts/vcr.ttf",46,38,26,7e));
HXDLIN( 227)		this->name = HX_("VCR OSD Mono",be,44,e4,b8);
HXDLIN( 227)		super::__construct(null());
            	}

Dynamic __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::__CreateEmpty() { return new __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj; }

void *__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::_hx_vtable = 0;

Dynamic __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj > _hx_result = new __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x2f360ce0) {
		if (inClassId<=(int)0x12d0aa2c) {
			return inClassId==(int)0x00000001 || inClassId==(int)0x12d0aa2c;
		} else {
			return inClassId==(int)0x2f360ce0;
		}
	} else {
		return inClassId==(int)0x40cee131;
	}
}


::hx::ObjectPtr< __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj > __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::__new() {
	::hx::ObjectPtr< __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj > __this = new __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj > __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::__alloc(::hx::Ctx *_hx_ctx) {
	__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj *__this = (__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj), true, "__ASSET__OPENFL__assets_fonts_vcr_ttf1"));
	*(void **)__this = __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj()
{
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo *__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj_sStaticStorageInfo = 0;
#endif

::hx::Class __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::__mClass;

void __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::__register()
{
	__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj _hx_dummy;
	__ASSET__OPENFL__assets_fonts_vcr_ttf1_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("__ASSET__OPENFL__assets_fonts_vcr_ttf1",bc,35,ff,80);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = __ASSET__OPENFL__assets_fonts_vcr_ttf1_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}
