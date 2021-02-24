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
            count(distinct u.id)
        FROM
            prefix_user as u
        WHERE
            u.id > 1
            AND u.deleted = 0
	        AND u.lastaccess=0
    ) as "Usuarios que nunca accedieron",
	(
        select
            count(u.id)
        FROM
            prefix_user as u
        WHERE
            u.id > 1
            AND u.deleted = 0
	        AND u.suspended=1
    ) as "Usuarios suspendidos",
    (
        select
            count(c.id)
        FROM
            prefix_course as c
        WHERE
            c.id > 1
    ) as "Total Cursos",
    (
        select
            count(c.id)
        FROM
            prefix_course as c
        WHERE
            c.id > 1
            and c.visible = 1
    ) as "Total Cursos Visibles",
    (
        select
            count(c.id)
        FROM
            prefix_course as c
        WHERE
            c.id > 1
            and c.visible = 1
            and to_timestamp(c.enddate) > now()
    ) as "Total Cursos en Progreso"
