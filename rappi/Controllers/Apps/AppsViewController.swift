//
//  AppsViewController.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 20/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class AppsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, TopBarDelegate {
  
  //MARK: Properties
  var category = "Games"
  let reuseIdentifier = "Cell"
  let realm = try! Realm()
  var items  = 0
  
  //MARK: Outlets
  @IBOutlet weak var collectionView: UICollectionView!
  
  //MARK: Actions
  
  @IBAction func returnFromDetailSegueActions(sender: UIStoryboardSegue){
    
  }
  
  //TopBar delegate Func
  func topbar(topbar: TopBar, clicked: String) {
    if (clicked == "menu") {
      self.backToMenu()
    }
  }
  //==============================================================//
  
  //MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    buildAppsViews()
    
    //TopBar
    let topBar = TopBar()
    topBar.hiddenMenu = false
    topBar.hiddenBack = true
    topBar.title      = category
    topBar.delegate   = self
    self.view.addSubview(topBar)
    
    //Add gesture for back navigation
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.backToMenu))
    swipeGesture.direction = .Right
    self.view.addGestureRecognizer(swipeGesture)
  }
  
  // MARK: Get apps collection
  private func buildAppsViews() {
    let userPredicate   = NSPredicate(format: "category = %@", category)
    let apps = realm.objects(Application).filter(userPredicate)
    items = apps.count
    
  }
  
  //MARK: Collection View Stuff
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AppsCollectionViewCell
    let userPredicate   = NSPredicate(format: "category = %@", category)
    let apps = realm.objects(Application).filter(userPredicate)
    
    let item = apps[indexPath.item]
    print(item.name)
    cell.layer.borderColor = UIColor.whiteColor().CGColor
    cell.layer.borderWidth = 5
    cell.itemImage.image = UIImage(data: item.image!)
    cell.itemLabel.text = item.name
    
    
    return cell
  }
  
  //MARK: Navigation
  
  func backToMenu () {
    self.performSegueWithIdentifier("returnMenuSegue", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "detailSegue" {
      let cell  = sender as! AppsCollectionViewCell
      let vc    = segue.destinationViewController as! DetailViewController
      vc.apps   = cell.itemLabel.text!
    }
  }
  
  override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
    if let id = identifier{
      if id == "returnCategoriesSegue" {
        let unwindSegue = ReturnCategoriesSegue(identifier: id,
                                                source: fromViewController,
                                                destination: toViewController,
                                                performHandler: { () -> Void in
                                                  
        })
        
        return unwindSegue
      }
    }
    return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
  }
  
}