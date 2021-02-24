SELECT
    concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=', c.id, '">', c.shortname, '</a>') as "Aula Virtual",
    u.username AS "DNI del docente",
    u.firstname AS "nombre del docente",
    u.lastname AS "apellido del docente",
   (
        CASE
            WHEN r.shortname like 'editingteacher' THEN 'Profesor'
        END
) as "Rol de usuario",
(
        CASE
            WHEN ula.timeaccess is null THEN 'Nunca'
            ELSE to_char(to_timestamp(ula.timeaccess)::timestamp, 'DD Mon YYYY HH:MI:SSPM')
        END
) as "Último acceso"

FROM
    prefix_user as u
    INNER JOIN prefix_role_assignments AS asg ON u.id=asg.userid
    INNER JOIN prefix_context AS context ON asg.contextid = context.id
        AND context.contextlevel = 50
    INNER JOIN prefix_course AS c ON context.instanceid = c.id
    INNER JOIN prefix_role as r ON asg.roleid = r.id
	LEFT JOIN prefix_user_lastaccess as ula on ula.userid=u.id and ula.courseid=c.id
WHERE
c.category = 145 and ula.id is NULL and
            r.shortname like any
(array ['teacher','editingteacher'])
            
order by c.shortname, u.username
