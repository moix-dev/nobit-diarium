CREATE TABLE IF NOT EXISTS "Journal" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Required
    entry_id TEXT NOT NULL, -- random Id
    account TEXT NOT NULL, -- 0+0.0
    nature INTEGER NOT NULL CHECK(nature BETWEEN -1 AND 1), -- -1, 0, +1
    amount NUMERAL NOT NULL CHECK(amount > 0), -- > 0
    -- Optional
    entry_ref TEXT,
    __data TEXT -- json data
);
