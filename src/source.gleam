pub type Source {
	Source(v: List(String), i: Int, b: String)
}

// Function that insert in the source the list of string
pub fn insert_split(src: List(String)) -> Source {
	Source(src, 0, "")
}

// Function that returns the list of string
pub fn get_source(s: Source) -> List(String) {
	s.v
}

// Function that returns the index
pub fn return_index(s: Source) -> Int {
	s.i
}
