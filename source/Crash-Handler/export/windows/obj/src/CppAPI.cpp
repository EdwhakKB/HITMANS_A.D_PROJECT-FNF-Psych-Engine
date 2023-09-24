#include <hxcpp.h>

#ifndef INCLUDED_CppAPI
#include <CppAPI.h>
#endif
#ifndef INCLUDED_WindowsCPP
#include <WindowsCPP.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_34a0ba5b2a33a65a_9_setWindowOppacity,"CppAPI","setWindowOppacity",0xd8a6c878,"CppAPI.setWindowOppacity","CppAPI.hx",9,0xaa490fc7)
HX_LOCAL_STACK_FRAME(_hx_pos_34a0ba5b2a33a65a_14__setWindowLayered,"CppAPI","_setWindowLayered",0xbd4658e6,"CppAPI._setWindowLayered","CppAPI.hx",14,0xaa490fc7)

void CppAPI_obj::__construct() { }

Dynamic CppAPI_obj::__CreateEmpty() { return new CppAPI_obj; }

void *CppAPI_obj::_hx_vtable = 0;

Dynamic CppAPI_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< CppAPI_obj > _hx_result = new CppAPI_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool CppAPI_obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x589b6a7b;
}

void CppAPI_obj::setWindowOppacity(Float a){
            	HX_STACKFRAME(&_hx_pos_34a0ba5b2a33a65a_9_setWindowOppacity)
HXDLIN(   9)		::WindowsCPP_obj::setWindowAlpha(a);
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(CppAPI_obj,setWindowOppacity,(void))

void CppAPI_obj::_setWindowLayered(){
            	HX_STACKFRAME(&_hx_pos_34a0ba5b2a33a65a_14__setWindowLayered)
HXDLIN(  14)		::WindowsCPP_obj::_setWindowLayered();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(CppAPI_obj,_setWindowLayered,(void))


CppAPI_obj::CppAPI_obj()
{
}

bool CppAPI_obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 17:
		if (HX_FIELD_EQ(inName,"setWindowOppacity") ) { outValue = setWindowOppacity_dyn(); return true; }
		if (HX_FIELD_EQ(inName,"_setWindowLayered") ) { outValue = _setWindowLayered_dyn(); return true; }
	}
	return false;
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *CppAPI_obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo *CppAPI_obj_sStaticStorageInfo = 0;
#endif

::hx::Class CppAPI_obj::__mClass;

static ::String CppAPI_obj_sStaticFields[] = {
	HX_("setWindowOppacity",4f,97,97,71),
	HX_("_setWindowLayered",bd,27,37,56),
	::String(null())
};

void CppAPI_obj::__register()
{
	CppAPI_obj _hx_dummy;
	CppAPI_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("CppAPI",57,a3,03,91);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &CppAPI_obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(CppAPI_obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< CppAPI_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = CppAPI_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = CppAPI_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

