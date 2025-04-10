:- consult('publicKB').
:- consult('student_schedule').

university_schedule(S) :-
    setof(Student, Course^studies(Student, Course), Students),
    maplist(generate_student_schedule, Students, S). %We used map liot to collect all resulting sched structures into the list S and we understood its format with the assistance of AI

generate_student_schedule(Student, sched(Student, Slots)) :-
    student_schedule(Student, Slots).