SELECT
    prefix_course_categories.name as categoria,
    prefix_course.fullname as curso,
    to_timestamp(prefix_course.startdate) as fecha_inicio,
    to_timestamp(prefix_course.timecreated) as fecha_creacion
FROM
    prefix_course
    INNER JOIN prefix_course_categories ON prefix_course.category = prefix_course_categories.id
ORDER BY
    prefix_course.startdate