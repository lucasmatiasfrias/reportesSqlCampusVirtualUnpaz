-- grado y pregrado 2020 1º Cuatrimestre
select 
count(distinct c.id) as "Total de aulas virtuales",
COUNT(DISTINCT CASE WHEN r.shortname like any(array ['teacher','editingteacher','teacherunpaz','editingteacherunpaz']) THEN asg.userid END) as "Total de Profesores",
COUNT(DISTINCT CASE WHEN r.shortname like 'student' THEN asg.userid END) as "Total de Estudiantes"
FROM
prefix_course as c 
inner join prefix_course_categories as cat on cat.id=c.category
inner join prefix_context as context on context.contextlevel=50 and c.id=context.instanceid
left join prefix_role_assignments as asg on asg.contextid=context.id
left join prefix_role as r on r.id=asg.roleid
where cat.parent=174 or (c.shortname like any (array['%_2019-2C', '_2019-2° Cuatrimestre']) and c.summary ilike '%anual%') or c.shortname ilike '%2020/1.2%' and c.category <> 177
