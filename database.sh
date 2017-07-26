#!/bin/bash

#Set MYSQL login information
MYSQLUSER=root
MSQLPASS=root

#Create database and table names
MYDATABASE=survey
MYTABLE=tblsurvey

#Put data in MySQL
sudo cp ./surveyanswers.csv /var/lib/mysql=files/
echo "Data placed in directory"

#Check database and create one if one does not exist
echo "Checking for database..."
DBCHECK=`mysql -u"$MYSQLUSER" -p"$MYSQLPASS" -e "show databases;" | grep -Fo $MYDATABASE`
if [ "$DBCHECK" == "$MYDATABASE" ]; then
   echo "Hooray. Database exists."
else
   echo "Sorry, Database does not exist. Creating database..."
   mysql -u"$MYSQLUSER" -p"$MYSQLPASS" -e "CREATE DATABASE $MYDATABASE"
fi

# Write data from backup.csv into database table
echo "Writing data to $MYTABLE in database $MYDATABASE."
mysql -u"$MYSQLUSER" -p"$MYSQLPASS" -e "LOAD DATA INFILE '/var/lib/mysql-files/surveyanswers.csv' INTO TABLE $MYTABLE FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"';" $MYDATABASE
echo "Data successfully written."

# Dump database into file
echo "Survey data dumped to file `date --iso-8601`-$MYDATABASE.sql"
mysqldump -u"$MYSQLUSER" -p"$MYSQLPASS" $MYDATABASE > `date --iso-8601`-$MYDATABASE.sql

#remove
sudo rm /var/lib/mysql-files/surveyanswers.csv