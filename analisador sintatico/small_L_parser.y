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

S: PROGRAM Id SCOLON Bloco {printf("P -> programa ID ; Bloco\nSintaticamente correto\n");}
  ;
Bloco: VAR Decl START Comandos END {printf("Bloco -> var Declaracao inicio Comandos fim\n");}
  ;
Decl: Nome_Var DOUBLE_DOT Tipo SCOLON {printf("Declaracao -> Nome_var : Tipo ;\n");}
        | Nome_Var DOUBLE_DOT Tipo SCOLON Decl {printf("Declaracao -> Nome_var : Tipo ; Declaracao\n");}
        ;
Nome_Var: Id {printf("Nome_var -> ID\n");} 
        | Id COMMA Nome_Var {printf("Nome_var -> ID , Nome_var\n");}
        ;
Tipo: TYPE_INTEGER {printf("Tipo -> inteiro\n");} 
        | TYPE_FLOAT {printf("Tipo -> real\n");} 
        | TYPE_BOOLEAN {printf("Tipo -> booleano\n");}
        ;
Comandos: Comando {printf("Comandos -> Comando \n");} 
        | Comando SCOLON Comandos {printf("Comandos -> Comando ; Comandos\n");} 
        ;
Comando: ComandoCombinado
        | ComandoAberto
        ;
ComandoCombinado: IF Expr THEN ComandoCombinado ELSE ComandoCombinado 
        | Atrib {printf("Comando -> Atribuicao\n");}
        | Repet {printf("Comando -> Repeticao\n");} 
        | Leia {printf("Comando -> Leitura\n");} 
        | Escreva {printf("Comando -> Escrita\n");}
        ;
ComandoAberto: IF Expr THEN Comando 
        | IF Expr THEN ComandoCombinado ELSE ComandoAberto
        ;
Atrib: Id ATRIB Expr {printf("Atribuicao -> ID atrib E\n");}
        ;
/*
Comando: Atrib {printf("C -> A\n");} 
        | Condic {printf("C -> I\n");} 
        | Repet {printf("C -> F\n");} 
        | Leia {printf("C -> R\n");} 
        | Escreva {printf("C -> W\n");}
        ;
Condic: IF Expr THEN Comandos {printf("I -> se E entao CS\n");}
        | IF Expr THEN Comandos ELSE Comandos {printf("I -> se E entao CS senao CS\n");}
        ;*/
Repet: WHILE Expr DO ComandoCombinado {printf("Repeticao -> enquanto E faca CS\n");}
        ;
Leia: READ PARENT_OPEN ID PARENT_CLOSE {printf("Leitura -> leia (ID)\n");}
        ;
Escreva: WRITE PARENT_OPEN ID PARENT_CLOSE {printf("Escrita -> escreva (ID)\n");}
        ;
Expr: Simples {printf("Expressao -> Simples\n");} 
        | Simples OpRel Simples {printf("Expressao -> Simples Operador_Relacional Simples\n");}
        ;
OpRel: DIFF {printf("Operador_Relacional -> <>\n");} 
        | EQUAL {printf("Operador_Relacional -> =\n");}
        | LESS {printf("Operador_Relacional -> <\n");}
        | GREATER {printf("Operador_Relacional -> >\n");}
        | LESS_OR_EQUAL {printf("Operador_Relacional -> <=\n");}
        | GREATER_OR_EQUAL {printf("Operador_Relacional -> >=\n");}
        ;
Simples: Termo Oper Termo {printf("Simples -> Termo Operador Termo\n");}
        | Termo {printf("Simples -> Termo\n");}
        ;
Oper: PLUS {printf("Operador -> +\n");}
        | MINUS {printf("Operador -> -\n");}
        | OR {printf("Operador -> ou\n");}
        ;
Termo: Fator {printf("Termo -> Fator\n");}
        | Fator Op Fator {printf("Termo -> Fator OP Fator\n");}
        ;
Op: MULTIPLY {printf("OP -> * \n");}
        | DIVIDE {printf("OP -> div \n");}
        | AND {printf("OP -> e \n");}
        ;
Fator: Id {printf("Fator -> ID \n");}
        | Num {printf("Fator -> N \n");}
        | PARENT_OPEN Expr PARENT_CLOSE {printf("Fator -> (Expressao) \n");}
        | TRUE {printf("Fator -> verdadeiro \n");}
        | FALSE {printf("Fator -> falso \n");}
        | NOT Fator {printf("Fator -> not FA \n");}
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

