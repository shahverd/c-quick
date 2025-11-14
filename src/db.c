#include <stdio.h>
#include "sqlite3/sqlite3.h"

int db_init(sqlite3* db){
    // Open SQLite database (or create if not exist)
    if (sqlite3_open("students.db", &db) != SQLITE_OK) {
        printf("Failed to open database: %s\n", sqlite3_errmsg(db));
        return 1;
    }


    // Initialize tables if not exist
    char *err_msg = NULL;
    const char *sql_create = 
        "CREATE TABLE IF NOT EXISTS students ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT, "
        "grade REAL);";

    if (sqlite3_exec(db, sql_create, 0, 0, &err_msg) != SQLITE_OK) {
        printf("SQL error: %s\n", err_msg);
        sqlite3_free(err_msg);
        sqlite3_close(db);
        return 1;
    }

    return 0;
}
