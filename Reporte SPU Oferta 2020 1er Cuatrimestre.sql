SELECT
    getCategoryPath(c.category),
    concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        c.id,
        '">',
        c.shortname,
        '</a>'
    ) as "Aula Virtual",
    c.summary,
    to_timestamp(c.startdate) as inicio,
    to_timestamp(c.enddate) as fin,
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
    prefix_course as c
WHERE
    (
        c.shortname like '%2020%'
        or c.fullname like '%2020%'
        or lower(getCategoryPath(c.category)) like '%marzo-2020%'
        or (
            c.shortname like 'AyF2019%'
            and c.shortname like '%_2019-2C'
        )
    )
    and c.visible = 1
order by
    getCategoryPath(c.category),
    c.shortname