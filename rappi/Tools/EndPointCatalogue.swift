//
//  EndPointCatalogue.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 17/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit
import SwiftyJSON

enum Api : String {
  case endPoint = "https://itunes.apple.com/us/rss/topfreeapplications/limit=100/json"
}

class ApplicationJson {
  let name : String
  var category : String
  var summary : String
  var price : Double
  var image : NSData
  
  init(data:JSON) {
    self.name     = data["im:name"]["label"].string!
    self.category = data["category"]["attributes"]["label"].string!
    self.summary  = data["summary"]["label"].string!
    let url       = data["im:image"][0]["label"].string!
    self.image    = NSData(contentsOfURL: NSURL(string: url)!)!
    self.price    = Double(data["im:price"]["attributes"]["amount"].string!)!
  }
  
}

let categorias = ["Games", "Photo & Video", "Social Networking", "Chat", "Entertainment", "Music", "Education", "Travel", "Navigation"]