SELECT country_lastfm, country_cnt / SUM(country_cnt) OVER() as ratio
FROM (
SELECT country_lastfm, COUNT(*) as country_cnt
FROM art.artists
WHERE length(trim(country_lastfm)) > 0
GROUP BY country_lastfm) t1
ORDER BY ratio DESC
LIMIT 10;