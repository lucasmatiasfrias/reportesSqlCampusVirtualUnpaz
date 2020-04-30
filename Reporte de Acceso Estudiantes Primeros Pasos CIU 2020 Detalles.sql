select
    c.fullname as "Aula",
    u.username as "Nombre de usuario",
    u.firstname as "Nombre",
    u.lastname as "Apellido",
    u.email as "Email",
    (
        CASE
            WHEN ula.timeaccess is not null THEN to_char(to_timestamp(ula.timeaccess), 'DD Mon YYYY')
            ELSE 'Nunca'
        END
    ) as "Ultimo Acceso al curso"
from
    prefix_course as c
    inner join prefix_enrol as e on c.id = e.courseid
    inner join prefix_user_enrolments as ue on e.id = ue.enrolid
    inner join prefix_user as u on ue.userid = u.id
    left join prefix_user_lastaccess ula on (ula.courseid = c.id)
    and (ula.userid = u.id)
where
    c.id = 1263
order by
    ula.timeaccess