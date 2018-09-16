#include <stdio.h>
#include <stdlib.h>

#include <libmake/header.h>

int main(void)
{
	if (sub(3, 5) != -2)
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
