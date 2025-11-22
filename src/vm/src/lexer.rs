#[derive(Debug)]
pub enum Token {
    PUSH,
    NUMBER(i32),
    BIND,
    ID(String),
    EOF,
}

pub struct Vm {
    pub index: usize,
    pub cur_tok: Token,
    pub stack: Vec<i32>,
    pub cur_line: i64,
}

// Function that inits the vm
pub fn lex_init() -> Vm {
    Vm {
        index: 0,
        cur_tok: Token::EOF,
        stack: Vec::new(),
        cur_line: 0,
    }
}

// Main lexer function that updates the vm state
pub fn get_tok(vm: &mut Vm, src: &Vec<String>) {
    let c = &src[vm.index];

    match c.as_str() {
        " " => get_tok(vm, src),
        "PUSH" => vm.cur_tok = Token::PUSH,
        "BIND" => vm.cur_tok = Token::BIND,
        &_ => {
            if c.parse::<i32>().is_ok() {
                vm.cur_tok = Token::NUMBER(
                    c.parse::<i32>()
                        .expect("This should not happen report this"),
                );
            } else {
                vm.cur_tok = Token::ID(String::from(c));
            }
        }
    }
    vm.index += 1;
}
