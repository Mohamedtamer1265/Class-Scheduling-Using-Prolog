:- consult('studentKB').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
slot_num(Day,Course,SN):-
    day_schedule(Day,L),
    slot_num_helper(L,Course,1,SN).

slot_num_helper([H|_],Course,Acc,Acc):-
    member(Course,H).

slot_num_helper([H|T],Course,Acc,SN):-
    \+member(Course,H),Acc1 is Acc+1,
    slot_num_helper(T,Course,Acc1,SN).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

student_schedule(student_id, X):-
    bagof(slot(Day,SN,Course),(studies(student_id,Course),slot_num(Day,Course,SN)),X).
