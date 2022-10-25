SELECT t1.mbid as artist_id, t1.artist_mb as artist_name  
FROM art.artists t1 JOIN (SELECT max(scrobbles_lastfm) as max_scrobbles FROM art.artists) t2
ON t1.scrobbles_lastfm = t2.max_scrobbles;
