//
//  ViewController.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 17/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
  @IBOutlet weak var activity: UIActivityIndicatorView!
  let real = try! Realm()
  //Device
  let device = UIDevice.currentDevice().userInterfaceIdiom.rawValue

  @IBAction func signIn(sender: AnyObject) {
    if device == 1 {
      performSegueWithIdentifier("ipad", sender: self)
    } else {
      performSegueWithIdentifier("iphone", sender: self)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    //Activity
    activity.hidesWhenStopped = true
    activity.startAnimating()
    loadData()
  }

  //Load data for first time and store in device
  func loadData() {
    let application : Application?
    application = real.objects(Application).first
    if application == nil {
      let api =  ApiBridge()
      if(!api.isConnectedToNetwork()) {
        UIAlertView(title: "Sin conexión", message: "Uups, no tienes conexión y es necesario para la primera carga, vuelve a internarlo en cuanto tengas conexión", delegate: nil, cancelButtonTitle: "Ok").show()

      } else {
        api.getData(Api.endPoint, activity: activity)
      }
    } else {
      activity.stopAnimating()
    }
  }
  

}
