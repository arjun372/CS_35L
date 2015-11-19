#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#define EOS 0x20
#define ASCII_FROB_TOKEN 0x2a
#define decode(a) (a ^ ASCII_FROB_TOKEN)
#define BUFFER_SIZE 4096
#define TRUE 1

unsigned int comparisons = 0;
static int frobcmp (char const *a, char const *b) 
{ 
  /* Iterate over arrays (a,b) while neither terminates & elements of both are equal */
  while( (*a!=EOS) && (*b!=EOS) && (*a==*b) ) 
    {
      a++;
      b++;
    }
  comparisons++;
  /* Return 1 if (a>b), -1 if (b>a), (a-b) otherwise */
  return ((*a!=EOS)&&(*b==EOS)) ? 1 : ((*a==EOS)&&(*b!=EOS) ? -1 : (decode(*a)-decode(*b)));
}

static int qsort_compatible_frobcmp(const void *a, const void *b)
{
  return frobcmp(*((char const **)a),*((char const **)b));
}

/* Print array over STDOUT, including EOS character */
static void displayStream(char **list,const unsigned int size)
{
  unsigned int word_iterator, char_iterator,eos = EOS;
  for(word_iterator = 0; word_iterator < size; word_iterator++) 
  {
      char_iterator = 0;
      while (list[word_iterator][char_iterator++] != EOS)
	write(1,&list[word_iterator][char_iterator-1],1);
	write(1,&eos,1);
} 
}

int main (int argc, char **argv) 
{
  struct stat fileStat;
  fstat(0,&fileStat);
  unsigned int buffer = (S_ISREG(fileStat.st_mode) && (fileStat.st_size > BUFFER_SIZE)) ? fileStat.st_size : BUFFER_SIZE;
  char **word_list = malloc(buffer * sizeof(char *));
  char *single_word_buffer = malloc(buffer * sizeof(char));
  char *complete_word_buffer;
  int EXIT_CODE = 0, single_c;
  unsigned int iterator = 0, word_size = 0, word_buffer_size = buffer, list_size = 0, list_buffer_size = buffer, charsRead = -1;

  if(!word_list || !single_word_buffer) 
  { 
    EXIT_CODE = 1; 
    goto clean_exit; 
  }

  while(TRUE) /* Read single byte-by-byte until loop is interrupted due to EOS, EOF or error */
  {
    if((charsRead = read(0,&single_c,1)) == 0 || (char)single_c == EOS || single_c == EOF)
    {
      if(word_size == 0 && (char)single_c != EOS) 
      {
	EXIT_CODE = 0; 
	goto clean_exit;
      }

      complete_word_buffer = malloc((word_size+1) * sizeof(char));
      if(!complete_word_buffer)
	goto clear_buffers_exit;

      for(iterator = 0; iterator < word_size; iterator++)
	complete_word_buffer[iterator] = single_word_buffer[iterator];
      
      complete_word_buffer[word_size] = EOS;
      word_size = 0;

      if(list_size == list_buffer_size) 
      {
	list_buffer_size += BUFFER_SIZE;
	word_list = realloc(word_list,(list_buffer_size * sizeof(char *)));
        fprintf("realloc list_buffer_size:%u",list_buffer_size);
	if(!word_list)
	  goto clear_buffers_exit;
      }
      word_list[list_size++] = complete_word_buffer;   	  
      if(single_c != EOF && charsRead !=0)
	continue;
      else
	break;
    }

    if(word_size == word_buffer_size)
    {
      word_buffer_size += BUFFER_SIZE;
      single_word_buffer = realloc(single_word_buffer,(word_buffer_size * sizeof(char)));
      fprintf("realloc word_buffer_size:%u",word_buffer_size);
      if(!single_word_buffer)
	goto clear_buffers_exit;
    }
    single_word_buffer[word_size++] = (char)single_c;
  }

  qsort(word_list,list_size,sizeof(char *),qsort_compatible_frobcmp);
  displayStream(word_list,list_size);
  fprintf(stderr,"Comparisons: %u\n",comparisons);
 clear_buffers_exit:
  for(iterator = 0; iterator < (list_size-1); iterator++)
    free(word_list[iterator]);
 clean_exit:
  free(word_list);
  free(single_word_buffer);
  if(EXIT_CODE)
  fprintf(stderr,"Memory re/allocation error. Exiting (1)");
  exit(EXIT_CODE);
}
