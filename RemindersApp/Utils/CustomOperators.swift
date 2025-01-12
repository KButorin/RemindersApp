//
//  CustomOperators.swift
//  RemindersApp
//
//  Created by ESSIP on 23.08.2024.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T>{
    Binding (
        get: { lhs.wrappedValue ?? rhs},
        set: { lhs.wrappedValue = $0}
    )
}

