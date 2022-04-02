/**
 *  Copyright (C) 2021 Masatoshi Fukunaga
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to
 *  deal in the Software without restriction, including without limitation the
 *  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 *  sell copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 *
 *  src/implc.c
 *  lua-net-http
 *  Created by Masatoshi Teruya on 17/10/11.
 */

#include <ctype.h>
#include <lauxlib.h>
#include <lua.h>

static int capitalize_lua(lua_State *L)
{
    size_t len    = 0;
    char *s       = NULL;
    size_t i      = 0;
    luaL_Buffer b = {0};

    luaL_checktype(L, 1, LUA_TSTRING);
    s = (char *)lua_tolstring(L, 1, &len);
    lua_settop(L, 1);
    // create copy
    luaL_buffinit(L, &b);

    if (isalnum(s[i])) {
CHECK_LOWER:
        if (islower(s[i])) {
            // convert to uppercase
            luaL_addchar(&b, s[i] - 0x20);
        } else {
            luaL_addchar(&b, s[i]);
        }

SKIP_LETTER:
        // skip letter and '_'
        while (++i < len && (s[i] == '_' || isalnum(s[i]))) {
            luaL_addchar(&b, s[i]);
        }
    }

    // skip non-letter
    for (; i < len; i++) {
        if (s[i] == '_') {
            luaL_addchar(&b, s[i]);
            goto SKIP_LETTER;
        } else if (isalnum(s[i])) {
            goto CHECK_LOWER;
        }
        luaL_addchar(&b, s[i]);
    }

    luaL_pushresult(&b);

    return 1;
}

LUALIB_API int luaopen_stringex_capitalize(lua_State *L)
{
    lua_pushcfunction(L, capitalize_lua);
    return 1;
}
