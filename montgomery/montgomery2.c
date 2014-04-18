/*
 * =====================================================================================
 *
 *       Filename:  montgomeryfactorial2.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  18/04/14 19:54:41
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "aux.h"

int main(){
  int n=101; /* The prime number */
  int r=128; /* 2^7 */
  int n1, r1;

  /* We've to find n1, r1 such as
   * r*r1 - n*n1 = 1 */
  find_r1n1(&n,&r, &n1, &r1);
  printf("r*r1-n*n1=%d*%d-%d*%d=%d\n",r,r1,n,n1,r*r1-n*n1);

  return 0;
}

