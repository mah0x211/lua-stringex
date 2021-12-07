require('luacov')
local assert = require('assertex')
local capitalize = require('stringex.capitalize')

local function test_capitalize()
    -- test that that converts the first letter of each word to uppercase
    for _, v in ipairs({
        {arg = 'foo-bar-baz', eq = 'Foo-Bar-Baz'},
        {arg = 'hello_world', eq = 'Hello_world'},
        {arg = ' () _ hello | world  _foo', eq = ' () _ Hello | World  _foo'},
    }) do
        local s = capitalize(v.arg)
        assert.equal(s, v.eq)
    end

    -- test that throws an erorr with invalid argument
    for _, v in ipairs({
        1,
        true,
        false,
        {},
        function()
        end,
    }) do
        local err = assert.throws(function()
            capitalize(v)
        end)
        assert.match(err, '#1 .+ [(]string expected, ', false)
    end
end

test_capitalize()
