SELECT
concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        course.id,
        '">',
        course.shortname,
        '</a>'
    ) as "Aula",
	concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        course.id,
        '&section=',cs.section,'">',
        cs.name,
        '</a>'
    ) as "Solapa",
	count (cm.id) as "Recursos por sección"
FROM prefix_course AS course
JOIN prefix_course_sections AS cs ON cs.course = course.id AND cs.section <= 14 AND cs.section > 0
LEFT JOIN prefix_course_modules AS cm ON cm.course = course.id AND cm.section = cs.id 
WHERE 
course.category=290 and cs.section=11
GROUP BY course.id,cs.id
ORDER BY "Recursos por sección"
