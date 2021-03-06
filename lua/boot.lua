#! /usr/bin/env tarantool
local ctrl = require '/lua/ctrl'

local server = require('http.server').new('0.0.0.0', 80)
server:route({ path = '/new' }, ctrl.new)
server:route({ path = '/get' }, ctrl.get)
server:route({ path = '/del' }, ctrl.del)
server:route({ path = '/user' }, ctrl.user)
server:route({ path = '/ip' }, ctrl.ip)
server:start()