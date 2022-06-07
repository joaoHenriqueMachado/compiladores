flex small_L.lex
bison -d small_L_parser.y
gcc -c -o small_L_parser.o small_L_parser.tab.c
gcc -c -o main.o main.c
gcc -o main small_L_parser.o main.o
.\main teste1.sml