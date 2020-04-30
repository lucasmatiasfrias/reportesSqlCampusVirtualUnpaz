Select
    c.id,
    c.fullname,
    c.shortname,
    count(l.id) as "Actividad total",
    (
        select
            count(DISTINCT prefix_user.id)
        FROM
            prefix_user
            INNER JOIN prefix_role_assignments ON prefix_user.id = prefix_role_assignments.userid
            INNER JOIN prefix_role ON prefix_role_assignments.roleid = prefix_role.id
            INNER JOIN prefix_user_enrolments ON prefix_user.id = prefix_user_enrolments.userid
            INNER JOIN prefix_enrol ON prefix_user_enrolments.enrolid = prefix_enrol.id
            INNER JOIN prefix_course ON prefix_course.id = prefix_enrol.courseid
            inner join prefix_user_lastaccess on prefix_user_lastaccess.courseid = prefix_course.id
            and prefix_user_lastaccess.userid = prefix_user_enrolments.userid
        where
            prefix_course.id = c.id
    ) as "Usuarios que Participaron",
(
        select
            count(DISTINCT prefix_user.id)
        FROM
            prefix_user
            INNER JOIN prefix_role_assignments ON prefix_user.id = prefix_role_assignments.userid
            INNER JOIN prefix_role ON prefix_role_assignments.roleid = prefix_role.id
            INNER JOIN prefix_user_enrolments ON prefix_user.id = prefix_user_enrolments.userid
            INNER JOIN prefix_enrol ON prefix_user_enrolments.enrolid = prefix_enrol.id
            INNER JOIN prefix_course ON prefix_course.id = prefix_enrol.courseid
        where
            prefix_course.id = c.id
    ) as "Usuarios inscritos"
FROM
    prefix_tag_instance as ti
    inner join prefix_tag as t on t.id = ti.tagid
    inner join prefix_course as c on ti.itemid = c.id
    inner join prefix_logstore_standard_log as l on l.courseid = c.id
where
    t.name like '%semipresencial%'
    and l.userid <> 566
    and l.userid <> 15032
    and l.userid <> 6
group by
    c.id
order by
    "Actividad total" desc