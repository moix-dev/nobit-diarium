import veb
import db.sqlite

fn new_entry_id(db sqlite.DB, size int) !string {
	row := db.exec_one('
		SELECT hex(randomblob(${size / 2})) AS entry_id;
	')!
	return row.vals[0]
}

@['/api/entry_id']
fn (mut app App) api_entry_id(mut ctx Context) veb.Result {
	if entry_id := new_entry_id(app.db, 6) {
		return ctx.text(entry_id)
	} else {
		return ctx.no_content()
	}
}
