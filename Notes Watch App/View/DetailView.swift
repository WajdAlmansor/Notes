//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Wajd on 08/09/2025.
//

import SwiftUI

struct DetailView: View {
    
    let note: Note
    let count: Int
    let index: Int
    
    @State private var isCreditOpen: Bool = false
    
    @State private var isSettingsOpen: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            //HEADER
            HeaderView(title: "")
            
            //CONTENT
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            
            //FOOTER
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsOpen.toggle()
                    }
                    .sheet(isPresented: $isSettingsOpen) {
                        SettingsView()
                    }
                
                Spacer()
                
                Text("\(count) / \(index + 1)")
                
                Spacer()
                
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditOpen.toggle()
                    }
                    .sheet(isPresented: $isCreditOpen) {
                        CreditView()
                    }
                
            }//end hstack
            .foregroundColor(.secondary)
            
        }//end vstack
        .padding(3)
    }
}

#Preview {
     var sampleData: Note = Note(id: UUID(), text: "Hello!")
    
    DetailView(note: sampleData, count: 5, index: 1)
}
