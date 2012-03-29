#include <stdio.h>
#include <string.h>

#define BUFFERSIZE 128

void execute_bin_sh() {
    execve("/bin/sh", NULL, NULL);
}

void log_string(int debug, char *str) {
    char localbuffer[BUFFERSIZE];

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

