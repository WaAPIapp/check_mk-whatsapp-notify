# Check_MK WhatsApp notification
<br>

<div align="center">
<img alt="check_mk" src="images/checkmk-logo-itsm-webinar.jpg" /> 
</div>

<br>
<div align="center">
<img alt="Linux" src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" /> - <img alt="Shell Script" src="https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white"/> 


</div>
<br>

## COMPATIBILITY
- Check_MK RAW version 1.6.0
- Check_MK RAW version 2.1.0p4
- Should also work with other versions of Check_MK


## EXAMPLE
Notifications are usually sent via a WhatsApp group. Here is an example of how a WhatsApp notification is structured.

<img src="images/WhatsApp_notification_example.png" alt="WhatsApp notification example" width="100%"/>

## REQUIREMENTS
In order for Check_MK to send alerts (notifications) to the WhatsApp Messenger, we need

* waapi.app account 
* waapi API Token
* waapi instance ID connected with your number
* a WhatsApp Chat- or Group-ID in the proper format. <xxx>@c.us for a single chat, <xxx>@g.us for group

## Creating WhatsApp API Key:

To use this shipment, it is necessary to contract the service.

visit https://www.waapi.app to create an accout

https://waapi.app/user/api-tokens to generate your API Token (select all scopes: read, update, create, delete)

## INSTALLATION
Change to your Check_MK site user
```
su - mysite
```

Change to the notification directory
```
cd ~/local/share/check_mk/notifications/
```

Download the WhatsApp notify script from Git repository
```
git clone https://github.com/WaAPIapp/check_mk-whatsapp-notify.git .
```

Give the script execution permissions
```
chmod +x check_mk_whatsapp-notify.sh
```

## CHECK_MK CONFIGURATION
### CHECK_MK VERSION 2.0.0 AND ABOVE
Now you can create your own alarm rules in Check_MK.

```Setup → Events → Notifications```

First create a clone of your existing mail notification rule

* Change the description (e.g. Notify all contacts of a host/service via WhatsApp)
* The notification method is "Push Notification (by WhatsApp)"
* Select option "Call with the following parameters:"
* As the first parameter we set the WaAPI Instance ID i.e. ```123```
* The second parameter is the WhatsApp destiny ChatId Group-ID i.e. ```<xxx>@c.us``` or ```<xxx>@g.us```
* The third parameter is the api token from WaAPI ```abc123mytokenxyz789```

<br>

## INSPIRATION
* Thanks for the excellent script for telegram with some adjustments we managed to make it functional for use with whatsapp. https://github.com/filipnet/checkmk-telegram-notify

## LICENSE
checkmk-whatsapp-notify and all individual scripts are under the BSD 3-Clause license unless explicitly noted otherwise. Please refer to the LICENSE
