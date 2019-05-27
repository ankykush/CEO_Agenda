//
//  Executive.swift
//  Agenda
//
//  Created by Sravanthi Kuppireddy on 5/24/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import Foundation

struct Executive {
    var name: String
    var role: String
    var imageUrl: String
    
    init(name: String, role: String, imageUrl: String) {
        self.name = name
        self.role = role
        self.imageUrl = imageUrl
    }
}
