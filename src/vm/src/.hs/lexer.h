typedef enum {
	PUSH,
	ID,
	BIND,
	NUMBER,
	STR_END,
} Token;

typedef struct {
	Token cur_tok;
	int index;
	int stack[1024];
} Vm;

Vm vm_init();
void get_tok(Vm *vm, char **src);
