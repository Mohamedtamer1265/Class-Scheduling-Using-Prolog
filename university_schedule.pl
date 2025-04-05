:- consult('studentKB').
:- consult('student_schedule')

university_schedule(S):-
    bagof(sched(student_id,Slots),student_schedule(student_id, Slots), S).
    
