//
//  Homework.swift
//  Clase_12
//
//  Created by Alumno on 22/4/26.
//

enum CourseLevel: String {
    case basic = "Basico"
    case intermediate = "Intermedio"  
    case advanced = "Avanzado"
}

// Add enum for academicState (require)
enum AcademicStatus: String {
    case reprobado = "Reprobado"
    case aprobado = "Aprobado"
    case excelente = "Excelente"
}

struct Student {
    let id: Int
    let name: String
    let age: Int
    let email: String
}

class Course {  
    let code: String
    let name: String
    let level: CourseLevel
    let MaxCapacity: Int
    var registered: [Student]

    // Add computed property
    var availableSpots: Int {
        return MaxCapacity - registered.count
    }
    
    // Constructor
    init(code: String, name: String, level: CourseLevel, MaxCapacity: Int) {
        self.code = code
        self.name = name
        self.level = level
        self.MaxCapacity = MaxCapacity
        self.registered = []
    }
    
    func registered(student: Student) -> Bool {
        // Add Validate: Avoid duplicates
        for existingStudent in registered {
            if existingStudent.id == student.id {
                print("The student is already enrolled in this course")
                return false
            }
        }
        
        if registered.count < MaxCapacity {
            registered.append(student)
            return true
        }
        
        // Si es Falso para que no pase en Sistema
        return false
    }
}

// Class Registered
class Registered_Course {
    let student: Student
    let course: Course  
    var grades: [Double]
    
    // Añadir propiedad academicStatus
    var academicStatus: AcademicStatus {
        let avg = average
        if avg >= 9 {
            return .excelente
        } else if avg >= 6 {
            return .aprobado
        } else {
            return .reprobado
        }
    }
    
    init(student: Student, course: Course) {  
        self.student = student
        self.course = course
        self.grades = []
    }
    
    var average: Double {
        if grades.isEmpty {
            return 0.0
        }
        
        var sum = 0.0
        for grade in grades {
            sum += grade
        }
        
        return sum / Double(grades.count)
    }
    
    func addGrade(grade: Double) {
        // Add: guard for validate grade
        guard grade >= 0 && grade <= 10 else {
            print("The grade must be between 0 & 10")
            return
        }
        grades.append(grade)
        print("Grade \(grade) added to \(student.name)")
    }
}

class CampusSystem {
    var students: [Student]
    var courses: [Course]  
    var registeredCourse: [Registered_Course]
    
    init() {
        self.students = []
        self.courses = []
        self.registeredCourse = []
    }
    
    func AddStudent(student: Student) {
        guard !student.name.isEmpty else {
            print("The name of sudent can't be empty")
            return
        }
        
        guard student.age >= 16 else {
            print("You must be at least 16 years old ")
            return
        }
        
        guard student.email.contains("@") else {
            print("The email can't be validate")
            return
        }

        // Add: Validate to avoid duplicates
        for existingStudent in students {
            if existingStudent.id == student.id {
                print("A student with that ID already exists")
                return
            }
        }
        
        // AddStudent
        students.append(student)
        print("Student \(student.name) add corrected")
        print("")
    }
    
    func AddCourse(course: Course) {  
        for existingCourse in courses {
            if existingCourse.code == course.code {
                print("A course with that code already exists")
                return  
            }
        }

        courses.append(course) 
        print("Course \(course.name) add corrected")  
        print("")
    }
    
    func Record(studentID: Int, codeCourse: String) {
        // Find a student
        var foundStudent: Student?
        for student in students {
            if student.id == studentID {
                foundStudent = student
                break 
            }
        }

        guard let student = foundStudent else {
            print("Student not found")
            return
        }

        // Found a Course
        var foundCourse: Course?
        for course in courses {
            if course.code == codeCourse {
                foundCourse = course
                break
            }
        }

        guard let course = foundCourse else {
            print("Course not found")
            return
        }

        // Check if you are already registered
        for enrollment in registeredCourse {
            if enrollment.student.id == studentID && enrollment.course.code == codeCourse {
                print("The student is already enrolled in this course")
                return 
            }
        }

        // Try to register
        if course.registered(student: student) {
            let newEnrollment = Registered_Course(student: student, course: course)

            registeredCourse.append(newEnrollment) 
            print("Registration successful\n") 
        } else {
            print("Registration is not available. The class is full")
        }
    }
    
    func AddGrades(studentID: Int, codeCourse: String, grade: Double) {
        var targetEnrollment: Registered_Course?
        for enrollment in registeredCourse {
            if enrollment.student.id == studentID && enrollment.course.code == codeCourse {
                targetEnrollment = enrollment
                break 
            }
        }

        guard let enrollment = targetEnrollment else {
            print("No enrollment record was found for this student in this course")
            return 
        }

        enrollment.addGrade(grade: grade)
    }

    // Show Final Report
    func ShowFinalReport() {
        print("\n=== FINAL REPORT ===")

        if registeredCourse.isEmpty {
            print("There are no entries on record")
            return 
        }

        for enrollment in registeredCourse {
            print("Student: \(enrollment.student.name)")
            print("Course: \(enrollment.course.name)")
            print("Grades: \(enrollment.grades)")
            print("Average: \(enrollment.average)")
            print("State: \(enrollment.academicStatus.rawValue)")
            print("----------------------")
        }
    }    
}
    

// Students
let estudiante1 = Student(id: 1, name: "Ana", age: 20, email: "ana@gmail.com")
let estudiante2 = Student(id: 2, name: "Charly", age: 21, email: "charl@gmail.com")
let estudiante3 = Student(id: 3, name: "Alberch", age: 23, email: "alberch@gmail.com")

// Create Courses - CORREGIDO: todos usan Course
let course1 = Course(code: "SW101", name: "Swift Basic", level: .basic, MaxCapacity: 2)
let course2 = Course(code: "SW102", name: "Swift Intermediate", level: .intermediate, MaxCapacity: 3)  // Corregido spelling
let course3 = Course(code: "SW103", name: "Swift Advanced", level: .advanced, MaxCapacity: 2)

// Create System
let system = CampusSystem()

// System testing
system.AddStudent(student: estudiante1)
system.AddStudent(student: estudiante2)
system.AddStudent(student: estudiante3)

system.AddCourse(course: course1)
system.AddCourse(course: course2)
system.AddCourse(course: course3)

system.Record(studentID: 1, codeCourse: "SW101")
system.AddGrades(studentID: 1, codeCourse: "SW101", grade: 9.5)
system.AddGrades(studentID: 1, codeCourse: "SW101", grade: 9.0)

system.Record(studentID: 2, codeCourse: "SW102")
system.AddGrades(studentID: 2, codeCourse: "SW102", grade: 8.0)
system.AddGrades(studentID: 2, codeCourse: "SW102", grade: 8.5)

system.Record(studentID: 3, codeCourse: "SW103")
system.AddGrades(studentID: 3, codeCourse: "SW103", grade: 6.0)
system.AddGrades(studentID: 3, codeCourse: "SW103", grade: 4.5)
system.ShowFinalReport()
