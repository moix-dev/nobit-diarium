import veb
import db.sqlite

fn new_entry_id(db sqlite.DB, size_bytes int) !string {
	row := db.exec_one('
		SELECT hex(randomblob(${size_bytes}));
	')!
	return row.vals[0]
}

@['/api/entry_id']
fn (mut app App) api_entry_id(mut ctx Context) veb.Result {
	if entry_id := new_entry_id(app.db, 3) {
		return ctx.text(entry_id)
	}
	return ctx.no_content()
}
