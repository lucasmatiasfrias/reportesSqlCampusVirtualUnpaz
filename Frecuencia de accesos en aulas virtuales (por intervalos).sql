select
    c.shortname as "Aula",
    (
        select
            count(distinct ue.userid)
        from
            prefix_enrol as e
            inner join prefix_user_enrolments as ue on e.id = ue.enrolid
            left join prefix_user_lastaccess as la on (
                la.courseid = c.id
                and la.userid = ue.userid
            )
        where
            (
                to_timestamp(la.timeaccess) between now() - interval '15 days'
                and now()
            )
            and e.courseid = c.id
    ) as "Hasta 15 días",
    (
        select
            count(distinct ue.userid)
        from
            prefix_enrol as e
            inner join prefix_user_enrolments as ue on e.id = ue.enrolid
            left join prefix_user_lastaccess as la on (
                la.courseid = c.id
                and la.userid = ue.userid
            )
        where
            (
                to_timestamp(la.timeaccess) between now() - interval '30 days'
                and now() - interval '15 days'
            )
            and e.courseid = c.id
    ) as "de 15 a 
 30 días",
    (
        select
            count(distinct ue.userid)
        from
            prefix_enrol as e
            inner join prefix_user_enrolments as ue on e.id = ue.enrolid
            left join prefix_user_lastaccess as la on (
                la.courseid = c.id
                and la.userid = ue.userid
            )
        where
            (
                to_timestamp(la.timeaccess) between now() - interval '45 days'
                and now() - interval '30 days'
            )
            and e.courseid = c.id
    ) as "de 30 a 
 45 días",
    (
        select
            count(distinct ue.userid)
        from
            prefix_enrol as e
            inner join prefix_user_enrolments as ue on e.id = ue.enrolid
            left join prefix_user_lastaccess as la on (
                la.courseid = c.id
                and la.userid = ue.userid
            )
        where
            (
                to_timestamp(la.timeaccess) between now() - interval '60 days'
                and now() - interval '45 days'
            )
            and e.courseid = c.id
    ) as "de 45 a 
 60 días",
    (
        select
            count(distinct ue.userid)
        from
            prefix_enrol as e
            inner join prefix_user_enrolments as ue on e.id = ue.enrolid
            left join prefix_user_lastaccess as la on (
                la.courseid = c.id
                and la.userid = ue.userid
            )
        where
            (
                to_timestamp(la.timeaccess) between now() - interval '600 days'
                and now() - interval '60 days'
            )
            and e.courseid = c.id
    ) as "Mas de 60 días",
    (
        select
            count(distinct ue.userid)
        from
            prefix_enrol as e
            inner join prefix_user_enrolments as ue on e.id = ue.enrolid
            left join prefix_user_lastaccess as la on (
                la.courseid = c.id
                and la.userid = ue.userid
            )
        where
            la.timeaccess is null
            and e.courseid = c.id
    ) as "Nunca"
from
    prefix_course as c
where
    (
        c.shortname like '%Derecho y Ciencias Políticas%'
        or c.shortname like '%Taller de escritura y argumentación%'
    )
    and c.shortname like '%_2019-2C%'
    and c.id <> 973
order by
    c.shortname