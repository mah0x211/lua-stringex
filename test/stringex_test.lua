require('luacov')
local assert = require('assertex')
local stringex = require('stringex')
local has = require('stringex.has')
local split = require('stringex.split')
local trim = require('stringex.trim')

local function test_stringex()
    -- test that contains the functions of module
    for mname, m in pairs({
        has = has,
        split = split,
        trim = trim,
    }) do
        for name, fn in pairs(m) do
            local fname = mname .. '_' .. name
            if name == mname then
                fname = name
            end
            assert.equal(fn, stringex[fname])
        end
    end
end

test_stringex()
