# Class-Scheduling-Using-Prolog
# 📚 University Schedule Management (Prolog Project)

## 📌 Overview
This project is a **Prolog-based system** for managing university schedules. It includes predicates for handling student schedules, checking for clashes, and analyzing study days and assembly hours. The system ensures that students have a structured and conflict-free timetable.

## 🛠 Project Structure
```
📂 project-root/
├── 📄 README.md          # Project documentation
├── 📄 studentKB.pl       # Knowledge base (shared facts)
├── 📄 university_schedule.pl  # University schedule predicates
├── 📄 student_schedule.pl     # Student schedule predicates
├── 📄 no_clashes.pl           # Predicate to check for scheduling conflicts
├── 📄 study_days.pl           # Predicate to determine study days
├── 📄 assembly_hours.pl       # Predicate to calculate assembly hours
└── 📄 main.pl                 # Entry point to consult and run all predicates
```

## 🚀 Getting Started
### 1️⃣ Clone the Repository
```sh
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

### 2️⃣ Load the Knowledge Base and Predicates in SWI-Prolog
```prolog
?- [main].
```

### 3️⃣ Run Sample Queries
```prolog
?- university_schedule(X).
?- student_schedule(Y).
?- no_clashes(Student1, Student2).
?- study_days(Student, Days).
?- assembly_hours(Student, Hours).
```

## 📜 License
This project is **open-source**. Feel free to modify and use it under an appropriate license.

---
Happy Coding! 🚀

