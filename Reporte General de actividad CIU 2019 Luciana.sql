SELECT
    (
        select
            count(id)
        from
            prefix_course
        where
            prefix_course.category = 61
    ) as "Cantidad de Aulas Sociedad y Vida Universitaria",
    (
        select
            count(id)
        from
            prefix_course
        where
            prefix_course.category = 65
    ) as "Cantidad de Aulas Matemática",
    (
        select
            count(id)
        from
            prefix_course
        where
            prefix_course.category = 64
    ) as "Cantidad de Aulas Lectura y Escritura",
    (
        select
            count(prefix_logstore_standard_log.id)
        from
            prefix_logstore_standard_log
            inner join prefix_course on prefix_logstore_standard_log.courseid = prefix_course.id
        where
            prefix_logstore_standard_log.eventname like '%course_viewed'
            AND prefix_course.category = 61
    ) as "Total Accesos Aulas de Sociedad y Vida Universitaria",
    (
        select
            count(prefix_logstore_standard_log.id)
        from
            prefix_logstore_standard_log
            inner join prefix_course on prefix_logstore_standard_log.courseid = prefix_course.id
        where
            prefix_logstore_standard_log.eventname like '%course_viewed'
            AND prefix_course.category = 65
    ) as "Total Accesos Aulas de Matemática",
    (
        select
            count(prefix_logstore_standard_log.id)
        from
            prefix_logstore_standard_log
            inner join prefix_course on prefix_logstore_standard_log.courseid = prefix_course.id
        where
            prefix_logstore_standard_log.eventname like '%course_viewed'
            AND prefix_course.category = 64
    ) as "Total Accesos Aulas de Lectura y Escritura",
    (
        select
            count(distinct prefix_logstore_standard_log.userid)
        from
            prefix_logstore_standard_log
            inner join prefix_course on prefix_logstore_standard_log.courseid = prefix_course.id
        where
            prefix_logstore_standard_log.eventname like '%course_viewed'
            AND prefix_course.category = 61
    ) as "Usuarios activos en Sociedad y Vida Universitaria",
    (
        select
            count(distinct prefix_logstore_standard_log.userid)
        from
            prefix_logstore_standard_log
            inner join prefix_course on prefix_logstore_standard_log.courseid = prefix_course.id
        where
            prefix_logstore_standard_log.eventname like '%course_viewed'
            AND prefix_course.category = 65
    ) as "Usuarios activos en Matemática",
    (
        select
            count(distinct prefix_logstore_standard_log.userid)
        from
            prefix_logstore_standard_log
            inner join prefix_course on prefix_logstore_standard_log.courseid = prefix_course.id
        where
            prefix_logstore_standard_log.eventname like '%course_viewed'
            AND prefix_course.category = 64
    ) as "Usuarios activos en Lectura y Escritura"