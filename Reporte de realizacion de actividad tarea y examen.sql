select
course.shortname,
concat(
        '<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',
        u.id,
        '">',
        concat(u.lastname, ', ', u.firstname),
        '</a>'
    ) as "Apellido y Nombre del usuario",
u.firstname, u.lastname, u.username,
u.email as "Email del Usuario",
r.shortname as "Rol",
(
  select sub.status from prefix_assign as a 
  inner join prefix_assign_submission as sub 
  on a.course=course.id and a.id=sub.assignment and sub.userid=u.id
  where a.name like '%Trabajo Práctico Individual y Obligatorio - Sociedad y Vida Universitaria%'
  and sub.latest=1
) as "Trabajo Práctico Individual y Obligatorio - Sociedad y Vida Universitaria",
(
  select sub.status from prefix_assign as a 
  inner join prefix_assign_submission as sub 
  on a.course=course.id and a.id=sub.assignment and sub.userid=u.id
  where a.name like '%TP del Taller de Lectura y Escritura%'
  and sub.latest=1
) as "TP del Taller de Lectura y Escritura",
(
  select count(attempts.id) from prefix_quiz as q 
  inner join prefix_quiz_attempts as attempts 
  on q.course=course.id and q.id=attempts.quiz and attempts.userid=u.id
  where q.name like '%TP Unidad 1%'
) as "TP Unidad 1"
FROM
   prefix_course as course inner join prefix_context as c on c.instanceid=course.id and c.contextlevel=50
   left join prefix_role_assignments as ra on ra.contextid=c.id
   left join prefix_user as u on u.id= ra.userid
   left join prefix_role as r on r.id=ra.roleid
where course.category in (290,291,292) and r.shortname like 'student'
order by u.lastname, u.firstname
