SELECT
    getCategoryPath(c.category) as Carrera,
    c.id,
    concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        c.id,
        '">',
        c.fullname,
        '</a>'
    ) as "Aula Virtual",
    c.summary as "Modalidad y Modelo",
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
    ),
    (
        SELECT
            COUNT(foro.id)
        FROM
            prefix_forum as foro
        where
            foro.course = c.id
            and foro.type not like 'news'
    ) AS "Foros",
    (
        SELECT
            COUNT(tarea.id)
        FROM
            prefix_assign as tarea
        where
            tarea.course = c.id
    ) AS "Tareas",
    (
        SELECT
            COUNT(examen.id)
        FROM
            prefix_quiz as examen
        where
            examen.course = c.id
    ) AS "Exámenes",
    (
        SELECT
            COUNT(glosario.id)
        FROM
            prefix_glossary as glosario
        where
            glosario.course = c.id
    ) AS "Glosarios",
    (
        SELECT
            COALESCE(min(m.count), 0)
        from
            (
                SELECT
                    (
                        Select
                            count(p.id)
                        from
                            prefix_forum_discussions as d
                            inner join prefix_forum_posts as p on d.id = p.discussion
                        where
                            d.forum = f.id
                    )
                from
                    prefix_forum as f
                where
                    f.course = c.id
                    and f.type not like 'news'
                group by
                    f.id
            ) as m
    ) as "Mínimo de Mensajes en Foros",
    (
        SELECT
            COALESCE(max(m.count), 0)
        from
            (
                SELECT
                    (
                        Select
                            count(p.id)
                        from
                            prefix_forum_discussions as d
                            inner join prefix_forum_posts as p on d.id = p.discussion
                        where
                            d.forum = f.id
                    )
                from
                    prefix_forum as f
                where
                    f.course = c.id
                    and f.type not like 'news'
                group by
                    f.id
            ) as m
    ) as "Máximo de Mensajes en Foros",
    (
        SELECT
            COALESCE(sum(m.count), 0)
        from
            (
                SELECT
                    (
                        Select
                            count(p.id)
                        from
                            prefix_forum_discussions as d
                            inner join prefix_forum_posts as p on d.id = p.discussion
                        where
                            d.forum = f.id
                    )
                from
                    prefix_forum as f
                where
                    f.course = c.id
                    and f.type not like 'news'
                group by
                    f.id
            ) as m
    ) as "Total de Mensajes en Foros",
    (
        SELECT
            round(COALESCE(avg(m.count), 0), 2)
        from
            (
                SELECT
                    (
                        Select
                            count(p.id)
                        from
                            prefix_forum_discussions as d
                            inner join prefix_forum_posts as p on d.id = p.discussion
                        where
                            d.forum = f.id
                    )
                from
                    prefix_forum as f
                where
                    f.course = c.id
                    and f.type not like 'news'
                group by
                    f.id
            ) as m
    ) as "Promedio de Mensajes en Foros",
    (
        SELECT
            count (userid) as "Usuarios Activos"
        FROM
            prefix_user_lastaccess
        where
            courseid = c.id
            and userid in (
                select
                    ue.userid
                from
                    prefix_user_enrolments as ue
                    inner join prefix_enrol as en on ue.enrolid = en.id
                where
                    en.courseid = c.id
            )
    ),
    (
        SELECT
            count (distinct userid) as "Docentes activos"
        FROM
            prefix_user_lastaccess
        where
            courseid = c.id
            and userid in (
                SELECT
                    asg.userid
                FROM
                    prefix_role_assignments AS asg
                    JOIN prefix_context AS context ON asg.contextid = context.id
                    AND context.contextlevel = 50
                    JOIN prefix_course AS course ON context.instanceid = course.id
                    JOIN prefix_role as r ON asg.roleid = r.id
                WHERE
                    r.shortname like any (array ['teacher','editingteacher'])
                    and course.id = c.id
            )
    ),
    (
        SELECT
            count (distinct userid) as "Estudiantes activos"
        FROM
            prefix_user_lastaccess
        where
            courseid = c.id
            and userid in (
                SELECT
                    asg.userid
                FROM
                    prefix_role_assignments AS asg
                    JOIN prefix_context AS context ON asg.contextid = context.id
                    AND context.contextlevel = 50
                    JOIN prefix_course AS course ON context.instanceid = course.id
                    JOIN prefix_role as r ON asg.roleid = r.id
                WHERE
                    r.shortname like 'student'
                    and course.id = c.id
            )
    ),
    (
        SELECT
            count(distinct l.userid)
        from
            prefix_logstore_standard_log as l
            inner join prefix_forum as f on f.course = l.courseid
        where
            courseid = c.id
            and component like '%forum%'
            and action like 'created'
            and lower(f.name) not like '%avisos%'
    ) as "Participaron en Foros",
    (
        SELECT
            count (distinct userid)
        from
            prefix_logstore_standard_log
        where
            courseid = c.id
            and component like '%assign%'
            and action like 'submitted'
            and to_timestamp(timecreated) between '2019-08-05'
            and '2019-09-30'
    ) as "Participaron en Tareas",
    concat(
        '<a target="_new" href="%%WWWROOT%%/report/outline/index.php?id=',
        c.id,
        '">Ver más</a>'
    ) as "Detalles de participación",
    concat('/course/view.php?id=', c.id) as "URL a buscar"
from
    prefix_course as c
    inner join prefix_logstore_standard_log as l on c.id = l.courseid
where
    c.visible = 1
    and c.category in (107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118)
group by
    c.id
order by
    c.category,
    c.fullname