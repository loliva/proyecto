#/opt/splunk/etc/apps/launcher/default/inputs.conf
#Se consolida de la siguiente forma locales
#LOCAL1 => SERVICIOS (AMQ, APACHE, ETC)
#LOCAL2 => WEB
#LOCAL3 => MICROSERVICIOS
#LOCAL4 => ENTEL LITE
#LOCAL5 => RSLITE => UTC
#LOCAL6 => MONGODB
#LOCAL7 => AUDITORIA


[monitor:///var/log/local1.log]
disabled = false
sourcetype = local1

[monitor:///var/log/local2.log]
disabled = false
sourcetype = local2

[monitor:///var/log/local3.log]
disabled = false
sourcetype = local3

[monitor:///var/log/local4.log]
disabled = false
sourcetype = local4

[monitor:///var/log/local5.log]
disabled = false
sourcetype = local5

[monitor:///var/log/local6.log]
disabled = false
sourcetype = local6

[monitor:///var/log/local7.log]
disabled = false
sourcetype = local7
