//
//  main.swift
//  Clase_12
//
//  Created by Alumno on 22/4/26.
//

import Foundation

/*
// Ejercicio 1
struct Student {
    let id: Int
    let name:String
    let age: Int
    let email: String
}

func creaeteStudent(id: Int, name:String, age: Int, email:String) -> Student? {
    guard !name.isEmpty else {
        print("El nombre no puede ser vacio")
        return nil
    }
    
    guard age > 16 else {
        print("La edad no puede ser menor a 16")
        return nil
    }
    
    guard email.contains("@") else {
        print("El correo no es valido")
        return nil
    }
    
    let student = Student (id: id, name: name, age: age, email: email)
    return student
}

if let student1 = creaeteStudent(id: 1, name: "Alan", age: 22, email: "alan@gmail.com") {
    print("Estudiante \(student1)")
}

if let student2 = creaeteStudent(id: 2, name: "Adrian", age: 21, email: "adr@gmail.com") {
    print("Estudiante \(student2)")
}
*/

// Ejercicio 2 - Crea un enum AcademicStatus con:
/* Aprobado
    Reprobado
    Excelente
 
    Despues crea un struct StudentRecord con:
        NOMBRE
        Arreglo de Calificaciones en base a 10
 
    Debe de tener:
        - Una propiedad computada average
        - Una propiedad computada status
 
    Reglas:
    - Si promedio menor a 6: Reprobado
    - Si promedioo entre 6 y 8.9: Aprobado
    - Si promedio desde 9: Excelente*/


enum AcademicStatus: String {
    case aprobado = "Aprobado"
    case reprobado = "Reprobado"
    case excelente = "Excelente"
}

struct StudentRecord {
    let name: String
    let grades: [Double]
    
    // Propiedad Computada
    var average: Double {
        var suma: Double = 0 // Incia en 0
        for grade in self.grades  {
            suma += grade
        }
        
        return suma / Double(grades.count)
    }
    
    var status: AcademicStatus {
        switch average {
        case ..<6:  // Toma el valor anterior del switch
            return AcademicStatus.reprobado
        
        case ..<9:
            return .excelente //El mismo atributo devuelve un AcademicStatus, al poner un "." se completa
        
        default:
            return .aprobado
        }
    }
}

// Testing of Software
let record1 = StudentRecord (name: "Adrian", grades: [8.0, 7.5, 8.5])
print("Promedio de \(record1.name) es \(record1.average)")
print("Estado: \(record1.status)")

let record2 = StudentRecord (name: "Adrian", grades: [9.0, 9.5, 8.9])
print("Promedio de \(record2.name) es \(record2.average)")
print("Estado: \(record2.status)")

let record3 = StudentRecord (name: "Adrian", grades: [2.0, 6.5, 4.5])
print("Promedio de \(record3.name) es \(record3.average)")
print("Estado: \(record3.status)")
