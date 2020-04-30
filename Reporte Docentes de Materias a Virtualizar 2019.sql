SELECT
    DISTINCT prefix_user.username AS nombre_usuario,
    prefix_user.firstname AS nombre,
    prefix_user.lastname AS apellido,
    prefix_user.email AS email,
    prefix_course.fullname AS curso
FROM
    (
        (
            prefix_user
            INNER JOIN prefix_user_enrolments ON prefix_user.id = prefix_user_enrolments.userid
        )
        INNER JOIN prefix_enrol ON prefix_user_enrolments.enrolid = prefix_enrol.id
    )
    INNER JOIN prefix_course ON prefix_course.id = prefix_enrol.courseid
where
    prefix_user.email like 'lau_gsa@yahoo.com.ar'
    or prefix_user.email like 'dariofederman@hotmail.com'
    or prefix_user.email like 'vgrondo@gmail.com'
    or prefix_user.email like 'mariano.beltra@gmail.com'
    or prefix_user.email like 'bdomattoconti@gmail.com'
    or prefix_user.email like 'federicomarco.1@gmail.com'
    or prefix_user.email like 'guillermoraulferron@gmail.com'
    or prefix_user.email like 'dlaguirrenegrete@gmail.com'
    or prefix_user.email like 'vh_contre@yahoo.com.ar'
    or prefix_user.email like 'vcontreras@unpaz.edu.ar'
    or prefix_user.email like 'dafernandez@gmail.com'
    or prefix_user.email like 'lucas.guaycochea@gmail.com'
    or prefix_user.email like 'cristianciarallo@gmail.com'
    or prefix_user.email like 'mdferreyra@hotmail.com'
    or prefix_user.email like 'jefunesc@yahoo.com.ar'
    or prefix_user.email like 'jefunesc@gmail.com'
    or prefix_user.email like 'lc_moyano@hotmail.com'
    or prefix_user.email like 'ferjamartini@gmail.com'
    or prefix_user.email like 'gachapur@gmail.com'
    or prefix_user.email like 'pablovannini@gmail.com'
    or prefix_user.email like 'm_cormick@yahoo.com.ar'
    or prefix_user.email like 'hrdd@hdosso.com.ar'
    or prefix_user.email like 'lucianaunpaz@gmail.com'
    or prefix_user.email like 'j@javierbilatz.com.ar'
    or prefix_user.email like 'tagnindario@yahoo.com.ar'
    or prefix_user.email like 'castrillo.work@gmail.com'
    or prefix_user.email like 'andres.rabosto87@gmail.com'
    or prefix_user.email like 'pablovannini@gmail.com'
    or prefix_user.email like 'j@javierbilatz.com.ar'
    or prefix_user.email like 'tagnindario@yahoo.com.ar'
    or prefix_user.email like 'cianiwalter@gmail.com'
    or prefix_user.email like 'castrillo.work@gmail.com'
    or prefix_user.email like 'hrdd@hdosso.com.ar'
ORDER BY
    nombre_usuario