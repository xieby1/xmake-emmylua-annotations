---@meta xmake
-- Xmake Build System DSL Type Definitions for EmmyLua
-- Based on xmake source code analysis
-- https://xmake.io

--=============================================================================
-- Core Scope Functions (target, option, rule, etc.)
--=============================================================================

--- Define a build target
---@param name string Target name
---@param config? table|fun() Optional table config or function body
function target(name, config) end

--- End target scope
function target_end() end

--- Define a configuration option
---@param name string Option name
---@param config? table|fun() Optional table config or function body
function option(name, config) end

--- End option scope
function option_end() end

--- Define a build rule
---@param name string Rule name
---@param config? table|fun() Optional table config or function body
function rule(name, config) end

--- End rule scope
function rule_end() end

--- Define a package dependency
---@param name string Package name
---@param config? table|fun() Optional table config or function body
function package(name, config) end

--- End package scope
function package_end() end

--- Define a toolchain
---@param name string Toolchain name
---@param config? table|fun() Optional table config or function body
function toolchain(name, config) end

--- End toolchain scope
function toolchain_end() end

--- Define a build task
---@param name string Task name
---@param config? table|fun() Optional table config or function body
function task(name, config) end

--- End task scope
function task_end() end

--- Define a language configuration
---@param name string Language name
---@param config? table|fun() Optional table config or function body
function language(name, config) end

--- End language scope
function language_end() end

--=============================================================================
-- Target APIs - Set Values (target.set_*)
--=============================================================================

--- Set target kind (binary, static, shared, object, phony, headeronly)
---@param kind "binary"|"static"|"shared"|"object"|"phony"|"headeronly"
function set_kind(kind) end

--- Set target platform
---@param plat string Platform name
function set_plat(plat) end

--- Set target architecture
---@param arch string Architecture name
function set_arch(arch) end

--- Set strip mode
---@param mode "all"|"debug"|"none"
function set_strip(mode) end

--- Set rules for target
---@param ... string Rule names
function set_rules(...) end

--- Set target group
---@param group string Group name
function set_group(group) end

--- Set target version
---@param version string Version string
function set_version(version) end

--- Set target license
---@param license string License name
function set_license(license) end

--- Enable/disable target
---@param enabled boolean Whether target is enabled
function set_enabled(enabled) end

--- Set as default target
---@param is_default boolean Whether this is the default target
function set_default(is_default) end

--- Set options for target
---@param ... string Option names
function set_options(...) end

--- Set symbol level
---@param symbols "debug"|"hidden"|"none"
function set_symbols(symbols) end

--- Set output filename
---@param filename string Filename
function set_filename(filename) end

--- Set output basename
---@param basename string Basename
function set_basename(basename) end

--- Set output extension
---@param ext string Extension
function set_extension(ext) end

--- Set output prefix name
---@param prefix string Prefix
function set_prefixname(prefix) end

--- Set output suffix name
---@param suffix string Suffix
function set_suffixname(suffix) end

--- Set warning level
---@param warnings "none"|"less"|"more"|"all"|"error"
function set_warnings(warnings) end

--- Set floating-point model
---@param ... string FPMODEL values
function set_fpmodels(...) end

--- Set optimization level
---@param optimize "none"|"fast"|"faster"|"fastest"|"smallest"|"aggressive"
function set_optimize(optimize) end

--- Set runtime library (MSVC)
---@param runtime "MD"|"MDd"|"MT"|"MTd"
function set_runtimes(runtime) end

--- Set language standards
---@param ... string Language standards (e.g., "c++17")
function set_languages(...) end

--- Set toolchains
---@param ... string Toolchain names
function set_toolchains(...) end

--- Set default run arguments
---@param ... string Arguments
function set_runargs(...) end

--- Set exception handling
---@param exceptions "no"|"cxx"
function set_exceptions(exceptions) end

--- Set source encodings
---@param ... string Encodings
function set_encodings(...) end

--- Set installation prefix directory
---@param dir string Directory path
function set_prefixdir(dir) end

--- Set policy
---@param name string Policy name
---@param value any Policy value
function set_policy(name, value) end

--=============================================================================
-- Target APIs - Add Values (target.add_*)
--=============================================================================

--- Add target dependencies
---@param ... string Dependency names
function add_deps(...) end

--- Add rules to target
---@param ... string Rule names
function add_rules(...) end

--- Add options to target
---@param ... string Option names
function add_options(...) end

--- Add package dependencies
---@param ... string Package names
function add_packages(...) end

--- Add imports for scripts
---@param ... string Import patterns (e.g., "core.base.option")
function add_imports(...) end

--- Add language standards
---@param ... string Language standards
function add_languages(...) end

