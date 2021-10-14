require('luacov')
local find = string.find
local assert = require('assertex')
local split = require('stringex.split')

local function test_split()
    -- test that non split an empty-string
    assert.equal(split.split('', ''), {''})

    -- test that split a string into all characters
    assert.equal(split.split('foo', ''), {'f', 'o', 'o'})

    -- test that split a string with pattern '/'
    assert.equal(split.split('foo/bar//baz/qux', '/'),
                 {'foo', 'bar', '', 'baz', 'qux'})

    -- test that split a string with pattern '/+'
    assert.equal(split.split('foo/bar//baz/qux', '/+'),
                 {'foo', 'bar', 'baz', 'qux'})

    -- test that split a string with plain string '/+'
    assert.equal(split.split('foo/bar/+baz/qux', '/+', true),
                 {'foo/bar', 'baz/qux'})

    -- test that split a string up to 3 times
    assert.equal(split.split('foo', '', nil, 3), {'f', 'o', 'o'})

    -- test that split a string up to 1 times
    assert.equal(split.split('foo/bar/baz/qux', '', nil, 1),
                 {'f', 'oo/bar/baz/qux'})

    -- test that split a string upto 2 times
    assert.equal(split.split('foo/bar/baz/qux', '/', nil, 2),
                 {'foo', 'bar', 'baz/qux'})

    -- test that throw erorr if s is not string
    local err = assert.throws(function()
        split.split()
    end)
    assert(find(err, '#1 (string expected,', nil, true), err)

    -- test that throw erorr if sep is not string
    err = assert.throws(function()
        split.split('foo')
    end)
    assert(find(err, '#2 (string expected,', nil, true), err)

    -- test that throw erorr if plain is not boolean
    err = assert.throws(function()
        split.split('foo', '', 1)
    end)
    assert(find(err, '#3 (nil or boolean expected,', nil, true), err)

    -- test that throw erorr if limit is not finite-number
    err = assert.throws(function()
        split.split('foo', '', nil, 'bar')
    end)
    assert(find(err, '#4 (nil or finite-number expected,', nil, true), err)
end

local function test_split_after()
    -- test that non split an empty-string
    assert.equal(split.after('', ''), {''})

    -- test that split a string into all characters
    assert.equal(split.after('foo', ''), {'f', 'o', 'o'})

    -- test that split a string with pattern '/'
    assert.equal(split.after('foo/bar//baz/qux', '/'),
                 {'foo/', 'bar/', '/', 'baz/', 'qux'})

    -- test that split a string with pattern '/+'
    assert.equal(split.after('foo/bar//baz/qux', '/+'),
                 {'foo/', 'bar//', 'baz/', 'qux'})

    -- test that split a string with plain string '/+'
    assert.equal(split.after('foo/bar/+baz/qux', '/+', true),
                 {'foo/bar/+', 'baz/qux'})

    -- test that split a string up to 3 times
    assert.equal(split.after('foo', '', nil, 3), {'f', 'o', 'o'})

    -- test that split a string up to 1 times
    assert.equal(split.after('foo/bar/baz/qux', '', nil, 1),
                 {'f', 'oo/bar/baz/qux'})

    -- test that split a string upto 2 times
    assert.equal(split.after('foo/bar/baz/qux', '/', nil, 2),
                 {'foo/', 'bar/', 'baz/qux'})

    -- test that throw erorr if s is not string
    local err = assert.throws(function()
        split.after()
    end)
    assert(find(err, '#1 (string expected,', nil, true), err)

    -- test that throw erorr if sep is not string
    err = assert.throws(function()
        split.after('foo')
    end)
    assert(find(err, '#2 (string expected,', nil, true), err)

    -- test that throw erorr if plain is not boolean
    err = assert.throws(function()
        split.after('foo', '', 1)
    end)
    assert(find(err, '#3 (nil or boolean expected,', nil, true), err)

    -- test that throw erorr if limit is not finite-number
    err = assert.throws(function()
        split.after('foo', '', nil, 'bar')
    end)
    assert(find(err, '#4 (nil or finite-number expected,', nil, true), err)
end

local function test_split_fields()
    -- test that returns empty-table
    assert.equal(split.fields(''), {})

    -- test that returns empty-table
    assert.equal(split.fields('    '), {})

    -- test that returns table containing substrings
    assert.equal(split.fields('\t  foo \t bar  \tbaz', ''),
                 {'foo', 'bar', 'baz'})

    -- test that throw erorr if s is not string
    local err = assert.throws(function()
        split.fields()
    end)
    assert(find(err, '#1 (string expected,', nil, true), err)
end

test_split()
test_split_after()
test_split_fields()
