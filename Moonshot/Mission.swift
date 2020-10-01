//
//  Mission.swift
//  Moonshot
//
//  Created by Rafael Calunga on 2020-10-01.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: String
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
