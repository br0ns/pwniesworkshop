#include <stdio.h>
#include <string.h>

char* my_strncpy(char *dst, char *src, int n) {
    int k;

    for(k = 0; k < n && src[k]; k++) {
        dst[k] = src[k];
    }

    if(k<n)
        dst[k] = '\0';

    return dst;
}


int main() {
    char buffer1[20];
    char *buffer2 = "testtest";

    memset(buffer1, 'A', 20);
    buffer1[19] = '\0';

    my_strncpy(buffer1, buffer2, 8);

    printf("%s\n", buffer1);
}
