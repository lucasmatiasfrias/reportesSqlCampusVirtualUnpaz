select 
concat(
        '<a target="_new" href="%%WWWROOT%%/course/management.php?categoryid=',
        cat.id,
        '">',
        getCategoryPath(cat.id),
        '</a>'
    ) as "Categoría",
c.id,
concat(
        '<a target="_new" href="%%WWWROOT%%/course/edit.php?id=',
        c.id,
        '">',
        c.shortname,
        '</a>'
    ) as "Aula virtual",
    c.summary,
    sum(CASE
               WHEN r.shortname like any(array ['teacher','editingteacher','teacherunpaz','editingteacherunpaz']) THEN 1
	       ELSE 0
	      END) as "Profesores",
     sum(CASE
               WHEN r.shortname like 'student' THEN 1
	       ELSE 0
	      END) as "Estudiantes",
c.visible
FROM
prefix_course as c 
inner join prefix_course_categories as cat on cat.id=c.category
inner join prefix_context as context on context.contextlevel=50 and c.id=context.instanceid
left join prefix_role_assignments as asg on asg.contextid=context.id
left join prefix_role as r on r.id=asg.roleid
where cat.parent=174 or (c.shortname like any (array['%_2019-2C', '_2019-2° Cuatrimestre']) and c.summary ilike '%anual%') or c.shortname ilike '%2020/1.2%' and c.category <> 177
group by c.id, cat.id
order by 
 c.visible,"Categoría", "Aula virtual"
