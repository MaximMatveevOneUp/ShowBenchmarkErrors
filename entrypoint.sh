#!/bin/bash

FILES=${INPUT_PATH}

for FILE in "$FILES"/*
do
	if [ -f "$FILE" ]; then		 		
		result=$(xmllint --xpath 'string(/test-run/@result)' "$FILE")	
		if [ "$result" != "Passed" ]; then
			echo -e "$(basename -- "${FILE%.*}") $result" >> $GITHUB_STEP_SUMMARY
			echo -e "$(xmllint --xpath 'string(/test-run/*//test-case/@fullname)' "$FILE")" >> $GITHUB_STEP_SUMMARY
			echo -e "$(xmllint --xpath 'string(/test-run/*//output)' "$FILE")" >> $GITHUB_STEP_SUMMARY
		else
			echo -e $(basename -- "${FILE%.*}") $result >> $GITHUB_STEP_SUMMARY
		fi
	fi
done
