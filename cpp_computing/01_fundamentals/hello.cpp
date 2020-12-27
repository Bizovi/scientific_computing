/*
 * A trivial C++ program
 * 
 * using namespace std; to access directly the functions
 * gcc hello.cpp -lstdc++ -o build/hello
 */

#include<iostream>
#include<string>
#include<cmath>


int main(int argc, char **argv) {
    std::string first_name = "";
    double age = 0.0;

    std::cout << "Helo, World!\n";
    std::cout << "Here we go again\n";

    std::cout << argv[0] << "\n";  // Easy way to get Segmentation fault: 11 if [1]
    std::cout << "Nr of arguments provided: " << argc - 1 << "\n";

    std::cout << "Input your first name and age:" << "\n";
    std::cin  >> first_name;
    std::cin  >> age;
    std::cout << "Hello, " << first_name 
              << " (age " << age * 12 
              << " months)\n";

    std::cout << sqrt(16.0) << "\n";
    return 0;
}