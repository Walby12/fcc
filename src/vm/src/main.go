package main;

type Token int

const (
	PUSH Token = iota
	BIND
	ID
	NUMBER
)

type Vm struct {
	cur_tok Token
	value any
	src []string
}

func main() {
	var vm Vm;
	vm.src = []string{"PUSH", "12", "BIND", "x"};
	lexe(vm);
}