--- Add vector extensions
---@param ... string Extension names (e.g., "neon", "avx2")
function add_vectorexts(...) end

--- Add toolchains
---@param ... string Toolchain names
function add_toolchains(...) end

--- Add tests
---@param name string Test name
---@param config table Test configuration
function add_tests(name, config) end

--=============================================================================
-- Target APIs - Paths (target.set_* for paths, target.add_* for files)
--=============================================================================

--- Set output directory
---@param dir string Directory path
function set_targetdir(dir) end

--- Set object file directory
---@param dir string Directory path
function set_objectdir(dir) end

--- Set dependency directory
---@param dir string Directory path
function set_dependir(dir) end

--- Set auto-generated files directory
---@param dir string Directory path
function set_autogendir(dir) end

--- Set config file output directory
---@param dir string Directory path
function set_configdir(dir) end

--- Set installation directory
---@param dir string Directory path
function set_installdir(dir) end

--- Set run working directory
---@param dir string Directory path
function set_rundir(dir) end

--- Add source files
---@param ... string File patterns
function add_files(...) end

--- Add files to clean
---@param ... string File patterns
function add_cleanfiles(...) end

--- Add config file templates
---@param ... string File patterns
function add_configfiles(...) end

--- Add files to install
---@param ... string File patterns
function add_installfiles(...) end

--- Add extra files
---@param ... string File patterns
function add_extrafiles(...) end

--- Add header files
---@param ... string File patterns
function add_headerfiles(...) end

--- Remove files
---@param ... string File patterns
function remove_files(...) end

--- Remove header files
---@param ... string File patterns
function remove_headerfiles(...) end

--- Remove config files
---@param ... string File patterns
function remove_configfiles(...) end

--- Remove install files
---@param ... string File patterns
function remove_installfiles(...) end

--- Remove extra files
---@param ... string File patterns
function remove_extrafiles(...) end

--=============================================================================
-- Target APIs - Key-Value Settings
--=============================================================================

--- Set generic value
---@param key string Key name
---@param ... any Values
function set_values(key, ...) end

--- Add generic value
---@param key string Key name
---@param ... any Values
function add_values(key, ...) end

--- Set config variable
---@param name string Variable name
---@param value any Variable value
---@param options? table Options (e.g., {quote = false})
function set_configvar(name, value, options) end

--- Set runtime environment variable
---@param name string Variable name
---@param value string Variable value
function set_runenv(name, value) end

--- Add runtime environment variables
---@param name string Variable name
---@param ... string Values
function add_runenvs(name, ...) end

--- Set toolset
---@param tool string Tool name (e.g., "cc", "cxx", "ld")
---@param value string Tool path or name
function set_toolset(tool, value) end

--=============================================================================
-- Target APIs - Script Hooks (on_*, before_*, after_*)
--=============================================================================

---@alias xmake_target_target table Target instance object

--- Custom run action
---@param func fun(target: xmake_target_target)
function on_run(func) end

--- Custom test action
---@param func fun(target: xmake_target_target)
function on_test(func) end

--- Custom load action
---@param func fun(target: xmake_target_target)
function on_load(func) end

--- Custom config action
---@param func fun(target: xmake_target_target)
function on_config(func) end

--- Custom link action
---@param func fun(target: xmake_target_target)
function on_link(func) end

--- Custom build action
---@param func fun(target: xmake_target_target)
function on_build(func) end

--- Custom build file action
---@param func fun(target: xmake_target_target, sourcefile: string, opt: table)
function on_build_file(func) end

--- Custom build files action
---@param func fun(target: xmake_target_target, sourcefiles: string[], opt: table)
function on_build_files(func) end

--- Custom clean action
---@param func fun(target: xmake_target_target)
function on_clean(func) end

--- Custom package action
---@param func fun(target: xmake_target_target)
function on_package(func) end

--- Custom install action
---@param func fun(target: xmake_target_target)
function on_install(func) end

--- Custom uninstall action
---@param func fun(target: xmake_target_target)
function on_uninstall(func) end

--- Custom command preparation
---@param func fun(target: xmake_target_target, cmd: table, opt: table)
function on_preparecmd(func) end

--- Custom link command
---@param func fun(target: xmake_target_target, cmd: table, opt: table)
function on_linkcmd(func) end

--- Custom build command
---@param func fun(target: xmake_target_target, cmd: table, opt: table)
function on_buildcmd(func) end

--- Custom install command
---@param func fun(target: xmake_target_target, cmd: table, opt: table)
function on_installcmd(func) end

--- Hook before run
---@param func fun(target: xmake_target_target)
function before_run(func) end

--- Hook after run
---@param func fun(target: xmake_target_target)
function after_run(func) end

