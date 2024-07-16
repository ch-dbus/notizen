//
//  ContentView.swift
//  notizen
//
//  Created by Dominik Bussinger on 16.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State var notizen: [String] = ["Schwimmen", "Einkaufen"]
    @State var notiz = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(notizen, id: \.self) { notiz in
                    Text(notiz)
                }
                .onDelete(perform: { indexSet in
                    
                })
            }
            .navigationTitle("Notitzen")
            HStack {
                TextField("Neue Notiz", text: $notiz)
                Button("Hinzufügen") {
                    
                    notiz = ""
                }
            }.padding(.horizontal)
        }
    }
}
    

#Preview {
    ContentView()
}
