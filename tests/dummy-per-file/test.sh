#!/usr/bin/env bash
env LUA_PATH=$(realpath ../..)/?.lua emmylua_check .
