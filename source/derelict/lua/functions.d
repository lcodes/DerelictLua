/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.lua.functions;

private {
    import core.stdc.stdarg;
    import derelict.lua.types;
}

extern(C) @nogc nothrow {
    //lua.h
    alias da_lua_newstate = lua_State* function(lua_Alloc, void*);
    alias da_lua_close = void function(lua_State*);
    alias da_lua_newthread = lua_State* function(lua_State*);
    alias da_lua_atpanic = lua_CFunction function(lua_State*, lua_CFunction);
    alias da_lua_version = const(lua_Number)* function(lua_State*);
    alias da_lua_absindex = int function(lua_State*, int);
    alias da_lua_gettop = int function(lua_State*);
    alias da_lua_settop = void function(lua_State*, int);
    alias da_lua_pushvalue = void function(lua_State*, int);
    alias da_lua_remove = void function(lua_State*, int);
    alias da_lua_insert = void function(lua_State*, int);
    alias da_lua_replace = void function(lua_State*, int);
    alias da_lua_copy = void function(lua_State*, int, int);
    alias da_lua_checkstack = int function(lua_State*, int sz);
    alias da_lua_xmove = void function(lua_State*, lua_State*, int);
    alias da_lua_isnumber = int function(lua_State*, int);
    alias da_lua_isstring = int function(lua_State*, int);
    alias da_lua_iscfunction = int function(lua_State*, int);
    alias da_lua_isuserdata = int function(lua_State*, int);
    alias da_lua_type = int function(lua_State*, int);
    alias da_lua_typename = const(char)* function(lua_State*, int);
    alias da_lua_tonumberx = lua_Number function(lua_State*, int, int*);
    alias da_lua_tointegerx = lua_Integer function(lua_State*, int, int*);
    alias da_lua_tounsignedx = lua_Unsigned function(lua_State*, int, int*);
    alias da_lua_toboolean = int function(lua_State*, int);
    alias da_lua_tolstring = const(char)* function(lua_State*, int, size_t*);
    alias da_lua_rawlen = size_t function(lua_State*, int);
    alias da_lua_tocfunction = lua_CFunction function(lua_State*, int);
    alias da_lua_touserdata = void* function(lua_State*, int);
    alias da_lua_tothread = lua_State* function(lua_State*, int);
    alias da_lua_topointer = const(void)* function(lua_State*, int);
    alias da_lua_arith = void function(lua_State*, int);
    alias da_lua_rawequal = int function(lua_State*, int, int);
    alias da_lua_compare = int function(lua_State*, int, int, int);
    alias da_lua_pushnil = void function(lua_State*);
    alias da_lua_pushnumber = void function(lua_State*, lua_Number);
    alias da_lua_pushinteger = void function(lua_State*, lua_Integer);
    alias da_lua_pushunsigned = void function(lua_State*, lua_Unsigned);
    alias da_lua_pushlstring = const(char)* function(lua_State*, const(char)*, size_t);
    alias da_lua_pushstring = const(char)* function(lua_State*, const(char)*);
    alias da_lua_pushvfstring = const(char)* function(lua_State*, const(char)*, va_list);
    alias da_lua_pushfstring = const(char)* function(lua_State*, const(char)*, ...);
    alias da_lua_pushcclosure = void function(lua_State*, lua_CFunction, int);
    alias da_lua_pushboolean = void function(lua_State*, int);
    alias da_lua_pushlightuserdata = void function(lua_State*, void*);
    alias da_lua_pushthread = void function(lua_State*);
    alias da_lua_getglobal = void function(lua_State*, const(char)*);
    alias da_lua_gettable = void function(lua_State*, int);
    alias da_lua_getfield = void function(lua_State*, int, const(char)*);
    alias da_lua_rawget = void function(lua_State*, int);
    alias da_lua_rawgeti = void function(lua_State*, int, int);
    alias da_lua_rawgetp = void function(lua_State*, int, const(void)*);
    alias da_lua_createtable = void function(lua_State*, int, int);
    alias da_lua_newuserdata = void* function(lua_State*, size_t);
    alias da_lua_getmetatable = int function(lua_State*, int);
    alias da_lua_getuservalue = void function(lua_State*, int);
    alias da_lua_setglobal = void function(lua_State*, const(char)*);
    alias da_lua_settable = void function(lua_State*, int);
    alias da_lua_setfield = void function(lua_State*, int, const(char)*);
    alias da_lua_rawset = void function(lua_State*, int);
    alias da_lua_rawseti = void function(lua_State*, int, int);
    alias da_lua_rawsetp = void function(lua_State*, int, const(void)*);
    alias da_lua_setmetatable = int function(lua_State*, int);
    alias da_lua_setuservalue = void function(lua_State*, int);
    alias da_lua_callk = void function(lua_State*, int, int, int, lua_CFunction);
    alias da_lua_getctx = int function(lua_State*, int*);
    alias da_lua_pcallk = int function(lua_State*, int, int, int, int, lua_CFunction);
    alias da_lua_load = int function(lua_State*, lua_Reader, void*, const(char)*, const(char)*);
    alias da_lua_dump = int function(lua_State*, lua_Writer, void*);
    alias da_lua_yieldk = int function(lua_State*, int, int, lua_CFunction);
    alias da_lua_resume = int function(lua_State*, lua_State*, int);
    alias da_lua_status = int function(lua_State*);
    alias da_lua_gc = int function(lua_State*, int, int);
    alias da_lua_error = int function(lua_State*);
    alias da_lua_next = int function(lua_State*, int);
    alias da_lua_concat = void function(lua_State*, int);
    alias da_lua_len = void function(lua_State*, int);
    alias da_lua_getallocf = lua_Alloc function(lua_State*, void**);
    alias da_lua_setallocf = void function(lua_State*, lua_Alloc, void*);
    alias da_lua_getstack = int function(lua_State*, int, lua_Debug*);
    alias da_lua_getinfo = int function(lua_State*, const(char)*, lua_Debug*);
    alias da_lua_getlocal = const(char)* function(lua_State*, const(lua_Debug)*, int);
    alias da_lua_setlocal = const(char)* function(lua_State*, const(lua_Debug)*, int);
    alias da_lua_getupvalue = const(char)* function(lua_State*, int, int);
    alias da_lua_setupvalue = const(char)* function(lua_State*, int, int);
    alias da_lua_upvalueid = void* function(lua_State*, int, int);
    alias da_lua_upvaluejoin = void function(lua_State*, int, int, int, int);
    alias da_lua_sethook = int function(lua_State*, lua_Hook, int, int);
    alias da_lua_gethook = lua_Hook function(lua_State*);
    alias da_lua_gethookmask = int function(lua_State*);
    alias da_lua_gethookcount = int function(lua_State*);

    //lauxlib.h
    alias da_luaL_checkversion_ = void function(lua_State*, lua_Number);
    alias da_luaL_getmetafield = int function(lua_State*, int, const(char)*);
    alias da_luaL_callmeta = int function(lua_State*, int, const(char)*);
    alias da_luaL_tolstring = const(char)* function(lua_State*, int, size_t*);
    alias da_luaL_argerror = int function(lua_State*, int, const(char)*);
    alias da_luaL_checklstring = const(char)* function(lua_State*, int, size_t*);
    alias da_luaL_optlstring = const(char)* function(lua_State*, int, const(char)*, size_t*);
    alias da_luaL_checknumber = lua_Number function(lua_State*, int);
    alias da_luaL_optnumber = lua_Number function(lua_State*, int, lua_Number);
    alias da_luaL_checkinteger = lua_Integer function(lua_State*, int);
    alias da_luaL_optinteger = lua_Integer function(lua_State*, int, lua_Integer);
    alias da_luaL_checkunsigned = lua_Unsigned function(lua_State*, int);
    alias da_luaL_optunsigned = lua_Unsigned function(lua_State*, int, lua_Unsigned);
    alias da_luaL_checkstack = void function(lua_State*, int, const(char)*);
    alias da_luaL_checktype = void function(lua_State*, int, int);
    alias da_luaL_checkany = void function(lua_State*, int);
    alias da_luaL_newmetatable = int function(lua_State*, const(char)*);
    alias da_luaL_setmetatable = void function(lua_State*, const(char)*);
    alias da_luaL_testudata = void* function(lua_State*, int, const(char)*);
    alias da_luaL_checkudata = void* function(lua_State*, int, const(char)*);
    alias da_luaL_where = void function(lua_State*, int);
    alias da_luaL_error = int function(lua_State*, const(char)*, ...);
    alias da_luaL_checkoption = int function(lua_State*, int, const(char)*);
    alias da_luaL_fileresult = int function(lua_State*, int, const(char)*);
    alias da_luaL_execresult = int function(lua_State*, int);
    alias da_luaL_ref = int function(lua_State*, int);
    alias da_luaL_unref = void function(lua_State*, int, int);
    alias da_luaL_loadfilex = int function(lua_State*, const(char)*, const(char)*);
    alias da_luaL_loadbufferx = int function(lua_State*, const(char)*, size_t, const(char)*, const(char)*);
    alias da_luaL_loadstring = int function(lua_State*, const(char)*);
    alias da_luaL_newstate = lua_State* function();
    alias da_luaL_len = int function(lua_State*, int);
    alias da_luaL_gsub = const(char)* function(lua_State*, const(char)*, const(char)*, const(char)*);
    alias da_luaL_setfuncs = void function(lua_State*, const luaL_Reg*, int);
    alias da_luaL_getsubtable = int function(lua_State*, int, const(char)*);
    alias da_luaL_traceback = void function(lua_State*, lua_State*, const(char)*, int);
    alias da_luaL_requiref = void function(lua_State*, const(char)*, lua_CFunction, int);
    alias da_luaL_buffinit = void function(lua_State*, luaL_Buffer*);
    alias da_luaL_prepbuffsize = char* function(luaL_Buffer*, size_t);
    alias da_luaL_addlstring = void function(luaL_Buffer*, const(char)*, size_t);
    alias da_luaL_addstring = void function(luaL_Buffer*, const(char)*);
    alias da_luaL_addvalue = void function(luaL_Buffer*);
    alias da_luaL_pushresult = void function(luaL_Buffer*);
    alias da_luaL_pushresultsize = void function(luaL_Buffer*, size_t);
    alias da_luaL_buffinitsize = char* function(lua_State*, luaL_Buffer*, size_t);
    alias da_luaL_pushmodule = void function(lua_State*, const(char)*, int);
    alias da_luaL_openlib = void function(lua_State*, const(char)*, const(luaL_Reg)*, int);
    //lualib.h
    alias da_luaopen_base = int function(lua_State*);
    alias da_luaopen_coroutine = int function(lua_State*);
    alias da_luaopen_table = int function(lua_State*);
    alias da_luaopen_io = int function(lua_State*);
    alias da_luaopen_os = int function(lua_State*);
    alias da_luaopen_string = int function(lua_State*);
    alias da_luaopen_bit32 = int function(lua_State*);
    alias da_luaopen_math = int function(lua_State*);
    alias da_luaopen_debug = int function(lua_State*);
    alias da_luaopen_package = int function(lua_State*);
    alias da_luaL_openlibs = void function(lua_State*);
}

