--
-- Copyright (C) 2021 Masatoshi Fukunaga
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
--- file-scope variables
local error = error
local type = type
local find = string.find
local format = string.format
local sub = string.sub

--- has tests whether the pattern is contained in s or not.
--- @param s string
--- @param pattern string
--- @param plain boolean
--- @return boolean
local function has(s, pattern, plain)
    if type(s) ~= 'string' then
        error(format('invalid argument #1 (string expected, got %s)', type(s)),
              2)
    elseif type(pattern) ~= 'string' then
        error(format('invalid argument #2 (string expected, got %s)',
                     type(pattern)), 2)
    elseif plain ~= nil and type(plain) ~= 'boolean' then
        error(format('invalid argument #3 (nil or boolean expected, got %s)',
                     type(plain)), 2)
    end

    return find(s, pattern, nil, plain) and true or false
end

--- has_suffix tests whether s ends with suffix
--- @param s string
--- @param suffix string
--- @return boolean
local function has_suffix(s, suffix)
    if type(s) ~= 'string' then
        error(format('invalid argument #1 (string expected, got %s)', type(s)),
              2)
    elseif type(suffix) ~= 'string' then
        error(format('invalid argument #2 (string expected, got %s)',
                     type(suffix)), 2)
    end

    local slen = #suffix
    if #s < slen then
        return false
    end

    return s == suffix or sub(s, -slen) == suffix
end

--- has_prefix tests whether s starts with prefix
--- @param s string
--- @param prefix string
--- @return boolean
local function has_prefix(s, prefix)
    if type(s) ~= 'string' then
        error(format('invalid argument #1 (string expected, got %s)', type(s)),
              2)
    elseif type(prefix) ~= 'string' then
        error(format('invalid argument #2 (string expected, got %s)',
                     type(prefix)), 2)
    end

    local plen = #prefix
    if #s < plen then
        return false
    end

    return s == prefix or sub(s, 1, plen) == prefix
end

return {
    has = has,
    suffix = has_suffix,
    prefix = has_prefix,
}
