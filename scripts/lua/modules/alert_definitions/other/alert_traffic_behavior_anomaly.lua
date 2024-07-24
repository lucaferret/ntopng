--
-- (C) 2019-24 - ntop.org
--

-- ##############################################

local other_alert_keys = require "other_alert_keys"
local classes = require "classes"
local alert = require "alert"
local alert_entities = require("alert_entities")
local behavior_utils = require("behavior_utils")
-- Import Mitre Att&ck utils
local mitre = require "mitre_utils"

-- ##############################################

local alert_traffic_behavior_anomaly = classes.class(alert)

-- ##############################################

alert_traffic_behavior_anomaly.meta = {
   alert_key = other_alert_keys.alert_traffic_behavior_anomaly,
   i18n_title = "alerts_dashboard.alert_unexpected_traffic_behavior_title",
   icon = "fas fa-fw fa-exclamation",
   entities = {
      alert_entities.interface,
   },

   -- Mitre Att&ck Matrix values
   mitre_values = {
      mitre_tactic = mitre.tactic.credential_access,
      mitre_technique = mitre.technique.network_sniffing,
      mitre_id = "T1040"
   },
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @param entity           The entity of this anomaly (ASN, Network, ..)
-- @param type_of_behavior The type of anomaly presented (Traffic RX, Traffic TX, Score, ...)
-- @param value            The value got from the measurement
-- @param lower_bound      The lower bound of the measurement
-- @param upper_bound      The upper bound of the measurement
-- @param entity_id        The entity id of the anomaly (Found into behavior_utils.lua)
-- @param extra_params     Table of extra parameters used to create the href to the graph (e.g. protocol), pass nil if no extra params is needed
-- @return A table with the alert built
function alert_traffic_behavior_anomaly:init(entity, type_of_behavior, value, upper_bound, lower_bound, entity_id, timeseries_id, extra_params)
   -- Call the parent constructor
   self.super:init()

   self.alert_type_params = {
      entity = entity,
      type_of_behavior = type_of_behavior,
      value = value,
      upper_bound = upper_bound,
      lower_bound = lower_bound,
      entity_id = entity_id,
      timeseries_id = timeseries_id,
      extra_params = extra_params or {},
   }
end

-- #######################################################

-- @brief Format an alert into a human-readable string
-- @param ifid The integer interface id of the generated alert
-- @param alert The alert description table, including alert data such as the generating entity, timestamp, granularity, type
-- @param alert_type_params Table `alert_type_params` as built in the `:init` method
-- @return A human-readable string
function alert_traffic_behavior_anomaly.format(ifid, alert, alert_type_params)
   local type_of_behavior = ""

   -- Name of the behavior type, e.g. Score
   if alert_type_params.type_of_behavior then
      type_of_behavior = i18n("alert_behaviors." .. alert_type_params.type_of_behavior)
   end

   -- Generating the href for the timeserie
   if ntop.isEnterpriseL() then
      -- Mantaining family_key for supporting past alerts
      if (alert_type_params["family_key"] or alert_type_params["entity_id"]) and alert_type_params["timeseries_id"] then
         -- 10 minutes before and 10 minutes after the alert
         local alert_time = tonumber(alert.tstamp)
         local key = nil

         for k, v in pairs(alert_entities) do
            if v["entity_id"] == alert_type_params["entity_id"] then
               key = k
               break
            end
         end

         -- Formatting all the strings used to create the href to the graph
         local timeseries_id = {}
      end
   end

   return(i18n("alerts_dashboard.unexpected_behavior_anomaly_description", {
      entity = alert_type_params.entity or "",
      type_of_behavior = type_of_behavior,
      value = alert_type_params.value or 0,
      lower_bound = alert_type_params.lower_bound or 0,
      upper_bound = alert_type_params.upper_bound or 0,
   }))
end

-- #######################################################

return alert_traffic_behavior_anomaly
