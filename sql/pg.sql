CREATE TABLE IF NOT EXISTS image (
    id SERIAL PRIMARY KEY,
    filename VARCHAR(64),
    src      BYTEA,
    ctime    INT NOT NULL,
    UNIQUE (filename)
);
