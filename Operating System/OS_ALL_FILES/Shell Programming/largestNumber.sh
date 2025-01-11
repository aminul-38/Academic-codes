#!/bin/bash

# Prompt the user to enter the size of the array
echo "Enter the size of the array: "
read size

# Initialize an empty array
array=()

# Read the elements of the array
echo "Enter the elements of the array: "
for (( i=0; i<size; i++ ))
do
    read element
    array+=($element)
done

# Assume the first element is the largest
largest=${array[0]}

# Loop through the array to find the largest element
for num in "${array[@]}"
do
    if [ $num -gt $largest ]; then
        largest=$num
    fi
done

# Output the largest number
echo "The largest number in the array is: $largest"
