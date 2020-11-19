select
concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        c.id,
        '">',
        c.shortname,
        '</a>'
    ) as "Aula Virtual",
concat(
        '<a target="_new" href="%%WWWROOT%%/mod/assign/view.php?id=',
        cm.id,
        '">',
        a.name,
        '</a>'
    ) as "Tarea",
concat(
        '<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',
        student.id,
        '">',
        concat(student.lastname,', ' ,student.firstname),
        '</a>'
    ) as "Estudiante",
concat(
        '<a target="_new" href="%%WWWROOT%%/mod/assign/view.php?id=',cm.id,'&rownum=0&action=grader&userid=',
        student.id,
        '">',
        g.grade,
        '</a>'
    ) as "Calificación Numérica",
concat(
        '<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',
        grader.id,
        '">',
        concat(grader.lastname,', ' ,grader.firstname),
        '</a>'
    ) as "Calificado por"
from prefix_assign as a 
inner join prefix_course_modules as cm on cm.module=1 and a.id=cm.instance
inner join prefix_assign_grades as g on a.id=g.assignment
inner join prefix_user as student on student.id=g.userid
inner join prefix_user as grader on grader.id=g.grader
inner join prefix_course as c on c.id=cm.course
where cm.id in (150567,133974,150486,134053,150561,133906,150393,133940)
order by "Aula Virtual", "Tarea", "Estudiante"
