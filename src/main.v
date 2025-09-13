module main

import veb

pub struct App {
mut:
	state shared State
}

pub struct Context {
	veb.Context
}

struct State {
mut:
	cnt int
}

fn main() {
	mut app := &App{}
	veb.run_at[App, Context](mut app) or { panic(err) }
}

// INDEX
pub fn (mut app App) index() veb.Result {
	return $veb.html()
}
