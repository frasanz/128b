#include <stdio.h>
#include <cuda.h>
#include <gmp.h>
#include "show.h"

int show(my_uint128_t * value){
	mpz_t fullresult;
	mpz_init(fullresult);
	mpz_t  dos_32, dos_64, dos_96;
	mpz_init_set_str (dos_32, "4294967296", 10);
	mpz_init_set_str (dos_64, "18446744073709551616", 10);
	mpz_init_set_str (dos_96, "79228162514264337593543950336", 10);
	mpz_add_ui(fullresult, fullresult, value->x);
	mpz_addmul_ui(fullresult, dos_32, value->y);
	mpz_addmul_ui(fullresult, dos_64, value->z);
	mpz_addmul_ui(fullresult, dos_96, value->w); 
	gmp_printf ("fullresult %Zd\n",fullresult );

	return 0;
}
