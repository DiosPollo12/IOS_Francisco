//
//  ContentView.swift
//  FranciscoRessume
//
//  Created by Alumno on 28/1/26.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Datos personales
    let nombre: String = "Francisco Vargas"
    let edad: Int = 21
    
    let experiencia: [String] = [
        "Proyecto 1",
        "Proyecto 2",
        "Proyecto 3"
    ]
    
    let educacion = (
        carrera: "Ingeniería en desarrollo de software",
        año: 2023,
        completada: true
    )
    
    // MARK: - Estados
    @State private var showAlert: Bool = false
    @State private var isEnabled: Bool = true
    @State private var valor: Double = 50
    
    // MARK: - Vista
    var body: some View {
        VStack(spacing: 16) {
            
            // FOTO DE PERFIL
            Image("fotoPerfil")
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 4)
                )
                .shadow(radius: 8)
            
            // NOMBRE Y EDAD
            VStack(spacing: 4) {
                Text(nombre)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Edad: \(edad)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            // EXPERIENCIA
            VStack(alignment: .leading, spacing: 8) {
                Text("Experiencia")
                    .font(.headline)
                
                ForEach(experiencia, id: \.self) { proyecto in
                    Text("• \(proyecto)")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            // FORMACIÓN ACADÉMICA
            VStack(alignment: .leading, spacing: 4) {
                Text("Formación académica")
                    .font(.headline)
                
                Text("\(educacion.carrera) - \(String(educacion.año))")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // BOTÓN DE CURSOS
            Button("Cursos") {
                showAlert = true
            }
            .buttonStyle(.borderedProminent)
            .alert("Cursos en 2025", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("""
                Curso 1: Desarrollo de apps en iOS
                Curso 2: Desarrollo de apps en Android
                Curso 3: Computación avanzada en Java
                """)
            }
            
            // PERFIL
            Toggle("Perfil", isOn: $isEnabled)
                .padding(.top)
            
            Text(isEnabled ? "Developer" : "Scrum Master")
                .font(.headline)
                .foregroundColor(isEnabled ? .green : .red)
            
            // SLIDER
            VStack {
                Text("Nivel: \(Int(valor))")
                Slider(value: $valor, in: 0...100, step: 1)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

