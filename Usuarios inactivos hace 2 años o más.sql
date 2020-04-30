select
    username,
    firstname,
    lastname,
    email,
    to_timestamp(lastaccess) as ultimo_acceso
from
    prefix_user
where
    to_timestamp(lastaccess) < (NOW() - INTERVAL '2 years')
    and deleted = 0
order by
    lastaccess