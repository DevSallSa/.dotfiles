#!/usr/bin/env bash

#TODO: make a service or a cron

. /home/masterx/.profile
desktop=`echo $XDG_SESSION_DESKTOP`
currentHour=`date +"%H"`
conditionHour="18"

#if [ "$desktop" = "KDE" ]; then
#	if [ $currentHour -le $conditionHour ]; then
#		echo "Toggle to dark mode $desktop done !!!"
		/usr/bin/lookandfeeltool -a 'com.github.vinceliuice.Qogir-dark'
#	else
#		echo 'Toggle to light mode done !!!'
#		/usr/bin/lookandfeeltool -a 'com.github.vinceliuice.Qogir-light'
#	fi
#else
#	echo "Error ! > $desktop < You aren't in KDE-PLASMA DESKTOP">&2
#fi

