//
//  ContentView.swift
//  notizen
//
//  Created by Dominik Bussinger on 16.07.2024.
//

import SwiftUI
import SwiftData

@Model
class Notiz: ObservableObject {
    var id: UUID
    var inhalt: String
    
    init(inhalt: String) {
        self.id = UUID()
        self.inhalt = inhalt
    }
}

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Notiz.inhalt) private var notizen: [Notiz]
    @State private var notiz = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(notizen, id: \.id) { notiz in
                        Text(notiz.inhalt)
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let notizToDelete = notizen[index]
                            modelContext.delete(notizToDelete)
                        }
                    })
                }
                .navigationTitle("Notizen")
                HStack {
                    TextField("Neue Notiz", text: $notiz)
                    Button("Hinzufügen") {
                        let neueNotiz = Notiz(inhalt: notiz)
                        modelContext.insert(neueNotiz)
                        notiz = ""
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
}

