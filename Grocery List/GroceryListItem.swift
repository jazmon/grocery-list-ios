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
struct GroceryListItem {
    var text: String
    var inBasket: Bool

    init(text: String) {
        self.text = text
        self.inBasket = false
    }
}
