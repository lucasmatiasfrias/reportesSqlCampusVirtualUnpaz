select
    c.id,
    cat.name,
    c.shortname,
    c.fullname,
    to_timestamp(c.startdate) as fecha_inicio,
    to_timestamp(c.enddate) as fecha_fin,
    c.visible,
    to_timestamp(c.timecreated) as fecha_creacion,
    to_timestamp(c.timemodified) as fecha_ultima_modificacion
from
    prefix_course as c
    inner join prefix_course_categories as cat on c.category = cat.id
where
    to_timestamp(c.timecreated) < NOW() - interval '2 years'
    and to_timestamp(c.startdate) < NOW() - interval '2 years'
    and c.visible = 1
order by
    timecreated