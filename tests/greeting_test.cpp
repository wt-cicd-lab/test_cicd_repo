#include "lab/greeting.hpp"
#include <iostream>
#include <string>

int main() {
    struct Case { std::string name; std::string expected; };
    const Case cases[] = {
        {"world", "Hello, world!"},
        {"runner", "Hello, runner!"},
        {"", "Hello, world!"}
    };
    for (const auto& item : cases) {
        const auto actual = lab::greeting(item.name);
        if (actual != item.expected) {
            std::cerr << "Expected: " << item.expected << ", actual: " << actual << '\n';
            return 1;
        }
    }
    std::cout << "Greeting tests passed.\n";
    return 0;
}
