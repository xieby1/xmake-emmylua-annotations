# XMake EmmyLua Annotations

EmmyLua type annotations for the [xmake](https://xmake.io) build system.

## Why this repo?

- xmake does not natively support Lua LSP annotations: https://github.com/xmake-io/xmake/issues/2656
- Existing Lua LSP annotations are out-of-date: https://github.com/LelouchHe/xmake-luals-addon, e.g. which does not support annotation of xmake function `add_toolchains`
- AI is good enough to generate annotations!

## Usage

Add this repository to your editor's Lua language server library path (`workspace.library`) so that `xmake-emmylua-annotations.lua` gets proper completions and diagnostics.

## Limitation

Current stock EmmyLua/`emmylua_check` only supports loading this annotation file as a workspace library. Per-file loading via `require("xmake-emmylua-annotations")` and `LUA_PATH` does not inject the global xmake DSL functions into just that file, so calls like `target()` and `target_end()` remain undefined unless the repo is added through `workspace.library`.

