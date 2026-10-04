#include <iostream>
#include <fstream>
#include <cmath>

#define max 1000000000

using namespace std;

int fairseq(int N, int *S);

int main (int argc, char *argv[]) {
    
    int N;
    int *seq;
        
    ifstream myfile;
    
    myfile.open(argv[1]);

    myfile >> N;

    seq = new int[N];
    
    for (int i = 0; i < N; i++) {
        myfile >> seq[i];
    }
    
    myfile.close();

    cout << fairseq(N,seq);

    delete seq;

    return 0;
}

int fairseq(int N, int *S) {

    int min = max;
    int sumin = 0;
    int sumout = 0;
    int total_sum = 0;

    for (int i=0; i<N; i++) {
        total_sum += S[i];
    }

    for (int i=0; i<N; i++) {
            sumin = 0;
        for (int j=i; j<N; j++) {
            sumin += S[j];
            sumout = total_sum - sumin;
            if (abs(sumin-sumout)<min) min = abs(sumin-sumout);
        }
    }
    return min;
}