# lua-stringex

[![test](https://github.com/mah0x211/lua-stringex/actions/workflows/test.yml/badge.svg)](https://github.com/mah0x211/lua-stringex/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/mah0x211/lua-stringex/branch/master/graph/badge.svg)](https://codecov.io/gh/mah0x211/lua-stringex)

additional features to the string module.

## Installation

```sh
luarocks install stringex
```


## `stringex` module

`stringex` module contains the following functions;

- functions of Lua's built-in `string` module
- functions of `stringex.capitalize` module
- functions of `stringex.has` module
- functions of `stringex.split` module
- functions of `stringex.trim` module

the function names of `stringex.*` submodules are prefixed with the module name.
however, if the function has the same name as the module name, it will not be prefixed.

**Example**
```lua
local stringex = require('stringex')
print(stringex.has('foo/bar/baz', 'bar')) -- true
```

## `stringex.capitalize` module

### s = capitalize(s)

Converts the first letter `a-z` of each word to uppercase.

**Params**

- `s:string`: string

**Returns**

- `s:string`: capitalized string.


## `stringex.has` module

### ok = has.has(s, pattern, plain)

tests whether the `pattern` is contained in `s` or not.

**Params**

- `s:string`: string
- `pattern:string`: pattern string
- `plain:boolean`: if `true`, the `pattern` will be used as a plain string

**Returns**

- `ok:boolean`: true if `pattern` is contained in `s`


### ok = has.suffix(s, suffix)

tests whether `s` ends with `suffix`.

**Params**

- `s:string`: string
- `suffix:string`: suffix string

**Returns**

- `ok:boolean`: true if `s` ends with `suffix`

    
### ok = has.prefix(s, prefix)

tests whether `s` starts with `prefix`.

**Params**

- `s:string`: string
- `prefix:string`: prefix string

**Returns**

- `ok:boolean`: true if `s` starts with `prefix`.


## `stringex.split` module


### arr = split.split(s, sep, plain, limit)

splits `s` by `sep` and returns an array of its substrings.

**Params**

- `s:string`: string
- `sep:string`: seperator pattern string
- `plain:boolean`: if `true`, the `sep` will be used as a plain string
- `limit:number`: splits `s` up to `limit` times

**Returns**

- `arr:table`: an array of substrings


### arr = split.after(s, sep, plain, limit)

splits `s` after a `sep` and returns an array of its substrings.

**Params**

- `s:string`: string
- `sep:string`: seperator pattern string
- `plain:boolean`: if `true`, the `sep` will be used as a plain string
- `limit:number`: splits `s` up to `limit` times

**Returns**

- `arr:table`: an array of substrings


### arr = split.fields(s)

splits `s` around each whitespace and returns an array of substrings.

**Params**

- `s:string`: string

**Returns**

- `arr:table`: an array of substrings


## `stringex.trim` module


### s = trim.space(s)

returns `s` with all leading and trailing whitespace removed.

**Params**

- `s:string`: string

**Returns**

- `s:string`: result string


### s = trim.suffix(s, suffix)

returns `s` with the `suffix` removed.

**Params**

- `s:string`: string
- `suffix:string`: suffix string

**Returns**

- `s:string`: result string


### s = trim.prefix(s, prefix)

returns `s` with the `prefix` removed.

**Params**

- `s:string`: string
- `suffix:string`: suffix string

**Returns**

- `s:string`: result string
