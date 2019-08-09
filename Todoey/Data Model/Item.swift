//
//  Item.swift
//  Todoey
//
//  Created by Lucas Rocha on 2019-08-07.
//  Copyright © 2019 Lucas Rocha. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
