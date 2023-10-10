#!/bin/bash

FILES=${INPUT_PATH}
RED='\033[0;31m'
GREEN='\033[0;32m'

for FILE in "$FILES"/*
do
	echo $FILE
	if [ -f "$FILE" ]; then		 		
		result=$(xmllint --xpath 'string(/test-run/@result)' "$FILE")	
  		echo $result
		if [ "$result" != "Passed" ]; then
			echo -e "${RED}$(basename -- "${FILE%.*}") $result" >> GITHUB_STEP_SUMMARY
		    echo -e "${RED}$(xmllint --xpath 'string(/test-run/*//test-case/@fullname)' "$FILE")" >> GITHUB_STEP_SUMMARY
		    echo -e "${RED}$(xmllint --xpath 'string(/test-run/*//output)' "$FILE")" >> GITHUB_STEP_SUMMARY
		else
			echo -e ${GREEN}$(basename -- "${FILE%.*}") $result >> GITHUB_STEP_SUMMARY
		fi
	fi
done
