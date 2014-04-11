/* It sums 5 times two 128bits integers using CUDA */

#include <stdio.h>
#include <cuda.h>
#include <gmp.h>
#include "show.h"

__global__ void mul_uint128(my_uint128_t * op1, my_uint128_t * op2, my_uint128_t * result)
{
 asm ("{\n\t"
         "mul.lo.u32      %0, %4, %8;    \n\t"
         "mul.hi.u32      %1, %4, %8;    \n\t"
         "mad.lo.cc.u32   %1, %4, %9, %1;\n\t"
         "madc.hi.u32     %2, %4, %9,  0;\n\t"
         "mad.lo.cc.u32   %1, %5, %8, %1;\n\t"
         "madc.hi.cc.u32  %2, %5, %8, %2;\n\t"
         "madc.hi.u32     %3, %4,%10,  0;\n\t"
         "mad.lo.cc.u32   %2, %4,%10, %2;\n\t"
         "madc.hi.u32     %3, %5, %9, %3;\n\t"
         "mad.lo.cc.u32   %2, %5, %9, %2;\n\t"
         "madc.hi.u32     %3, %6, %8, %3;\n\t"
         "mad.lo.cc.u32   %2, %6, %8, %2;\n\t"
         "madc.lo.u32     %3, %4,%11, %3;\n\t"
         "mad.lo.u32      %3, %5,%10, %3;\n\t"
         "mad.lo.u32      %3, %6, %9, %3;\n\t"
         "mad.lo.u32      %3, %7, %8, %3;\n\t"
         "}"
         : "=r"(result->x), "=r"(result->y), "=r"(result->z), "=r"(result->w)
         : "r"(op1->x), "r"(op1->y), "r"(op1->z), "r"(op1->w),
           "r"(op2->x), "r"(op2->y), "r"(op2->z), "r"(op2->w));


	printf("%u %u %u %u %d\n",result->w, result->z, result->y, result->x, threadIdx.x);
}


int main()
{

	/* Definition of operands and result */
	my_uint128_t * d_op1;
	my_uint128_t * h_op1;
	my_uint128_t * d_op2;
	my_uint128_t * h_op2;
	my_uint128_t * d_result;
	my_uint128_t * h_result;

	/* Malloc */
	cudaMalloc((void**)&d_op1, sizeof(my_uint128_t));
	h_op1 = (my_uint128_t *) malloc(sizeof(my_uint128_t));


	cudaMalloc((void**)&d_op2, sizeof(my_uint128_t));
	h_op2 = (my_uint128_t *) malloc(sizeof(my_uint128_t));


	cudaMalloc((void**)&d_result, sizeof(my_uint128_t));
	h_result = (my_uint128_t *) malloc(sizeof(my_uint128_t));

	/* Definition of op1 and op2 */
	h_op1->x = 0;
	h_op1->y = 1001203;
	h_op1->z = 0;
	h_op1->w = 0;
	h_op2->x = 0;
	h_op2->y = 0;
	h_op2->z = 3211;
	h_op2->w = 0;
	cudaMemcpy(d_op1, h_op1, sizeof(my_uint128_t), cudaMemcpyHostToDevice);
	cudaMemcpy(d_op2, h_op2, sizeof(my_uint128_t), cudaMemcpyHostToDevice);

	mul_uint128<<<1,5>>>(d_op1, d_op2, d_result);
	cudaMemcpy(h_result, d_result, sizeof(my_uint128_t), cudaMemcpyDeviceToHost);

	printf("%u %u %u %u \n",h_result->w, h_result->z, h_result->y, h_result->x);
	show(h_op1);
	show(h_op2);
	show(h_result);
	cudaFree(d_result);
	cudaFree(d_op1);
	cudaFree(d_op2);
	free(h_result);
	free(h_op1);
	free(h_op2);
	return 0;
}
