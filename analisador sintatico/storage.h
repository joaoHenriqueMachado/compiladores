#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Box Box;
typedef struct Storage Storage;

struct Box{
    int value;
    char* lex_value;
    Box* next;
};

struct Storage{
    Box* head;
};

Box* newBox(char* lex_value, int value);
Storage* createStorage(void);
int isEmpty(Storage *s);
int insertBox(Storage* s, char* lex_value, int value);
int getValue(Storage* s, char* lex_value);
void clearStorage(Storage* s);