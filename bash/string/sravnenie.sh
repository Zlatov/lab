#!/bin/bash
migrationVersion=( "1.0.0" "1.0.5" "1.0.15" "1.1.10" "1.1.15" "1.2.0" "1.2.15" )
dbVersion="1.0.5"
for mVersion in "${migrationVersion[@]}"
do
	mArray=(${mVersion//./ })
	dbArray=(${dbVersion//./ })
	if [[ ${mArray[0]} -gt ${dbArray[0]} ]]
		then
			echo "$mVersion > $dbVersion"
		else
			if [[ ${mArray[1]} -gt ${dbArray[1]} ]]
				then
					echo "$mVersion > $dbVersion"
				else
					if [[ ${mArray[2]} -gt ${dbArray[2]} ]]
						then
							echo "$mVersion > $dbVersion"
						else
							echo "$mVersion <= $dbVersion"
					fi
			fi
	fi
done

