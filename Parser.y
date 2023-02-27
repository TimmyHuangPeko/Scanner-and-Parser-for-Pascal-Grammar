%{
#include <stdio.h>
#include <string.h>

int yylex();
extern int lineno;
extern int charno;
extern char* yytext;
extern int yyleng;
extern char msg[256];
void yyerror(const char* message);
char errmsg[256];
int decN = 0;
char temptype[16] = "";
char op1[16] = "";
char op2[16] = "";
typedef struct node{
	char name[16];
	char type[16];
	struct node* link;
}NODE;

NODE* head = NULL;
void pushNODE(char*,char*);
%}

%union{
	char* str;
}

%error-verbose
%type <str> prog prog_name dec_list dec type standtype arraytype id_list stmt_list stmt assign ifstmt exp relop simpexp term factor read write writeln for index_exp varid arg arg_list body
%token <str> T_ABSOLUTE T_AND T_BEGIN T_BREAK T_CASE T_CONST T_CONTINUE T_DO T_ELSE T_END T_FOR T_FUNCTION T_IF T_MOD T_NIL T_NOT T_OBJECT T_OF T_OR T_PROGRAM T_THEN T_TO T_VAR T_WHILE T_ARRAY T_INTEGER T_DOUBLE T_WRITE T_WRITELN T_STRING T_FLOAT T_READ T_REALTYPE T_INT T_REAL T_ID T_STR
%token <str> T_COM T_SEMI T_COL T_GT T_LT T_EQ T_PLUS T_MINU T_MUL T_DIV T_DOT T_LP T_RP T_LB T_RB T_ASSG T_LE T_GE T_UNEQ
%%
prog
	: T_PROGRAM prog_name T_SEMI  T_VAR dec_list T_SEMI  T_BEGIN stmt_list T_SEMI T_END T_DOT
	{
		;
	}
	| error
	;
prog_name
	: T_ID
	{
		pushNODE($1, "program");
	}
	;
dec_list
	: dec
	| dec_list T_SEMI  dec
	;
dec
	:id_list T_COL type
	{
		decN = 0;
	}
	;
type
	: standtype
	| arraytype
	;
standtype
	: T_INTEGER
	{
		NODE* p = head;
		for(int i = 0; i < decN; i++){
			strcpy(p->type, "integer");
			p = p->link;
		}
	}
	| T_REALTYPE
	{
		NODE* p = head;
		for(int i = 0; i < decN; i++){
			strcpy(p->type, "realtype");
			p = p->link;
		}
	}
	| T_STRING
	{
		NODE* p = head;
		for(int i = 0; i < decN; i++){
			strcpy(p->type, "string");
			p = p->link;
		}
	}
	;
arraytype
	: T_ARRAY T_LB T_INT T_DOT T_DOT T_INT T_RB T_OF standtype
	;
id_list	
	: T_ID
	{
		pushNODE($1, "");
		decN++;
	}
	| id_list T_COM  T_ID
	{
		pushNODE($3, "");
		decN++;
	}
	;
stmt_list
	: stmt
	| stmt_list T_SEMI stmt
	;
stmt
	: assign
	| read
	| write
	| writeln
	| for
	| ifstmt
	;
assign
	: varid T_ASSG simpexp
	{
		if(strcmp(op1, op2)) printf("Syntax error at line: %d, invalid assignment of %s\n", lineno - 1, $1);
		strcpy(op1, "");
		strcpy(op2, "");
	}
	| varid T_ASSG T_STR
	{
		if(strcmp(op1, "string")) printf("Syntax error at line: %d, invalid assignment of %s\n", lineno - 1, $1);
		strcpy(op1, "");
	}
	;
ifstmt
	: T_IF T_LP exp T_RP T_THEN body
	;
exp
	: simpexp
	| exp relop simpexp
	;
relop
	: T_GT
	| T_LT
	| T_GE
	| T_LE
	| T_UNEQ
	| T_EQ
	;
simpexp
	: term
	| T_PLUS term
	| T_MINU term
	| simpexp T_PLUS term
	| simpexp T_MINU term
	;
term
	: factor
	| term T_MUL factor
	| term T_DIV factor
	| term T_MOD factor
	;
factor
	: varid
	| T_INT
	{
		strcpy(op2, "integer");
	}
	| T_REAL
	{
		strcpy(op1, "realtype");
	}
	| T_LP simpexp T_RP
	;
read
	: T_READ T_LP id_list T_RP
	;
write
	: T_WRITE T_LP arg_list T_RP
	;
writeln
	: T_WRITELN
	| T_WRITELN T_LP arg_list T_RP
	;
for
	: T_FOR index_exp T_DO body
	;
index_exp
	: varid T_ASSG simpexp T_TO exp
	;
varid
	: T_ID
	{
		NODE* p = head;
		while(p){
			if(!strcmp($1, p->name)){strcpy(temptype, p->type); break;}
			p = p->link;
		}
		if(strcmp(op1, "")) strcpy(op2, temptype);
		else strcpy(op1, temptype);
	}
	| T_ID T_LB simpexp T_RB
	{
		NODE* p = head;
		while(p){
			if(!strcmp($1, p->name)){strcpy(temptype, p->type); break;}
			p = p->link;
		}
		if(strcmp(op1, "")) strcpy(op2, temptype);
		else strcpy(op1, temptype);
	}
	;
arg
	: simpexp
	| T_STR
	;
arg_list
	: arg
	| arg_list T_COM arg
	;
body
	: stmt
	| T_BEGIN stmt_list T_SEMI T_END
	;

%%
int main()
{
	yyparse();
	if(strcmp(msg, "")) printf("line %.2d: %s\n", lineno, msg);
	return 0;
}

void yyerror(const char* message)
{
	printf("Syntax error at line: %d, %s\n",lineno, yytext);
}

void pushNODE(char* id, char* t)
{
	NODE* n = (NODE*)malloc(sizeof(NODE));
	strcpy(n->name, id);
	strcpy(n->type, t);
	n->link = head;
	head = n;
}
