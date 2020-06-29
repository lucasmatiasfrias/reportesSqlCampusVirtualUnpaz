-- Context
-- Here are the possible contexts, listed from the most general to the most specific.
-- A diagram of the contexts in Moodle. Click on the diagram to see a more detailed view of it.
-- CONTEXT NAME	CONTEXT AREA	CONTEXTLEVEL
-- CONTEXT_SYSTEM	the whole site	10
-- CONTEXT_USER	another user	30
-- CONTEXT_COURSECAT	a course category	40
-- CONTEXT_COURSE	a course	50
-- CONTEXT_MODULE	an activity module	70
-- CONTEXT_BLOCK	a block	80

select context.instanceid, c.shortname, a.name, u.username as dni, concat(u.lastname,', ' ,u.firstname) as nombre_y_apellido, ag.grade, 
(select description from mdl_gradingform_rubric_criteria where gfrl.criterionid=id and definitionid=gd.id) as criterio,
gfrl.definition
from 
(select * from mdl_context where contextlevel=70) as context
inner join mdl_grading_areas as ga on context.id=ga.contextid
inner join mdl_grading_definitions as gd on ga.id=gd.areaid
inner join mdl_grading_instances as gi on gi.definitionid=gd.id and gi.status = 1
inner join mdl_assign_grades as ag on ag.id=gi.itemid --El itemid de la instancia de calificación se corresponde con el id de assign_grades
inner join mdl_gradingform_rubric_fillings as gfrf on gfrf.instanceid=gi.id
inner join mdl_gradingform_rubric_levels as gfrl on  gfrl.id=gfrf.levelid
inner join mdl_user as u on ag.userid=u.id
inner join mdl_assign as a on a.id=ag.assignment
inner join mdl_course as c on c.id=a.course
where c.category=141 order by c.shortname, a.name, u.lastname, u.firstname
