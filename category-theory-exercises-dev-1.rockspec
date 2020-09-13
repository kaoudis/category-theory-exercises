package = "category-theory-exercises"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/kaoudis/category-theory-exercises.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      ["kleisli-category"] = "src/kleisli-category.lua"
   },
   install = {
      bin = {}
   }
}
