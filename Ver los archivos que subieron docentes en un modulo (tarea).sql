SELECT 
DISTINCT u.username as username,u.email,u.firstname,u.lastname,
course.shortname as course1,
r.shortname as role1,
ue.status as enrolstatus1,
f.*,cont.*,
a.*

FROM
prefix_course as course inner join prefix_context as c on c.instanceid=course.id /*and c.contextlevel=50*/
inner join prefix_role_assignments as ra on ra.contextid=c.id
inner join prefix_user as u on u.id= ra.userid
inner join prefix_role as r on r.id=ra.roleid
inner join prefix_user_enrolments as ue on ue.userid = u.id
inner join prefix_enrol as e on ue.enrolid=e.id and e.courseid = course.id
inner join prefix_files as f on f.userid = u.id
inner join prefix_context as cont on cont.id = f.contextid
inner join prefix_course_modules as cm on cm.id = cont.instanceid
inner join prefix_assign as a on a.id = cm.instance
WHERE 
	course.id in (13444)and (/*(r.shortname = 'student') or */(r.shortname = 'editingteacher')) and ue.status = 0
and	f.filesize > 0
and f.filearea = 'introattachment'
and a.name = 'Actividad Prueba1'
ORDER BY course1,enrolstatus1,role1,username
