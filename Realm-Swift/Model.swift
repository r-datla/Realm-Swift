//
//  Model.swift
//  Realm-Swift
//
//  Created by Remote Tiger on 11/2/17.
//  Copyright © 2017 Remote Tiger. All rights reserved.
//

import Foundation
import RealmSwift

class Model:Object{
    
    
    @objc dynamic var firstName:String?
    @objc dynamic var lastName:String?
    @objc dynamic var id:String?
    
    override class func primaryKey()->String{
        return "id"
    }
    
    
}
