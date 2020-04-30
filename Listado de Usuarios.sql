SELECT
    u.username as usuario,
    u.firstname as nombre,
    u.lastname as apellido,
    u.email
FROM
    prefix_user AS u
ORDER BY
    u.username ASC