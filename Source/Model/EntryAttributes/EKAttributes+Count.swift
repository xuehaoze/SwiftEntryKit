//
//  EKAttributes+Count.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/22/18.
//

import Foundation

extension EKAttributes {
    
    /** Numeric representation of the last instantiated attributes' id */
    private static var identifier: UInt = 0
    
    /** Counts the active entries. When 0, no entry is presented. */
    static var count: UInt = 0
    
    /** *true* when at least 1 entry is presented */
    static var isDisplaying: Bool {
        return count > 0
    }
    
    /** Returns the next entry identifier */
    static var nextIdentifier: String {
        identifier += 1
        return "\(identifier)"
    }
}
