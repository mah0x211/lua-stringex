local dofile = dofile

for _, pathname in ipairs({
    'test/has_test.lua',
    'test/split_test.lua',
    'test/stringex_test.lua',
    'test/trim_test.lua',
}) do
    dofile(pathname)
end
