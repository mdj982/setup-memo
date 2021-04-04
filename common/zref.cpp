#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <climits>
#include <cstring>

struct bibinfo_t {

    std::string title;
    std::string year;
    std::string author;
    std::string bibstr;

};

bibinfo_t get_bibinfo() {

    bibinfo_t bibinfo;

    std::cerr << "Input bib:" << std::endl;
    std::string sbuf;
    int bracket_cnt = INT_MAX;

    while (bracket_cnt != 0) {
        getline(std::cin, sbuf);
        for (const char c : sbuf) {
            if (bracket_cnt != INT_MAX) {
                if (c == '{') {
                    bracket_cnt++;
                }
                if (c == '}') {
                    bracket_cnt--;
                }
            }
            else {
                if (c == '{') {
                    bracket_cnt = 1;
                }
            }
        }
        bibinfo.bibstr += sbuf + '\n';
    }
    size_t p = 0;
    int title_flag = 0;
    int year_flag = 0;
    int author_flag = 0;
    while (true) {
        p = bibinfo.bibstr.find('=', p);
        if (p == std::string::npos) {
            break;
        }
        else {
            size_t t = p - 1;
            while (t > 0 && (bibinfo.bibstr[t] == ' ' || bibinfo.bibstr[t] == '\t')) {
                t--;
            }
            if (bibinfo.bibstr.substr(t - 4, 5) == "title" && bibinfo.bibstr.substr(t - 8, 9) != "booktitle") {
                title_flag = 1;
            }
            if (bibinfo.bibstr.substr(t - 3, 4) == "year") {
                year_flag = 1;
            }
            if (bibinfo.bibstr.substr(t - 5, 6) == "author") {
                author_flag = 1;
            }
        }
        size_t s = 0;
        if (title_flag || year_flag || author_flag) {
            bracket_cnt = INT_MAX;
            while (bracket_cnt != 0) {
                char c = bibinfo.bibstr[++p];
                if (bracket_cnt != INT_MAX) {
                    if (c == '{') {
                        bracket_cnt++;
                    }
                    if (c == '}') {
                        bracket_cnt--;
                    }
                }
                else {
                    if (c == '{') {
                        bracket_cnt = 1;
                        s = p + 1;
                    }
                }
            }
        }
        if (title_flag) {
            bibinfo.title = bibinfo.bibstr.substr(s, p - s);
            title_flag = 0;
        }
        if (year_flag) {
            bibinfo.year = bibinfo.bibstr.substr(s, p - s);
            year_flag = 0;
        }
        if (author_flag) {
            bibinfo.author = bibinfo.bibstr.substr(s, p - s);
            author_flag = 0;
        }
        p++;
    }

    return bibinfo;

}

std::string insert_underscore(const std::string &str) {
    std::string ret = "";
    for (const char c : str) {
        if (c == ' ' || c == '\t') {
            ret += '_';
        }
        else if (c != '$' && c != '\\' && c != '`' && c != '\"' && c != '\'' && c != '^' && c != ':') {
            ret += c;
        }
    }
    return ret;
}

int main(int argc, char *argv[]) {
    if (argc > 2) {
        std::cerr << "Error: Too many arguments." << std::endl;
    }
    if (argc == 1 || argc > 2) {
        std::cerr << "Usage: zref [filename]" << std::endl;
        exit(0);
    }
    std::string prev_fname = argv[1];
    std::ifstream ifs;
    ifs.open(prev_fname);
    if (!ifs.is_open()) {
        std::cerr << "Error: " << strerror(errno) << (" \"" + prev_fname + "\"") << std::endl;
        exit(0);
    }
    ifs.close();

    bibinfo_t bibinfo = get_bibinfo();
    std::string next_fname = bibinfo.year + "_" + insert_underscore(bibinfo.title) + ".pdf";
    std::string mvcmd = "mv '" + prev_fname + "' " + next_fname;

    std::ofstream ofs; ofs.open("zref.bib", std::ios_base::app);
    if (!ofs.is_open()) {
        std::cerr << "Error: " << strerror(errno) << " \"zref.bib\"" << std::endl;
        exit(0);
    }
    ofs << std::endl << bibinfo.bibstr;
    ofs.close();

    if (system(mvcmd.c_str())) {
        exit(0);
    }

}
