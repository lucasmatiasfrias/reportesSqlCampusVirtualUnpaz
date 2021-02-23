select
    l.eventname,
    to_timestamp(l.timecreated), l.timecreated
from
    prefix_logstore_standard_log as l
where
l.timecreated > extract(EPOCH FROM TIMESTAMP WITH TIME ZONE '2020-11-29 00:00:00-3') and
    (
        l.eventname like '%course_created%'
        or l.eventname like '%user_created%'
        or l.eventname like '%course_deleted%'
        or l.eventname like '%user_deleted%'
    )
order by
    l.timecreated
