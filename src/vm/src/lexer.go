package main;

import (
	"fmt"
	"strconv"
)

func lexe(vm Vm) []Token {
	tokens :=  make([]Token, 0, len(vm.src));
	
	for _, v := range vm.src {
		switch v {
		case "PUSH":
			fmt.Printf("PUSH\n")
			tokens = append(tokens, PUSH);
		case "BIND":
			fmt.Printf("BIND\n")
			tokens = append(tokens, BIND);
		default:
			n, err := strconv.Atoi(v);
			if err != nil {
				fmt.Printf("ID: %s\n", v)
				tokens = append(tokens, ID);
			} else {
				fmt.Printf("NUMBER: %d\n", n)
				tokens = append(tokens, NUMBER);
			}
		}
	}
	return tokens;
}
