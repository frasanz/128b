/* It sums 5 times two 128bits integers using CUDA */

#include <stdio.h>
#include <cuda.h>
#include <gmp.h>
#include "show.h"

__global__ void mul_uint128(my_uint128_t * result)
{
	my_uint128_t a,b;

	/* Posicion numero 
	.w .z .y .x*/

	a.x = 0;
	a.y = 1001203;
	a.z = 0;
	a.w = 0;
	b.x = 0;
	b.y = 0;
	b.z = 3211;
	b.w = 0;

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
         : "r"(a.x), "r"(a.y), "r"(a.z), "r"(a.w),
           "r"(b.x), "r"(b.y), "r"(b.z), "r"(b.w));


	printf("%u %u %u %u %d\n",result->w, result->z, result->y, result->x, threadIdx.x);
}


int main()
{
	my_uint128_t * d_result;
	my_uint128_t * h_result;
	cudaMalloc((void**)&d_result, sizeof(my_uint128_t));
	h_result = (my_uint128_t *) malloc(sizeof(my_uint128_t));

	mul_uint128<<<1,5>>>(d_result);
	cudaMemcpy(h_result, d_result, sizeof(my_uint128_t), cudaMemcpyDeviceToHost);

	printf("%u %u %u %u \n",h_result->w, h_result->z, h_result->y, h_result->x);
	show(h_result);
	cudaFree(d_result);
	free(h_result);
	return 0;
}
