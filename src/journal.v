import veb
import db.sqlite
import json

fn create_journal(db sqlite.DB, period int) !bool {
	db.exec('
		CREATE TABLE IF NOT EXISTS Journal_${period}(
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
			entry_id TEXT NOT NULL,
			account TEXT NOT NULL,
			nature INTEGER NOT NULL CHECK(nature BETWEEN -1 AND 1),
			amount REAL NOT NULL CHECK(amount > 0),
			entry_ref TEXT NOT NULL DEFAULT "",
			__data TEXT NOT NULL DEFAULT "{}"
		);
	')!
	return true
}

fn list_journals(db sqlite.DB) ![]string {
	rows := db.exec("
		SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'Journal_%';
	")!
	mut data := []string{}
	for row in rows {
		data << row.vals[0]
	}
	return data
}

@['/api/journals']
fn (mut app App) api_journals(mut ctx Context) veb.Result {
	data := list_journals(app.db) or { return ctx.no_content() }
	json_data := json.encode(data)
	return ctx.text(json_data)
}
