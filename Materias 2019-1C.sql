SELECT
    DISTINCT prefix_user.username AS nombre_usuario,
    prefix_user.firstname AS nombre,
    prefix_user.lastname AS apellido,
    prefix_user.email AS Mail,
    prefix_role.shortname AS rol_de_usuario,
    prefix_course.fullname AS curso,
    prefix_tag.name as modalidad
FROM
    prefix_user
    INNER JOIN prefix_role_assignments ON prefix_user.id = prefix_role_assignments.userid
    INNER JOIN prefix_role ON prefix_role_assignments.roleid = prefix_role.id
    INNER JOIN prefix_user_enrolments ON prefix_user.id = prefix_user_enrolments.userid
    INNER JOIN prefix_enrol ON prefix_user_enrolments.enrolid = prefix_enrol.id
    INNER JOIN prefix_course ON prefix_course.id = prefix_enrol.courseid
    inner join prefix_tag_instance on prefix_course.id = prefix_tag_instance.itemid
    inner join prefix_tag on prefix_tag_instance.tagid = prefix_tag.id
WHERE
    prefix_role.shortname = 'editingteacher'
    AND (
        prefix_tag.name like 'apoyo a la presencialidad'
        or prefix_tag.name like 'semipresencial'
    )
ORDER BY
    curso