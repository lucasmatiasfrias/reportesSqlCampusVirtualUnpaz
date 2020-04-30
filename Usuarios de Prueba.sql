SELECT
    u.username,
    u.firstname,
    u.lastname,
    u.email,
    to_timestamp(u.lastaccess) as ultimo_acceso,
    (
        select
            count(id)
        from
            prefix_logstore_standard_log as logs
        where
            logs.userid = u.id
    ) as conteo_de_actividad
from
    prefix_user as u
where
    (
        lower(u.email) like any (
            array ['%test%', '%prueba%', '%estudiante%', '%alumno%']
        )
        or lower(u.firstname) like any (
            array ['%test%', '%prueba%', '%estudiante%', '%alumno%']
        )
        or lower(u.lastname) like any (
            array ['%test%', '%prueba%', '%estudiante%', '%alumno%']
        )
        or lower(u.username) like any (
            array ['%test%', '%prueba%', '%estudiante%', '%alumno%']
        )
    )
    and u.deleted = 0
order by
    u.lastaccess