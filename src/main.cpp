#include "lab/greeting.hpp"
#include <iostream>

int main(int argc, char* argv[]) {
    if (argc > 2) {
        std::cerr << "Usage: hello [name]\n";
        return 2;
    }
    std::cout << lab::greeting(argc == 2 ? argv[1] : "world") << '\n';
    return 0;
}
