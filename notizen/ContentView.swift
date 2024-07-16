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
    var events: [Event]
    
    init(inhalt: String) {
        self.id = UUID()
        self.inhalt = inhalt
        self.events = []
        
    }
}

@Model
class Event {
    var id: UUID
    var info: String
    var date: Date
    
    init(info: String, date: Date) {
        self.id = UUID()
        self.info = info
        self.date = date
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
                        NavigationLink(destination: NotizDetail(notiz: notiz)) {
                            Text(notiz.inhalt)
                                .swipeActions {
                                    Button("Delete", role: .destructive) {
                                        modelContext.delete(notiz)
                                    }
                                }
                        }
                    }
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

struct NotizDetail: View {
    
    @Bindable var notiz: Notiz
    @Environment(\.modelContext) private var modelContext

    
    var body: some View {
        VStack {
            TextField("Inhalt", text: $notiz.inhalt)
                .onAppear{
                    let event = Event(info: "Geöffnet", date: Date())
                    notiz.events.append(event)
                }
            List {
                ForEach(notiz.events) { event in
                    HStack{
                        Text(event.info)
                        Text("\(event.date)")
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        let event = notiz.events.remove(at: index)
                        modelContext.delete(event)
                    }
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
