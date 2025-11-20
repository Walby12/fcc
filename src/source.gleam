pub type Source {
	Src(v: List(String))
}

// Function that insert in the source the list of string
pub fn insert_split(src: List(String)) -> Source {
	Src(src)
}

// Function that returns the list of string
pub fn get_source(s: Source) -> List(String) {
	s.v
}
