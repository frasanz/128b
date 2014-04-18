/*
 * =====================================================================================
 *
 *       Filename:  montgomeryfactorial.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  18/04/14 02:33:32
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

void find_r1n1(int *n, int * r, int *n1, int *r1){
  int i, j, resultado;
  r1[0]=1;
  n1[0]=1;
  resultado=0;
  while(resultado!=1){
    if(resultado>n[0])
      n1[0]++;
    else
      r1[0]++;
    resultado = r[0]*r1[0]-n[0]*n1[0];
  }
}

int main(){
  int n=101; /* The prime number */
  int r=128; /* 2^7 */
  int n1, r1;
  int m,t;

  /* We've to found n1, r1 such as
   * r*r1 - n*n1 = 1 */
  find_r1n1(&n, &r, &n1, &r1);
  printf("r*r1-n*n1=%d*%d-%d*%d=%d\n",r,r1,n,n1,r*r1-n*n1);

  /* First 100*99 (mod 101) */
  m = ((100*99 & (r-1))*n1 &(r-1));
  t = ((100*99+m*n))/128; /* This divission can be improved */
  printf("t=%d\n",t);
  printf("mod=%d\n",t*r%n);

  return 0;
}

