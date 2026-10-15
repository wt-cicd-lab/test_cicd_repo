#include "lab/greeting.hpp"

namespace lab {
std::string greeting(const std::string& name) {
    return "Hello, " + (name.empty() ? std::string("world") : name) + "!";
}
}
