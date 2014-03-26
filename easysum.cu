/* It sums 5 times two 128bits integers using CUDA */

#include <stdio.h>
#include <cuda.h>
#include <gmp.h>

typedef uint4 my_uint128_t;
__global__ void add_uint128(my_uint128_t * result)
{
	my_uint128_t a, b;

	/* Posicion numero 
	.w .z .y .x*/


	a.x = 0;
	a.y = 0;
	a.z = 4294967295;
	a.w = 0;
	b.x = 0;
	b.y = 0;
	b.z = 1;
	b.w = 0;

	asm ("add.cc.u32      %0, %4, %8;\n\t"
			"addc.cc.u32     %1, %5, %9;\n\t"
			"addc.cc.u32     %2, %6, %10;\n\t"
			"addc.u32        %3, %7, %11;\n\t"
			: "=r"(result->x), "=r"(result->y), "=r"(result->z), "=r"(result->w)
			: "r"(a.x), "r"(a.y), "r"(a.z), "r"(a.w),
			"r"(b.x), "r"(b.y), "r"(b.z), "r"(b.w)); 

	printf("%u %u %u %u %d\n",result->w, result->z, result->y, result->x, threadIdx.x);
}


int main()
{
	mpz_t fullresult;
	mpz_init(fullresult);
	mpz_t  dos_32, dos_64, dos_96;
	mpz_init_set_str (dos_32, "4294967296", 10);
	mpz_init_set_str (dos_64, "18446744073709551616", 10);
	mpz_init_set_str (dos_96, "79228162514264337593543950336", 10);
	my_uint128_t * result;
	my_uint128_t * h_result;
	cudaMalloc((void**)&result, sizeof(my_uint128_t));
	h_result = (my_uint128_t *) malloc(sizeof(my_uint128_t));
	h_result->x=10;
	h_result->y=11;
	h_result->z=12;
	h_result->w=13;
	add_uint128<<<1,5>>>(result);
	cudaMemcpy(h_result, result, sizeof(my_uint128_t), cudaMemcpyDeviceToHost);
	printf("%u %u %u %u \n",h_result->w, h_result->z, h_result->y, h_result->x);
	mpz_add_ui(fullresult, fullresult, h_result->x);
	mpz_addmul_ui(fullresult, dos_32, h_result->y);
	mpz_addmul_ui(fullresult, dos_64, h_result->z);
	mpz_addmul_ui(fullresult, dos_96, h_result->w); 
	gmp_printf ("fullresult %Zd\n",fullresult );
	cudaFree(result);
	free(h_result);

	return 0;
}
