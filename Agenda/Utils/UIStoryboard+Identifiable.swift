//
//  UIStoryboard+Identifiable.swift
//  Agenda
//
//  Created by Ankush jain on 23/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

public protocol Identifiable: class {
    static var identifier: String { get }
}

public extension Identifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

public extension Identifiable where Self: UIStoryboard {
    
    init(_ bundle: Bundle?) {
        self.init(name: Self.identifier, bundle: bundle)
    }
    
    static func instantiateViewController<T: UIViewController>(_: T.Type) -> T where T: Identifiable {
        let storyboard = Self(nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("View controller with identifier '\(T.identifier)' in '\(self.identifier)' is not of type '\(T.self)'")
        }
        return vc
    }
    
    static func instantiateInitialViewController<T: UIViewController>(_: T.Type) -> T where T: Identifiable {
        let storyboard = Self(nil)
        guard let vc = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Initial view controller in '\(self.identifier)' is not of type '\(T.identifier)'")
        }
        return vc
    }
}
