//
//  Category.swift
//  Todoey
//
//  Created by Lucas Rocha on 2019-08-07.
//  Copyright © 2019 Lucas Rocha. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<Item>()
}
