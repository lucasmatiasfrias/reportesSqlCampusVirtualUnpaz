select 
concat(
        '<a target="_new" href="%%WWWROOT%%/course/management.php?categoryid=',
        cat.id,
        '">',
        getCategoryPath(cat.id),
        '</a>'
    ) as "Categoría",
concat(
        '<a target="_new" href="%%WWWROOT%%/course/edit.php?id=',
        c.id,
        '">',
        c.shortname,
        '</a>'
    ) as "Aula virtual",
c.fullname,
    c.summary,
    c.visible,
    to_timestamp(c.startdate) as "Fecha de inicio",
    to_timestamp(c.enddate) as "Fecha de fin",
    sum(CASE
               WHEN r.shortname like any(array ['teacher','editingteacher']) THEN 1
	       ELSE 0
	      END) as "Profesores",
     sum(CASE
               WHEN r.shortname like 'student' THEN 1
	       ELSE 0
	      END) as "Estudiantes"
FROM
prefix_course as c 
inner join prefix_course_categories as cat on cat.id=c.category
inner join prefix_context as context on context.contextlevel=50 and c.id=context.instanceid
inner join prefix_role_assignments as asg on asg.contextid=context.id
inner join prefix_role as r on r.id=asg.roleid
where cat.parent=144
group by c.id, cat.id
order by "Categoría", "Aula virtual"
