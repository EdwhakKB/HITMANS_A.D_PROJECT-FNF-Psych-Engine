#ifndef INCLUDED___ASSET__assets_fonts_vcr_ttf1
#define INCLUDED___ASSET__assets_fonts_vcr_ttf1

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_lime_text_Font
#include <lime/text/Font.h>
#endif
HX_DECLARE_CLASS0(__ASSET__assets_fonts_vcr_ttf1)
HX_DECLARE_CLASS2(lime,text,Font)



class HXCPP_CLASS_ATTRIBUTES __ASSET__assets_fonts_vcr_ttf1_obj : public  ::lime::text::Font_obj
{
	public:
		typedef  ::lime::text::Font_obj super;
		typedef __ASSET__assets_fonts_vcr_ttf1_obj OBJ_;
		__ASSET__assets_fonts_vcr_ttf1_obj();

	public:
		enum { _hx_ClassId = 0x30858d2c };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="__ASSET__assets_fonts_vcr_ttf1")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"__ASSET__assets_fonts_vcr_ttf1"); }
		static ::hx::ObjectPtr< __ASSET__assets_fonts_vcr_ttf1_obj > __new();
		static ::hx::ObjectPtr< __ASSET__assets_fonts_vcr_ttf1_obj > __alloc(::hx::Ctx *_hx_ctx);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~__ASSET__assets_fonts_vcr_ttf1_obj();

		HX_DO_RTTI_ALL;
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("__ASSET__assets_fonts_vcr_ttf1",6c,8a,18,81); }

};


#endif /* INCLUDED___ASSET__assets_fonts_vcr_ttf1 */ 
