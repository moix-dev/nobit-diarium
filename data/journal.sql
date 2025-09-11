CREATE TABLE IF NOT EXISTS "Journal" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Required
    entry TEXT NOT NULL, -- random
    account TEXT NOT NULL, -- 0+0.0
    nature INTEGER NOT NULL, -- -1, 0, +1
    amount NUMERAL NOT NULL CHECK(amount > 0), -- > 0
    -- Optional
    entry_ref TEXT,
    __data TEXT -- json data
);
