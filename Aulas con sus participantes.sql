select 
concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        course.id,
        '">',
        course.shortname,
        '</a>'
    ) as "Aula",
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
   prefix_course as course inner join prefix_context as c on c.instanceid=course.id and c.contextlevel=50
left join prefix_role_assignments as ra on ra.contextid=c.id
left join prefix_user as u on u.id= ra.userid
left join prefix_role as r on r.id=ra.roleid
where c.id=118413
order by course.shortname
