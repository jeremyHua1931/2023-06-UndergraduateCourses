#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "tests.h"

#define sumscore 100

extern int bitAnd(int x, int y);
extern int bitNor(int x, int y);
extern int copyLSB(int x);
extern int evenBits(void);
extern int logicalShift(int x, int n);
extern int bang(int x);
extern int leastBitPos(int x);
extern int tmax(void);
extern int negate(int x);
extern int isPositive(int x);
extern int isNonNegative(int x);
extern int sum3(int x, int y, int z);
extern int addOK(int x, int y);
extern int logicalAbs(int x);
extern int isNonZero(int x);

void printformat(){
	printf("ID\tScore\tSum\n");
}

void printline(int id, int score){
	printf("%d\t%d\t%d\n",id,score,sumscore);
}

int myrand() {
	int rint = rand();
	int symbol = rand();
	//printline(rint,symbol);
	if(symbol % 2)
		rint = - rint;
	return rint;
}
//func1
int test1(){
	int i = 0;
	int score = 0;
	for(i=0;i<sumscore;i++){
		int x = myrand();
		int y = myrand();
		if(bitAnd(x,y)==test_bitAnd(x,y)){
				score++;
		}
	}
	printline(1,score);
	return score;
}

//func2
int test2(){
	int i = 0;
	int score = 0;
	for(i=0;i<sumscore;i++){
		int x = myrand();
		int y = myrand();
		if(bitNor(x,y)==test_bitNor(x,y)){
				score++;
		}
	}
	printline(2,score);
	return score;
}

//func3
int test3(){
	int i = 0;
	int score = 0;
	for(i=0;i<sumscore;i++){
		int x = myrand();
		if(copyLSB(x)==test_copyLSB(x)){
				score++;
		}
	}
	printline(3,score);
	return score;
}

//func4
int test4(){
	int i = 0;
	int score = 0;
	for(i=0;i<sumscore;i++){
		if(evenBits()==test_evenBits()){
				score++;
		}
	}
	printline(4,score);
	return score;
}

//func5
int test5(){
	int i = 0;
	int score = 0;
	srand((unsigned)time(NULL));
	for(i=0;i<sumscore;i++){
		int x = myrand();
		int n = (myrand()%31+31)%31+1;
		if(logicalShift(x,n)==test_logicalShift(x,n)){
				score++;
		}
	}
	printline(5,score);
	return score;
}

//func6
int test6(){
	int i = 0;
	int score = 0;
	if(bang(0)==test_bang(0)){
		score+=sumscore/4;
	}
	if(bang(0x80000000)==test_bang(0x80000000)){
		score+=sumscore/4;
	}
	for(i=0;i<sumscore/2;i++){
		int x = myrand();
		if(bang(x)==test_bang(x)){
				score++;
		}
	}
	printline(6,score);
	return score;
}

//func7
int test7(){
	int i = 0;
	int score = 0;
	for(i=0;i<sumscore;i++){
		int x = myrand();
		if(leastBitPos(x)==test_leastBitPos(x)){
				score++;
		}
	}
	printline(7,score);
	return score;
}

//func8
int test8(){
	int i = 0;
	int score = 0;
	for(i=0;i<sumscore;i++){
		if(tmax()==test_tmax()){
				score++;
		}
	}
	printline(8,score);
	return score;
}

//func9
int test9(){
	int i = 0;
	int score = 0;
	if(negate(0)==test_negate(0)){
		score+=sumscore/2;
	}
	for(i=0;i<sumscore/2;i++){
		int x = myrand();
		if(negate(x)==test_negate(x)){
				score++;
		}
	}
	printline(9,score);
	return score;
}

//func10
int test10(){
	int i = 0;
	int score = 0;
	if(isPositive(0)==test_isPositive(0)){
		score+=sumscore/4;
	}
	int Tmin = -2147483648;
	if(isPositive(Tmin)==test_isPositive(Tmin)){
		score+=sumscore/4;
	}
	for(i=0;i<sumscore/2;i++){
		int x = myrand();
		if(isPositive(x)==test_isPositive(x)){
				score++;
		}
	}
	printline(10,score);
	return score;
}

//func11
int test11(){
	int i = 0;
	int score = 0;
	if(isNonNegative(0)==test_isNonNegative(0)){
		score+=sumscore/4;
	}
	int Tmin = -2147483648;
	if(isNonNegative(Tmin)==test_isNonNegative(Tmin)){
		score+=sumscore/4;
	}
	for(i=0;i<sumscore/2;i++){
		int x = myrand();
		if(isNonNegative(x)==test_isNonNegative(x)){
				score++;
		}
	}
	printline(11,score);
	return score;
}

//func12
int test12(){
	int i = 0;
	int score = 0;
	for(i=0;i<sumscore;i++){
		int x = myrand();
		int y = myrand();
		int z = myrand();
		if(sum3(x,y,z)==test_sum3(x,y,z)){
				score++;
		}
	}
	printline(12,score);
	return score;
}

//func13
int test13(){
	int i = 0;
	int score = 0;
	if(addOK(0x7fffffff,0x00000001)==test_addOK(0x7fffffff,0x00000001)){
		score+=sumscore/4;
	}
	if(addOK(0x80000000,0x80000000)==test_addOK(0x80000000,0x80000000)){
		score+=sumscore/4;
	}
	for(i=0;i<sumscore/2;i++){
		int x = myrand();
		int y = myrand();
		if(addOK(x,y)==test_addOK(x,y)){
				score++;
		}
	}
	printline(13,score);
	return score;
}

//func14
int test14(){
	int i = 0;
	int score = 0;
	for(i=0;i<sumscore;i++){
		int x = myrand();
		if(logicalAbs(x)==test_logicalAbs(x)){
				score++;
		}
	}
	printline(14,score);
	return score;
}

//func15
int test15(){
	int i = 0;
	int score = 0;
	if(isNonZero(0)==test_isNonZero(0)){
		score+=sumscore/4;
	}
	if(isNonZero(0x80000000)==test_isNonZero(0x80000000)){
		score+=sumscore/4;
	}
	for(i=0;i<sumscore/2;i++){
		int x = myrand();
		if(isNonZero(x)==test_isNonZero(x)){
				score++;
		}
	}
	printline(15,score);
	return score;
}

int main(){
	srand((unsigned)time(NULL));
	printformat();
	int score = 0;
	score+=test1();
	score+=test2();
	score+=test3();
	score+=test4();
	score+=test5();
	score+=test6();
	score+=test7();
	score+=test8();
	score+=test9();
	score+=test10();
	score+=test11();
	score+=test12();
	score+=test13();
	score+=test14();
	score+=test15();
	printf("total score/sum score: %d / %d\n",score,sumscore*15);
	if(score==sumscore*15){
		printf("Congratuations! You passed all puzzles.\n");
	}
	else{
		printf("Try again.\n");
	}
	return 0;
}




