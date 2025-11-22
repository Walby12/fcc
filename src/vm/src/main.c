#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include ".hs/lexer.h"

int main() {
	char string[50] = "PUSH 12 BIND x"; 
	
	char *token = strtok(string, " ");
	int i = 0;
	char **src = malloc(sizeof(string));

	while(token != NULL) {
		if ((int) sizeof(src) < i) {
			src = realloc(src, sizeof(src) + 20);
		}
		src[i++] = token;
    	token = strtok(NULL, " ");
	}
	
	Vm vm = vm_init();
	vm.index = 0;
	get_tok(&vm, src);
	get_tok(&vm, src);
	get_tok(&vm, src);
	get_tok(&vm, src);
	get_tok(&vm, src);
	return 0;
}
