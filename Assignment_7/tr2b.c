#include <unistd.h>
#include <stdio.h>

int main(int argc, char** argv) {  
  unsigned from_len = strlen(argv[1]), to_len = strlen(argv[2]);
  
  /* Return error if from & to dont have the same size */
  if(from_len != to_len) {
    fprintf(stdout,"from and to are not the same length\n");
    exit(1);
  }

  /* Return error if from has duplicates */
  int i,j;
  for(i=0;i<from_len;i++)
    for(j=i+1;j<from_len;j++)
      if(argv[1][j] == argv[1][i]) {
	fprintf(stdout,"'from' contains duplicates \n");
        exit(1);
      }

  int buffer;
  while ((buffer = getchar()) != EOF) {
    
    /* If read byte belongs to 'from', then translate it */
    for(i=0;i<from_len;i++)
      if(buffer == argv[1][i])
	buffer = argv[2][i];

    putchar(buffer);
  } 
  exit(0);
}
