//
//  DetailViewController.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 21/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
  
  var apps : String?
  let realm = try! Realm()
  var scrollHeight : CGFloat = 0
  var scrollWidth :CGFloat = 0
  
  //MARK: Outlets
  @IBOutlet weak var appImage: UIImageView!
  @IBOutlet weak var appName: UILabel!
  @IBOutlet weak var appCategory: UILabel!
  @IBOutlet weak var appPrice: UILabel!
  @IBOutlet weak var appDescription: UITextView!
  @IBOutlet weak var appRecommendedView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()
    getApp()
    
    //Add gesture
    let gestureToBack = UISwipeGestureRecognizer(target: self, action: #selector(DetailViewController.backToCategories))
    gestureToBack.direction = .Down
    self.view.addGestureRecognizer(gestureToBack)
  }
  
  override func viewDidLayoutSubviews() {
    let height = appRecommendedView.frame.height
    self.appRecommendedView.contentSize = CGSize(width: scrollWidth, height:height)
    
  }
  
  private func getApp() {
    var xView : CGFloat = 5.0
    if let app = apps {
      let userPredicate   = NSPredicate(format: "name = %@", app)
      let application     = realm.objects(Application).filter(userPredicate).first
      appImage.image      = UIImage(data: application!.image!)
      appName.text        = application!.name
      appCategory.text    = application!.category
      appPrice.text       = String(application!.price)
      appDescription.text = application!.sumary
      
      //Built recommended section
      let recommended     = realm.objects(Application).filter("category = '\(application!.category)'")
      for item in recommended {
        let recommendedImage : CustomImage = CustomImage(frame: CGRectMake(xView, 0, 80, appRecommendedView.frame.height))
        recommendedImage.image = UIImage(data: item.image!)
        recommendedImage.contentMode = .ScaleAspectFit
        self.appRecommendedView.addSubview(recommendedImage)
        scrollWidth += recommendedImage.frame.size.width + 5
        xView += recommendedImage.frame.size.width + 5
      }
    }
  }
  
  //Navigation
  func backToCategories() {
    self.performSegueWithIdentifier("returnCategoriesSegue", sender: self)
  }

}
