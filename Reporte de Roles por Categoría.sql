select 
concat(
        '<a target="_new" href="%%WWWROOT%%/admin/roles/assign.php?contextid=',
        c.id,
        '">',
        getCategoryPath(cat.id),
        '</a>'
    ) as "Categoría",
concat(
        '<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',
        u.id,
        '">',
        concat(u.lastname, ', ', u.firstname),
        '</a>'
    ) as "Nombre de usuario",
concat(u.lastname, ', ', u.firstname) as "Apellido y Nombre del usuario",
r.name as "Rol"
from prefix_role_assignments as ra
inner join prefix_context as c on c.id=ra.contextid
inner join prefix_course_categories as cat on c.contextlevel=40 and cat.id=c.instanceid
inner join prefix_user as u on ra.userid=u.id
inner join prefix_role as r on r.id=ra.roleid
order by "Categoría", "Rol", "Apellido y Nombre del usuario"