__gshared {
    da_lua_newstate lua_newstate;
    da_lua_close lua_close;
    da_lua_newthread lua_newthread;
    da_lua_atpanic lua_atpanic;
    da_lua_version lua_version;
    da_lua_absindex lua_absindex;
    da_lua_gettop lua_gettop;
    da_lua_settop lua_settop;
    da_lua_pushvalue lua_pushvalue;
    da_lua_remove lua_remove;
    da_lua_insert lua_insert;
    da_lua_replace lua_replace;
    da_lua_copy lua_copy;
    da_lua_checkstack lua_checkstack;
    da_lua_xmove lua_xmove;
    da_lua_isnumber lua_isnumber;
    da_lua_isstring lua_isstring;
    da_lua_iscfunction lua_iscfunction;
    da_lua_isuserdata lua_isuserdata;
    da_lua_type lua_type;
    da_lua_typename lua_typename;
    da_lua_tonumberx lua_tonumberx;
    da_lua_tointegerx lua_tointegerx;
    da_lua_tounsignedx lua_tounsignedx;
    da_lua_toboolean lua_toboolean;
    da_lua_tolstring lua_tolstring;
    da_lua_rawlen lua_rawlen;
    da_lua_tocfunction lua_tocfunction;
    da_lua_touserdata lua_touserdata;
    da_lua_tothread lua_tothread;
    da_lua_topointer lua_topointer;
    da_lua_arith lua_arith;
    da_lua_rawequal lua_rawequal;
    da_lua_compare lua_compare;
    da_lua_pushnil lua_pushnil;
    da_lua_pushnumber lua_pushnumber;
    da_lua_pushinteger lua_pushinteger;
    da_lua_pushunsigned lua_pushunsigned;
    da_lua_pushlstring lua_pushlstring;
    da_lua_pushstring lua_pushstring;
    da_lua_pushvfstring lua_pushvfstring;
    da_lua_pushfstring lua_pushfstring;
    da_lua_pushcclosure lua_pushcclosure;
    da_lua_pushboolean lua_pushboolean;
    da_lua_pushlightuserdata lua_pushlightuserdata;
    da_lua_pushthread lua_pushthread;
    da_lua_getglobal lua_getglobal;
    da_lua_gettable lua_gettable;
    da_lua_getfield lua_getfield;
    da_lua_rawget lua_rawget;
    da_lua_rawgeti lua_rawgeti;
    da_lua_rawgetp lua_rawgetp;
    da_lua_createtable lua_createtable;
    da_lua_newuserdata lua_newuserdata;
    da_lua_getmetatable lua_getmetatable;
    da_lua_getuservalue lua_getuservalue;
    da_lua_setglobal lua_setglobal;
    da_lua_settable lua_settable;
    da_lua_setfield lua_setfield;
    da_lua_rawset lua_rawset;
    da_lua_rawseti lua_rawseti;
    da_lua_rawsetp lua_rawsetp;
    da_lua_setmetatable lua_setmetatable;
    da_lua_setuservalue lua_setuservalue;
    da_lua_callk lua_callk;
    da_lua_getctx lua_getctx;
    da_lua_pcallk lua_pcallk;
    da_lua_load lua_load;
    da_lua_dump lua_dump;
    da_lua_yieldk lua_yieldk;
    da_lua_resume lua_resume;
    da_lua_status lua_status;
    da_lua_gc lua_gc;
    da_lua_error lua_error;
    da_lua_next lua_next;
    da_lua_concat lua_concat;
    da_lua_len lua_len;
    da_lua_getallocf lua_getallocf;
    da_lua_setallocf lua_setallocf;
    da_lua_getstack lua_getstack;
    da_lua_getinfo lua_getinfo;
    da_lua_getlocal lua_getlocal;
    da_lua_setlocal lua_setlocal;
    da_lua_getupvalue lua_getupvalue;
    da_lua_setupvalue lua_setupvalue;
    da_lua_upvalueid lua_upvalueid;
    da_lua_upvaluejoin lua_upvaluejoin;
    da_lua_sethook lua_sethook;
    da_lua_gethook lua_gethook;
    da_lua_gethookmask lua_gethookmask;
    da_lua_gethookcount lua_gethookcount;
    da_luaL_checkversion_ luaL_checkversion_;
    da_luaL_getmetafield luaL_getmetafield;
    da_luaL_callmeta luaL_callmeta;
    da_luaL_tolstring luaL_tolstring;
    da_luaL_argerror luaL_argerror;
    da_luaL_checklstring luaL_checklstring;
    da_luaL_optlstring luaL_optlstring;
    da_luaL_checknumber luaL_checknumber;
    da_luaL_optnumber luaL_optnumber;
    da_luaL_checkinteger luaL_checkinteger;
    da_luaL_optinteger luaL_optinteger;
    da_luaL_checkunsigned luaL_checkunsigned;
    da_luaL_optunsigned luaL_optunsigned;
    da_luaL_checkstack luaL_checkstack;
    da_luaL_checktype luaL_checktype;
    da_luaL_checkany luaL_checkany;
    da_luaL_newmetatable luaL_newmetatable;
    da_luaL_setmetatable luaL_setmetatable;
    da_luaL_testudata luaL_testudata;
    da_luaL_checkudata luaL_checkudata;
    da_luaL_where luaL_where;
    da_luaL_error luaL_error;
    da_luaL_checkoption luaL_checkoption;
    da_luaL_fileresult luaL_fileresult;
    da_luaL_execresult luaL_execresult;
    da_luaL_ref luaL_ref;
    da_luaL_unref luaL_unref;
    da_luaL_loadfilex luaL_loadfilex;
    da_luaL_loadbufferx luaL_loadbufferx;
    da_luaL_loadstring luaL_loadstring;
    da_luaL_newstate luaL_newstate;
    da_luaL_len luaL_len;
    da_luaL_gsub luaL_gsub;
    da_luaL_setfuncs luaL_setfuncs;
    da_luaL_getsubtable luaL_getsubtable;
    da_luaL_traceback luaL_traceback;
    da_luaL_requiref luaL_requiref;
    da_luaL_buffinit luaL_buffinit;
    da_luaL_prepbuffsize luaL_prepbuffsize;
    da_luaL_addlstring luaL_addlstring;
    da_luaL_addstring luaL_addstring;
    da_luaL_addvalue luaL_addvalue;
    da_luaL_pushresult luaL_pushresult;
    da_luaL_pushresultsize luaL_pushresultsize;
    da_luaL_buffinitsize luaL_buffinitsize;
    da_luaL_pushmodule luaL_pushmodule;
    da_luaL_openlib luaL_openlib;
    da_luaopen_base luaopen_base;
    da_luaopen_coroutine luaopen_coroutine;
    da_luaopen_table luaopen_table;
    da_luaopen_io luaopen_io;
    da_luaopen_os luaopen_os;
    da_luaopen_string luaopen_string;
    da_luaopen_bit32 luaopen_bit32;
    da_luaopen_math luaopen_math;
    da_luaopen_debug luaopen_debug;
    da_luaopen_package luaopen_package;
    da_luaL_openlibs luaL_openlibs;
}