--- Hook before build
---@param func fun(target: xmake_target_target)
function before_build(func) end

--- Hook after build
---@param func fun(target: xmake_target_target)
function after_build(func) end

--- Hook before link
---@param func fun(target: xmake_target_target)
function before_link(func) end

--- Hook after link
---@param func fun(target: xmake_target_target)
function after_link(func) end

--- Hook before clean
---@param func fun(target: xmake_target_target)
function before_clean(func) end

--- Hook after clean
---@param func fun(target: xmake_target_target)
function after_clean(func) end

--- Hook before install
---@param func fun(target: xmake_target_target)
function before_install(func) end

--- Hook after install
---@param func fun(target: xmake_target_target)
function after_install(func) end

--=============================================================================
-- Option APIs
--=============================================================================

--- Set option description
---@param desc string Description
function set_description(desc) end

--- Set option category
---@param category string Category name
function set_category(category) end

--- Set option as boolean only
---@param is_bool boolean Whether option is boolean
function set_is_bool(is_bool) end

--- Show option in menu
---@param show boolean Whether to show
function set_showmenu(show) end

--- Set option default value
---@param value any Default value
function set_default(value) end

--- Set option to trigger rebuild when changed
---@param always boolean Whether always build
function set_always_build(always) end

--- Check option configuration
---@param func fun(option: table) Checker function
function on_check(func) end

--=============================================================================
-- Package APIs
--=============================================================================

--- Set package description
---@param desc string Description
function set_description(desc) end

--- Set package homepage
---@param url string URL
function set_homepage(url) end

--- Set package URL for download
---@param url string URL pattern
function set_url(url) end

--- Set package version
---@param version string Version
---@param sha256? string SHA256 hash
function set_version(version, sha256) end

--- Set package kind (binary, library)
---@param kind "binary"|"library"
function set_kind(kind) end

--- Set package license
---@param license string License
function set_license(license) end

--- Set package sourcedir
---@param dir string Directory
function set_sourcedir(dir) end

--- Set package base directory
---@param dir string Directory
function set_basedir(dir) end

--- Add package URLs
---@param ... string URLs
function add_urls(...) end

--- Add package versions
---@param version string Version
---@param sha256 string SHA256 hash
function add_versions(version, sha256) end

--- Add package patches
---@param version string Version
---@param patch string Patch file
---@param sha256 string SHA256 hash
function add_patches(version, patch, sha256) end

--- Add package dependencies
---@param ... string Package names
function add_deps(...) end

--- Add package configurations
---@param name string Config name
---@param config table Config definition
function add_configs(name, config) end

--- Set package on load callback
---@param func fun(package: table)
function on_load(func) end

--- Set package install callback
---@param func fun(package: table)
function on_install(func) end

--- Set package test callback
---@param func fun(package: table)
function on_test(func) end

--=============================================================================
-- Rule APIs
--=============================================================================

--- Set rule dependencies
---@param ... string Rule names
function add_deps(...) end

--- Custom rule on load
---@param func fun(target: table)
function on_load(func) end

--- Custom rule on config
---@param func fun(target: table)
function on_config(func) end

--- Custom rule on build file
---@param func fun(target: table, sourcefile: string, opt: table)
function on_build_file(func) end

--- Custom rule on build files
---@param func fun(target: table, sourcefiles: string[], opt: table)
function on_build_files(func) end

--- Custom rule on clean
---@param func fun(target: table, sourcefiles: string[], opt: table)
function on_clean(func) end

--- Custom rule on link
---@param func fun(target: table)
function on_link(func) end

--- Custom rule before build file
---@param func fun(target: table, sourcefile: string, opt: table)
function before_build_file(func) end

--- Custom rule after build file
---@param func fun(target: table, sourcefile: string, opt: table)
function after_build_file(func) end

--- Custom rule before build files
---@param func fun(target: table, sourcefiles: string[], opt: table)
function before_build_files(func) end

--- Custom rule after build files
---@param func fun(target: table, sourcefiles: string[], opt: table)
function after_build_files(func) end

--=============================================================================
-- Toolchain APIs
--=============================================================================

--- Set toolchain description
---@param desc string Description
function set_description(desc) end

--- Set toolchain kind
---@param kind string Kind
function set_kind(kind) end

--- Set toolchain home directory
---@param home string Path
function set_home(home) end

--- Set toolchain path
---@param tool string Tool name
---@param path string Tool path
function set_tool(tool, path) end

--- Add toolchain tools
---@param tool string Tool name
---@param ... string Tool paths/names
function add_tools(tool, ...) end

--- Add toolchain paths
---@param ... string Paths
function add_toolchains(...) end

--- Check toolchain
---@param func fun(toolchain: table)
function on_check(func) end

