module main

import db.sqlite

const journal_period = 2025
const journal_name = 'Journal_${journal_period}'
const db = sqlite.connect('data/test.sqlite') or { panic(err) }
const row_test = Row{
	entry_id: 'ABC123'
	account:  '0+0.0'
	nature:   0
	amount:   1.0
}

fn test_journal() {
	assert create_journal(db, journal_period)
	assert list_journals(db).len > 0
}

fn test_entry() {
	entry_id_size := 6
	assert new_entry_id(db, entry_id_size) or { '' } != ''
}

fn test_row() {
	assert add_row(db, journal_name, row_test) or { 0 } > 0
	assert list_rows(db, journal_name, '%') or { [] }.len > 0
	assert list_rows(db, journal_name, row_test.entry_id) or { [] }.len > 0
}

fn test_data() {
	// assert set_data(db, entry_id)
}
