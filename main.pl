:- consult('publicKB').

%university_schedule
university_schedule(S) :-
    setof(Student, Course^studies(Student, Course), Students),
    maplist(generate_student_schedule, Students, S). %We used map liot to collect all resulting sched structures into the list S and we understood its format with the assistance of AI

generate_student_schedule(Student, sched(Student, Slots)) :-
    student_schedule(Student, Slots).
	
%student_schedule
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
	setof(Day,allDays(Slots,Day),Days),
	list_length(Days,ActualDays),
	ActualDays=<5,
	no_clashes(Slots).

student_schedule_helper([],[]):-!.
student_schedule_helper([H|T],[X|Y]):-
 	findSlot(H,X),
    student_schedule_helper(T,Y).


% noclashes
no_clashes([]).
no_clashes([slot(Day, Slot, _) | T]) :-
    \+ member(slot(Day, Slot, _), T),
    no_clashes(T).
	
% study_days
study_days(Slots, DayCount):-
		setof(Day,allDays(Slots,Day),Days),
		list_length(Days,ActualDays),
		ActualDays=<DayCount.

allDays([slot(Day,_,_)|_],Day).
allDays([_|T],Day):- allDays(T,Day).
		
list_length([],0).
list_length([_|T],N):- length(T,N1),N is N1+1.


% assembly_hours
assembly_hours(Schedules, AH) :-


% Collect all slots (including duplicates)
findall(slot(Day, SlotNumber), 
        (member(sched(_, Slots), Schedules),
         member(slot(Day, SlotNumber, _), Slots)), 
        Slots),

% Remove duplicates 
list_to_set(Slots, Occupied),


 % Define all possible slots per day 
findall(slot(Day, SlotNumber), 
        (member(Day, [saturday, sunday, monday, tuesday, wednesday, thursday]), 
         between(1, 5, SlotNumber)), 
        AllSlots),
		
% Find free slots (slots not in occupied slots)
    findall(slot(Day, SlotNumber), 
            (member(slot(Day, SlotNumber), AllSlots), 
             \+ member(slot(Day, SlotNumber), Occupied)), 
            FreeSlots),
			
	
valid_for_all(Schedules, FreeSlots, AH).


% Filters free slots based on study days
valid_for_all(Schedules, FreeSlots, AH) :-
    findall(slot(Day, SlotNumber),
            (member(slot(Day, SlotNumber), FreeSlots),
             study_day(Schedules, Day)), 
            AH).

% Ensures all students have at least one slot on that day
study_day(Schedules, Day) :-
    forall(
        member(sched(_, Slots), Schedules),
        member(slot(Day, _, _), Slots)
    ).