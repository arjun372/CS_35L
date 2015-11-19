#include <stdio.h>
#include <stdlib.h>
#define readIn(buf) read(0,&buf,1)
#define writeOut(buf) write(1,&buf,1)
#define TRUE 1
#define FALSE 0

/* Returns string length in O(n) time */
static size_t arrlen(char* arr)
{
  size_t len = 0;
  while(arr[len++]!='\0')
    continue;
  return (len-1);
}

/* Checks for duplicate bytes in O(n) time */   
static unsigned containsDuplicates(char* arr,size_t len)
{
  static char hash[256]; 
  size_t i;

  for(i=0;i<len;i++)
    {
      if(hash[(size_t)arr[i]] == TRUE)
	return TRUE;
      else
	hash[(size_t)arr[i]] = TRUE;
    }
  return FALSE;
}

int main(int argc, char** argv)
{  
  size_t from_len = arrlen(argv[1]);

  /* Return error if 'from' & 'to' don't have the same size */
  if(from_len != arrlen(argv[2])) 
    goto ERROR_LEN_EXIT;

  /* Return error if 'from' contains duplicates */
  if(containsDuplicates(argv[1],from_len))
    goto ERROR_DUP_EXIT;

  char buffer;
  size_t i;
  while (readIn(buffer) > 0) 
  {    
    /* If read byte belongs to 'from', then translate it */
    for(i=0;i<from_len;i++)
      if(buffer == argv[1][i])
	buffer = argv[2][i];

    writeOut(buffer);
  } 

  exit(0);

 ERROR_LEN_EXIT:
    fprintf(stdout,"'from' and 'to' are not the same length\n");
    exit(1);
 ERROR_DUP_EXIT:
    fprintf(stdout,"'from' contains duplicates \n");
    exit(1);
}
