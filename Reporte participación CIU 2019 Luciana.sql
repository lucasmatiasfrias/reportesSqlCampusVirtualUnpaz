select
    getCategoryPath(c.category) as Carrera,
    c.id,
    c.fullname as "Aula Virtual",
    c.summary as "Descripción",
    (
        select
            count (userid)
        from
            prefix_user_enrolments as ue
            inner join prefix_enrol as e on ue.enrolid = e.id
        where
            e.courseid = c.id
    ) as "Participantes inscritos",
    (
        select
            count (distinct userid)
        from
            prefix_logstore_standard_log
        where
            courseid = c.id
    ) as "Usuarios Activos",
    (
        select
            count (distinct userid)
        from
            prefix_logstore_standard_log
        where
            courseid = c.id
            and component like '%forum%'
    ) as "Participaron en Foros",
    (
        select
            count (distinct userid)
        from
            prefix_logstore_standard_log
        where
            courseid = c.id
            and component like '%assign%'
    ) as "Participaron en Tareas"
from
    prefix_course as c
    inner join prefix_logstore_standard_log as l on c.id = l.courseid
where
    getCategoryPath(c.category) like '%CIU%'
    and to_timestamp(l.timecreated) between '2019-03-04'
    and '2019-06-30'
    and l.userid not in (
        19341,
        19431,
        16346,
        5803,
        16085,
        1046,
        6915,
        5,
        11,
        6794,
        4,
        6916,
        16506,
        6,
        1603
    )
group by
    c.id
order by
    c.category,
    c.fullname