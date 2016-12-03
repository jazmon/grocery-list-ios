//
//  GroceryItems.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 27/11/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import UIKit

class GroceryItems: NSObject {
    var items: [String: [GroceryListItem]]

    override init() {
        self.items = [:]

        var foo = [[String]]()
        foo.append(["lol"])
    }

    func add(item: GroceryListItem, to: String) -> Void {
        if (items[to] == nil) {
            items[to] = []
        }
        items[to]!.append(item)
    }

    func remove(itemIndex: Int, from: String) -> GroceryListItem? {
        if (items[from] == nil) {
            return nil
        }
        return items[from]!.remove(at: itemIndex)
    }

    var listCount: Int {
        get {
            return self.items.keys.count
        }
    }

    var count: Int {
        get {
            var itemCount = 0

            for category in items.keys {
                if let itemsArray = items[category] {
                    itemCount += itemsArray.count
                }
            }
            return itemCount
        }
    }
}
