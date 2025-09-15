module main

import db.sqlite

const db = sqlite.connect('data/test.sqlite') or { panic(err) }
const journal_period = 2025
const journal_name = 'Journal_${journal_period}'
const entry_id_size = 6 / 2
const row_test_id = 1
const row_test_ref = 'XYZ987'
const row_test = Row{
	entry_id: 'ABC123'
	account:  '0+0.0'
	nature:   0
	amount:   1.0
}

fn test_journal() {
	assert create_journal(db, journal_period) or { false }
	assert list_journals(db) or { [] }.len > 0
}

fn test_entry() {
	assert new_entry_id(db, entry_id_size) or { '' }.len > 0
}

fn test_row() {
	assert add_row(db, journal_name, row_test) or { 0 } > 0
	assert list_rows(db, journal_name, '%') or { [] }.len > 0
	assert list_rows(db, journal_name, row_test.entry_id) or { [] }.len > 0
}

fn test_data() {
	assert set_ref(db, journal_name, row_test_id, row_test_ref) or { false }
	assert set_data(db, journal_name, row_test_id, 'key', 'value') or { false }
	assert get_data(db, journal_name, row_test_id, 'key') or { '' } == 'value'
	data := list_data(db, journal_name, row_test_id) or { '{}' }
	assert data != '{}'
	assert parse_data(data) or { Data{} }['key'] == 'value'
	assert del_data(db, journal_name, row_test_id, 'key') or { false }
}
