#!/bin/bash

let MaxGID=1001
LUUsers="admin"
Calendar="./daysoff"
NowHoliday=false

while read DateNow;
do
    if [ "$DateNow" == "$(date +%D)" ];
    then
	NowHoliday=true
	echo "$(date): Shabbat has come, it is impossible to work, it is necessary to celebrate !!!" >> ./lock-unlock.log
	wall 'Shabbat has come, it is impossible to work, it is necessary to celebrate!'
    fi
done < $Calendar

STR=$(getent group | grep ^$LUUsers":" | cut -d":" -f3)
STR1=$(getent group | grep nfsnobody | cut -d":" -f3)

for UsName in $(compgen -u)
do
    UsGroup=$(echo $(id -G $UsName) | cut -d" " -f1)
    if (( "$UsGroup" >= "$MaxGID" && "$UsGroup" != "$STR" && "$UsGroup" != "$STR1" ));
    then
	if $NowHoliday;
	then
	    loginctl kill-user $UsName
	    usermod -L $UsName
	    echo "$(date): $UsName is locked" >> ./lock-unlock.log
	else
	    usermod -U $UsName
	    echo "$(date): $UsName is unlocked" >> ./lock-unlock.log
	fi
    fi
done
