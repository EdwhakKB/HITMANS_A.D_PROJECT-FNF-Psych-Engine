#ifndef INCLUDED_CppAPI
#define INCLUDED_CppAPI

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(CppAPI)



class HXCPP_CLASS_ATTRIBUTES CppAPI_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef CppAPI_obj OBJ_;
		CppAPI_obj();

	public:
		enum { _hx_ClassId = 0x589b6a7b };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="CppAPI")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"CppAPI"); }

		inline static ::hx::ObjectPtr< CppAPI_obj > __new() {
			::hx::ObjectPtr< CppAPI_obj > __this = new CppAPI_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< CppAPI_obj > __alloc(::hx::Ctx *_hx_ctx) {
			CppAPI_obj *__this = (CppAPI_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(CppAPI_obj), false, "CppAPI"));
			*(void **)__this = CppAPI_obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~CppAPI_obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("CppAPI",57,a3,03,91); }

		static void setWindowOppacity(Float a);
		static ::Dynamic setWindowOppacity_dyn();

		static void _setWindowLayered();
		static ::Dynamic _setWindowLayered_dyn();

};


#endif /* INCLUDED_CppAPI */ 
