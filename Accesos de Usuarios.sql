Select
    count(la.id) as cant_vistas,
    u.username,
    u.firstname,
    u.lastname,
    c.fullname,
    c.shortname
from
    prefix_logstore_standard_log as la
    inner join prefix_user as u on la.userid = u.id
    inner join prefix_course as c on la.courseid = c.id
where
    la.action like 'viewed'
group by
    c.id,
    u.username,
    c.shortname,
    u.firstname,
    u.lastname,
    c.fullname
order by
    c.shortname