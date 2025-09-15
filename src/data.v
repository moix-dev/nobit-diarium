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
