import veb
import db.sqlite
import json

type Data = map[string]string

fn set_ref(db sqlite.DB, journal string, id i64, ref string) !bool {
	db.exec_param_many('
		UPDATE ${journal} SET entry_ref = ? WHERE id = ?;
	', [ref,
		id.str()])!
	return true
}

fn set_data(db sqlite.DB, journal string, id i64, key string, value string) !bool {
	db.exec_param_many('
		UPDATE ${journal} SET __data = json_set(__data, ?, ?) WHERE id = ?;
	',
		['$.' + key, value, id.str()])!
	return true
}

fn get_data(db sqlite.DB, journal string, id i64, key string) !string {
	rows := db.exec_param_many('
		SELECT json_extract(__data, ?) FROM ${journal} WHERE id = ? LIMIT 1;
	',
		['$.' + key, id.str()])!
	if rows.len == 1 {
		return rows.first().vals[0]
	}
	return error('get_data')
}

fn del_data(db sqlite.DB, journal string, id i64, key string) !bool {
	db.exec_param_many('
		UPDATE ${journal} SET __data = json_remove(__data, ?) WHERE id = ?;
	',
		['$.' + key, id.str()])!
	return true
}

fn list_data(db sqlite.DB, journal string, id i64) !string {
	rows := db.exec_param('
		SELECT __data FROM ${journal} WHERE id = ? LIMIT 1;
	',
		id.str())!
	if rows.len == 1 {
		return rows.first().vals[0]
	}
	return error('list_data')
}

fn parse_data(data string) !Data {
	return json.decode(Data, data)!
}

@['/api/:journal/entry_ref/:id'; post]
fn (mut app App) api_entry_ref(mut ctx Context, journal string, id i64) veb.Result {
	ref := ctx.req.data
	set_ref(app.db, journal, id, ref) or { return ctx.not_found() }
	return ctx.text(id.str())
}

@['/api/:journal/data/:id']
fn (mut app App) api_data(mut ctx Context, journal string, id i64) veb.Result {
	data_raw := list_data(app.db, journal, id) or { return ctx.no_content() }
	data_json := parse_data(data_raw) or { return ctx.no_content() }
	mut data := [][]string{}
	for key in data_json.keys() {
		data << [key, data_json[key]]
	}
	data_text := json.encode(data)
	return ctx.text(data_text)
}

@['/api/:journal/key/:id/:key']
fn (mut app App) api_get_data(mut ctx Context, journal string, id i64, key string) veb.Result {
	data := get_data(app.db, journal, id, key) or { return ctx.no_content() }
	return ctx.text(data)
}

@['/api/:journal/key/:id/:key'; delete]
fn (mut app App) api_del_data(mut ctx Context, journal string, id i64, key string) veb.Result {
	del_data(app.db, journal, id, key) or { return ctx.not_found() }
	return ctx.text(id.str())
}

@['/api/:journal/key/:id/:key'; post]
fn (mut app App) api_set_data(mut ctx Context, journal string, id i64, key string) veb.Result {
	value := ctx.req.data
	set_data(app.db, journal, id, key, value) or { return ctx.not_found() }
	return ctx.text(id.str())
}
