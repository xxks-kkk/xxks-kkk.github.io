connect to testdb;
drop table p1.subject_selection;
create table p1.subject_selection (subject VARCHAR(30), Semester VARCHAR(30), Attendee VARCHAR(30));
insert into p1.subject_selection values ('ITB001', 1, 'John'), 
       ('ITB001', 1, 'Bob'), 
       ('ITB001', 1, 'Mickey'), 
       ('ITB001', 2, 'Jenny'), 
       ('ITB001', 2, 'James'), 
       ('MKB114', 1, 'John'), 
       ('MKB114', 1, 'Erica');
select * from p1.subject_selection;

select subject, count(*) from p1.subject_selection group by subject;

select subject, semester, count(*) from p1.subject_selection group by subject, semester;
