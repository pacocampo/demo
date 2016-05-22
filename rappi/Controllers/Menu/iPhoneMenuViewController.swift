//
//  iPhoneMenuViewController.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 21/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit

class iPhoneMenuViewController: UIViewController {
  //Outlets
  @IBOutlet weak var tableview: UITableView!
  
  //Action
  @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
    
  }

  //Attributes
  let categories = Menu.categorias

  //Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    let bar = TopBar()
    bar.hiddenMenu = false
    bar.title = "Categorias"
    self.view.addSubview(bar)
  }
  
}

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
  
  
//  //MARK: Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    let cell    = tableview.indexPathForSelectedRow!
//    let vc      = segue.destinationViewController as! AppsViewController
//    vc.category = categories[cell.row]
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
