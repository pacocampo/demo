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
  var itunes : String
  
  init(data:JSON) {
    self.name     = data["im:name"]["label"].string!
    self.category = data["category"]["attributes"]["label"].string!
    self.summary  = data["summary"]["label"].string!
    let url       = data["im:image"][0]["label"].string!
    self.image    = NSData(contentsOfURL: NSURL(string: url)!)!
    self.price    = Double(data["im:price"]["attributes"]["amount"].string!)!
    self.itunes   = data["link"]["attributes"]["href"].string!
  }
  
}

class Menu {
  static var categorias : NSDictionary {
    let data = NSMutableDictionary()
    data[0] = ["title" : "Games", "icon" : "employees"]
    data[1] = ["title" : "Photo & Video", "icon" : "binoculars"]
    data[2] = ["title" : "Social Networking", "icon" : "coffee"]
    data[3] = ["title" : "Chat", "icon" : "paper-plane"]
    data[4] = ["title" : "Entertainment", "icon" : "ufo"]
    data[5] = ["title" : "Music", "icon" : "smartphone-1"]
    data[6] = ["title" : "Education", "icon" : "microscope"]
    data[7] = ["title" : "Travel", "icon" : "glasses"]
    data[8] = ["title" : "Navigation", "icon" : "compass"]
    
    return NSDictionary(dictionary: data)
  }

}

