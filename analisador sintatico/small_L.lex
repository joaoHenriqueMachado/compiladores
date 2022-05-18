%option noyywrap

%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include "small_L_parser.tab.h"
    int lines = 1;
    int errCount = 0;
    extern int yylval;
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
{prog}              {yylval = yytext[0]; return PROGRAM;}
"booleano"          {yylval = yytext[0]; return TYPE_BOOLEAN;}
"inteiro"           {yylval = yytext[0]; return TYPE_INTEGER;}
"real"              {yylval = yytext[0]; return TYPE_FLOAT;}
"var"               {yylval = yytext[0]; return VAR;}
"inicio"            {yylval = yytext[0]; return START;}
"fim"               {yylval = yytext[0]; return END;}
"se"                {yylval = yytext[0]; return IF;}
"entao"             {yylval = yytext[0]; return THEN;}
"senao"             {yylval = yytext[0]; return ELSE;}
"enquanto"          {yylval = yytext[0]; return WHILE;}
"faca"              {yylval = yytext[0]; return DO;}
"leia"              {yylval = yytext[0]; return READ;}
"escreva"           {yylval = yytext[0]; return WRITE;}
":="                {yylval = yytext[0]; return ATRIB;}
":"                 {yylval = yytext[0]; return DOUBLE_DOT;}
"="                 {yylval = yytext[0]; return EQUAL;}
"<"                 {yylval = yytext[0]; return LESS;}
">"                 {yylval = yytext[0]; return GREATER;}
"<="                {yylval = yytext[0]; return LESS_OR_EQUAL;}
"<>"                {yylval = yytext[0]; return DIFF;}
">="                {yylval = yytext[0]; return GREATER_OR_EQUAL;}
"+"                 {yylval = yytext[0]; return PLUS;}
"-"                 {yylval = yytext[0]; return MINUS;}
"ou"                {yylval = yytext[0]; return OR;}  
"*"                 {yylval = yytext[0]; return MULTIPLY;}
"div"               {yylval = yytext[0]; return DIVIDE;}
"e"                 {yylval = yytext[0]; return AND;}
"verdadeiro"        {yylval = yytext[0]; return TRUE;}   
"falso"             {yylval = yytext[0]; return FALSE;}
"nao"               {yylval = yytext[0]; return NOT;}
";"                 {yylval = yytext[0]; return SCOLON;}  
","                 {yylval = yytext[0]; return COMMA;}  
"("                 {yylval = yytext[0]; return PARENT_OPEN;}  
")"                 {yylval = yytext[0]; return PARENT_CLOSE;} 
{zeroErro}          //{printf("(<ERRO>,%d) ", lines); errCount++;}
{zeroNegErro}       //{printf("(<ERRO>,%d) ", lines); errCount++;}
{booleano}          {yylval = yytext[0]; return NUM;}                  
{real}              {yylval = yytext[0]; return NUM;} 
{inteiro}           {yylval = yytext[0]; return NUM;}                  
{id}                {yylval = yytext[0]; return ID;}
{digitoErro}        //{printf("(<ERRO>,%d) ", lines); errCount++;} 
{idErro}            //{printf("(<ERRO>,%d) ", lines); errCount++;}
.                   //{printf("(<ERRO>,%d) ", lines); errCount++;}
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