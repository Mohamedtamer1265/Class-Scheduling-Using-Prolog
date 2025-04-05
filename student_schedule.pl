% Load knowledge base and helper file
:- consult('publicKB').
:- consult('no_clashes').

findSlot(Subject,slot(Day,SlotNumber,Subject)):-
    day_schedule(Day,Schedule),
    found(Subject,Schedule,1,SlotNumber).

found(Subject,[H|_],Index,Index):- member(Subject,H),!.
found(Subject,[_|T],Index,SlotNumber):-
    NextIndex is Index+1,
    found(Subject,T,NextIndex,SlotNumber).

findSubjects(Student_id,L):-
    findall(Subject,studies(Student_id,Subject),L).

student_schedule(Student_id,Slots):-
    findSubjects(Student_id,Subjects),
    permutation(Subjects,NewSubjects),
    student_schedule_helper(NewSubjects,Slots),
	no_clashes(Slots).

student_schedule_helper([],[]):-!.
student_schedule_helper([H|T],[X|Y]):-
 	findSlot(H,X),
    student_schedule_helper(T,Y).
