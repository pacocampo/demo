//
//  ApiBridge.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 17/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import SystemConfiguration

class ApiBridge {
  
  func getData(url: Api, activity : ViewController) {
      Alamofire.request(.GET, url.rawValue)
        .responseJSON { response in
          guard response.result.error == nil else {
            print(response.result.error!)
            return
          }
          if let value: AnyObject = response.result.value {
              let data = JSON(value)
              self.saveDataOnLocal(data)
              activity.activity.stopAnimating()
              activity.actionButton_IBO.setTitle("¡Para ingresar arrastra el logo aquí!", forState: .Normal)
          }
      }
  }
  
  private func saveDataOnLocal(data: JSON) {
    let realm = try! Realm()
    let apps = data["feed"]["entry"]
    for app in apps {
      let applicationJson   = ApplicationJson(data: app.1)
      let application       = Application()
      application.name      = applicationJson.name
      application.category  = applicationJson.category
      application.sumary    = applicationJson.summary
      application.image     = applicationJson.image
      application.price     = applicationJson.price
      application.itunes    = applicationJson.itunes
      try! realm.write {
        realm.add(application)
      }
    }
    print("Data Saved")
  }
  
  func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
      SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
    }
    
    var flags = SCNetworkReachabilityFlags()
    
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
      return false
    }
    
    let reachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let noConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    
    return (reachable && !noConnection)
  }
}


