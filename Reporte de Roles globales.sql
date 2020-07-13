select 
case when c.id=1 then 'UNPAZ - Campus virtual (Sitio)' end as "Contexto",
concat(
        '<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',
        u.id,
        '">',
        concat(u.lastname, ', ', u.firstname),
        '</a>'
    ) as "Nombre de usuario",
concat(u.lastname, ', ', u.firstname) as "Apellido y Nombre del usuario",
r.name as "Rol",
concat(
        '<a target="_new" href="%%WWWROOT%%/admin/roles/assign.php?contextid=',c.id,'&roleid=',
       r.id,
        '">',
        r.shortname,
        '</a>'
    ) as "Rol shortname"
from prefix_role_assignments as ra
inner join prefix_context as c on c.id=ra.contextid
inner join prefix_user as u on ra.userid=u.id
inner join prefix_role as r on r.id=ra.roleid
where ra.contextid=1 and c.contextlevel=10
order by "Rol", "Apellido y Nombre del usuario"
