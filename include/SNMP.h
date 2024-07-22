/*
 *
 * (C) 2013-24 - ntop.org
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 */

#ifndef _SNMP_H_
#define _SNMP_H_

#include "ntop_includes.h"

#define SNMP_MAX_NUM_OIDS 10

/* ******************************* */

typedef enum {
  snmp_get_pdu = 0,
  snmp_get_next_pdu,
  snmp_get_bulk_pdu,
  snmp_set_pdu,
} snmp_pdu_primitive;

class SNMP {
 private:
  u_int snmp_version;
  bool batch_mode;
#ifdef HAVE_LIBSNMP
  std::vector<SNMPSession *> sessions;
  /* Variables below are used for the async check */
  lua_State *vm;
#else
  int udp_sock;
  u_int32_t request_id;
#endif
  u_int8_t getbulk_max_num_repetitions;
  
  void send_snmp_request(char *agent_host, u_int version, char *community,
                         char *level, char *username, char *auth_protocol,
                         char *auth_passphrase, char *privacy_protocol,
                         char *privacy_passphrase, snmp_pdu_primitive pduType,
                         char *oid[SNMP_MAX_NUM_OIDS],
                         char value_types[SNMP_MAX_NUM_OIDS],
                         char *values[SNMP_MAX_NUM_OIDS], bool _batch_mode);
#ifdef HAVE_LIBSNMP
  int snmpv3_get_fctn(lua_State *vm, snmp_pdu_primitive pduType,
                      bool skip_first_param, bool _batch_mode);
#endif
  int snmp_get_fctn(lua_State *vm, snmp_pdu_primitive pduType,
                    bool skip_first_param, bool _batch_mode);
  int snmp_read_response(lua_State *vm, u_int timeout);

 public:
  SNMP();
  ~SNMP();
  
#ifdef HAVE_LIBSNMP
  void handle_async_response(struct snmp_pdu *pdu, const char *agent_ip);
  void send_snmp_set_request(char *agent_host, char *community,
                             snmp_pdu_primitive pduType, u_int version,
                             char *oid[SNMP_MAX_NUM_OIDS],
                             char value_types[SNMP_MAX_NUM_OIDS],
                             char *values[SNMP_MAX_NUM_OIDS]);

  void send_snmpv3_request(char *agent_host, char *level, char *username,
                           char *auth_protocol, char *auth_passphrase,
                           char *privacy_protocol, char *privacy_passphrase,
                           snmp_pdu_primitive pduType,
                           char *oid[SNMP_MAX_NUM_OIDS],
                           char value_types[SNMP_MAX_NUM_OIDS],
                           char *values[SNMP_MAX_NUM_OIDS], bool _batch_mode);
#endif

  void send_snmpv1v2c_request(char *agent_host, char *community,
                              snmp_pdu_primitive pduType, u_int version,
                              char *oid[SNMP_MAX_NUM_OIDS], bool _batch_mode);
  void snmp_fetch_responses(lua_State *vm, u_int timeout);

  void     set_snmpbulk_max_repetitions(u_int8_t n) { getbulk_max_num_repetitions = n;     };
  u_int8_t get_snmpbulk_max_repetitions()           { return(getbulk_max_num_repetitions); };
  
  int get(lua_State *vm, bool skip_first_param);
  int getnext(lua_State *vm, bool skip_first_param);
  int getnextbulk(lua_State *vm, bool skip_first_param);
  int set(lua_State *vm, bool skip_first_param);
};

#endif /* _SNMP_H_ */
