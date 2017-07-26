#!/bin/bash


#Survey questions

# Ask question 1: what is their first and last name
echo "What is your first and last name?"
read name

# Ask question 2: what is your field of study/major
echo "What is your field of study/major?"
read major

# Ask question 3: what year were you born?
echo "What year were you born?"
read year

# Ask question 4: Where have you spent most of your life?
echo "What language do you wish you knew?"
read dreams

# Ask question 5: What do you think is the most pressing issue of our time?
echo "What do you think is the most pressing issue of our time?"
read worldissues

#save the time
date=`date --iso-8601=seconds`

#create unique identifier
IDENTIFIER="`echo $RANDOM

# write data to CSV file
echo "$IDENTIFIER, $name, $major, $year, $dreams, $worldissues, $date" >> ./surveyanswers.csv

# read the data
cat ./surveyanswers.csv

# write data to database
bash ./database.sh

# save data
cat ./surveyanswers.csv >> backup.csv

# remove temp file
rm ./surveyanswers.csv
