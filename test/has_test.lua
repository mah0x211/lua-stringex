require('luacov')
local find = string.find
local format = string.format
local assert = require('assert')
local has = require('stringex.has')

local function test_has()
    -- test tha pattern is a match
    assert(has.has('foo bar baz', 'bar%s*baz'),
           format('%q has not match pattern %q', 'foo bar baz', 'bar%s*baz'))

    -- test tha plain pattern is a match
    assert(has.has('foo bar baz', 'bar '),
           format('%q has not match pattern %q', 'foo bar baz', 'bar '))

    -- test that pattern does not match
    assert(not has.has('foo bar baz', 'bar%s*baz', true),
           format('%q has not match pattern %q', 'foo bar baz', 'bar%s*baz'))

    -- test that throw erorr if s is not string
    local err = assert.throws(function()
        has.has()
    end)
    assert(find(err, '#1 (string expected,', nil, true), err)

    -- test that throw erorr if pattern is not string
    err = assert.throws(function()
        has.has('foo')
    end)
    assert(find(err, '#2 (string expected,', nil, true), err)

    -- test that throw erorr if plain is not boolean
    err = assert.throws(function()
        has.has('foo', 'bar', 1)
    end)
    assert(find(err, '#3 (nil or boolean expected,', nil, true), err)
end

local function test_has_suffix()
    local suffix = 'baz'

    -- test that returns true
    for _, v in ipairs({'foo/bar/baz', 'foo bar baz', 'baz'}) do
        assert(has.suffix(v, suffix), format('%q has not suffix %q', v, suffix))
    end

    -- test that returns false
    for _, v in ipairs({'', 'foo/bar/baz/qux', 'foo bar baz qux', 'baz '}) do
        assert(not has.suffix(v, suffix), format('%q has suffix %q', v, suffix))
    end

    -- test that throw erorr if s is not string
    local err = assert.throws(function()
        has.suffix()
    end)
    assert(find(err, '#1 (string expected,', nil, true), err)

    -- test that throw erorr if s is not string
    err = assert.throws(function()
        has.suffix('foo')
    end)
    assert(find(err, '#2 (string expected,', nil, true), err)
end

local function test_has_prefix()
    local prefix = 'foo'

    -- test that returns true
    for _, v in ipairs({'foo/bar/baz', 'foo bar baz', 'foo'}) do
        assert(has.prefix(v, prefix), format('%q has not prefix %q', v, prefix))
    end

    -- test that returns false
    for _, v in ipairs({'', 'bar/baz/qux', 'bar baz qux', ' foo '}) do
        assert(not has.prefix(v, prefix), format('%q has prefix %q', v, prefix))
    end

    -- test that throw erorr if s is not string
    local err = assert.throws(function()
        has.prefix()
    end)
    assert(find(err, '#1 (string expected,', nil, true), err)

    -- test that throw erorr if s is not string
    err = assert.throws(function()
        has.prefix('baz')
    end)
    assert(find(err, '#2 (string expected,', nil, true), err)
end

test_has()
test_has_suffix()
test_has_prefix()
