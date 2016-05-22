//
//  iPhoneMenuViewController.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 21/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit

class iPhoneMenuViewController: UIViewController, TopBarDelegate {
  
  //Attributes
  let topbarView : TopBar = TopBar()
  let categories = Menu.categorias
  
  //Outlets
  //  @IBOutlet weak var topbarView:TopBar!;
  @IBOutlet weak var tableview: UITableView!
  
  //Action
  @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
  }
  
  //===================================================================//
  
  //Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    topbarView.hiddenMenu  = true
    topbarView.title       = "Categorias"
    topbarView.delegate    = self
    self.view.addSubview(topbarView)
  }
  //===================================================================//
}

//MARK : Table View Delegate & DataSource
extension iPhoneMenuViewController : UITableViewDelegate, UITableViewDataSource {
  
  //MARK: Table stuff
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! iPhoneMenuTableViewCell
    
    let category = categories[indexPath.row]
    
    cell.itemImage_IBO.image = UIImage(named: category!["icon"] as! String)
    cell.itemLabel_IBO.text = category!["title"] as? String
    
    return cell
  }
  //===================================================================//
  
  //  //MARK: Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let cell    = tableview.indexPathForSelectedRow!
    let item    = categories[cell.row]
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
