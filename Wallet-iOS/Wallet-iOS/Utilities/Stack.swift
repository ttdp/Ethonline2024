//
//  Stack.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import Foundation

struct Stack<T: Equatable> {
    
    private var items = [T]()
    
    public mutating func push(_ item: T) {
        items.append(item)
    }
    
    public mutating func remove(_ item: T) {
        if let index = items.lastIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    public func peek() -> T? {
        return items.last
    }
    
}

extension Stack: CustomStringConvertible where T == String {
    
    var description: String {
        var stack = "["
        for (index, item) in items.enumerated() {
            var name = item
            
            if let dot = name.firstIndex(of: ".") {
                let range = name.index(after: dot) ..< name.endIndex
                name = String(name[range])
            }
       
            if name.contains("Coordinator") {
                name = String(name.dropLast(11)) // remove "Coordinator"
            }
            
            if index != items.count - 1 {
                stack += name + "|"
            } else {
                stack += name + "]"
            }
        }
        
        return "\(stack)"
    }
    
}
