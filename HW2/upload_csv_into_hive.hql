CREATE DATABASE IF NOT EXISTS art;

CREATE TABLE IF NOT EXISTS art.artists (
 mbid string,
 artist_mb string,
 artist_lastfm string,
 country_mb string,
 country_lastfm string,
 tags_mb string,
 tags_lastfm string,
 listeners_lastfm double,
 scrobbles_lastfm double,
 ambiguous_artist boolean)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';


LOAD DATA INPATH '/user/hive/data/artists.csv' INTO TABLE art.artists;
