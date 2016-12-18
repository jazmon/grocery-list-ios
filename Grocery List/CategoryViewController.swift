//
//  CategoryViewController.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 18/12/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import UIKit

// https://stackoverflow.com/a/33229483
protocol DataEnteredDelegate: class {
    func addCategory(category: GroceryCategory)
}

class CategoryViewController: UIViewController {
    // making this a weak variable so that it won't create a strong reference cycle

    weak var delegate: DataEnteredDelegate? = nil

    @IBOutlet weak var textField: UITextField!
    @IBAction func addPressed(_ sender: UIButton) {
        // call this method on whichever class implements our delegate protocol
        delegate?.addCategory(category: GroceryCategory(name: textField.text!)!)


        // go back to the previous view controller
        self.navigationController?.popViewController(animated: true)
    }
    
}
