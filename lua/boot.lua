#! /usr/bin/env tarantool
local ctrl = require '/lua/ctrl'

local server = require('http.server').new('0.0.0.0', 80)
server:route({ path = '/new' }, ctrl.new)
server:route({ path = '/get' }, ctrl.get)
server:start()