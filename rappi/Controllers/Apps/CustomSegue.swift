//
//  CategoriesApp.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 15/05/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit

class CategoriesAppSegue: UIStoryboardSegue {
  
  override func perform() {
    let firstVc = self.sourceViewController.view as UIView
    let secondVc = self.destinationViewController.view as UIView
    
    let height = UIScreen.mainScreen().bounds.size.height
    let width = UIScreen.mainScreen().bounds.size.width
    
    secondVc.frame = CGRectMake(0.0, height, width, height)
    
    let window = UIApplication.sharedApplication().keyWindow
    window?.insertSubview(secondVc, aboveSubview: firstVc)
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
      firstVc.frame = CGRectOffset(firstVc.frame, 0.0, -height)
      secondVc.frame = CGRectOffset(secondVc.frame, 0.0, -height)
    
    }) { (Finished) -> Void in
      self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
    }
  }
}

class ReturnMenueSegue : UIStoryboardSegue {
  override func perform() {
    let secondVc = self.sourceViewController.view as UIView
    let firstVc = self.destinationViewController.view as UIView
    
    let height = UIScreen.mainScreen().bounds.size.height
    
    let window = UIApplication.sharedApplication().keyWindow
    window?.insertSubview(secondVc, aboveSubview: secondVc)
    
    UIView.animateWithDuration(1, animations: { () -> Void in
      firstVc.frame = CGRectOffset(firstVc.frame, 0.0, height)
      secondVc.frame = CGRectOffset(secondVc.frame, 0.0, -height)
      
    }) { (Finished) -> Void in
      self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
    }

  }
}

class DetailCustomSegue : UIStoryboardSegue {
  override func perform() {
    let firstVc = self.sourceViewController.view as UIView
    let secondVc = self.destinationViewController.view as UIView
    
    let window = UIApplication.sharedApplication().keyWindow
    window?.insertSubview(secondVc, aboveSubview: firstVc)
    
    secondVc.transform = CGAffineTransformScale(secondVc.transform, 0.001, 0.001)
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
      firstVc.transform = CGAffineTransformScale(secondVc.transform, 0.001, 0.001)
      
    }) { (Finished) -> Void in
      
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        secondVc.transform = CGAffineTransformIdentity
        
        }, completion: { (Finished) -> Void in
          
          firstVc.transform = CGAffineTransformIdentity
          self.sourceViewController.presentViewController(self.destinationViewController as UIViewController, animated: false, completion: nil)
      })
    }
  }
}

class ReturnCategoriesSegue : UIStoryboardSegue {
  override func perform() {
    let firstVc = destinationViewController.view as UIView!
    let secondVc = sourceViewController.view as UIView!
    
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    firstVc.frame = CGRectOffset(firstVc.frame, 0.0, screenHeight)
    firstVc.transform = CGAffineTransformScale(firstVc.transform, 0.001, 0.001)
    
    let window = UIApplication.sharedApplication().keyWindow
    window?.insertSubview(firstVc, aboveSubview: secondVc)
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
      
      secondVc.transform = CGAffineTransformScale(secondVc.transform, 0.001, 0.001)
      secondVc.frame = CGRectOffset(secondVc.frame, 0.0, -screenHeight)
      
      firstVc.transform = CGAffineTransformIdentity
      firstVc.frame = CGRectOffset(firstVc.frame, 0.0, -screenHeight)
      
    }) { (Finished) -> Void in
      
      self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
    }
  }
}
