/* It sums 5 times two 128bits integers using CUDA */

#include <stdio.h>
#include <cuda.h>

typedef uint4 my_uint128_t;
__global__ void add_uint128(float f)
{
	my_uint128_t addend;
	my_uint128_t augend;
	my_uint128_t res;

	/* Posicion numero 
	.w .z .y .x*/

	addend.x = 0;
	addend.y = 1001203;
	addend.z = 0;
	addend.w = 0;
	augend.x = 0;
	augend.y = 0;
	augend.z = 3211;
	augend.w = 0;
	res.x = 0;
	res.y = 0;
	res.z = 0;
	res.w = 0;

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
         : "=r"(res.x), "=r"(res.y), "=r"(res.z), "=r"(res.w)
         : "r"(addend.x), "r"(addend.y), "r"(addend.z), "r"(addend.w),
           "r"(augend.x), "r"(augend.y), "r"(augend.z), "r"(augend.w));


	printf("%u %u %u %u %d\n",res.w, res.z, res.y, res.x, threadIdx.x);
}


int main()
{
	add_uint128<<<1,5>>>(1.1f);
	cudaDeviceReset();
	return 0;
}
