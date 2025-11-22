#include <stdio.h>
#include <stdlib.h>
#include <klib/kstring.h>
#include "db.h"
#include <sqlite3/sqlite3.h>

sqlite3 *db;

int main(){

  run();

  FILE *p = fopen("helloll.txt", "w");

  fwrite("sfsdfsdfsdf", 1, 1, p);

  kstring_t sample_kstr = {0};
  kputs("Sample text for kstring.", &sample_kstr);
  printf(" %s ---> len: %zu \n", sample_kstr.s, sample_kstr.l);
  
  exit(0);
  return 0;
}
