#include "cointoss.h"
#include <iostream>
#include <cstdlib>
#include <ctime>

void message() {
    std::cout << "The 'cointoss' function in this class flips a coin until you get n heads in a row." << std::endl;
}

int cointoss(int n) {
    srand(static_cast<unsigned int>(time(0)));
    
    int count = 0;
    int heads = 0;
    while (heads < n) {
        count++;
        int toss = rand() % 2;
        if (toss == 0) {
            heads++;
            std::cout << "Toss " << count << ": heads" << std::endl;
        }
        else {
            heads = 0;
            std::cout << "Toss " << count << ": tails" << std::endl;
        }
    }
    return count;
}
