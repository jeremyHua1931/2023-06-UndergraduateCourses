/*
 * CS:APP Data Lab
 *
 * bits.c - Source file with your solutions to the Lab.
 *          This is the file you will hand in to your instructor.
 *
 */
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//#include "tests.h"
/*
 * Instructions to Students:
 *
 * STEP 1: Fill in the following struct with your identifying info. //struct {name ,id[year(4),label(1),major(3),id(3)]} char *s, 
 */
struct identifying_info
{  
   char name[30];
   char id[30];
}identifying_info={"华章昭","2019300003032"};
#if 0
/*
 * STEP 2: Read the following instructions carefully.
 */

You will provide your solution to the Data Lab by
editing the collection of functions in this source file.

CODING RULES:

  Replace the "return" statement in each function with one
  or more lines of C code that implements the function. Your code
  must conform to the following style:

  int Funct(arg1, arg2, ...) {
      /* brief description of how your implementation works */
      int var1 = Expr1;
      ...
      int varM = ExprM;	

      varJ = ExprJ;
      ...
      varN = ExprN;
      return ExprR;
  }

  Each "Expr" is an expression using ONLY the following:
  1. Integer constants 0 through 255 (0xFF), inclusive. You are
      not allowed to use big constants such as 0xffffffff.
  2. Function arguments and local variables (no global variables).
  3. Unary integer operations ! ~
  4. Binary integer operations & ^ | + << >>

  Some of the problems restrict the set of allowed operators even further.
  Each "Expr" may consist of multiple operators. You are not restricted to
  one operator per line.

  You are expressly forbidden to:
  1. Use any control constructs such as if, do, while, for, switch, etc.
  2. Define or use any macros.
  3. Define any additional functions in this file.
  4. Call any functions.
  5. Use any other operations, such as &&, ||, -, or ?:
  6. Use any form of casting.

  You may assume that your machine:
  1. Uses 2s complement, 32-bit representations of integers.
  2. Performs right shifts arithmetically.
  3. Has unpredictable behavior when shifting an integer by more
     than the word size.

EXAMPLES OF ACCEPTABLE CODING STYLE:
  /*
   * pow2plus1 - returns 2^x + 1, where 0 <= x <= 31
   */
  int pow2plus1(int x) {
     /* exploit ability of shifts to compute powers of 2 */
     return (1 << x) + 1;
  }

  /*
   * pow2plus4 - returns 2^x + 4, where 0 <= x <= 31
   */
  int pow2plus4(int x) {
     /* exploit ability of shifts to compute powers of 2 */
     int result = (1 << x);
     result += 4;
     return result;
  }
#endif

/*
 * STEP 3: Modify the following functions according the coding rules.
 *
 */
/* NO:1
 * bitAnd - x&y using only ~ and |
 *   Example: bitAnd(6, 5) = 4
 *   Legal ops: ~ |
 *   Max ops: 8
 *   Rating: 1
 */
int bitAnd(int x, int y)    //1-用或运算与取反运算实现与运算
{
   return ~((~x)|(~y));
}

/* NO:2
 * bitNor - ~(x|y) using only ~ and &
 *   Example: bitNor(0x6, 0x5) = 0xFFFFFFF8
 *   Legal ops: ~ &
 *   Max ops: 8
 *   Rating: 1
 */
int bitNor(int x, int y)   //2-用取反运算和与运算实现~(x|y)
{
  return (~x)&(~y);
}

/* NO:3
 * copyLSB - set all bits of result to least significant bit of x
 *   Example: copyLSB(5) = 0xFFFFFFFF, copyLSB(6) = 0x00000000
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 5
 *   Rating: 2
 */
int copyLSB(int x)        //3-将结果的所有位设为x的最小有效位
{
  return ~((x&1)+(-1));
}

/* NO:4
 * evenBits - return word with all even-numbered bits set to 1
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 8
 *   Rating: 2
 */

int evenBits(void)     //4-将结果的偶数位设为1
{ 
  int t1=(0x55<<8)+0x55;
   return ((t1<<16)+t1);
}

/* NO:5
 * logicalShift - shift x to the right by n, using a logical shift
 *   Can assume that 1 <= n <= 31
 *   Examples: logicalShift(0x87654321,4) = 0x08765432
 *   Legal ops: ~ & ^ | + << >>
 *   Max ops: 16
 *   Rating: 3
 */
