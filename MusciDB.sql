CREATE TABLE GENRES (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE ARTISTS (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE genre_artist (
    genre_id INT REFERENCES GENRES(genre_id) ON DELETE CASCADE,
    artist_id INT REFERENCES ARTISTS(artist_id) ON DELETE CASCADE,
    PRIMARY KEY (genre_id, artist_id)
);

CREATE TABLE ALBUMS (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT CHECK (release_year > 1900)
);

CREATE TABLE artist_album (
    artist_id INT REFERENCES ARTISTS(artist_id) ON DELETE CASCADE,
    album_id INT REFERENCES ALBUMS(album_id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE TRACKS (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INTERVAL NOT NULL,
    album_id INT REFERENCES ALBUMS(album_id) ON DELETE CASCADE\
);

CREATE TABLE COLLECTIONS (
    collection_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT CHECK (release_year > 1900)
);

CREATE TABLE collection_track (
    collection_id INT REFERENCES COLLECTIONS(collection_id) ON DELETE CASCADE,
    track_id INT REFERENCES TRACKS(track_id) ON DELETE CASCADE,
    PRIMARY KEY (collection_id, track_id)
);
