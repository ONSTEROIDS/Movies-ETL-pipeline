-- schema.sql

DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
    movie_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    title_clean TEXT,
    year INTEGER,
    genres TEXT,
    director TEXT,
    plot TEXT,
    box_office TEXT,
    box_office_usd INTEGER,
    runtime TEXT,
    runtime_min INTEGER,
    released TEXT,
    released_dt TEXT,
    language TEXT,
    actors TEXT,
    imdb_id TEXT,
    genre_api TEXT
);

CREATE TABLE ratings (
    rating_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    rating REAL NOT NULL,
    timestamp INTEGER,
    timestamp_converted TEXT,
    timestamp_dt TEXT,
    FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
);
