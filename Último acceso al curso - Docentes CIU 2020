SELECT
    concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=', c.id, '">', c.shortname, '</a>') as "Aula Virtual",
    u.username AS nombre_usuario,
    u.firstname AS nombre,
    u.lastname AS apellido,
    r.shortname AS rol_de_usuario,
    (
        CASE
            WHEN ula.timeaccess is not null THEN to_char(to_timestamp(ula.timeaccess), 'DD Mon YYYY')
            ELSE 'Nunca'
        END
) as "Ultimo Acceso al curso"

FROM
    prefix_user as u
    INNER JOIN prefix_role_assignments AS asg ON u.id=asg.userid
    INNER JOIN prefix_context AS context ON asg.contextid = context.id
        AND context.contextlevel = 50
    INNER JOIN prefix_course AS c ON context.instanceid = c.id
    INNER JOIN prefix_role as r ON asg.roleid = r.id
    LEFT JOIN prefix_user_lastaccess as ula ON ula.userid = u.id
        AND ula.courseid = c.id
WHERE
            r.shortname like any
(array ['teacher','editingteacher'])
            and c.category in
(128,129,130)
order by c.shortname, u.username
