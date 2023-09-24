#ifndef INCLUDED_WindowsCPP
#define INCLUDED_WindowsCPP

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(WindowsCPP)



class HXCPP_CLASS_ATTRIBUTES WindowsCPP_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef WindowsCPP_obj OBJ_;
		WindowsCPP_obj();

	public:
		enum { _hx_ClassId = 0x39d91fa4 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="WindowsCPP")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"WindowsCPP"); }

		inline static ::hx::ObjectPtr< WindowsCPP_obj > __new() {
			::hx::ObjectPtr< WindowsCPP_obj > __this = new WindowsCPP_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< WindowsCPP_obj > __alloc(::hx::Ctx *_hx_ctx) {
			WindowsCPP_obj *__this = (WindowsCPP_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(WindowsCPP_obj), false, "WindowsCPP"));
			*(void **)__this = WindowsCPP_obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~WindowsCPP_obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("WindowsCPP",80,f6,e4,e2); }

		static void _setWindowLayered();
		static ::Dynamic _setWindowLayered_dyn();

		static Float setWindowAlpha(Float alpha);
		static ::Dynamic setWindowAlpha_dyn();

};


#endif /* INCLUDED_WindowsCPP */ 
