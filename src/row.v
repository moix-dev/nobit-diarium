import veb
import db.sqlite
import json

struct Row {
	entry_id  string
	account   string
	nature    i8
	amount    f32
	entry_ref ?string
}

fn (row Row) verify() ! {
	if row.entry_id.len == 0 {
		return error('entry_id null')
	}
	if row.account.len == 0 {
		return error('account null')
	}
	if row.nature < -1 || row.nature > 1 {
		return error('narute no range -1 to 1')
	}
	if row.amount <= 0 {
		return error('amount <= 0')
	}
}

fn (row Row) vals() []string {
	mut data := []string{}
	data << row.entry_id
	data << row.account
	data << row.nature.str()
	data << row.amount.str()
	return data
}

fn add_row(db sqlite.DB, journal string, row Row) !i64 {
	row.verify()!
	db.exec_param_many('
		INSERT INTO ${journal}(entry_id, account, nature, amount)
		VALUES(?, ?, ?, ?);
	',
		row.vals())!
	return db.last_insert_rowid()
}

fn list_rows(db sqlite.DB, journal string, entry_id string) ![][]string {
	rows := db.exec_param('
		SELECT id, entry_id, account, nature, amount, entry_ref
		FROM ${journal}
		WHERE entry_id LIKE ?
		ORDER BY created_at DESC
	',
		entry_id)!
	mut data := [][]string{}
	for row in rows {
		data << row.vals
	}
	return data
}

@['/api/:journal/row'; post]
fn (mut app App) api_post_row(mut ctx Context, journal string) veb.Result {
	body := ctx.req.data
	row := json.decode(Row, body) or { return ctx.not_found() }
	id := add_row(app.db, journal, row) or { return ctx.not_found() }
	if id > 0 {
		return ctx.text(id.str())
	}
	return ctx.not_found()
}

@['/api/:journal/rows']
fn (mut app App) api_rows(mut ctx Context, journal string) veb.Result {
	data := list_rows(app.db, journal, '%') or { return ctx.no_content() }
	data_json := json.encode(data)
	return ctx.text(data_json)
}

@['/api/:journal/entry/:entry_id']
fn (mut app App) api_rows_id(mut ctx Context, journal string, entry_id string) veb.Result {
	data := list_rows(app.db, journal, entry_id) or { return ctx.no_content() }
	data_json := json.encode(data)
	return ctx.text(data_json)
}
