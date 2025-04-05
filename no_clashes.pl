:- consult('studentKB').

contains(slot(Day,Slot,_),[slot(Day,Slot,_)|T])
contains(slot(Day,Slot,_),[slot(Day2,Slot2,_)|T]):-
    (Day2 \= Day;Slot2 \= Slot),
    contains(slot(Day,Slot,_),T).