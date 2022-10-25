WITH temp_tags as (
select trim(tag) as tag, artist_mb, listeners_lastfm, length(trim(tag)) as len_tag
FROM art.artists
lateral view explode(split(tags_lastfm, '[;]')) tt as tag
)


SELECT stat.tag as tag, stat.artist_mb as artist_name, stat.listeners_lastfm as listeners
FROM (
SELECT temp_tags.tag, temp_tags.artist_mb, temp_tags.listeners_lastfm, ROW_NUMBER() OVER (PARTITION BY temp_tags.tag ORDER BY temp_tags.listeners_lastfm DESC) AS RN
FROM
(SELECT tag, count(*) as cnt
FROM temp_tags
WHERE len_tag > 0
GROUP BY tag
ORDER BY cnt DESC
LIMIT 10) t1
JOIN
temp_tags
ON temp_tags.tag = t1.tag) stat
WHERE RN = 1