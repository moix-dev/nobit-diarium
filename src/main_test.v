module main

import db.sqlite

const journal_period = 2025
const db = sqlite.connect('data/test.sqlite') or { panic(err) }

fn test_journal() {
	assert create_journal(db, journal_period)
	assert list_journals(db).len > 0
}
