#include <stdio.h>
#include <stdlib.h>

#include <libtest/header.h>

int main(void)
{
	if (add(1, 1) != 2)
	{
		puts("FAILURE");
		return EXIT_FAILURE;
	}
	else
	{
		puts("SUCCESS");
		return EXIT_SUCCESS;
	}
}
