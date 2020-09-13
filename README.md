# [WIP] category-theory-exercises
I'm slowly (and in random order) working through Bartosz Milewski's category theory lectures https://www.youtube.com/user/DrBartosz in Lua. You can also find a PDF of the book that goes with the lectures here: https://github.com/hmemcpy/milewski-ctfp-pdf.

## Running Tests
I'm using `busted` which is a simple unit test framework. I may add a script to run all the tests eventually, but for now:
```
lua_modules/bin/busted spec/<spec>.lua
```

## Style
I'm generally trying to follow https://github.com/Olivine-Labs/lua-style-guide.
