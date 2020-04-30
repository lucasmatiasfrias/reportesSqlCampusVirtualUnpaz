select
    c.id,
    c.fullname,
    c.summary,
    to_timestamp(c.startdate) as fecha_inicio,
    to_timestamp(c.enddate) as fecha_fin
from
    prefix_course as c
where
    c.summary like '%para primer cuatrimestre 2020%'