//
//  SectionModel.swift
//  RxDataSources
//
//  Created by Krunoslav Zaher on 6/16/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation

public struct SectionModel<Section, ItemType>
    : SectionModelType
    , CustomStringConvertible {
    public typealias Identity = Section
    public typealias Item = ItemType
    public var model: Section

    public var identity: Section {
        return model
    }

    public var items: [Item]
    
    public init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }

    public var description: String {
        get {
            return "\(self.model) > \(items)"
        }
    }
}

public struct HashableSectionModel<Section: Hashable, ItemType: Hashable>
    : Hashable
    , AnimatableSectionModelType
    , CustomStringConvertible {
    public typealias Item = IdentitifiableValue<ItemType>
    public typealias Identity = Section

    public var model: Section
    
    public var items: [Item]

    public var identity: Section {
        get {
            return model
        }
    }
    
    public init(model: Section, items: [ItemType]) {
        self.model = model
        self.items = items.map(IdentitifiableValue.init)
    }
    
    public init(original: HashableSectionModel, items: [Item]) {
        self.model = original.model
        self.items = items
    }
    
    public var description: String {
        get {
            return "HashableSectionModel(model: \"\(self.model)\", items: \(items))"
        }
    }
    
    public var hashValue: Int {
        get {
            return self.model.hashValue
        }
    }
}

public func == <S, I>(lhs: HashableSectionModel<S, I>, rhs: HashableSectionModel<S, I>) -> Bool {
    return lhs.model == rhs.model
}