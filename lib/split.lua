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
local type = type
local error = error
local sub = string.sub
local find = string.find
local format = string.format
local isa = require('isa')

--- split_ex splits s by pattern and returns the substring as an array
--- @param s string
--- @param sep string
--- @param plain boolean
--- @param limit number
--- @param after boolean
--- @return table
local function split_ex(s, sep, plain, limit, after)
    if type(s) ~= 'string' then
        error(format('invalid argument #1 (string expected, got %s)', type(s)),
              3)
    elseif type(sep) ~= 'string' then
        error(
            format('invalid argument #2 (string expected, got %s)', type(sep)),
            3)
    elseif plain ~= nil and type(plain) ~= 'boolean' then
        error(format('invalid argument #3 (nil or boolean expected, got %s)',
                     type(plain)), 3)
    elseif limit ~= nil and not isa.Finite(limit) then
        error(format(
                  'invalid argument #4 (nil or finite-number expected, got %s)',
                  type(limit)), 3)
    elseif after ~= nil and type(after) ~= 'boolean' then
        error(format('invalid argument #5 (nil or boolean expected, got %s)',
                     type(after)), 3)
    elseif s == '' then
        -- empty-string
        return {''}
    elseif sep == '' then
        local arr = {}

        -- split s into all characters up to limit times
        if limit then
            for i = 1, #s do
                if i > limit then
                    arr[i] = sub(s, i)
                    return arr
                end
                arr[i] = sub(s, i, i)
            end

            return arr
        end

        -- split s into all characters
        for i = 1, #s do
            arr[i] = sub(s, i, i)
        end

        return arr
    end

    -- split a string with pattern
    local arr = {}
    local idx = 1
    local pos = 1
    local head, tail = find(s, sep, pos, plain)

    -- up to limit times
    if limit then
        while head do
            if idx > limit then
                break
            end

            if after then
                arr[idx] = sub(s, pos, tail)
            else
                arr[idx] = sub(s, pos, head - 1)
            end
            idx = idx + 1
            pos = tail + 1
            head, tail = find(s, sep, pos, plain)
        end
    else
        while head do
            if after then
                arr[idx] = sub(s, pos, tail)
            else
                arr[idx] = sub(s, pos, head - 1)
            end
            idx = idx + 1
            pos = tail + 1
            head, tail = find(s, sep, pos, plain)
        end
    end

    -- push remaining string
    if pos <= #s then
        arr[idx] = sub(s, pos)
    end

    return arr
end

--- split splits s by pattern and returns the substring as an array
--- @param s string
--- @param sep string
--- @param plain boolean
--- @param limit number
--- @return table
local function split(s, sep, plain, limit)
    return split_ex(s, sep, plain, limit)
end

--- split_after splits s after a pattern and returns an array of its substrings
--- @param s string
--- @param sep string
--- @param plain boolean
--- @param limit number
--- @return table
local function split_after(s, sep, plain, limit)
    return split_ex(s, sep, plain, limit, true)
end

--- split_fields splits s around each white space and returns an array of substrings
--- @param s string
--- @return table
local function split_fields(s)
    if type(s) ~= 'string' then
        error(format('invalid argument #1 (string expected, got %s)', type(s)),
              2)
    elseif s == '' then
        return {}
    end

    -- split a string with pattern
    local arr = {}
    local sep = '%s+'
    local idx = 1
    local pos = 1
    local head, tail = find(s, sep, pos)

    -- skip leading whitespaces
    if pos == head then
        pos = tail + 1
        head, tail = find(s, sep, pos)
    end

    while head do
        arr[idx] = sub(s, pos, head - 1)
        idx = idx + 1
        pos = tail + 1
        head, tail = find(s, sep, pos)
    end

    -- push remaining string
    if pos <= #s then
        arr[idx] = sub(s, pos)
    end

    return arr
end

return {
    split = split,
    after = split_after,
    fields = split_fields,
}
