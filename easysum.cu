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
	addend.y = 0;
	addend.z = 1;
	addend.w = 0;
	augend.x = 0;
	augend.y = 0;
	augend.z = 4294967294;
	augend.w = 0;
	res.x = 0;
	res.y = 0;
	res.z = 0;
	res.w = 0;

	asm ("add.cc.u32      %0, %4, %8;\n\t"
			"addc.cc.u32     %1, %5, %9;\n\t"
			"addc.cc.u32     %2, %6, %10;\n\t"
			"addc.u32        %3, %7, %11;\n\t"
			: "=r"(res.x), "=r"(res.y), "=r"(res.z), "=r"(res.w)
			: "r"(addend.x), "r"(addend.y), "r"(addend.z), "r"(addend.w),
			"r"(augend.x), "r"(augend.y), "r"(augend.z), "r"(augend.w)); 

	printf("%d %d %d %d %d\n",res.x, res.y, res.z, res.w, threadIdx.x);
	printf("%8x %8x %8x %8x %d\n",res.w, res.z, res.y, res.x, threadIdx.x);
}


int main()
{
	add_uint128<<<1,5>>>(1.1f);
	cudaDeviceReset();
	return 0;
}
