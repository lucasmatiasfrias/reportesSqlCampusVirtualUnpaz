select distinct
concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        course.id,
        '">',
        course.shortname,
        '</a>'
    ) as "Aula",
concat(
        '<a target="_new" href="%%WWWROOT%%/mod/forum/view.php?id=',
        cm.id,
        '">',
        f.name,
        '</a>'
    ) as "Foro",
concat(
        '<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',
        u.id,
        '">',
        concat(u.lastname, ', ', u.firstname),
        '</a>'
    ) as "Apellido y Nombre del usuario",
u.username
FROM
   prefix_course as course inner join prefix_context as c on c.instanceid=course.id and c.contextlevel=50
inner join (select *
    from prefix_course_modules
    where module=9 and deletioninprogress=0) as cm on cm.course=course.id
inner join prefix_forum as f on f.course=course.id and f.id=cm.instance
inner join prefix_role_assignments as ra on ra.contextid=c.id
inner join prefix_user as u on u.id= ra.userid
left join prefix_forum_discussions as d on d.forum=f.id and d.userid=ra.userid
left join prefix_forum_posts as p on d.id = p.discussion and p.userid=ra.userid
where course.category=198 and f.name ilike 'foro 1' and d.id is null and p.id is null
order by "Aula", "Foro", "Apellido y Nombre del usuario"
