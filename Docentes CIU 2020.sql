SELECT
    Distinct CONCAT(
        '<a target="_new" href="%%WWWROOT%%/user/index.php?id=',
        c.id,
        '">',
        c.fullname,
        '</a>'
    ) as "Aula",
    c.summary as "Descripción Aula",
    u.username as "DNI Docente",
    u.firstname as "Nombre Docente",
    u.lastname as "Apellido Docente",
    u.email as "Email Docente"
FROM
    (
        (
            (
                (
                    prefix_user as u
                    INNER JOIN prefix_role_assignments as ra ON u.id = ra.userid
                )
                INNER JOIN prefix_role as r ON ra.roleid = r.id
            )
            INNER JOIN prefix_user_enrolments as ue ON u.id = ue.userid
        )
        INNER JOIN prefix_enrol as e ON ue.enrolid = e.id
    )
    INNER JOIN prefix_course as c ON c.id = e.courseid
WHERE
    c.category in (104, 105, 103)
    and r.shortname like any (array ['teacher', 'editingteacher'])