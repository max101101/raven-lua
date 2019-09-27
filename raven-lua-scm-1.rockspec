package = "raven-lua"
version = "scm-1"
source = {
   url = "git://github.com/max101101/raven-lua.git"
}
description = {
   detailed = [[
A small Lua interface to [Sentry](https://sentry.readthedocs.org/) that also
has a helpful wrapper function `call()` that takes any arbitrary Lua function
(with arguments) and executes it, traps any errors and reports it automatically
to Sentry.]],
   homepage = "https://github.com/cloudflare/raven-lua",
   license = "BSD 3-clause"
}
dependencies = {
  "lua >= 5.1",
}
build = {
   type = "builtin",
   modules = {
      raven = "raven/init.lua",
      ["raven.util"] = "raven/util.lua",
      ["raven.senders.tarantool"] = "raven/senders/tarantool.lua",
      ["raven.senders.tarantool-legacy"] = "raven/senders/tarantool-legacy.lua",
   },
   copy_directories = {
   }
}
