SELECT
    (
        select
            count(u.id)
        FROM
            prefix_user as u
        WHERE
            u.id > 1
            AND u.deleted = 0
    ) as "Total Usuarios",
    (
        select
            count(c.id) as total_aulas
        FROM
            prefix_course as c
        WHERE
            c.id > 1
    ) as "Total Cursos",
    (
        select
            count(c.id) as total_aulas
        FROM
            prefix_course as c
        WHERE
            c.id > 1
            and c.visible = 1
    ) as "Total Cursos Visibles",
    (
        select
            count(c.id) as total_aulas
        FROM
            prefix_course as c
        WHERE
            c.id > 1
            and c.visible = 1
            and to_timestamp(c.enddate) > now()
        limit
            1
    ) as "Total Cursos en Progreso"