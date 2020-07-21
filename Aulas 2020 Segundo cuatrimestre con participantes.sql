select 
concat(
        '<a target="_new" href="%%WWWROOT%%/course/management.php?categoryid=',
        cat.id,
        '">',
        getCategoryPath(cat.id),
        '</a>'
    ) as "Categoría",
concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        c.id,
        '">',
        c.shortname,
        '</a>'
    ) as "Aula virtual",
    to_timestamp(c.startdate) as "Fecha de inicio",
    to_timestamp(c.enddate) as "Fecha de fin",
    (
        SELECT
            COUNT(ue.id)
        FROM
            prefix_course AS course
            JOIN prefix_enrol AS en ON en.courseid = course.id
            JOIN prefix_user_enrolments AS ue ON ue.enrolid = en.id
        where
            course.id = c.id
    ) as "Participantes inscritos",
    (
        SELECT
            COUNT(distinct asg.userid) AS "Estudiantes"
        FROM
            prefix_role_assignments AS asg
            JOIN prefix_context AS context ON asg.contextid = context.id
            AND context.contextlevel = 50
            JOIN prefix_course AS course ON context.instanceid = course.id
            JOIN prefix_role as r ON asg.roleid = r.id
        WHERE
            r.shortname like 'student'
            and course.id = c.id
    ),
    (
        SELECT
            COUNT(distinct asg.userid) AS "Profesores"
        FROM
            prefix_role_assignments AS asg
            JOIN prefix_context AS context ON asg.contextid = context.id
            AND context.contextlevel = 50
            JOIN prefix_course AS course ON context.instanceid = course.id
            JOIN prefix_role as r ON asg.roleid = r.id
        WHERE
            r.shortname like any(array ['teacher','editingteacher'])
            and course.id = c.id
    )
FROM
    prefix_course as c inner join prefix_course_categories as cat on cat.id=c.category
where getCategoryPath(cat.id) like 'SUPERIOR/2020.2 - Grado y Pregrado%'
order by "Categoría", "Aula virtual"
