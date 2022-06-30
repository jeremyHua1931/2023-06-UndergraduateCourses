/* retinf.c   	AXL分析器 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
 
 
#include "lex.h"
 
 
char err_id[] = "error";
char * midexp;
extern char * yytext;
 
 
struct YYLVAL {
  char * val;  /* 记录表达式中间临时变量 */
  char * expr; /* 记录表达式后缀式 */
  int last_op;  /* last operation of expression 
		   for elimination of redundant parentheses */
};
 
 
typedef struct YYLVAL Yylval;

Yylval    *expression ( void );
 
 
char *newname( void ); /* 在name.c中定义 */
char *getVar(void);
extern void freename( char *name );
 
 
void statements ( void )
{
  /*  statements -> expression SEMI  |  expression SEMI statements  */
  /*  请完成！！！*/
  printf("Please input an infix expression and ending with \";\"\n");

  Yylval *temp1;

  while( !match(EOI) ){
    temp1 = expression();
    printf("the affix expression is: %s\n", temp1 -> expr);
  
    freename(temp1 -> val);
    free(temp1 -> expr);
    free(temp1);   
 
    if( match( SEMI ) ){
      printf("Please input an infix expression and ending with \";\"\n");
      advance();
    }

	// if( match( SEMI ) ){
    //   advance();
    // }
    else
      fprintf( stderr, "%d: Inserting missing semicolon\n", yylineno );
  }
}
 
 
Yylval *expression()
{ 
  /*
    expression -> PLUS expression expression
               |  MINUS expression expression
               |  TIMES expression expression
               |  DIVISION expression expression
	       |  NUM_OR_ID
  */
 /*  请完成！！！*/

	Yylval* temp;
	temp=(Yylval *) malloc(sizeof(Yylval));

	if(match(PLUS)||match(MINUS) || match(TIMES)|| match(DIVISION) ){ 
    
		int p=0;

		if(match(TIMES)||match(DIVISION)) {
			p = 1;
		}

	    char op=yytext[0];
    	advance();
    	Yylval* temp1=expression();
    	Yylval* temp2=expression();

	    printf("        %s %c = %s\n",temp1->val,op,temp2->val);
		
		freename(temp2->val); 

	    temp->val=temp1->val;	
 

		if(p ==0){

			temp->last_op=1; 
	    temp->expr=(char *)malloc(strlen(temp1->expr)+1+strlen(temp2->expr));

	    sprintf( temp->expr, "%s %c %s",temp1->expr, op, temp2->expr);

		}else{

		  temp->last_op=2;
		  if(temp1->last_op==1||temp2->last_op==1){
				if(temp1->last_op!=1){
					temp->expr=(char *)malloc(strlen(temp1->expr)+3+strlen(temp2->expr));
					sprintf(temp->expr,"%s %c %c %s %c",temp1->expr,op,'(',temp2->expr,')');
				}else if(temp2->last_op!=1){
					temp->expr=(char *)malloc(strlen(temp1->expr)+3+strlen(temp2->expr));
					sprintf(temp->expr,"%c %s %c %c %s",'(',temp1->expr,')',op,temp2->expr);
				}else{
					temp->expr=(char *)malloc(strlen(temp1->expr)+5+strlen(temp2->expr));
					sprintf(temp->expr,"%c %s %c %c %c %s %c",'(',temp1->expr,')',op,'(',temp2->expr,')');
				}
		  }else{
			    temp->expr=(char *)malloc(strlen(temp1->expr)+1+strlen(temp2->expr));
			    sprintf(temp->expr, "%s %c %s", temp1->expr, op, temp2->expr);
			}
		}	     
 	}else if(match(NUM_OR_ID)){ 

	    char *name;
	    name = (char *) malloc(yyleng + 1);
	    strncpy(name, yytext, yyleng);
		char *name1 = newname();

	    printf("        %s = %s\n",name1,name);	
	    temp->expr=(char *)malloc(strlen(name));

	    sprintf(temp->expr,"%s",name);
 
	    temp->last_op=2;
	    temp->val=name1;
	    advance();		
	}else{
		advance();
	}	
	return temp;
}