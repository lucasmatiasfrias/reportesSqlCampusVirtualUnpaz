Select concat(
        '<a target="_new" href="%%WWWROOT%%/course/view.php?id=',
        c.id,
        '">',
        c.fullname,
        '</a>'
    ) as "Aula Virtual",
(
        SELECT
            COALESCE(sum(m.count), 0)
        from
            (
                SELECT
                    (
                        Select
                            count(distinct p.userid)
                        from
                            prefix_forum_discussions as d
                            inner join prefix_forum_posts as p on d.id = p.discussion
                        where
                            d.forum = f.id
                    )
                from
                    prefix_forum as f
                where
                    f.course = c.id
                    and f.name like 'Foro de presentación'
                group by
                    f.id
            ) as m
    )
from prefix_course as c 
where c.category =129
