#!/bin/bash

prt=0
DATE=`date +"%Y-%m-%d"`
while read -r line
do 
	if [[ ${line} == *"Rule Name "* ]]; then
                prt=1
        elif [[ ${line} =~ ^$ ]]; then
                prt=0
        fi
	
	if [[ ${line} == *"Total "* ]]; then
		lineA=($line)
		echo "Date=${DATE} ${lineA[0]}${lineA[1]}${lineA[2]} ${lineA[3]}"
	fi

	if [[ ${prt} == 1  ]]; then
		lineA=($line)
		case $line in
                        *"Rule Name"*) ;;
			*"("*) ;;
			*------*) ;;
                        *"Host"*) echo "Date=${DATE} $line" ;;
                        *'*'*) echo "Date=${DATE} RuleName=${lineA[2]}${lineA[3]} SeverityLevel=${lineA[-4]} Added=${lineA[-3]} Removed=${lineA[-2]} Modified=${lineA[-1]}" ;;
			*) echo "Date=${DATE} RuleName=${lineA[0]}${lineA[1]}  SeverityLevel=${lineA[-4]} Added=${lineA[-3]} Removed=${lineA[-2]} Modified=${lineA[-1]}" ;;
		esac
		sleep 1
	fi

done < /var/log/tripwire/daily_report.log
