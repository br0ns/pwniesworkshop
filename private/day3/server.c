#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<errno.h>
#include<string.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<netdb.h>
#include<arpa/inet.h>
#include<sys/wait.h>
#include<signal.h>

const char WELCOME[] = "Your output to my input? Do your best!\n";
const char REPLY[]   = "Is this your best?:\n";

char global_client_buffer[4096];

void read_from_client (int sock) {
  struct {
    int i;
    int res;
    char buf[200];
  }  __attribute__ ((packed)) locals;

  locals.i = 0;
  while (1) {
    locals.res = read(sock, &locals.buf[locals.i], 1);
    global_client_buffer[locals.i] = locals.buf[locals.i];
    if (locals.res == 0)
      break;
    if (locals.buf[locals.i] == '\n') {
      locals.i++;
      break;
    }
    locals.i++;
  }
  global_client_buffer[locals.i] = 0;
}


void write_to_client (int sock) {
  write(sock, REPLY, sizeof(REPLY) - 1);
  write(sock, global_client_buffer, strlen(global_client_buffer));
}

void welcome_client (int sock) {
  write(sock, WELCOME, sizeof(WELCOME) - 1);
}

void handle_client (int sock) {
  welcome_client(sock);
  read_from_client(sock);
  write_to_client(sock);
  close(sock);
}

#define BACKLOG 100

void sigchld_handler(int s) {
  while(waitpid(-1, NULL, WNOHANG) > 0);
}

int open_sock (unsigned short int port) {
  int sock, nsock, nsocklen = sizeof(struct sockaddr_in), yes = 1;
  struct sockaddr_in saddr;
  struct sigaction sa;

  memset(&saddr, 0, sizeof saddr);
  saddr.sin_family = AF_INET;
  saddr.sin_port = htons(port);
  saddr.sin_addr.s_addr = INADDR_ANY;

  if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) == -1) {
    perror("socket");
    exit(1);
  }

  if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int)) == -1) {
    perror("setsockopt");
    exit(1);
  }

  if (bind(sock, (struct sockaddr *)&saddr, sizeof saddr) == -1) {
    close(sock);
    perror("bind");
    exit(1);
  }

  if (listen(sock, BACKLOG) == -1) {
    perror("listen");
    exit(1);
  }

  sa.sa_handler = sigchld_handler; // reap all dead processes
  sigemptyset(&sa.sa_mask);
  sa.sa_flags = SA_RESTART;
  if (sigaction(SIGCHLD, &sa, NULL) == -1) {
    perror("sigaction");
    exit(1);
  }

  return sock;
}

int main (int argc, char **argv) {
  unsigned short int port;
  struct sockaddr_in caddr;
  int sock, nsock, nsocklen;

  if (argc < 2) {
    printf("Usage: %s port", argv[0]);
    return 0;
  }
  port = atoi(argv[1]);

  sock = open_sock(port);

  nsocklen = sizeof(caddr);
  for (;;) {
    if ((nsock = accept(sock, (struct sockaddr *)&caddr, &nsocklen)) == -1) {
      perror("accept");
      continue;
    }

    printf("Got connection from %d.%d.%d.%d\n",
           ((caddr.sin_addr.s_addr      ) & 0xFF),
           ((caddr.sin_addr.s_addr >>  8) & 0xFF),
           ((caddr.sin_addr.s_addr >> 16) & 0xFF),
           ((caddr.sin_addr.s_addr >> 24) & 0xFF)
           );
    if (fork() == 0) {
      close(sock);
      handle_client(nsock);
      printf("Clean exit\n");
      exit(0);
    }
    else
      close(nsock);
  }

  return 0;
}
