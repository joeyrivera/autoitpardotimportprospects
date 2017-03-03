# Automate uploading prospect CSV using AutoIt

Works on Windows only

## Setup
* download the AutoIt editor from https://www.autoitscript.com/site/autoit/downloads/
* rename config.dist.au3 to config.au3
* edit the config.au3 file and update the contents with your information
* edit the sample.csv file to replace token with the name of your custom field for the token

## Run
* edit the admin import prospect.au3 file with the AutoIt editor
* go to Tools -> go

## Possible issues
* unable to upload csv file, pardot gives error message related to content type.
  * this means your windows machine isn't setup correctly with how .csv files are defined. You'll have to edit your registry to add the .csv file type and set the content type to text/csv then restart your browser to try again
  * http://stackoverflow.com/a/1202329
