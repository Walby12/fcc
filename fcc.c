#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "ERROR: passed the wrong number of args\nUSAGE: fcc <file_name>\n");
		return 1;
	}
	
	char command[256];
	snprintf(command, sizeof(command), "gleam run --no-print-progress -t erlang %s", argv[1]);
	
	int ret = system(command);
	return ret;
}
