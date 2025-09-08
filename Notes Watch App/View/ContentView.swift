

import SwiftUI

struct ContentView: View {
    //MARK: - PROPRTIES
    @State private var notes: [Note] = [Note]()
    
    @State private var text: String = ""
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    //MARK: - FUNCTIONS
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }//end getDocumentDirectory func
    
    func save() {
        do {
            // 1. Convert the notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            // 2. Create a new URL to save the file using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            // 3. Write the data to the giving URL
            try data.write(to: url)
            
        } catch {
            print("Saving data has failed!.")
        }
    }//end save func
    
    func load() {
        DispatchQueue.main.async {
            do {
                // 1. Get the notes URL path
                let url = getDocumentDirectory().appendingPathComponent("notes")

                // 2. Create a new property for the data
                let data = try Data(contentsOf: url)
                
                // 3. Decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
                
            } catch {
                // Do nothing
            }
        }
    }//end load func
    
    func delete(offset: IndexSet) {
        withAnimation{
            notes.remove(atOffsets: offset)
            save()
        }
    }
    
    //MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add New Notes", text: $text)
                    
                    Button {
                        // 1. Only run the button's action when the text field is not empty
                        guard text.isEmpty == false else { return }
                        
                        // 2. Create a new note item and initialize it with the text value
                        let note = Note(id: UUID(), text: text)
                        
                        // 3. Add the new note item to the notes array (append)
                        notes.append(note)
                        
                        // 4. Make the text field empty
                        text = ""
                        
                        // 5. Save the notes (function)
                        save()
                        
                    }label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42,weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.accent)
                   // .buttonStyle(BorderedButtonStyle(tint: .accent))
                }//end hstack
                
                Spacer()
                
                if notes.count >= 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }//end hstack
                            }//end navigation link
                        }//end loop
                        .onDelete(perform: delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(25)
                    Spacer()
                }//end list
            }//end vstack
            .navigationTitle("Notes")
            .onAppear(perform: {
                load()
            })
        }
    }
}


//MARK: - PREVIEW
#Preview {
    ContentView()
}
