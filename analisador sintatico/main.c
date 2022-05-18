#include <stdio.h>
#include "lex.yy.c"

extern int yyparse (void);

void yyerror(char const *message){
    printf("\nError: %s", message);
}

int main(int argc, char const *argv[]) {
    yyin = fopen(argv[1], "r");
    int result_code = yyparse();
    fclose(yyin);
    return result_code;
}