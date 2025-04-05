% Load knowledge base and helper file
:- consult('publicKB').
:- consult('no_clashes').
:- consult('study_days').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Day index mapping for sorting
day_index(saturday, 1).
day_index(sunday, 2).
day_index(monday, 3).
day_index(tuesday, 4).
day_index(wednesday, 5).
day_index(thursday, 6).
day_index(friday, 7).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom comparator for slot sorting
compare_slots(Order, slot(Day1, Num1, _), slot(Day2, Num2, _)) :-
    day_index(Day1, I1),
    day_index(Day2, I2),
    (
        I1 < I2 -> Order = '<'
    ;   I1 > I2 -> Order = '>'
    ;   Num1 < Num2 -> Order = '<'
    ;   Num1 > Num2 -> Order = '>'
    ;   Order = '='
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check if two slots clash
clashes(slot(Day, SlotNum, _), slot(Day, SlotNum, _)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract all slots related to a list of courses
course_slots(Courses, SlotList) :-
    findall(slot(Day, SlotNum, Course),
        (
            day_schedule(Day, Slots),
            nth1(SlotNum, Slots, SlotCourses),
            member(Course, SlotCourses),
            member(Course, Courses)
        ),
        SlotList).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Group slots by course
group_slots_by_course([], []).
group_slots_by_course([slot(Day, Num, C)|Rest], Result) :-
    group_slots_by_course(Rest, Temp),
    add_slot(C, slot(Day, Num, C), Temp, Result).

add_slot(Course, Slot, [], [Course-[Slot]]).
add_slot(Course, Slot, [Course-Slots | Rest], [Course-[Slot|Slots] | Rest]).
add_slot(Course, Slot, [OtherCourse-OtherSlots | Rest], [OtherCourse-OtherSlots | NewRest]) :-
    Course \= OtherCourse,
    add_slot(Course, Slot, Rest, NewRest).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate all possible one-slot-per-course combinations
select_one_slot_per_course([], []).
select_one_slot_per_course([_-Slots|Rest], [Chosen|ChosenRest]) :-
    member(Chosen, Slots),
    select_one_slot_per_course(Rest, ChosenRest).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choose one valid non-clashing schedule
valid_schedule(AllSlots, FinalSchedule) :-
    group_slots_by_course(AllSlots, Grouped),
    select_one_slot_per_course(Grouped, Candidate),
    no_clashes(Candidate),
    FinalSchedule = Candidate.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main predicate: student_schedule/2 (sorted result)
student_schedule(Student, SC) :-
    findall(C, studies(Student, C), Courses0),
    sort(Courses0, Courses),                    % Remove duplicates
    course_slots(Courses, SlotList),
    valid_schedule(SlotList, SC).
