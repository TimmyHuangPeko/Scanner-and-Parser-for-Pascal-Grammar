%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
int lineno = 1;
int charno = 1;
char msg[256];
int flag = 0;
%}

absolute	[aA][bB][sS][oO][lL][uU][tT][eE]
and			[aA][nN][dD]
begin		[bB][eE][gG][iI][nN]
break		[bB][rR][eE][aA][kK]
case		[cC][aA][sS][eE]
const		[cC][oO][nN][sS][tT]
continue	[cC][oO][nN][tT][iI][nN][uU][eE]
do			[dD][oO]
else		[eE][lL][sS][eE]
end			[eE][nN][dD]
for			[fF][oO][rR]
function	[fF][uU][nN][cC][tT][iI][oO][nN]
if			[iI][fF]
mod			[mM][oO][dD]
nil			[nN][iI][lL]
not			[nN][oO][tT]
object		[oO][bB][jJ][eE][cC][tT]
of			[oO][fF]
or			[oO][rR]
program		[pP][rR][oO][gG][rR][aA][mM]
then		[tT][hH][eE][nN]
to			[tT][oO]
var			[vV][aA][rR]
while		[wW][hH][iI][lL][eE]
array		[aA][rR][rR][aA][yY]
integer		[iI][nN][tT][eE][gG][eE][rR]
double		[dD][oO][uU][bB][lL][eE]
write		[wW][rR][iI][tT][eE]
writeln		[wW][rR][iI][tT][eE][lL][nN]
string		[sS][tT][rR][iI][nN][gG]
float		[fF][lL][oO][aA][tT]
read		[rR][eE][aA][dD]
realtype 	[rR][eE][aA][lL][tT][yY][pP][eE]

letter		[a-zA-Z]
digit		[0-9]

Integer		([1-9]{digit}*|0)
Real		([1-9]{digit}*(\.({digit}*[1-9]0?|0))?[eE][+-]?[1-9]{digit}*|([1-9]{digit}*|0)\.({digit}*[1-9]0?|0))
ID			({letter}|_)({letter}|{digit}|_){0,14}
String		\'([^\'\n]|\'\')*\'
Comment		"(*"([^*(]|\*[^)]|\([^*])*"*)"

%%
{absolute}  {strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_ABSOLUTE;}
{and}		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_AND;}
{begin}    	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_BEGIN;}
{break}    	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_BREAK;}
{case} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_CASE;}
{const} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_CONST;}
{continue} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_CONTINUE;}
{do} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_DO;}
{else} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_ELSE;}
{end} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_END;}
{for} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_FOR;}
{function}	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_FUNCTION;}
{if}		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_IF;}
{mod} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_MOD;}
{nil} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_NIL;}
{not} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_NOT;}
{object} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_OBJECT;}
{of} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_OF;}
{or} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_OR;}
{program} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_PROGRAM;}
{then} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_THEN;}
{to} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_TO;}
{var} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_VAR;}
{while} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_WHILE;}
{array} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_ARRAY;}
{integer} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_INTEGER;}
{double} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_DOUBLE;}
{write} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_WRITE;}
{writeln} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_WRITELN;}
{string} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_STRING;}
{float} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_FLOAT;}
{read} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_READ;}
{realtype} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_REALTYPE;}

{Integer} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_INT;}
{Real}		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_REAL;}
{ID} 		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_ID;}
{String} 	{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_STR;}
{Comment} 	{for(int i = 0; i < yyleng; i++){
		    	if(yytext[i] == '\n') {lineno++; charno = 1;}
		   		else charno++;
		 	}}

","			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_COM;}
";"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_SEMI;}
":"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_COL;}
">"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_GT;}
"<"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_LT;}
"="			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_EQ;}
"+"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_PLUS;}
"-"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_MINU;}
"*"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_MUL;}
"/"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_DIV;}
"."			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_DOT;}
"("			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_LP;}
")"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_RP;}
"["			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_LB;}
"]"			{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_RB;}
":="		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_ASSG;}
"<="		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_LE;}
">="		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_GE;}
"<>"		{strcat(msg, yytext); charno += yyleng; yylval.str = strdup(yytext); return T_UNEQ;}

" "+ 		{strcat(msg, yytext); charno += yyleng;}
"\n" 		{for(int i = 0; i < strlen(msg); i++)
			 	if(msg[i] != ' ') flag = 1;
			 if(flag) printf("line %.2d: %s\n", lineno, msg);
			 lineno++; charno = 1; strcpy(msg, "");
			 flag = 0;}
"\t" 		{strcat(msg, yytext); charno += yyleng;}

%%
int yywrap(){
	return 1;
}
