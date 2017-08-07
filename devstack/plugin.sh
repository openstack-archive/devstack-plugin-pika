#!/bin/bash
#
# Copyright 2015 Hewlett-Packard Development Company, L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

function get_transport_url {
    local virtual_host=$1
    echo "pika://$RABBIT_USERID:$RABBIT_PASSWORD@$RABBIT_HOST:5672/$virtual_host"
}

function get_notification_url {
    local virtual_host=$1
    echo "pika://$RABBIT_USERID:$RABBIT_PASSWORD@$RABBIT_HOST:5672/$virtual_host"
}

# Note: no need to override default 'rpc_backend_add_vhost' since the
# backend is also rabbitmq

function iniset_rpc_backend {
    local package=$1
    local file=$2
    local section=${3:-DEFAULT}
    local virtual_host=$4

    iniset $file $section transport_url $(get_transport_url "$virtual_host")
    iniset $file oslo_messaging_notifications transport_url $(get_notification_url "$virtual_host")
}
