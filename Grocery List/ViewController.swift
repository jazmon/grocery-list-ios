//
//  ViewController.swift
//  Grocery List
//
//  Created by Atte Huhtakangas on 16/11/2016.
//  Copyright © 2016 Atte Huhtakangas. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var groceryListItems: [GroceryListItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.black

        if groceryListItems.count > 0 {
            return
        }

        groceryListItems.append(GroceryListItem(text: "bacon"))
        groceryListItems.append(GroceryListItem(text: "eggs"))
    }

    // MARK: - Tableview datasource

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let item = groceryListItems[indexPath.row]
        cell.textLabel?.text = item.text
        cell.selectionStyle = .none
        return cell
        /*let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "foo")
        return cell*/
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryListItems.count
    }
}