int logicalShift(int x, int n)   //5-实现逻辑右移
{
    int t1=x>>n;  
    int t2= (1<<(32-n))+(-1); 
    return t1 & t2; 
}
/* NO:6
 * bang - Compute !x without using !
 *   Examples: bang(3) = 0, bang(0) = 1
 *   Legal ops: ~ & ^ | + << >>
 *   Max ops: 12
 *   Rating: 4
 */
int bang(int x)        //6-不用！实现！x
{  
  int t1= (x|((~x)+1));
  return (~(t1>>31))&1;
}

/* NO:7
 * leastBitPos - return a mask that marks the position of the
 *               least significant 1 bit. If x == 0, return 0
 *   Example: leastBitPos(96) = 0x20
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 6
 *   Rating: 4
 */
int leastBitPos(int x)    //7-获取x最低位的1所在位置
{
  return x&((~x)+1);
}

/* NO:8
 * TMax - return maximum two's complement integer
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 4
 *   Rating: 1
 */
int tmax(void)         //8-返回最大的补码   
{
  return ~(1<<31);
}

/* NO:9
 * negate - return -x
 *   Example: negate(1) = -1.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 5
 *   Rating: 2
 */
int negate(int x)  //9-不用-返回-x
{
  return (~x)+1;
}
/* NO:10
 * isPositive - return 1 if x > 0, return 0 otherwise
 *   Example: is                                                                                                                                                                                                                                          Positive(-1) = 0.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 8
 *   Rating: 3
 */
int isPositive(int x)   //10-判断x是否为正数
{
  return (!(!x))&(!(x>>31));
}
/* NO:11
 * isNonNegative - return 1 if x >= 0, return 0 otherwise
 *   Example: isNonNegative(-1) = 0.  isNonNegative(0) = 1.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 6
 *   Rating: 3
 */
int isNonNegative(int x)    //11-判断x是否为非负数
{
  return (!(x>>31));
}

/* NO:12
 * sum3 - x+y+z using only a single '+'
 *   Example: sum3(3, 4, 5) = 12
 *   Legal ops: ! ~ & ^ | << >>
 *   Max ops: 16
 *   Rating: 3
 */
/* A helper routine to perform the addition.  Don't change this code */
static int sum(int x, int y)    //12-不用加号并借助已有函数sum求三数之和
{
  return x+y;
}
int sum3(int x, int y, int z) 
{
  int word1 = 0;
  int word2 = 0;
  word1=(x^y)^z;
  int t1=(x&y);
  int t2=(x&z);
  int t3=(y&z);
  word2=(t1|t2|t3)<<1;
    /**************************************************************
     Fill in code below that computes values for word1 and word2
     without using any '+' operations
  ***************************************************************/
  /**************************************************************
     Don't change anything below here
  ***************************************************************/
  return sum(word1,word2);
}
/* NO:13
 * addOK - Determine if can compute x+y without overflow
 *   Example: addOK(0x80000000,0x80000000) = 0,
 *            addOK(0x80000000,0x70000000) = 1,
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 20
 *   Rating: 3
 */
int addOK(int x, int y)    //13-判断两个数相加是否会溢出
{ 
  int t1=x>>31;
  int t2=y>>31;
  int t3=(x+y)>>31;
  int p=(t1&t2)&(!t3);  
  int q=(!t1&!t2)&(t3); 
  return !(p|q);
}
/* NO:14
 * logicalAbs - absolute value of x (except returns TMin for TMin)
 *   Example: abs(-1) = 1.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 10
 *   Rating: 4
 */
int logicalAbs(int x)     //14-返回绝对值
{ 
  int t1=(x>>31)^x;
  int t2=!!(x>>31);
  return t1+t2;
}
/* NO:15
 * isNonZero - Check whether x is nonzero using
 *              the legal operators except !
 *   Examples: isNonZero(3) = 1, isNonZero(0) = 0
 *   Legal ops: ~ & ^ | + << >>
 *   Max ops: 12
 *   Rating: 4
 */
int isNonZero(int x)    //15-判断x是否为0
{
   int t1= (x|((~x)+1));
  return (t1>>31)&1;
}

