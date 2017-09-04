#!/bin/bash
HUB=${HUB:-}
NICK=${NICK:-admin}
PASSWORD=${PASSWORD:-password}

if [ ! -d /config/cfg ]
then

if [ -z ${HUB} ]
then
	echo "You must specify a hub name using the HUB environment variable; exiting."
	exit 1
fi

cp -r /opt/PtokaX/cfg.example /config/cfg

cat << EOF > /config/cfg/Settings.xml
<?xml version="1.0" encoding="windows-1252" standalone="yes" ?>
<PtokaX Version="0.5.0.1">
    <Booleans>
        <Bool Name="AutoRegister">0</Bool>
        <Bool Name="AdvancedPassProtection">0</Bool>
        <Bool Name="HashPasswords">1</Bool>
    </Booleans>
    <Integers />
    <Strings>
        <String Name="HubName">$HUB</String>
        <String Name="HubAddress">$HUB</String>
        <String Name="HubDescription">$HUB</String>
    </Strings>
</PtokaX>
EOF

cat << EOF > /config/cfg/RegisteredUsers.xml
<?xml version="1.0" encoding="windows-1252" standalone="yes" ?>
<RegisteredUsers>
    <RegisteredUser>
        <Nick>$NICK</Nick>
        <Password>$PASSWORD</Password>
        <Profile>0</Profile><!-- 0 for master, 1 for operator, 2 for vip, 3 for reg -->
    </RegisteredUser>
</RegisteredUsers>
EOF

cat << EOF > /config/cfg/Motd.txt
Welcome to DC++ Private Hub ($HUB)
EOF
fi

/opt/PtokaX/PtokaX -c /config
