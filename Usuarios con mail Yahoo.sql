select
    u.id,
    u.username,
    u.firstname,
    u.lastname,
    u.email,
    to_timestamp(u.lastaccess) as lastaccess,
    to_timestamp(u.timecreated) as timecreated
from
    prefix_user as u
where
    lower(u.email) like '%yahoo%'
order by
    u.lastaccess,
    u.timecreated