# AI Agent Guide: Maintaining Xmake EmmyLua Annotations

This guide helps AI agents update the `xmake.lua` EmmyLua type definitions file when xmake adds new APIs or changes existing ones.

---

## Quick Reference

| Item                  | Path                       |
| -                     | -                          |
| **Xmake Source**      | env `${XMAKE_SOURCE}`      |
| **EmmyLua LS Source** | env `${EMMYLUA_LS_SOURCE}` |
| **Annotation Output** | `./xmake.lua`              |

---

## Understanding the Architecture

### Xmake API Registration Flow

```
xmake/core/project/*.lua defines APIs
        ↓
api_define() called with scope.prefix
        ↓
api_register_scope() auto-creates entry functions
        ↓
APIs available in xmake.lua DSL
```

Key concept: **Scopes** - Each scope (`target`, `option`, `rule`, `package`, `toolchain`) has:
1. **Entry function** (e.g., `target("name")`) - registered by `api_register_scope()`
2. **Scoped APIs** (e.g., `set_kind()`, `add_files()`) - defined in `scope.apis()`

---

## Key Source Files in Xmake

### 1. API Definitions by Scope

| Scope | File Path | Function to Check |
|-------|-----------|-------------------|
| `target` | `${XMAKE_SOURCE}/xmake/core/project/target.lua` | `target.apis()` around line 2900+ |
| `option` | `${XMAKE_SOURCE}/xmake/core/project/option.lua` | `option.apis()` |
| `rule` | `${XMAKE_SOURCE}/xmake/core/project/rule.lua` | `rule.apis()` |
| `package` | `${XMAKE_SOURCE}/xmake/core/project/package.lua` | `package.apis()` |
| `toolchain` | `${XMAKE_SOURCE}/xmake/core/project/toolchain.lua` | `toolchain.apis()` |

### 2. API Registration System

| File | Purpose |
|------|---------|
| `${XMAKE_SOURCE}/xmake/core/base/interpreter.lua` | Core interpreter, `api_define()`, `api_register_scope()` |
| `${XMAKE_SOURCE}/xmake/core/project/project.lua` | Loads and registers all scope APIs |

### 3. Builtin Functions

| File | Contents |
|------|----------|
| `${XMAKE_SOURCE}/xmake/core/sandbox/modules/` | Sandbox modules available in `xmake.lua` (os, path, string, table) |
| `${XMAKE_SOURCE}/xmake/core/base/` | Base modules for utility scripts |

---

## How to Extract APIs

### Step 1: Read the Scope's `apis()` Function

Example for target scope:

```lua
-- In ${XMAKE_SOURCE}/xmake/core/project/target.lua
function target.apis()
    return {
        -- Value APIs: set_kind, set_version, etc.
        values = {
            "target.set_kind",
            "target.set_version",
            "target.set_plat",
            -- ... more
        },
        -- Path APIs: set_targetdir, add_files, etc.
        paths = {
            "target.set_targetdir",
            "target.add_files",
            -- ... more
        },
        -- Script APIs: on_load, before_build, after_link, etc.
        script = {
            {"target.on_load", "function"},
            {"target.before_build", "function"},
            -- ... more
        },
        -- Key-value APIs: set_configvar, set_values, etc.
        keyvalues = {
            "target.set_configvar",
            "target.set_values",
            -- ... more
        },
        -- Dictionary APIs
        dicts = {
            -- ...
        },
        -- Array APIs
        arrays = {
            -- ...
        }
    }
end
```

### Step 2: Parse API Names

Each API string follows the pattern: `"scope.function_name"`

| API String | Generated Function | Scope |
|------------|-------------------|-------|
| `"target.set_kind"` | `set_kind()` | target |
| `"target.add_files"` | `add_files()` | target |
| `"option.set_default"` | `set_default()` | option |

### Step 3: Generate EmmyLua Annotations

#### For Value APIs (`values`)

```lua
--- Set target kind (binary, static, shared, object, phony, headeronly)
---@param kind "binary"|"static"|"shared"|"object"|"phony"|"headeronly"
function set_kind(kind) end
```

**Notes:**
- Document valid values in the description
- Use literal union types for enums

#### For Path APIs (`paths`)

```lua
--- Set output directory
---@param dir string Directory path
function set_targetdir(dir) end
```

**Notes:**
- All paths are strings
- Some accept glob patterns

#### For Script APIs (`script`)

```lua
---@alias xmake_target_target table Target instance object

--- Custom load action
---@param func fun(target: xmake_target_target)
function on_load(func) end
```

**Notes:**
- Callbacks receive `target` object as first parameter
- Use `@alias` to define the target type
- Some callbacks receive additional parameters (sourcefile, opt)

