#!/bin/bash

curdir=$(pwd)
RED='\033[0;51;30m'
STD='\033[0;0;39m'
APIKEY='AKCp2WWshJKjZjguhB3vD2u3RMwHA7gmxWUohWVhs1FqacHBAzKaiL2pp24NNUEhWHm5Dd4JY'

consumer() {
   echo "performing Excercise 2 (consumer, with CMake)"
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

create() {
   cd create
   conan new mylib/1.0@myuser/testing -t
   conan test_package
}

create_sources() {
   cd create_sources
   conan new mylib/1.0@myuser/testing -t
   sed -i 's/source/no_source/g' conanfile.py
   sed -i 's/\"cmake\"/\"cmake\"\n    exports="*"/g' conanfile.py
   conan test_package
}

consumer_debug() {
   cd consumer
   cd build
   conan install .. -s build_type=Debug
   cmake ..
   cmake --build .
   conan search
   conan search zlib/1.2.8@lasote/stable
}



read_options(){
        local choice
        cd ${curdir}
        read -p "Enter choice: " choice
        case $choice in
                2) consumer ;;
                3) consumer_debug ;;
                5) create ;;
                6) create_sources ;;
                -1) exit 0 ;;
                *) echo -e "${RED}Not valid option! ${STD}" && sleep 2
        esac
}

# function to display menus
show_menus() {
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo " Automation Catch Up Menu "
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "2. Excercise 2 (Consume with CMake)"
        echo "3. Excercise 3 (Consume with CMake, with different build_type, Debug)"
        echo "5. Excercise 5 (Create a conan package)"
        echo "6. Excercise 6 (Create package with sources)"
        echo "-1. Exit"
}

while true
do
        show_menus
        read_options
done
