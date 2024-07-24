--
-- (C) 2019-24 - ntop.org
--

-- ##############################################

local flow_alert_keys = require "flow_alert_keys"

-- Import the classes library.
local classes = require "classes"
-- Make sure to import the Superclass!
local alert = require "alert"
-- Import Mitre Att&ck utils
local mitre = require "mitre_utils"

-- ##############################################

local alert_ndpi_tls_uncommon_alpn = classes.class(alert)

-- ##############################################

alert_ndpi_tls_uncommon_alpn.meta = {
  alert_key = flow_alert_keys.flow_alert_ndpi_tls_uncommon_alpn,
  i18n_title = "flow_checks_config.tls_uncommon_alpn",
  icon = "fas fa-fw fa-info-circle",

   -- Mitre Att&ck Matrix values
   mitre_values = {
      mitre_tactic = mitre.tactic.discovery,
      mitre_technique = mitre.technique.remote_system_discovery,
      mitre_id = "T1018"
   },
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @return A table with the alert built
function alert_ndpi_tls_uncommon_alpn:init()
   -- Call the parent constructor
   self.super:init()
end

-- #######################################################

return alert_ndpi_tls_uncommon_alpn

