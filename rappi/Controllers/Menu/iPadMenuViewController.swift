//
//  iPadMenuViewController.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 21/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit

class iPadMenuViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
    let categories : [String] = ["Games", "Photo & Video", "Social Networking", "Chat", "Entertainment", "Music", "Education", "Travel", "Navigation"]

  //Action
  @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
    
  }
  
  //Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

extension iPadMenuViewController :  UICollectionViewDataSource, UICollectionViewDelegate {

  //MARK: Collection View
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
    let label = UILabel(frame: CGRect(x: 20, y: 5, width: 300, height: 50))
    label.text = categories[indexPath.row]
    label.numberOfLines = 3
    cell.addSubview(label)
    return cell
  }
    

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let cell    = collectionView.indexPathForCell(sender as! UICollectionViewCell)
    let vc      = segue.destinationViewController as! AppsViewController
    vc.category = categories[(cell?.row)!]
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
