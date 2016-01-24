CREATE TABLE users (
    id              INTEGER PRIMARY KEY, -- autoincrements in SQLite
    name            VARCHAR(255),
    email           VARCHAR(255) UNIQUE,
    password_digest VARCHAR(255),
    created_at      TIMESTAMP,
    updated_at      TIMESTAMP
);
