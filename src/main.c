#include <stdio.h>
#include "sqlite3/sqlite3.h"
#include "klib/kstring.h"
#include "db.h"

sqlite3 *db;

int main(){

  db_init(db);

  kstring_t sample_kstr = {0};
  kputs("Sample text for kstring.", &sample_kstr);
  printf(" %s ---> len: %zu \n", sample_kstr.s, sample_kstr.l);
  
  return 0;
}
