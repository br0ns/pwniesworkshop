#include <stdio.h>
#include <string.h>

#define BUFFERSIZE 128

char hostname[BUFFERSIZE];


void log_string(int debug, char *str) {
    char localbuffer[BUFFERSIZE];

    strcpy(localbuffer, str);

    if(debug)
        printf("%s: %s\n", hostname, localbuffer);
}

void save_hostname(char *host) {
    memset(hostname, 0, BUFFERSIZE);
    strncpy(hostname, host, BUFFERSIZE-1);
}

int main(int argc, char **argv) {
    if(argc != 3) {
        printf("Usage: %s [hostname] [string]\n", argv[0]);
        return -1;
    }

    save_hostname(argv[1]);
    log_string(0, argv[2]);
}

