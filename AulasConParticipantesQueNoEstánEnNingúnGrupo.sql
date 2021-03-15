select distinct
concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        course.id,
        '">',
        course.shortname,
        '</a>'
    ) as "Aula", course.shortname,
concat(
        '<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',
        u.id,
        '">',
        concat(u.lastname, ', ', u.firstname),
        '</a>'
    ) as "Apellido y Nombre del usuario",
u.firstname, u.lastname, u.username,
u.email as "Email del Usuario",
r.shortname as "Rol"
FROM
   prefix_course as course inner join prefix_course_categories as cat on course.category=cat.id
inner join prefix_context as c on c.instanceid=course.id and c.contextlevel=50
inner join prefix_role_assignments as ra on ra.contextid=c.id
inner join prefix_user as u on u.id= ra.userid
inner join prefix_role as r on r.id=ra.roleid
where cat.parent=247 and u.id not in 
(select gm.userid from prefix_course as course2 inner join prefix_groups as g on g.courseid=course2.id
left join prefix_groups_members as gm on gm.groupid=g.id and gm.userid=u.id where course2.id=course.id and gm.id is not null)
and r.shortname like 'student'
order by course.shortname, u.lastname, u.firstname
