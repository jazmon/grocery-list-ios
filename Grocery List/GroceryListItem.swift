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
    var text: String
    var inBasket: Bool

    init(text: String) {
        self.text = text
        self.inBasket = false
    }

    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "text") as! String
        inBasket = aDecoder.decodeBool(forKey: "inBasket")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(inBasket, forKey: "inBasket")
    }
}
