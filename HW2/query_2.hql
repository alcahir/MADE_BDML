WITH temp_tags as (
select trim(tag) as tag, artist_mb, listeners_lastfm, length(trim(tag)) as len_tag
FROM art.artists
lateral view explode(split(tags_lastfm, '[;]')) tt as tag
)


SELECT tag, count(*) as cnt
FROM temp_tags
WHERE len_tag > 0
GROUP BY tag
ORDER BY cnt DESC
LIMIT 10;
