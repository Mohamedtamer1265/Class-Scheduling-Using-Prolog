:- consult('publicKB').

student_schedule(StudentID, Schedule) :-
    findall(Course, studies(StudentID, Course), Courses),
    build_schedule(Courses, [], Schedule),
    no_clashes(Schedule).

build_schedule([], Acc, Acc).
build_schedule([Course | Rest], Acc, Schedule) :-
    day_schedule(Day, DaySchedule),
    nth1(SlotNum, DaySchedule, CourseList),
    member(Course, CourseList),
    build_schedule(Rest, [slot(Day, SlotNum, Course) | Acc], Schedule).
