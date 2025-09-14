module main

import veb
import db.sqlite

pub struct App {
mut:
	db sqlite.DB
}

pub struct Context {
	veb.Context
}

fn main() {
	mut app := &App{
		db: sqlite.connect('data/test.sqlite') or { panic(err) }
	}
	veb.run_at[App, Context](mut app) or { panic(err) }
}

// INDEX
pub fn (mut app App) index() veb.Result {
	return $veb.html()
}
