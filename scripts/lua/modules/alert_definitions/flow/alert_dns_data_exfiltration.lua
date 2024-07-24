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

local alert_dns_data_exfiltration = classes.class(alert)

-- ##############################################

alert_dns_data_exfiltration.meta = {
   alert_key = flow_alert_keys.flow_alert_dns_data_exfiltration,
   i18n_title = "flow_details.dns_data_exfiltration",
   icon = "fas fa-fw fa-exclamation",

   -- Mitre Att&ck Matrix values
   mitre_values = {
      mitre_tactic = mitre.tactic.exfiltration,
      mitre_technique = mitre.technique.exfiltration_over_alt_proto,
      mitre_id = "T1048"
   },

   has_attacker = true,
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @return A table with the alert built
function alert_dns_data_exfiltration:init()
   -- Call the parent constructor
   self.super:init()
end

-- #######################################################

-- @brief Format an alert into a human-readable string
-- @param ifid The integer interface id of the generated alert
-- @param alert The alert description table, including alert data such as the generating entity, timestamp, granularity, type
-- @param alert_type_params Table `alert_type_params` as built in the `:init` method
-- @return A human-readable string
function alert_dns_data_exfiltration.format(ifid, alert, alert_type_params)
   return i18n("flow_details.dns_data_exfiltration")
end

-- #######################################################

return alert_dns_data_exfiltration
