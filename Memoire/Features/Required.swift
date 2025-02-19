//
//  Required.swift
//  Memoire
//
//  Created by Risa on 19/02/25.
//

@propertyWrapper
struct Required {
    private var value: String
    private let message: String
    
    var wrappedValue: String {
        get { value }
        set { value = newValue }
    }
    
    var projectedValue: String? {
        return value.isEmpty ? message: nil
    }
    
    init(wrappedValue: String, _ message: String) {
        self.value = wrappedValue
        self.message = message
    }
    
}
