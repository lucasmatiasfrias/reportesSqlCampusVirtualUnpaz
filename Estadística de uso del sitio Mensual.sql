select
    stats.userid as id_usuario,
    to_timestamp(stats.timeend) as fecha_y_hora,
    stats.stattype as tipo_de_estadística,
    course.fullname as curso
from
    prefix_stats_user_daily as stats
    inner join prefix_course as course on course.id = stats.courseid
where
    course.id = 1
    and stats.stattype like 'activity'
order by
    fecha_y_hora asc