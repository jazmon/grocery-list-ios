//
//  GroceryItems.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 27/11/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import UIKit

class GroceryItems: NSObject {
    var categoryNames: [String]
    var itemsPerCategory: [[GroceryListItem]]

    override init() {
        self.categoryNames = [];
        self.categoryNames.append("Uncategorized")
        self.categoryNames.append("produce")

        self.itemsPerCategory = [
            [GroceryListItem(text: "bacon")],
            [GroceryListItem(text: "lettuce"), GroceryListItem(text: "spinach")]
        ]
    }

    func add(item: GroceryListItem, to: Int) -> Void {
        // category must exists before adding an item to it
        itemsPerCategory[to].append(item)
    }

    func insert(item: GroceryListItem, list: Int, to: Int) {
        itemsPerCategory[list].insert(item, at: to)
    }

    func remove(itemIndex: Int, from: Int) -> GroceryListItem? {
        return itemsPerCategory[from].remove(at: itemIndex)
    }

    func getItem(list: Int, index: Int) -> GroceryListItem {
        return self.itemsPerCategory[list][index]
    }

    func countFor(index: Int) -> Int {
        return self.itemsPerCategory[index].count
    }

    func remove(item: GroceryListItem) -> (section: Int, index: Int)? {
        for (index, list) in itemsPerCategory.enumerated() {
            if let i: Int = list.index(where: {$0.text == item.text}) {
                itemsPerCategory[index].remove(at: i)
                return (section: index, index: i)
            }
        }
        return nil
    }

    var listCount: Int {
        get {
            return self.itemsPerCategory.count
        }
    }

    var count: Int {
        get {
            var itemCount = 0
            for i in self.itemsPerCategory {
                itemCount += i.count
            }

            return itemCount
        }
    }
}
