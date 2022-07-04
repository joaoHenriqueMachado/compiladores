#include "storage.h"

Box* newBox(char* lex_value, int value){
    Box *b = malloc(sizeof(Box));
    b->next = NULL;
    b->lex_value = lex_value;
    b->value = value;
    return b;
} 

Storage* createStorage(void){
    Storage *s = malloc(sizeof(Storage));
    s->head = NULL;

    return s;
}
int isEmpty(Storage *s){
    return (s == NULL || s->head == NULL);
}
int insertBox(Storage* s, char* lex_value, int value){
    Box *aux;

    if(isEmpty(s)){
        s->head = newBox(lex_value, value);
        return 0;
    }
    else{
        aux = s->head;
        while(aux->next != NULL){
            if(strcmp(aux->lex_value, lex_value) == 0){
                aux->value = value;
                return 0;
            }
            aux = aux->next;
        }
        if(strcmp(aux->lex_value, lex_value) == 0){
            aux->value = value;
            return 0;
        }
        aux->next = newBox(lex_value, value);
        return 0;
    }
}
int getValue(Storage* s, char* lex_value){
    Box *aux;
    if(!isEmpty(s)){
        aux = s->head;
        while(aux != NULL){
            if(strcmp(aux->lex_value, lex_value) == 0){
                return aux->value;
            }
            aux = aux->next;
        }
    }
    return -1;
}
void clearStorage(Storage* s){
    Box *aux;
    if(s != NULL){
        while(!isEmpty(s)){
            aux = s->head;
            s->head = s->head->next;
            free(aux);
        }
        free(s);
    }
}

