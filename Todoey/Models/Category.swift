//
//  Catgeoyr.swift
//  Todoey
//
//  Created by Krish Thawani on 8/22/18.
//  Copyright © 2018 Innocent Penguin. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
