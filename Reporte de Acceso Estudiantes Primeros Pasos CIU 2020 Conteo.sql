select
    count(ula.timeaccess) as "Cantidad de Estudiantes que accedieron a Primeros Pasos"
from
    prefix_course as c
    inner join prefix_enrol as e on c.id = e.courseid
    inner join prefix_user_enrolments as ue on e.id = ue.enrolid
    inner join prefix_user as u on ue.userid = u.id
    left join prefix_user_lastaccess ula on (ula.courseid = c.id)
    and (ula.userid = u.id)
where
    c.id = 1263
    and ula is not null