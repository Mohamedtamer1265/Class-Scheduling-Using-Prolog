:- consult('publicKB').
:- consult('student_schedule').

findStudents(Students):-
    setof(Student, Subject^studies(Student, Subject), Students).

university_schedule(S):-
    findStudents(Students),
    university_schedule_helper(Students,S).

university_schedule_helper([],[]):-!.
university_schedule_helper([H|T],[X|Y]):-
    student_schedule(H,X),
    university_schedule_helper(T,Y).