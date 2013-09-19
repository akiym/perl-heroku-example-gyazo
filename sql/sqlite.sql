CREATE TABLE IF NOT EXISTS image (
    id INTEGER NOT NULL PRIMARY KEY,
    filename VARCHAR(64),
    src      TEXT,
    ctime    INT UNSIGNED NOT NULL,
    UNIQUE (filename)
);
