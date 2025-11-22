#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include ".hs/lexer.h"

Vm vm_init() {
	Vm vm = {0};
	return vm;
}

void get_tok(Vm *vm, char **src) {
	if (src[vm->index] == NULL) {
		vm->cur_tok = STR_END;
		return;
	}
	
	while (strcmp(src[vm->index], " ") == 0) {
        vm->index++;
    }

	printf("%s\n", src[vm->index]);

	if (strcmp(src[vm->index], "PUSH") == 0) {
		vm->cur_tok = PUSH;
	} else if (strcmp(src[vm->index], "BIND") == 0) {
		vm->cur_tok = BIND;
	} else {
		if (src[vm->index][0] >= '0' && src[vm->index][0] <= '9') {
			vm->cur_tok = NUMBER;
		} else {
			vm->cur_tok = ID;
		}
	}
	vm->index++;
}
