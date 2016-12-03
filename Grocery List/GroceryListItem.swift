//
//  GroceryListItem.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 19/11/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import Foundation
import UIKit

// Model for grocery list item
//struct GroceryListItem {
//    var text: String
//    var inBasket: Bool
//
//    init(text: String) {
//        self.text = text
//        self.inBasket = false
//    }
//}


class GroceryListItem: NSObject, NSCoding {
    // Name of the item
    var text: String
    // how many units
    var amount: Int

    // Is the item in basket
    var inBasket: Bool

    // A units price
    var price: Int?

    init(text: String) {
        self.text = text
        self.inBasket = false
        self.amount = 1
        self.price = nil
    }

    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "text") as! String
        inBasket = aDecoder.decodeBool(forKey: "inBasket")
        price = aDecoder.decodeInteger(forKey: "price")
        amount = aDecoder.decodeInteger(forKey: "amount")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(inBasket, forKey: "inBasket")
        aCoder.encode(amount, forKey: "amount")
        aCoder.encode(price, forKey: "price")
    }
}
