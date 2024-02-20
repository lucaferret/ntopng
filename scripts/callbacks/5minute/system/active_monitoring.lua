--
-- (C) 2013-24 - ntop.org
--

local dirs = ntop.getDirs()
package.path = dirs.installdir .. "/scripts/lua/modules/?.lua;" .. package.path

local do_am = ntop.getPrefs().active_monitoring
if (not do_am) then
  -- exit if am is disabled
  return
end

local ts_dump = require "ts_5min_dump_utils"
local am_utils = require  "am_utils"

local hosts = am_utils.getHosts(nil, "5mins")
am_utils.run_am_check(os.time(), hosts, "5mins")

