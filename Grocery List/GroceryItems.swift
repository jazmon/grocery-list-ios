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
    // var items: [String: [GroceryListItem]]

    override init() {
        //self.items = [:]
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

    func remove(itemIndex: Int, from: Int) -> GroceryListItem? {
//        if let item = itemsPerCategory[from][itemIndex] {
//            return item
//        }
//        return nil
        // return itemsPerCategory[from][itemIndex]
        return itemsPerCategory[from].remove(at: itemIndex)
//        if ()
//        if (items[from] == nil) {
//            return nil
//        }
//        return items[from]!.remove(at: itemIndex)
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
//        if let index = itemsPerCategory.index(where: {$0.text == item.text}) {
//            groceryListItems.remove(at: index)
//
//            self.tableView.beginUpdates()
//            let indexPathForRow = IndexPath(row: index, section: 0)
//            self.tableView.deleteRows(at: [indexPathForRow], with: UITableViewRowAnimation.fade)
//            tableView.endUpdates()
//        }
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
