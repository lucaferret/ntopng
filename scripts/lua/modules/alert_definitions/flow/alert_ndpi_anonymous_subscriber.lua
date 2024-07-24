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

local alert_ndpi_anonymous_subscriber = classes.class(alert)

-- ##############################################

alert_ndpi_anonymous_subscriber.meta = {
   alert_key  = flow_alert_keys.flow_alert_ndpi_anonymous_subscriber,
   i18n_title = "flow_risk.ndpi_anonymous_subscriber",
   icon = "fas fa-fw fa-exclamation",

   -- Mitre Att&ck Matrix values
   mitre_values = {
      mitre_tactic = mitre.tactic.indicator_removal,
      mitre_technique = mitre.technique.data_from_conf_repo,
      mitre_id = "T1070"
   },
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @return A table with the alert built
function alert_ndpi_anonymous_subscriber:init()
   -- Call the parent constructor
   self.super:init()
end

-- #######################################################

function alert_ndpi_anonymous_subscriber.format(ifid, alert, alert_type_params)
   return ""
end

-- #######################################################

return alert_ndpi_anonymous_subscriber
