{\rtf1\ansi\ansicpg1251\cocoartf2821
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- \uc0\u1057 \u1086 \u1079 \u1076 \u1072 \u1085 \u1080 \u1077  \u1090 \u1072 \u1073 \u1083 \u1080 \u1094 \
CREATE TABLE GENRES (\
    genre_id SERIAL PRIMARY KEY,\
    name VARCHAR(255) UNIQUE NOT NULL\
);\
\
CREATE TABLE ARTISTS (\
    artist_id SERIAL PRIMARY KEY,\
    name VARCHAR(255) UNIQUE NOT NULL\
);\
\
CREATE TABLE genre_artist (\
    genre_id INT REFERENCES GENRES(genre_id) ON DELETE CASCADE,\
    artist_id INT REFERENCES ARTISTS(artist_id) ON DELETE CASCADE,\
    PRIMARY KEY (genre_id, artist_id)\
);\
\
CREATE TABLE ALBUMS (\
    album_id SERIAL PRIMARY KEY,\
    title VARCHAR(255) NOT NULL,\
    release_year INT CHECK (release_year > 1900)\
);\
\
CREATE TABLE artist_album (\
    artist_id INT REFERENCES ARTISTS(artist_id) ON DELETE CASCADE,\
    album_id INT REFERENCES ALBUMS(album_id) ON DELETE CASCADE,\
    PRIMARY KEY (artist_id, album_id)\
);\
\
CREATE TABLE TRACKS (\
    track_id SERIAL PRIMARY KEY,\
    title VARCHAR(255) NOT NULL,\
    duration INTERVAL NOT NULL,\
    album_id INT REFERENCES ALBUMS(album_id) ON DELETE CASCADE\
);\
\
CREATE TABLE COLLECTIONS (\
    collection_id SERIAL PRIMARY KEY,\
    title VARCHAR(255) NOT NULL,\
    release_year INT CHECK (release_year > 1900)\
);\
\
CREATE TABLE collection_track (\
    collection_id INT REFERENCES COLLECTIONS(collection_id) ON DELETE CASCADE,\
    track_id INT REFERENCES TRACKS(track_id) ON DELETE CASCADE,\
    PRIMARY KEY (collection_id, track_id)\
);}