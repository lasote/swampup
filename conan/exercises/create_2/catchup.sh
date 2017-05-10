conan new mylib/1.0@myuser/testing -t
sed -i 's/source/no_source/g' conanfile.py
sed -i 's/\"cmake\"/\"cmake\"\n    exports="*"/g' conanfile.py
conan test_package

