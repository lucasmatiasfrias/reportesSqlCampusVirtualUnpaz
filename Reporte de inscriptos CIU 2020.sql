SELECT
    (
        SELECT
            COUNT(distinct asg.userid) AS "Participantes Inscritos"
        FROM
            prefix_role_assignments AS asg
            JOIN prefix_context AS context ON asg.contextid = context.id
            AND context.contextlevel = 50
            JOIN prefix_course AS course ON context.instanceid = course.id
            JOIN prefix_role as r ON asg.roleid = r.id
        WHERE
            course.visible = 1
            /*Categorías del CIU 2020*/
            and course.category in (128, 129, 130)
    ),
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
            and course.visible = 1
            /*Categorías del CIU 2020*/
            and course.category in (128, 129, 130)
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
            and course.visible = 1
            /*Categorías del CIU 2020*/
            and course.category in (128, 129, 130)
    )
