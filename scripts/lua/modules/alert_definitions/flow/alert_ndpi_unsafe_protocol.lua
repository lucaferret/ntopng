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

local alert_ndpi_unsafe_protocol = classes.class(alert)

-- ##############################################

alert_ndpi_unsafe_protocol.meta = {
   alert_key  = flow_alert_keys.flow_alert_ndpi_unsafe_protocol,
   i18n_title = "alerts_dashboard.ndpi_unsafe_protocol_title",
   icon = "fas fa-fw fa-exclamation",

   -- Mitre Att&ck Matrix values
   mitre_values = {
      mitre_tactic = mitre.tactic.credential_access,
      mitre_technique = mitre.technique.forced_authentication,
      mitre_id = "T1187"
   },

   has_attacker = true,
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @return A table with the alert built
function alert_ndpi_unsafe_protocol:init()
   -- Call the parent constructor
   self.super:init()
end

-- #######################################################

function alert_ndpi_unsafe_protocol.format(ifid, alert, alert_type_params)
   return i18n('flow_risk.ndpi_unsafe_protocol_descr')
end

-- #######################################################

return alert_ndpi_unsafe_protocol
