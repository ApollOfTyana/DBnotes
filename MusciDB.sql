CREATE TABLE IF NOT EXISTS GENRES (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS ARTISTS (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS genre_artist (
    genre_id INT REFERENCES GENRES(genre_id) ON DELETE CASCADE,
    artist_id INT REFERENCES ARTISTS(artist_id) ON DELETE CASCADE,
    PRIMARY KEY (genre_id, artist_id)
);

CREATE TABLE IF NOT EXISTS ALBUMS (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT CHECK (release_year > 1900)
);

CREATE TABLE IF NOT EXISTS artist_album (
    artist_id INT REFERENCES ARTISTS(artist_id) ON DELETE CASCADE,
    album_id INT REFERENCES ALBUMS(album_id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS TRACKS (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INTERVAL NOT NULL,
    album_id INT REFERENCES ALBUMS(album_id) ON DELETE CASCADE\
);

CREATE TABLE IF NOT EXISTS COLLECTIONS (
    collection_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT CHECK (release_year > 1900)
);

CREATE TABLE IF NOT EXISTS collection_track (
    collection_id INT REFERENCES COLLECTIONS(collection_id) ON DELETE CASCADE,
    track_id INT REFERENCES TRACKS(track_id) ON DELETE CASCADE,
    PRIMARY KEY (collection_id, track_id)
);
