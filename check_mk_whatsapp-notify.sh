#!/bin/bash
# Push Notification (using whatsapp with waapi.app)
#
# Script Name   : check_mk_whatsapp-notify.sh
# Description   : Send Check_MK notifications by WhatsApp
# Author        : Welligton Analista Linux4Life
# License       : BSD 3-Clause "New" or "Revised" License
# ======================================================================================

#WaAPI instance, Destination and token

if [ -z ${NOTIFY_PARAMETER_1} ]; then
        echo "No WaAPI Instance ID. Exiting" >&2
        exit 2
else
        instance="${NOTIFY_PARAMETER_1}"
fi

if [ -z ${NOTIFY_PARAMETER_2} ]; then
        echo "No WaAPI destiny. Exiting" >&2
        exit 2
else
        destiny=${NOTIFY_PARAMETER_2}
fi

if [ -z ${NOTIFY_PARAMETER_3} ]; then
        echo "No WaAPI API Token. Exiting" >&2
        exit 2
else
        token="${NOTIFY_PARAMETER_3}"
fi


# Set an appropriate emoji for the current state

if [[ ${NOTIFY_WHAT} == "SERVICE" ]]; then
        STATE="${NOTIFY_SERVICESHORTSTATE}"
else
        STATE="${NOTIFY_HOSTSHORTSTATE}"
fi
case "${STATE}" in
    OK|UP)
        EMOJI=$'\u2705' 
        ;;
    WARN)
        EMOJI=$'\u26A0\uFE0F' 
        ;;
    CRIT|DOWN)
        EMOJI=$'\u274C' 
        ;;
    UNKN)
        EMOJI=$'U+1F612' 
esac

# Create a MESSAGE variable to send to your WhatsApp

MESSAGE=${NOTIFY_HOSTNAME}' ('${NOTIFY_HOSTALIAS}')\n\n'
MESSAGE+=${EMOJI}' '${NOTIFY_WHAT}' '${NOTIFY_NOTIFICATIONTYPE}'\n\n'
if [[ ${NOTIFY_WHAT} == "SERVICE" ]]; then
        MESSAGE+=${NOTIFY_SERVICEDESC}'\n'
        MESSAGE+='State changed from '${NOTIFY_PREVIOUSSERVICEHARDSHORTSTATE}' to '${NOTIFY_SERVICESHORTSTATE}'\n'
        MESSAGE+=${NOTIFY_SERVICEOUTPUT}'\n'
else
        MESSAGE+='State changed from '${NOTIFY_PREVIOUSHOSTHARDSHORTSTATE}' to '${NOTIFY_HOSTSHORTSTATE}'\n'
        MESSAGE+=${NOTIFY_HOSTOUTPUT}'\n'
fi

MESSAGE+='\nIPv4: '${NOTIFY_HOST_ADDRESS_4}' \nIPv6: '${NOTIFY_HOST_ADDRESS_6}'\n'
MESSAGE+=${NOTIFY_SHORTDATETIME}' | '${OMD_SITE}


# Send message to WhatsApp bot

curl --request -S -X POST "https://waapi.app/api/v1/instances/${instance}/client/action/send-message" -H "accept: application/json" -H "authorization: Bearer ${token}" -H "content-type: application/json" -d '{"chatId":"'"${destiny}"'","message":"'"${MESSAGE}"'"}'

if [ $? -ne 0 ]; then
        echo "Not able to send WhatsApp message" >&2
        exit 2
else
        exit 0
fi