#### For Key-Value APIs (`keyvalues`)

```lua
--- Set config variable
---@param name string Variable name
---@param value any Variable value
---@param options? table Options (e.g., {quote = false})
function set_configvar(name, value, options) end
```

---

## Scope Entry Functions

Every scope has an entry function and an exit function:

| Scope | Entry Function | Exit Function |
|-------|---------------|---------------|
| target | `target(name, config?)` | `target_end()` |
| option | `option(name, config?)` | `option_end()` |
| rule | `rule(name, config?)` | `rule_end()` |
| package | `package(name, config?)` | `package_end()` |
| toolchain | `toolchain(name, config?)` | `toolchain_end()` |
| task | `task(name, config?)` | `task_end()` |
| language | `language(name, config?)` | `language_end()` |

**Entry function signature:**

```lua
--- Define a build target
---@param name string Target name
---@param config? table|fun() Optional table config or function body
function target(name, config) end
```

---

## Platform Detection Functions

These are global functions available in `xmake.lua`:

```lua
--- Check if host OS matches
---@param plat string Platform name
---@return boolean
function is_host(plat) end

--- Check if target platform matches
---@param plat string Platform name
---@return boolean
function is_plat(...) end

--- Check if target architecture matches
---@param arch string Architecture name
---@return boolean
function is_arch(...) end

--- Check if build mode matches
---@param mode string Mode name (e.g., "debug", "release")
---@return boolean
function is_mode(mode) end

--- Check if config exists
---@param name string Config name
---@return boolean
function has_config(name) end

--- Check if package exists
---@param name string Package name
---@return boolean
function has_package(name) end
```

---

## Script Context Functions

Available inside `on_*`, `before_*`, `after_*` callbacks:

```lua
--- Get the current target instance
---@return xmake_target_target
function target() end

--- Import a module
---@param name string Module name (e.g., "core.base.option")
---@param opt? table Options {inherit = boolean, alias = string}
---@return any Imported module
function import(name, opt) end

--- Raise an error and abort
---@param msg string Error message
---@param ... any Format arguments
function raise(msg, ...) end

--- Print formatted message
---@param ... any Values to print
function print(...) end

--- Print warning message
---@param ... any Values to print
function warn(...) end
```

---

## Builtin Modules Available

These modules are available in `xmake.lua` scope:

```lua
---@class xmake_os_module
os = {}

---@class xmake_path_module
path = {}

--- Standard Lua modules also available:
--- string, table, io, math, pairs, ipairs, tonumber, tostring, type, print
```

**To see full module definitions, check:**
- `${XMAKE_SOURCE}/xmake/core/sandbox/modules/import/core/sandbox/module.lua`
- `${XMAKE_SOURCE}/xmake/core/sandbox/modules/os.lua`
- `${XMAKE_SOURCE}/xmake/core/sandbox/modules/path.lua`

---

## Annotation File Structure

The `xmake.lua` file should be organized as follows:

```lua
---@meta xmake
-- Xmake Build System DSL Type Definitions for EmmyLua
-- Based on xmake source code analysis
-- https://xmake.io

--=============================================================================
-- 1. Core Scope Functions (target, option, rule, etc.)
--=============================================================================

--=============================================================================
-- 2. Target APIs - Set Values (target.set_*)
--=============================================================================

--=============================================================================
-- 3. Target APIs - Add Values (target.add_*)
--=============================================================================

--=============================================================================
-- 4. Target APIs - Paths
--=============================================================================

--=============================================================================
-- 5. Target APIs - Key-Value Settings
--=============================================================================

--=============================================================================
-- 6. Target APIs - Script Hooks (on_*, before_*, after_*)
--=============================================================================

--=============================================================================
-- 7. Option APIs
--=============================================================================

--=============================================================================
-- 8. Package APIs
--=============================================================================

--=============================================================================
-- 9. Rule APIs
--=============================================================================

--=============================================================================
-- 10. Toolchain APIs
--=============================================================================

--=============================================================================
-- 11. Project-level APIs
--=============================================================================

--=============================================================================
-- 12. Platform Detection Functions
--=============================================================================

--=============================================================================
-- 13. Script Context - Builtin Functions
--=============================================================================

--=============================================================================
-- 14. Builtin Sandbox Modules
--=============================================================================

--=============================================================================
-- 15. Common Aliases for Type Hints
--=============================================================================
```

---

## Update Checklist

When updating the annotation file:

