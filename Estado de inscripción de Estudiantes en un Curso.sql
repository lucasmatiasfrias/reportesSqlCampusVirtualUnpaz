select 
concat(
        '<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',
        u.id,
        '">',
        concat(u.lastname, ', ', u.firstname),
        '</a>'
    ) as "Apellido y Nombre del usuario",
u.username as username,
u.email as email,
course.shortname as course1,
r.shortname as role1,
(select 
 concat(
        '<a target="_new" href="%%WWWROOT%%/enrol/editenrolment.php?contextid=',c.id,'&courseid=',course.id,'&ue=',ue.id,
        '">',
        concat('status:',ue.status,' - ',u.username),
        '</a>'
    )
 from prefix_user_enrolments as ue inner join prefix_enrol as e on ue.enrolid=e.id
where ue.userid=u.id and e.courseid=course.id) as enrolmentstatus
FROM
prefix_course as course inner join prefix_context as c on c.instanceid=course.id and c.contextlevel=50
inner join prefix_role_assignments as ra on ra.contextid=c.id
inner join prefix_user as u on u.id= ra.userid
inner join prefix_role as r on r.id=ra.roleid
where course.category=288 and r.shortname like 'student'
order by enrolmentstatus
