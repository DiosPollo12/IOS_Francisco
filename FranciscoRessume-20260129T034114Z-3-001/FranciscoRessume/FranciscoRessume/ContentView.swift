//
//  ContentView.swift
//  FranciscoRessume
//
//  Created by Alumno on 28/1/26.
//

import SwiftUI

struct ContentView: View {
    var Nombre = "Francisco"
    let Edad = 21
    var Experiencia = ["Proyecto 1", "Proyecto 2", "Proyecto 3"]
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Nombre: \(Nombre) \nEdad: \(Edad)")
            
            ForEach (Experiencia, id: \.self) { proyecto in
                Text("\(proyecto)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
