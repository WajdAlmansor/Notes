//
//  HeaderView.swift
//  Notes Watch App
//
//  Created by Wajd on 08/09/2025.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String = ""
    
    var body: some View {
        VStack {
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accent)
            }
            
            
            HStack {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }//end hstack
            .foregroundColor(.accent)
        }//end vstack
    }
}

#Preview {
    HeaderView(title: "Creadits")
}
