SELECT hex(randomblob(3)) AS entry_id; -- random 3 bytes to len(hex) = 6

INSERT INTO "Journal" (entry_id, account, nature, amount)
VALUES('ABC123', '0+0.0', 0, 1.0);
