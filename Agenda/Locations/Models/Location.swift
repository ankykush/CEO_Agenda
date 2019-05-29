//
//  Location.swift
//  Agenda
//
//  Created by Ankush jain on 28/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import Foundation

struct Location {
    var name: String
    var imageUrl: String
    var description: String
    
    init(name: String, imageUrl: String, description: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.description = description
    }
}
