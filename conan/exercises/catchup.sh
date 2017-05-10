#!/bin/bash

RED='\033[0;41;30m'
STD='\033[0;0;39m'
APIKEY='AKCp2WWshJKjZjguhB3vD2u3RMwHA7gmxWUohWVhs1FqacHBAzKaiL2pp24NNUEhWHm5Dd4JY'

exercise1() {
   echo "performing exercise 1"
   cd consumer
   conan remote add artifactory http://35.185.192.7/artifactory
   mkdir -p build
   cd build
   conan install ../ --build missing
   cmake ..
   cmake --build .
   cd bin
   ./timer
}

read_options(){
        local choice
        read -p "Enter choice [ 1 - 4] " choice
        case $choice in
                1) exercise1 ;;
                2) exercise2 ;;
                3) exrecise3 ;;
                4) exit 0 ;;
                *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
}

# function to display menus
show_menus() {
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo " Automation Catch Up Menu "
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Excercise 1"
        echo "2. Excercise 2"
        echo "3. Excercise 3"
        echo "4. Exit"
}

while true
do
        show_menus
        read_options
done
