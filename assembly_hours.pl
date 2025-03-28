:- consult('studentKB').

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