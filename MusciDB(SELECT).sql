-- 2.1: Самый длительный трек
SELECT title, duration 
FROM TRACKS 
ORDER BY duration DESC 
LIMIT 1;

-- 2.2: Треки ≥ 3.5 минут
SELECT title 
FROM TRACKS 
WHERE duration >= '00:03:30';

-- 2.3: Сборники 2018-2020
SELECT title 
FROM COLLECTIONS 
WHERE release_year BETWEEN 2018 AND 2020;

-- 2.4: Исполнители с именем из одного слова
SELECT name 
FROM ARTISTS 
WHERE name NOT LIKE '% %';

-- 2.5: Треки с 'мой'/'my' (кириллица)
SELECT title 
FROM TRACKS 
WHERE LOWER(title) LIKE '%мой%' OR LOWER(title) LIKE '%my%';

-- 3.1: Количество исполнителей по жанрам
SELECT g.name, COUNT(a.artist_id) AS artists_count
FROM GENRES g
JOIN genre_artist ga ON g.genre_id = ga.genre_id
JOIN ARTISTS a ON ga.artist_id = a.artist_id
GROUP BY g.name;

-- 3.2: Треки в альбомах 2019-2020
SELECT COUNT(t.track_id) 
FROM TRACKS t
JOIN ALBUMS a ON t.album_id = a.album_id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3.3: Средняя длительность треков по альбомам
SELECT a.title, AVG(t.duration) AS avg_duration
FROM ALBUMS a
JOIN TRACKS t ON a.album_id = t.album_id
GROUP BY a.title;

-- 3.4: Исполнители без альбомов 2020
SELECT a.name 
FROM ARTISTS a
LEFT JOIN artist_album aa ON a.artist_id = aa.artist_id
LEFT JOIN ALBUMS al ON aa.album_id = al.album_id AND al.release_year = 2020
WHERE al.album_id IS NULL;

-- 3.5: Сборники с "Би-2"
SELECT DISTINCT c.title
FROM COLLECTIONS c
JOIN collection_track ct ON c.collection_id = ct.collection_id
JOIN TRACKS t ON ct.track_id = t.track_id
JOIN ALBUMS al ON t.album_id = al.album_id
JOIN artist_album aa ON al.album_id = aa.album_id
JOIN ARTISTS art ON aa.artist_id = art.artist_id
WHERE art.name = 'Би-2';

-- 4.1: Альбомы с исполнителями разных жанров
SELECT al.title
FROM ALBUMS al
JOIN artist_album aa ON al.album_id = aa.album_id
JOIN ARTISTS a ON aa.artist_id = a.artist_id
JOIN genre_artist ga ON a.artist_id = ga.artist_id
GROUP BY al.title
HAVING COUNT(DISTINCT ga.genre_id) > 1;

-- 4.2: Треки не в сборниках
SELECT t.title
FROM TRACKS t
LEFT JOIN collection_track ct ON t.track_id = ct.track_id
WHERE ct.collection_id IS NULL;

-- 4.3: Исполнители с самым коротким треком
SELECT art.name
FROM ARTISTS art
JOIN artist_album aa ON art.artist_id = aa.artist_id
JOIN TRACKS t ON aa.album_id = t.album_id
WHERE t.duration = (SELECT MIN(duration) FROM TRACKS);

-- 4.4: Альбомы с наименьшим количеством треков
SELECT a.title
FROM ALBUMS a
JOIN (
    SELECT album_id, COUNT(track_id) AS track_count
    FROM TRACKS
    GROUP BY album_id
) AS t ON a.album_id = t.album_id
WHERE t.track_count = (
    SELECT MIN(track_count)
    FROM (
        SELECT COUNT(track_id) AS track_count
        FROM TRACKS
        GROUP BY album_id
    ) AS sub
);