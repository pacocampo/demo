//
//  AppsModel.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 20/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import RealmSwift

class Application: Object {
  dynamic var name = ""
  dynamic var category = ""
  dynamic var image : NSData?
  dynamic var sumary = ""
  dynamic var price = 0.0
  
}