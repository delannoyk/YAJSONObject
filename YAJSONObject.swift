//
//  YAJSONObject.swift
//  YAJSONObject
//
//  Created by Kevin DELANNOY on 13/05/15.
//  Copyright (c) 2015 Kevin Delannoy. All rights reserved.
//

import Foundation

// MARK: - YAJSONObject
////////////////////////////////////////////////////////////////////////////

public class YAJSONObject: SequenceType {
    internal let value: AnyObject?
    internal var index: Int = 0

    public init(_ value: AnyObject?) {
        self.value = value
    }

    public subscript(index: Int) -> YAJSONObject {
        return (value as? [AnyObject]).map { YAJSONObject($0[index]) } ?? YAJSONObject(nil)
    }

    public subscript(key: String) -> YAJSONObject {
        return (value as? NSDictionary).map { YAJSONObject($0[key]) } ?? YAJSONObject(nil)
    }

    public func generate() -> AnyGenerator<YAJSONObject> {
        index = 0
        return anyGenerator {
            if self.index + 1 < 0 {
                return nil
            }
            return self[self.index++]
        }
    }

    public func map<U>(f: YAJSONObject -> U) -> [U]? {
        if let value = value as? [AnyObject] {
            return value.map({ f(YAJSONObject($0)) })
        }
        return nil
    }
}

public extension YAJSONObject {
    public var anyObjectValue: AnyObject? {
        return value
    }

    public var intValue: Int? {
        return (value as? Int)
    }

    public var uint64Value: UInt64? {
        return (value as? UInt64)
    }

    public var doubleValue: Double? {
        return (value as? Double)
    }

    public var boolValue: Bool? {
        return (value as? Bool)
    }

    public var stringValue: String? {
        return (value as? String)
    }

    public var URLValue: NSURL? {
        return (value as? String).map { NSURL(string: $0) } ?? nil
    }

    public func dateValue(dateFormat: String) -> NSDate? {
        let date: NSDate?? = stringValue.map {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = dateFormat
            return dateFormatter.dateFromString($0)
        }
        return date ?? nil
    }

    public func arrayValue<T>(mapping: YAJSONObject -> T?) -> [T]? {
        if let JSONArray =  value as? [AnyObject] {
            let values = JSONArray.map { mapping(YAJSONObject($0)) }
            return values.reduce([], combine: { (l, o) -> [T] in
                if let o = o {
                    return l + [o]
                }
                return l
            })
        }
        return nil
    }
}

////////////////////////////////////////////////////////////////////////////
