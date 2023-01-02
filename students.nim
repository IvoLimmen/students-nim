import strutils as str

type
  Course = object
    name: string
    grades: seq[int]

type
  Student = object
    name: string
    courses: seq[Course]

proc addGrade(self: Student, course: string, grade: int) =
  var added: bool = false
  echo self
  var list: seq[Course] = self.courses
  for c in list:
    if (c.name == course):
      echo "course exists"
      added = true
      var g : seq[int] = c.grades
      g.add(grade)
  if not added:
    echo "add new list"
    var g = newSeq[int](0)
    g.add(grade)
    echo g
    var c : Course = Course(name: course, grades: g)
    echo c
    var list: seq[Course] = self.courses
    list.add(c)
  echo self

proc show(self: Student) =
  echo "Grades for ", self.name
  echo self
  var list: seq[Course] = self.courses
  for c in list:
    var total: int
    var count: int
    var glist: seq[int] = c.grades
    for g in glist:
      total = total + g
      count = count + 1
    var avg = total / count
    echo c.name, " - ", count, " exams - ", avg, " avg"

proc help() =
  echo "Grading system"
  echo "add-student [name] - Add student"
  echo "select-student [name] - Select a student"
  echo "add-grade [course] [grade] - Add a grade for a course for the current selected student"
  echo "end - Stop the program"

var students: seq[Student]
var student: Student
var command: string

while command != "end":
  command = readLine(stdin)
  if command.startsWith("add-student"):
    var name: string = command.split(" ")[1]
    var c : seq[Course] = newSeq[Course](0)
    student = Student(name: name, courses: c)
    students.add(student)
  if command.startsWith("select-student"):
    var name: string = command.split(" ")[1]
    for item in students:
      if item.name == name:
        student = item
  if command.startsWith("add-grade"):
    var course: string = command.split(" ")[1]
    var grade: int = command.split(" ")[2].parseInt()
    student.addGrade(course, grade)
  if command.startsWith("help"):
    help()

for item in students:
  student.show()
  