-- find within 10 minute queries
SELECT 
  pid,user,
  pg_stat_activity.query_start,
  now() - pg_stat_activity.query_start AS query_time,
  query,
  state,
  wait_event_type,
  wait_event
  FROM pg_stat_activity
  WHERE (now() - pg_stat_activity.query_start) > interval '10minutes';
  
--total activity in the databases.
  SELECT
 client_addr,usename,datname,state,count(*)
 FROM pg_stat_activity GROUP BY 1,2,3,4
 ORDER BY 5 DESC;
 
 --find blocking queries
 SELECT
   activity.pid,
   activity.usename,
   activity.query,
   blocking.pid AS blocking_id,
   blocking.query AS blocking_query
FROM pg_stat_activity AS activity
jOIN pg_stat_activity AS blocking ON blocking.pid = ANY(pg_blocking_pids(activity.pid));
