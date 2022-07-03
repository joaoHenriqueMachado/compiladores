%option noyywrap

%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include "small_L_parser.tab.h"
    int lines = 1;
    int errCount = 0;
    extern YYSTYPE yylval;
%}
id [a-zA-Z][0-9a-zA-Z_]*
idErro {id}[^(\n\t" ")]+
booleano [01]
digito [0-9]+
inteiro "-"?{digito}
zeroErro "-"?[0]{digito}
zeroNegErro "-"[0]
real {inteiro}"."{digito}
digitoErro {digito}[^(\n\t" ")]+
prog "programa"

%%
  //regras da linguagem 
\n                  {lines++;} 
"{"[^}]*"}"         {/*Ignorar*/} 
[[:space:]]         {/*Ignorar*/} 
{prog}              {return PROGRAM;}
"booleano"          {return TYPE_BOOLEAN;}
"inteiro"           {return TYPE_INTEGER;}
"real"              {return TYPE_FLOAT;}
"var"               {return VAR;}
"inicio"            {return START;}
"fim"               {return END;}
"se"                {return IF;}
"entao"             {return THEN;}
"senao"             {return ELSE;}
"enquanto"          {return WHILE;}
"faca"              {return DO;}
"leia"              {return READ;}
"escreva"           {return WRITE;}
":="                {return ATRIB;}
":"                 {return DOUBLE_DOT;}
"="                 {return EQUAL;}
"<"                 {return LESS;}
">"                 {return GREATER;}
"<="                {return LESS_OR_EQUAL;}
"<>"                {return DIFF;}
">="                {return GREATER_OR_EQUAL;}
"+"                 {yylval.lex_value = yytext[0]; return PLUS;}
"-"                 {yylval.lex_value = yytext[0]; return MINUS;}
"ou"                {return OR;}  
"*"                 {yylval.lex_value = yytext[0]; return MULTIPLY;}
"div"               {yylval.lex_value = yytext[0]; return DIVIDE;}
"e"                 {return AND;}
"verdadeiro"        {return TRUE;}   
"falso"             {return FALSE;}
"nao"               {return NOT;}
";"                 {return SCOLON;}  
","                 {return COMMA;}  
"("                 {return PARENT_OPEN;}  
")"                 {return PARENT_CLOSE;} 
{zeroErro}          {printf("Erro lexico na linha %d ", lines); errCount++; return -1;} 
{zeroNegErro}       {printf("Erro lexico na linha %d ", lines); errCount++; return -1;} 
{booleano}          {return NUM;}                  
{real}              {return NUM;} 
{inteiro}           {yylval.value = atoi(yytext); return NUM;}                  
{id}                {yylval.lex_value = yytext[0]; return ID;}
{digitoErro}        {printf("Erro lexico na linha %d ", lines); errCount++; return -1;} 
{idErro}            {printf("Erro lexico na linha %d ", lines); errCount++; return -1;} 
.                   {printf("Erro lexico na linha %d ", lines); errCount++; return -1;} 
%%

/*int main(char *f){
    FILE *file = fopen(f, "r");

    if(!file){
        printf("Arquivo não encontrado");
        return -1;
    }

    yyin = file;

    while(yylex());
    printf("\nAnalise Lexica\n");
    printf("Numero de linhas: %8d\n", lines);
    printf("Numero de Erros: %8d\n", errCount);

    fclose(file);
    return 0;
}*/