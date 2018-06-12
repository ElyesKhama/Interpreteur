%{
	#include <stdio.h>
	#include <stdlib.h>	
	#include <string.h>
	int yylex(void);
	int yyerror(char *);
	#define lignemax 100
	#define NB_REGISTRES 16
	#define TAILLE_MEMOIRE 50

	struct {
		int ind;
		char *instr;
		int a;
		int b;
		int c;
	} tab_asm[lignemax];

	int indice = 0;
	int registres[NB_REGISTRES];
	int memoire[TAILLE_MEMOIRE];

void initiateMem(){
	printf("*******Initialisation de la mémoire à 0*******\n");
	int i;	
	for(i=0; i<TAILLE_MEMOIRE;i++){
		memoire[i] = i;
	}
}

void initiateReg(){
	int i;	
	for(i=0; i<NB_REGISTRES;i++){
		registres[i] = 0;
	}
}

void printMem(){
	int i;
	printf("MEMOIRE :\n");
	for(i=0; i<TAILLE_MEMOIRE;i++){
		printf("%d\n",memoire[i]);
	}
	printf("\n");
}

void printReg(){
	int i;
	printf("REGISTRES :\n");
	for(i=0; i<NB_REGISTRES;i++){
		printf("%d\n",registres[i]);
	}
	printf("\n");
}

void execute(){
	int i;
	for (i=0;i<indice;i++){
		if(strcmp(tab_asm[i].instr,"ADD") == 0){
			registres[tab_asm[i].a] = registres[tab_asm[i].b] + registres[tab_asm[i].c]; 		
		}
		if(strcmp(tab_asm[i].instr,"MUL") == 0){
			registres[tab_asm[i].a] = registres[tab_asm[i].b] * registres[tab_asm[i].c]; 		
		}
		else if(strcmp(tab_asm[i].instr,"SOU") == 0){
			registres[tab_asm[i].a] = registres[tab_asm[i].b] - registres[tab_asm[i].c]; 		
		}
		else if(strcmp(tab_asm[i].instr,"DIV") == 0){
			registres[tab_asm[i].a] = registres[tab_asm[i].b] / registres[tab_asm[i].c]; 		
		}
		else if(strcmp(tab_asm[i].instr,"EQU") == 0){
			if(registres[tab_asm[i].b]==registres[tab_asm[i].c]){
				registres[tab_asm[i].a] = 1;			
			}
			else{
				registres[tab_asm[i].a] = 0;
			}
		}
		else if(strcmp(tab_asm[i].instr,"INF") == 0){
			if(registres[tab_asm[i].c]<registres[tab_asm[i].b]){
				registres[tab_asm[i].a] = 1;
			}
			else{
				registres[tab_asm[i].a] = 0;
			}
		}
		else if(strcmp(tab_asm[i].instr,"INFE") == 0){
			if(registres[tab_asm[i].c]<=registres[tab_asm[i].b]){
				registres[tab_asm[i].a] = 1;			
			}
			else{
				registres[tab_asm[i].a] = 0;
			}
		}
		else if(strcmp(tab_asm[i].instr,"SUP") == 0){
			if(registres[tab_asm[i].c]>registres[tab_asm[i].b]){
				registres[tab_asm[i].a] = 1;			
			}
			else{
				registres[tab_asm[i].a] = 0;
			}
		}
		else if(strcmp(tab_asm[i].instr,"SUPE") == 0){
			if(registres[tab_asm[i].c]>=registres[tab_asm[i].b]){
				registres[tab_asm[i].a] = 1;			
			}
			else{
				registres[tab_asm[i].a] = 0;
			}
		}
		else if(strcmp(tab_asm[i].instr,"COP") == 0){
			registres[tab_asm[i].a] = registres[tab_asm[i].b];
		}
		else if(strcmp(tab_asm[i].instr,"AFC") == 0){
			registres[tab_asm[i].a] = tab_asm[i].b;			//a voir si on mets que dans b pour afc
		}
		else if(strcmp(tab_asm[i].instr,"LOAD") == 0){
			registres[tab_asm[i].a] = memoire[tab_asm[i].b];	//a voir si on mets que dans b pour load
		}
		else if(strcmp(tab_asm[i].instr,"STORE") == 0){
			memoire[tab_asm[i].a] = registres[tab_asm[i].b];	//a voir si on mets que dans a pour store
		}
		else if(strcmp(tab_asm[i].instr,"JMP") == 0){
			i = tab_asm[i].a;									//a voir si on mets que dans a pour jmp
		}
		else if(strcmp(tab_asm[i].instr,"JMPC") == 0){
			if(registres[tab_asm[i].c] == 0){
				i = tab_asm[i].a;
			}
		}
	}
}



%}

%union{
	int nb;
	char* str; 
}

%token tADD tMUL tSOU tDIV tCOP tAFC tLOAD tSTORE tEQU tINF tINFE tSUP tSUPE tJMP tJMPC tNB

%type <str>	tADD tMUL tSOU tDIV tCOP tAFC tLOAD tSTORE tEQU tINF tINFE tSUP tSUPE tJMP tJMPC
%type <nb>	tNB

%%


instructions: instr1 instructions
			| instr2 instructions
			| instr3 instructions
			|
			;


instr1:  tADD tNB tNB tNB				{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}
	| tMUL tNB tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}						
	| tSOU tNB tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}			
	| tDIV tNB tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}					
	| tEQU tNB tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}					
	| tINF tNB tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}					
	| tINFE tNB tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}
	| tSUP tNB tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}
	| tSUPE tNB tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;tab_asm[indice].b = $3;tab_asm[indice].c = $4;indice++;}

instr2: tCOP tNB tNB					{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2; tab_asm[indice].b = $3;	indice++;}
	|tAFC tNB tNB						{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2; tab_asm[indice].b = $3;	indice++;}
	|tLOAD tNB tNB						{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2; tab_asm[indice].b = $3;	indice++;}
	|tSTORE tNB tNB						{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2; tab_asm[indice].b = $3;	indice++;}
	|tJMPC tNB tNB						{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2; tab_asm[indice].b = $3;	indice++;}

instr3:	tJMP tNB						{tab_asm[indice].ind = indice;tab_asm[indice].instr = $1;tab_asm[indice].a = $2;indice++;}

%%

int main() {
	yyparse();
	int i;
	for(i=0;i<indice;i++)
	{		
		printf("%d\t%s\t%d\t%d\t%d\t",tab_asm[i].ind,tab_asm[i].instr,tab_asm[i].a,tab_asm[i].b,tab_asm[i].c);
		printf("\n");
	}
	
	initiateReg();
	printf("******Mémoire avant execution des instructions ******\n");
	printMem();
	execute();
	printf("******Mémoire après execution des instructions ******\n");
	printMem();
}