- [ ] Read the scope's `apis()` function in `${XMAKE_SOURCE}/xmake/core/project/*.lua`
- [ ] Compare with existing annotations in `xmake.lua`
- [ ] Identify new APIs added since last update
- [ ] Identify deprecated/removed APIs
- [ ] Update type signatures for changed APIs
- [ ] Add/update `@alias` types for new enum values
- [ ] Verify entry functions (scope, scope_end) are documented
- [ ] Check if new scopes were added
- [ ] Update `EMMYLUA_SETUP.md` if configuration changed
- [ ] Test annotations with a sample `xmake.lua`

---

## Finding Changes in Xmake

### Method 1: Check Git History

```bash
cd ${XMAKE_SOURCE}
git log --oneline --all -- "**/target.lua" "**/option.lua" "**/rule.lua" | head -20
```

### Method 2: Search for API Patterns

```bash
# Find all set_* function definitions
grep -r "set_\w*" ${XMAKE_SOURCE}/xmake/core/project/*.lua

# Find all add_* function definitions
grep -r "add_\w*" ${XMAKE_SOURCE}/xmake/core/project/*.lua

# Find all on_* function definitions
grep -r "on_\w*" ${XMAKE_SOURCE}/xmake/core/project/*.lua
```

### Method 3: Check xmake show APIs

```bash
# If xmake is built, list all APIs
xmake show apis
```

---

## Common Patterns

### Pattern 1: Simple Value Setter

```lua
-- Xmake source:
"target.set_kind"

-- EmmyLua annotation:
--- Set target kind
---@param kind "binary"|"static"|"shared"|"object"|"phony"|"headeronly"
function set_kind(kind) end
```

### Pattern 2: Multiple Values (varargs)

```lua
-- Xmake source:
"target.add_files"

-- EmmyLua annotation:
--- Add source files
---@param ... string File patterns
function add_files(...) end
```

### Pattern 3: Key-Value Function

```lua
-- Xmake source:
"target.set_configvar"

-- EmmyLua annotation:
--- Set config variable
---@param name string Variable name
---@param value any Variable value
---@param options? table Options
function set_configvar(name, value, options) end
```

### Pattern 4: Script Hook

```lua
-- Xmake source:
{"target.on_load", "function"}

-- EmmyLua annotation:
--- Custom load action
---@param func fun(target: xmake_target_target)
function on_load(func) end
```

### Pattern 5: Path Function

```lua
-- Xmake source:
"target.set_targetdir"

-- EmmyLua annotation:
--- Set output directory
---@param dir string Directory path
function set_targetdir(dir) end
```

---

## Type Aliases to Maintain

Keep these `@alias` definitions updated:

```lua
---@alias xmake_build_kind "binary"|"static"|"shared"|"object"|"phony"|"headeronly"
---@alias xmake_plat "linux"|"macosx"|"windows"|"android"|"iphoneos"|"watchos"|"appletv"
---@alias xmake_arch "x86"|"x64"|"arm"|"arm64"|"mips"|"mips64"|"riscv"|"riscv64"
---@alias xmake_mode "debug"|"release"|"releasedbg"|"minsizerel"
---@alias xmake_optimize "none"|"fast"|"faster"|"fastest"|"smallest"|"aggressive"
---@alias xmake_warnings "none"|"less"|"more"|"all"|"error"
---@alias xmake_symbols "none"|"debug"|"hidden"
```

Add new values when xmake adds new platforms, architectures, or modes.

---

## Testing the Annotations

### Step 1: Create Test xmake.lua

```lua
target("test")
    set_kind("binary")  -- Should autocomplete: binary, static, shared...
    set_languages("c++17")
    add_files("src/*.cpp")
    add_deps("libfoo")
    
    on_load(function (target)
        print("Loading " .. target:name())
    end)
target_end()
```

### Step 2: Configure EmmyLua

```json
{
  "workspace": {
    "library": ["<the-path-of-this-repo>"]
  }
}
```

### Step 3: Verify

- No `undefined-global` errors for `target`, `set_kind`, `add_files`
- Autocomplete shows valid options for `set_kind()`
- Parameter hints appear for `add_files()`
- Inside `on_load()`, `target` parameter has autocomplete

---

## References

- **Xmake Manual**: https://xmake.io/#/manual/project_target
- **EmmyLua Annotations**: ${EMMYLUA_LS_SOURCE}/docs/emmylua_doc/
- **EmmyLua Config**: ${EMMYLUA_LS_SOURCE}/docs/config/emmyrc_json_EN.md

---

## Questions?

If unclear about an API:
1. Check `${XMAKE_SOURCE}/xmake/core/project/*.lua` for the `apis()` function
2. Look for usage examples in `${XMAKE_SOURCE}/tests/`
3. Check xmake documentation at https://xmake.io
4. Search for the function implementation in the interpreter
