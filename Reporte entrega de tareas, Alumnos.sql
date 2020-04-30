SELECT
    u.username as "DNI del Alumno",
    concat(u.firstname, ' ', u.lastname) as "Nombre y Apellido del alumno",
    a.name as "Actividad",
    to_timestamp(a.duedate) as "Fecha de entrega de la actividad",
    to_timestamp(asub.timecreated) as "Fecha en la que el alumno realizó la entrega"
from
    prefix_assign as a
    inner join prefix_assign_submission as asub on a.id = asub.assignment
    inner join prefix_user as u on u.id = asub.userid
where
    a.course = 1078
    and (
        u.username like '36375592'
        or u.username like '42370306'
    )