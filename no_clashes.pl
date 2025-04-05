:- consult('publicKB').
no_clashes([]).
no_clashes([slot(Day, Slot, _)|T]) :-
    \+ member(slot(Day, Slot, _), T),
    no_clashes(T).