--- Load toolchain
---@param func fun(toolchain: table)
function on_load(func) end

--=============================================================================
-- Project-level APIs
--=============================================================================

--- Set project name
---@param name string Project name
function set_project(name) end

--- Set project version
---@param version string Version
function set_version(version) end

--- Set project description
---@param desc string Description
function set_description(desc) end

--- Set xmake minimum version
---@param version string Version
function set_xmakever(version) end

--- Set project license
---@param license string License
function set_license(license) end

--- Set project languages
---@param ... string Languages
function set_languages(...) end

--- Set project warnings
---@param warnings string Warning level
function set_warnings(warnings) end

--- Set project encodings
---@param ... string Encodings
function set_encodings(...) end

--- Set project policies
---@param name string Policy name
---@param value any Policy value
function set_policy(name, value) end

--- Set allowed modes (debug, release, etc.)
---@param ... string Modes
function set_allowedmodes(...) end

--- Set allowed platforms
---@param ... string Platforms
function set_allowedplats(...) end

--- Set allowed architectures
---@param ... string Architectures
function set_allowedarchs(...) end

--- Set default mode
---@param mode string Mode
function set_defaultmode(mode) end

--- Set default platform
---@param plat string Platform
function set_defaultplat(plat) end

--- Set default architecture
---@param arch string Architecture
function set_defaultarch(arch) end

--- Add project modules
---@param ... string Module paths
function add_moduledirs(...) end

--- Add project plugins
---@param ... string Plugin paths
function add_plugindirs(...) end

--- Add project repositories
---@param ... string Repository URLs
function add_repositories(...) end

--- Add package requires
---@param ... string Package specifications
function add_requires(...) end

--- Add package requires with configurations
---@param spec string Package specification
---@param config table Package configuration
function add_requires(spec, config) end

--- Add project configurations
---@param name string Config name
---@param config table Config definition
function add_configs(name, config) end

--- Add project defines
---@param ... string Defines
function add_defines(...) end

--- Add project options
---@param ... string Option files
function add_options(...) end

--- Add project rules
---@param ... string Rule files
function add_rules(...) end

--- Add project subdirectories
---@param ... string Directory paths
function add_subdirs(...) end

--- Add project subfiles
---@param ... string File paths
function add_subfiles(...) end

--- Add project files
---@param ... string File patterns
function add_files(...) end

--=============================================================================
-- Platform Detection Functions
--=============================================================================

--- Check if host OS matches
---@param plat string Platform name
---@return boolean
function is_host(plat) end

--- Check if sub-host OS matches
---@param plat string Platform name
---@return boolean
function is_subhost(plat) end

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

--- Check if target kind matches
---@param kind string Kind name
---@return boolean
function is_kind(kind) end

--- Check if config exists
---@param name string Config name
---@return boolean
function has_config(name) end

--- Check if package exists
---@param name string Package name
---@return boolean
function has_package(name) end

--- Check if tool exists
---@param name string Tool name
---@return boolean
function has_tool(name) end

--=============================================================================
-- Script Context - Builtin Functions (available in on_*, before_*, after_*)
--=============================================================================

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

--- Print formatted message (no newline)
---@param ... any Values to print
function printf(...) end

--- Print a warning message
---@param ... any Values to print
function warn(...) end

--=============================================================================
-- Builtin Sandbox Modules (available in xmake.lua)
--=============================================================================

---@class xmake_os_module
os = {}

---@class xmake_path_module
path = {}

---@class xmake_string_module
string = {}

---@class xmake_table_module
table = {}

---@class xmake_io_module
io = {}

---@class xmake_math_module
math = {}

---@class xmake_pairs_module
pairs = pairs

---@class xmake_ipairs_module
ipairs = ipairs

---@class xmake_tonumber_module
tonumber = tonumber

---@class xmake_tostring_module
tostring = tostring

---@class xmake_type_module
type = type

---@class xmake_print_module
print = print

--=============================================================================
-- Common Aliases for Type Hints
--=============================================================================

---@alias xmake_build_kind "binary"|"static"|"shared"|"object"|"phony"|"headeronly"
---@alias xmake_plat "linux"|"macosx"|"windows"|"android"|"iphoneos"|"watchos"|"appletv"
---@alias xmake_arch "x86"|"x64"|"arm"|"arm64"|"mips"|"mips64"|"riscv"|"riscv64"
---@alias xmake_mode "debug"|"release"|"releasedbg"|"minsizerel"
---@alias xmake_optimize "none"|"fast"|"faster"|"fastest"|"smallest"|"aggressive"
---@alias xmake_warnings "none"|"less"|"more"|"all"|"error"
---@alias xmake_symbols "none"|"debug"|"hidden"
