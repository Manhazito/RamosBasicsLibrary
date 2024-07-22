//
//  Cache.swift
//
//
//  Created by Filipe Ramos on 15/07/2024.
//

import UIKit

final public class Cache<Key: Hashable, Value>: NSObject {
    private let cache = NSCache<CacheKey, CacheValue>()
    
    public func add(_ value: Value, key: Key) {
        cache.setObject(CacheValue(value), forKey: CacheKey(key))
    }
    
    public func get(key: Key) -> Value? {
        cache.object(forKey: CacheKey(key))?.value
    }
    
    public func contains(key: Key) -> Bool {
        get(key: key) != nil
    }
    
    public func remove(key: Key) {
        cache.removeObject(forKey: CacheKey(key))
    }
    
    public func reset() {
        cache.removeAllObjects()
    }
}

private extension Cache {
    final class CacheKey: NSObject {
        let key: Key
        
        override private init() { fatalError("You need to provide a Key when initializing CacheKey.") }

        init(_ key: Key) { self.key = key }
        
        override var hash: Int { key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? CacheKey else { return false }
            return value.key == self.key
        }
    }
    
    final class CacheValue {
        let value: Value
        
        private init() { fatalError("You need to provide a Value when initializing CacheValue.") }

        init(_ value: Value) { self.value = value }
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get { get(key: key) }
        set {
            guard let newValue else {
                remove(key: key)
                return
            }
            
            add(newValue, key: key)
        }
    }
}
