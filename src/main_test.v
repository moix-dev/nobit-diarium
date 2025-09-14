module main

import db.sqlite

const journal_period = 2025
const db = sqlite.connect('data/test.sqlite') or { panic(err) }

fn test_journal() {
	assert create_journal(db, journal_period)
	assert list_journals(db).len > 0
}

fn test_entry() {
	entry_id_size := 6
	assert new_entry_id(db, entry_id_size) or { '' } != ''
	// assert list_entry(db, '%').len > 0
}

fn test_row() {
	// assert add_row(db)
}

fn test_data() {
	// assert set_data(db, entry_id)
}
