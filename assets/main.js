async function getJson(btn, fn, uri) {
    const res = await fetch(uri);
    if (!res.ok) throw new Error('Error HTTP: ' + res.statusText);
    return [btn.closest('form'), await res[fn]()]
}
async function setJson(fn, uri, data) {
    const res = await fetch(uri, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    if (!res.ok) throw new Error('Error HTTP: ' + res.statusText);
    return await res[fn]()
}
function forTable(data) {
    return data.map(x =>
        '<tr>' + x.map(y => '<td>' + y + '</td>').join('') + '</tr>'
    ).join('');
}
async function listJournals(btn) {
    const [form, data] = await getJson(btn, 'json', '/api/journals');
    const html_data = data.map(x => '<option value="' + x + '">' + x + '</option>').join('');
    form.querySelector('select[name="journal_name"]').innerHTML = html_data;
}
async function newEntryId(btn) {
    const [form, data] = await getJson(btn, 'text', '/api/entry_id')
    form.entry_id.value = data;
}
async function addRow(btn) {
    const form = btn.closest('form');
    const journal_name = form.journal_name.value;
    const row = {
        entry_id: form.entry_id.value,
        account: form.account.value,
        nature: parseInt(form.nature.value),
        amount: parseFloat(form.amount.value)
    };
    form.row_id.value = await setJson('text', '/api/' + journal_name + '/row', row);
}
async function listRows(btn) {
    const journal_name = btn.closest('form').journal_name.value;
    const [_, data] = await getJson(btn, 'json', '/api/' + journal_name + '/rows');
    document.querySelector('#view-rows>tbody').innerHTML = forTable(data);
}
async function listEntryId(btn) {
    const form = btn.closest('form');
    const journal_name = form.journal_name.value;
    const entry_id = form.entry_id.value;
    const [_, data] = await getJson(btn, 'json', '/api/' + journal_name + '/entry/' + entry_id);
    document.querySelector('#view-rows>tbody').innerHTML = forTable(data);
}
async function setEntryRef(btn) {
    const form = btn.closest('form');
    const journal_name = form.journal_name.value;
    const row_id = form.row_id.value;
    const entry_ref = form.entry_ref.value;
    const res = await fetch('/api/' + journal_name + '/entry_ref/' + row_id, {
        method: 'POST',
        body: entry_ref
    });
    if (res.ok) alert('Referencia actualizada');
}