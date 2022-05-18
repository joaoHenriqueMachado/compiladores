%{
#include <stdio.h>
extern void yyerror(char const *message);
extern int yylex(void);

/*void yyerror(char *c);
int yylex(void);
int main();*/ 

%}
%token PROGRAM TYPE_BOOLEAN TYPE_INTEGER TYPE_FLOAT VAR START END IF THEN ELSE WHILE DO READ WRITE ATRIB DOUBLE_DOT EQUAL LESS GREATER LESS_OR_EQUAL DIFF GREATER_OR_EQUAL PLUS MINUS OR MULTIPLY DIVIDE AND TRUE FALSE NOT SCOLON COMMA PARENT_OPEN PARENT_CLOSE NUM ID
%right NOT
%left MULTIPLY DIVIDE
%left MINUS PLUS
%left LESS GREATER LESS_OR_EQUAL GREATER_OR_EQUAL
%left EQUAL DIFF
%left TRUE FALSE
%right ATRIB
%%

S: PROGRAM Id SCOLON Bloco {printf("P -> programa ID ; B\nSintaticamente correto\n");}
  ;
Bloco: VAR Decl START Comandos END {printf("B -> var D inicio CS fim\n");}
  ;
Decl: Nome_Var DOUBLE_DOT Tipo SCOLON {printf("D -> NV : T ;\n");}
        | Nome_Var DOUBLE_DOT Tipo SCOLON Decl {printf("D -> NV : T ; D\n");}
        ;
Nome_Var: Id {printf("NV -> ID\n");} 
        | Id COMMA Nome_Var {printf("NV -> ID comma NV\n");}
        ;
Tipo: TYPE_INTEGER {printf("T -> inteiro\n");} 
        | TYPE_FLOAT {printf("T -> real\n");} 
        | TYPE_BOOLEAN {printf("T -> booleano\n");}
        ;
Comandos: Comando {printf("CS -> C ;\n");} 
        | Comando SCOLON Comandos {printf("CS -> C ; CS\n");} 
        ;
Comando: Atrib {printf("C -> A\n");} 
        | Condic {printf("C -> I\n");} 
        | Repet {printf("C -> F\n");} 
        | Leia {printf("C -> R\n");} 
        | Escreva {printf("C -> W\n");}
        ;
Atrib: Id ATRIB Expr {printf("A -> ID atrib E\n");}
        ;
Condic: IF Expr THEN Comandos {printf("I -> se E entao CS\n");}
        | IF Expr THEN Comandos ELSE Comandos {printf("I -> se E entao CS senao CS\n");}
        ;
Repet: WHILE Expr DO Comandos {printf("F -> enquanto E faca CS\n");}
        ;
Leia: READ PARENT_OPEN ID PARENT_CLOSE {printf("R -> leia (ID)\n");}
        ;
Escreva: WRITE PARENT_OPEN ID PARENT_CLOSE {printf("W -> escreva (ID)\n");}
        ;
Expr: Simples {printf("E -> S\n");} 
        | Simples OpRel Simples {printf("E -> S OR S\n");}
        ;
OpRel: DIFF {printf("OR -> <>\n");} 
        | EQUAL {printf("OR -> =\n");}
        | LESS {printf("OR -> <\n");}
        | GREATER {printf("OR -> >\n");}
        | LESS_OR_EQUAL {printf("OR -> <=\n");}
        | GREATER_OR_EQUAL {printf("OR -> >=\n");}
        ;
Simples: Termo Oper Termo {printf("S -> TE O TE\n");}
        | Termo {printf("S -> TE\n");}
        ;
Oper: PLUS {printf("O -> +\n");}
        | MINUS {printf("O -> -\n");}
        | OR {printf("O -> ou\n");}
        ;
Termo: Fator {printf("TE -> FA\n");}
        | Fator Op Fator {printf("TE -> FA OP FA\n");}
        ;
Op: MULTIPLY {printf("OP -> * \n");}
        | DIVIDE {printf("OP -> div \n");}
        | AND {printf("OP -> e \n");}
        ;
Fator: Id {printf("FA -> ID \n");}
        | Num {printf("FA -> N \n");}
        | PARENT_OPEN Expr PARENT_CLOSE {printf("FA -> (E) \n");}
        | TRUE {printf("FA -> verdadeiro \n");}
        | FALSE {printf("FA -> falso \n");}
        | NOT Fator {printf("FA -> not FA \n");}
        ;
Id: ID {printf("ID -> id \n");}
        ;
Num: NUM {printf("N -> num \n");}
        ;
%%

/*
void yyerror(char *c) {
 printf("Erro: %s\n", c);
}

int main() {
  yyparse();
  return 0;
}*/

