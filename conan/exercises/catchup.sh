#!/bin/bash

RED='\033[0;41;30m'
STD='\033[0;0;39m'
APIKEY='AKCp2WWshJKjZjguhB3vD2u3RMwHA7gmxWUohWVhs1FqacHBAzKaiL2pp24NNUEhWHm5Dd4JY'

consumer() {
   echo "performing Excercise 2 (consumer, with CMake)"
   cd 1_consumer
   conan remote add artifactory http://35.185.192.7/artifactory
   mkdir -p build
   cd build
   conan install ../ --build missing
   cmake ..
   cmake --build .
   cd bin
   ./timer
}

create() {
   conan new mylib/1.0@myuser/testing -t
   conan test_package
}

create_sources() {
   conan new mylib/1.0@myuser/testing -t
   sed -i 's/source/no_source/g' conanfile.py
   sed -i 's/\"cmake\"/\"cmake\"\n    exports="*"/g' conanfile.py
   conan test_package
}



read_options(){
        local choice
        read -p "Enter choice [ 1 - 4] " choice
        case $choice in
                1) exercise2 ;;
                4) exercise2 ;;
                6) create_sources ;;
                -1) exit 0 ;;
                *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
}

# function to display menus
show_menus() {
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo " Automation Catch Up Menu "
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "2. Excercise 2 (Consume with CMake)"
        echo "5. Excercise 5 (Create a conan package)"
        echo "6. Excercise 6 (Create package with sources)"
        echo "-1. Exit"
}

while true
do
        show_menus
        read_options
done
