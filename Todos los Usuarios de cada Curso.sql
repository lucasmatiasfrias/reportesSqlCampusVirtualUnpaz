SELECT
    DISTINCT prefix_user.username AS nombre_usuario,
    prefix_user.email AS email,
    prefix_user.firstname AS nombre,
    prefix_user.lastname AS apellido,
    prefix_role.shortname AS rol_de_usuario,
    prefix_role.id AS ID_rol_de_usuario,
    prefix_course.fullname AS curso
FROM
    (
        (
            (
                (
                    prefix_user
                    INNER JOIN prefix_role_assignments ON prefix_user.id = prefix_role_assignments.userid
                )
                INNER JOIN prefix_role ON prefix_role_assignments.roleid = prefix_role.id
            )
            INNER JOIN prefix_user_enrolments ON prefix_user.id = prefix_user_enrolments.userid
        )
        INNER JOIN prefix_enrol ON prefix_user_enrolments.enrolid = prefix_enrol.id
    )
    INNER JOIN prefix_course ON prefix_course.id = prefix_enrol.courseid
ORDER BY
    curso