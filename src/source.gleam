pub type Source {
	Source(v: List(String), i: Int, b: String, n: String)
}

// Function that insert in the source the list of string
pub fn start_comp(src: List(String), name: String) -> Source {
	Source(src, 0, "", name)
}

// Function that returns the list of string
pub fn get_source(s: Source) -> List(String) {
	s.v
}

// Function that returns the index
pub fn return_index(s: Source) -> Int {
	s.i
}

// Function that returns the file name
pub fn return_name(s: Source) -> String {
	s.n
}
