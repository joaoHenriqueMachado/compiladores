%{
#include <stdio.h>
#include <string.h>
#include "storage.h"
extern void yyerror(char const *message);
extern int yylex(void);
Storage *storage;

%}

%union{
        int value;
        char* lex_value;
}

%token PROGRAM TYPE_BOOLEAN TYPE_INTEGER TYPE_FLOAT VAR START END IF THEN ELSE WHILE DO READ WRITE ATRIB DOUBLE_DOT EQUAL LESS GREATER LESS_OR_EQUAL DIFF GREATER_OR_EQUAL PLUS MINUS OR MULTIPLY DIVIDE AND TRUE FALSE NOT SCOLON COMMA PARENT_OPEN PARENT_CLOSE NUM ID
%right NOT
%left MULTIPLY DIVIDE
%left MINUS PLUS
%left LESS GREATER LESS_OR_EQUAL GREATER_OR_EQUAL
%left EQUAL DIFF
%left TRUE FALSE
%right ATRIB

%type <value> Num Fator Termo Simples Expr Id
%start S

%%

S: PROGRAM Id SCOLON Bloco {printf("P -> programa ID ; Bloco\nSintaticamente correto\n"); clearStorage(storage);}
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
Atrib: Id ATRIB Expr {printf("Atribuicao -> ID atrib E\n"); if(isEmpty(storage)){
        storage = createStorage();
} insertBox(storage, $<lex_value>1, $<value>3);
}
        ;
Repet: WHILE Expr DO ComandoCombinado {printf("Repeticao -> enquanto E faca CS\n");}
        ;
Leia: READ PARENT_OPEN ID PARENT_CLOSE {printf("Leitura -> leia (ID)\n");}
        ;
Escreva: WRITE PARENT_OPEN ID PARENT_CLOSE {printf("Escrita -> escreva (ID)\n"); printf("%d\n", getValue(storage, $<lex_value>3));}
        ;
Expr: Simples {printf("Expressao -> Simples\n"); $<value>$ = $<value>1;} 
        | Simples OpRel Simples {printf("Expressao -> Simples Operador_Relacional Simples\n");}
        ;
OpRel: DIFF {printf("Operador_Relacional -> <>\n");} 
        | EQUAL {printf("Operador_Relacional -> =\n");}
        | LESS {printf("Operador_Relacional -> <\n");}
        | GREATER {printf("Operador_Relacional -> >\n");}
        | LESS_OR_EQUAL {printf("Operador_Relacional -> <=\n");}
        | GREATER_OR_EQUAL {printf("Operador_Relacional -> >=\n");}
        ;
Simples: Termo Oper Termo {printf("Simples -> Termo Operador Termo\n");
        if(strcmp($<lex_value>2, "+") == 0){
                $<value>$ = $<value>1 + $<value>3;
        }else if(strcmp($<lex_value>2, "-") == 0){
                $<value>$ = $<value>1 - $<value>3;
        }
        }
        | Termo {printf("Simples -> Termo\n"); $<value>$ = $<value>1;}
        ;
Oper: PLUS {printf("Operador -> +\n");}
        | MINUS {printf("Operador -> -\n");}
        | OR {printf("Operador -> ou\n");}
        ;
Termo: Fator {printf("Termo -> Fator\n"); $<value>$ = $<value>1;}
        | Fator Op Fator {printf("Termo -> Fator OP Fator\n");
                if(strcmp($<lex_value>2, "*") == 0){
                        $<value>$ = $<value>1 * $<value>3;
                }else if(strcmp($<lex_value>2 , "div") == 0){
                        $<value>$ = $<value>1 / $<value>3;
                }
        }
        ;
Op: MULTIPLY {printf("OP -> * \n");}
        | DIVIDE {printf("OP -> div \n");}
        | AND {printf("OP -> e \n");}
        ;
Fator: Id {printf("Fator -> ID \n");
        $<value>$ = getValue(storage, $<lex_value>1);
}
        | Num {printf("Fator -> Num \n");
                $<value>$ = $<value>1;
        }
        | PARENT_OPEN Expr PARENT_CLOSE {printf("Fator -> (Expressao) \n");
                $<value>$ = $<value>2;
        }
        | TRUE {printf("Fator -> verdadeiro \n");}
        | FALSE {printf("Fator -> falso \n");}
        | NOT Fator {printf("Fator -> not FA \n");}
        ;
Id: ID {printf("ID -> id \n");}
        ;
Num: NUM {printf("N -> num \n"); $<value>$ = $<value>1;}
        ;
%%

