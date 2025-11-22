mod lexer;
mod parser;
use crate::lexer as lex;
use crate::parser as parse;

fn main() {
    parse::test();
    let mut vm = lex::lex_init();
    let str: String = String::from("PUSH 12 BIND x");
    let src: Vec<String> = str.split(' ').map(|s| s.to_string()).collect();

    lex::get_tok(&mut vm, &src);
    println!("Tok: {:?}", vm.cur_tok);

    lex::get_tok(&mut vm, &src);
    println!("Tok: {:?}", vm.cur_tok);
}
