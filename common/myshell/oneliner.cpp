#include <iostream>
#include <string>

int main() {
    std::string istr;
    std::string ostr;
    while (std::getline(std::cin, istr)) {
        for (size_t i = 0; i < istr.length(); ++i) {
            if (i != istr.length() - 1) {
                ostr += istr[i];
            }
            else {
                if (istr[i] != '-') {
                    ostr += istr[i];
                    ostr += ' ';
                }
            }
        }
    }
    std::cout << "\n\n" << ostr << std::endl;
}
