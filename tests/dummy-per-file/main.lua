-- Stock EmmyLua does not apply this repo's global xmake annotations per file
-- via require()/LUA_PATH alone; target() remains undefined without workspace.library.
require("xmake-emmylua-annotations")
target("miao")
target_end()
