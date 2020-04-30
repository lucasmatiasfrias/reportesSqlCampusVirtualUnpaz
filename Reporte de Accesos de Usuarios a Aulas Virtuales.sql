select
    prefix_course.fullname as "Aula",
    prefix_user.username as "Nombre de usuario",
    prefix_user.firstname as "Nombre",
    prefix_user.lastname as "Apellido",
    prefix_user.email,
    to_timestamp(prefix_user_lastaccess.timeaccess) as "Ultimo Acceso al curso"
from
    prefix_course
    inner join prefix_enrol on prefix_course.id = prefix_enrol.courseid
    inner join prefix_user_enrolments on prefix_enrol.id = prefix_user_enrolments.enrolid
    inner join prefix_user on prefix_user_enrolments.userid = prefix_user.id
    left join prefix_user_lastaccess on (prefix_user_lastaccess.courseid = prefix_course.id)
    and (prefix_user_lastaccess.userid = prefix_user.id)
order by
    prefix_course.fullname