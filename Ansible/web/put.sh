#!/bin/bash

# script is responsible for inserting values to people database.
# you have to copy this script with 'people.txt' file to db container and run it there

counter=0

while [ $counter -lt 50 ]; do
  let counter=counter+1

  name=$(nl people.txt | grep -w $counter | awk '{print $2}' | awk -F ',' '{print $1}')
  lastname=$(nl people.txt | grep -w $counter | awk '{print $2}' | awk -F ',' '{print $2}')
  age=$(shuf -i 20-25 -n 1)
  
  mysql -u root -p 1234 people -e "insert into register values ($counter, '$name', '$lastname', '$age')"
  echo "$counter, $name, $lastname, $age was correctly imported"

done

# 'nl' - get nb of lines;
# '{print $2}' - name,lastname;
# 'awk -F ','' - separate name and lastname;
# '{print $1}' - show name

# command 'nl people.txt' 
# output:    1	Denice,Caudle

# 'shuf -i 20-25 -n 1' -  choose values between 20-25, and use the 1st from the output

# 'people' - database
# 'register' - table
