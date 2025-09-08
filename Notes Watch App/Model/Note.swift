//
//  Note.swift
//  Notes Watch App
//
//  Created by Wajd on 08/09/2025.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    let text: String
}
