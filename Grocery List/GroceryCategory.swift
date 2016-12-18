//
//  GroceryCategory.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 17/12/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import Foundation

class GroceryCategory: NSObject, NSCoding {

    // MARK: Properties
    var items: [Grocery]
    var name: String

    // MARK: Archiving Paths

    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("categories")

    // MARK: Types

    struct PropertyKey {
        static let nameKey = "name"
        static let itemsKey = "items"
    }

    init?(name: String) {
        self.name = name
        self.items = []

        super.init()

        if name.isEmpty {
            return nil
        }
    }

    init?(name: String, items: [Grocery]) {
        self.name = name
        self.items = items

        super.init()

        if name.isEmpty {
            return nil
        }
    }

    // MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(items, forKey: PropertyKey.itemsKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let name: String = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let items: [Grocery] = aDecoder.decodeObject(forKey: PropertyKey.itemsKey) as! [Grocery]

        self.init(name: name, items: items)
    }
}
