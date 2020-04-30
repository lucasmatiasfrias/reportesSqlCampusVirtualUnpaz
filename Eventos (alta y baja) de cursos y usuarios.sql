select
    l.eventname,
    to_timestamp(l.timecreated)
from
    prefix_logstore_standard_log as l
where
    (
        l.eventname like '%course_created%'
        or l.eventname like '%user_created%'
        or l.eventname like '%course_deleted%'
        or l.eventname like '%user_deleted%'
    )
    and l.timecreated > 1575046831
order by
    l.timecreated