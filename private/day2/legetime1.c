#include <stdio.h>

int helper(int n, int acc) {
    if(n <= 1)
        return acc;

    return helper(n-1, acc*n);
}

int anon(int n) {
    return helper(n, 1);
}

int main(int argc, char **argv) {
    if(argc != 2) {
        printf("Must have exactly one argument\n");
        return -1;
    }

    int n = atoi(argv[1]);
    printf("Calculating %d!\n", n);
    printf("%d! = %d\n", n, anon(n));

    return 0;
}
