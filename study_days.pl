:- consult('publicKB').
study_days(Slots, DayCount):-
		setof(Day,allDays(Slots,Day),Days),
		list_length(Days,ActualDays),
		ActualDays=<DayCount.

allDays([slot(Day,_,_)|_],Day).
allDays([_|T],Day):- allDays(T,Day).
		
list_length([],0).
list_length([_|T],N):- length(T,N1),N is N1+1.