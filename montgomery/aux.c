/*
 * =====================================================================================
 *
 *       Filename:  aux.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  18/04/14 19:56:05
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */
#include <stdlib.h>
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


