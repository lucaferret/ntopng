<template>
    <div class="m-2 mb-3">
        <TableWithConfig ref="table_probes" :table_id="table_id" :csrf="csrf" :f_map_columns="map_table_def_columns"
            :f_sort_rows="columns_sorting" :get_extra_params_obj="get_extra_params_obj">
        </TableWithConfig>
    </div>
</template>


<script setup>
import { ref, onBeforeMount } from "vue";
import { default as sortingFunctions } from "../utilities/sorting-utils.js";
import { default as TableWithConfig } from "./table-with-config.vue";
import formatterUtils from "../utilities/formatter-utils";

const props = defineProps({
    context: Object,
});

const table_id = ref('probes');
const table_probes = ref(null);
const csrf = props.context.csrf;

const chart_url = `${http_prefix}/lua/pro/enterprise/flowdevices_stats.lua?page=historical`
const exporter_url = `${http_prefix}/lua/pro/enterprise/flowdevices_stats.lua?`
const host_url = `${http_prefix}/lua/host_details.lua?`

onBeforeMount(() => {})

const get_extra_params_obj = () => {
    let extra_params = ntopng_url_manager.get_url_object();
    return extra_params;
};

const map_table_def_columns = (columns) => {
    let map_columns = {
        "probe_ip": (value, row) => {
            if (!row.is_probe_active) {
                return value                
            } else {
                return `<a href="${host_url}?ip=${value}">${value} <i class="fas fa-laptop"></i></a>` 
            }
        },
        "probe_public_ip": (value, row) => {
            return value
        },
        "probe_uuid": (value, row) => {
            return value
        },
        "probe_interface": (value, row) => {
            return value
        },
        "flow_exporters": (value, row) => {
            if (!value) {
                return '';
            } else {
                return `<a href="${exporter_url}&ifid=${row.ifid}&ip=${row.probe_ip}"><i class="fas fa-file-export"></i> ${formatterUtils.getFormatter("number")(value)}</a>` 
            }
        },
        "dropped_flows": (value, row) => {
            if (!value) {
                return '';
            } else {
                return `<a href="${exporter_url}&ifid=${row.ifid}&ip=${row.probe_ip}"><i class="fas fa-file-export"></i> ${formatterUtils.getFormatter("number")(value)}</a>` 
            }
        },
        "exported_flows": (value, row) => {
            if (!value) {
                return '';
            } else {
                return `<a href="${exporter_url}&ifid=${row.ifid}&ip=${row.probe_ip}"><i class="fas fa-file-export"></i> ${formatterUtils.getFormatter("number")(value)}</a>` 
            }
        },
        "probe_edition": (value, row) => {
            return value
        },
        "probe_license": (value, row) => {
            return value
        },
        "probe_maintenance": (value, row) => {
            return value
        },
    };

    columns.forEach((c) => {
        c.render_func = map_columns[c.data_field];
    });

    return columns;
};


function columns_sorting(col, r0, r1) {
    if (col != null) {
        if (col.id == "probe_ip") {
            return sortingFunctions.sortByIP(r0.probe_ip, r1.probe_ip, col.sort);
        } else if (col.id == "probe_public_ip") {
            return sortingFunctions.sortByIP(r0.probe_public_ip, r1.probe_public_ip, col.sort);
        } else if (col.id == "probe_uuid") {
            return sortingFunctions.sortByName(r0.probe_uuid, r1.probe_uuid, col.sort);
        } else if (col.id == "probe_interface") {
            return sortingFunctions.sortByName(r0.probe_interface, r1.probe_interface, col.sort);
        } else if (col.id == "flow_exporters") {
            return sortingFunctions.sortByNumber(r0.flow_exporters, r1.flow_exporters, col.sort);
        } else if (col.id == "dropped_flows") {
            return sortingFunctions.sortByNumber(r0.dropped_flows, r1.dropped_flows, col.sort);
        } else if (col.id == "exported_flows") {
            return sortingFunctions.sortByNumber(r0.exported_flows, r1.exported_flows, col.sort);
        } else if (col.id == "probe_edition") {
            return sortingFunctions.sortByName(r0.probe_edition, r1.probe_edition, col.sort);
        } else if (col.id == "probe_license") {
            return sortingFunctions.sortByName(r0.probe_license, r1.probe_license, col.sort);
        } else if (col.id == "probe_maintenance") {
            return sortingFunctions.sortByName(r0.probe_maintenance, r1.probe_maintenance, col.sort);
        }
    }
}
</script>