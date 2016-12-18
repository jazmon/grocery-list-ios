//
//  Grocery.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 17/12/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import Foundation

class Grocery: NSObject, NSCoding {
    // MARK: Properties

    var name: String
    var price: Int
    var amount: Int

    // MARK: Archiving Paths

    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("groceries")


    // MARK: Types

    struct PropertyKey {
        static let nameKey = "name"
        static let priceKey = "price"
        static let amountKey = "amount"
    }

    init?(name: String, price: Int, amount: Int) {
        self.name = name
        self.price = price
        self.amount = amount

        super.init()

        if name.isEmpty {
            return nil
        }
    }

    // MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(price, forKey: PropertyKey.priceKey)
        aCoder.encode(amount, forKey: PropertyKey.amountKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let name: String = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let price: Int = aDecoder.decodeInteger(forKey: PropertyKey.priceKey)
        let amount: Int = aDecoder.decodeInteger(forKey: PropertyKey.amountKey)

        self.init(name: name, price: price, amount: amount)
    }
}
