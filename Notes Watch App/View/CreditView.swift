//
//  CreditView.swift
//  Notes Watch App
//
//  Created by Wajd on 08/09/2025.
//

import SwiftUI

struct CreditView: View {
    
    @State private var randomNumber: Int = Int.random(in: 1..<4)
    
    private var randomImage: String {
        return "developer-no\(randomNumber)"
    }
    
    var body: some View {
        VStack(spacing: 3) {
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
                .frame(height: 75)
            
            HeaderView(title: "Credits")
            
            Text("Wajd Almansor")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(.secondary)
            
        }//end vstack
    }
}

#Preview {
    CreditView()
}
