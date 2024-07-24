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

local alert_ndpi_tls_cert_validity_too_long = classes.class(alert)

-- ##############################################

alert_ndpi_tls_cert_validity_too_long.meta = {
   alert_key  = flow_alert_keys.flow_alert_ndpi_tls_cert_validity_too_long,
   i18n_title = "alerts_dashboard.ndpi_tls_cert_validity_too_long_title",
   icon = "fas fa-fw fa-exclamation",

   -- Mitre Att&ck Matrix values
   mitre_values = {
      mitre_tactic = mitre.tactic.defense_evasion,
      mitre_technique = mitre.technique.impair_defenses,
      mitre_id = "T1562"
   },
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @return A table with the alert built
function alert_ndpi_tls_cert_validity_too_long:init()
   -- Call the parent constructor
   self.super:init()
end

-- #######################################################

function alert_ndpi_tls_cert_validity_too_long.format(ifid, alert, alert_type_params)
   return
end

-- #######################################################

return alert_ndpi_tls_cert_validity_too_long
