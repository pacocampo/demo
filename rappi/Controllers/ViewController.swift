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
  
  // MARK: Attributes
  let real = try! Realm()
  var location = CGPoint(x: 0, y: 0)
  
  // MARK: Outlets
  @IBOutlet weak var activity: UIActivityIndicatorView!
  @IBOutlet weak var rappiImage_IBO: UIImageView!
  @IBOutlet weak var actionButton_IBO: UIButton!
  
  
  // MARK: Actions
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch : UITouch! = touches.first!
    location = touch.locationInView(self.view)
    rappiImage_IBO.center = location
    let goal = actionButton_IBO.center
    if location.x >= goal.x && location.y >= goal.y {
      start()
    }
  }
  
  
  //Device
  let device = UIDevice.currentDevice().userInterfaceIdiom.rawValue


  
  func start() {
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
    self.actionButton_IBO.setTitle("Espera por favor...", forState: .Normal)
    activity.startAnimating()
    loadData()
    rappiImage_IBO.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
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
        api.getData(Api.endPoint, activity: self)
      }
    } else {
      activity.stopAnimating()
      actionButton_IBO.setTitle("¡Para ingresar arrastra el logo aquí!", forState: .Normal)
    }
  }
  

}
