#include <stdio.h>
#include <string.h>

#define BUFFERSIZE 128

void zero_buffer(char *buffer) {
    memset(buffer, 0, BUFFERSIZE);
}

void log_string(int debug, char *str) {
    char localbuffer[BUFFERSIZE];

    zero_buffer(localbuffer);
    strcpy(localbuffer, str);

    if(debug)
        printf("%s\n", localbuffer);
}

int main(int argc, char **argv) {
    if(argc != 2) {
        printf("Usage: %s [string]\n", argv[0]);
        return -1;
    }

    log_string(0, argv[1]);
}

