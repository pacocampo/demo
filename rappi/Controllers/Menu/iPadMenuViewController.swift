//
//  iPadMenuViewController.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 21/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit

class iPadMenuViewController: UIViewController, TopBarDelegate {
  
  //Attributes
  let topbarView : TopBar = TopBar()
  
  @IBOutlet weak var collectionView: UICollectionView!
    let categories = Menu.categorias

  //Action
  @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
    
  }
  
  //Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    topbarView.hiddenMenu  = true
    topbarView.hiddenBack  = true
    topbarView.title       = "Categorias"
    topbarView.delegate    = self
    self.view.addSubview(topbarView)
  }
  
}

extension iPadMenuViewController :  UICollectionViewDataSource, UICollectionViewDelegate {

  //MARK: Collection View
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! iPadMenuCollectionViewCell
    
    let item = categories[indexPath.row]
    
    cell.itemImage_IBO.image = UIImage(named: item!["icon"] as! String)
    cell.itemLabel_IBO.text = item!["title"] as? String
   
    
    return cell
  }
    

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let cell    = collectionView.indexPathForCell(sender as! UICollectionViewCell)
    let item    = categories[cell!.row]
    let vc      = segue.destinationViewController as! AppsViewController
    vc.category = item!["title"] as! String
  }
  
  override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
    if let id = identifier {
      if id == "returnMenuSegue" {
        let undwindSegue = ReturnMenueSegue(identifier: id, source: fromViewController, destination: toViewController, performHandler: {
          () -> Void in
        })
        return undwindSegue
      }
    }
    return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
  }

}
