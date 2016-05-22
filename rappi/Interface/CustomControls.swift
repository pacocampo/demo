//
//  CustomControls.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 17/02/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit

class CustomImage : UIImageView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    layer.cornerRadius = 15
    layer.shadowOpacity = 5.0
    layer.shadowColor = UIColor.grayColor().CGColor
    layer.shadowRadius = 15
    layer.shadowOffset = CGSize(width: 10, height: 10)
    clipsToBounds = true
  }

}

class RoundImage : UIImageView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    layer.cornerRadius = self.frame.width / 2
    layer.shadowOpacity = 15.0
    layer.shadowColor = UIColor.grayColor().CGColor
    layer.shadowRadius = 15
    layer.shadowOffset = CGSize(width: 10, height: 10)
    clipsToBounds = true
  }
}

class rappiAppSelectedButton : UIButton {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    backgroundColor = UIColor.whiteColor()
    tintColor = UIColor(red: 253/255, green: 125/255, blue: 91/255, alpha: 1.0)
    setTitle("Ver en iTunes", forState: .Normal)
    layer.borderColor = UIColor(red: 253/255, green: 125/255, blue: 91/255, alpha: 1.0).CGColor
    layer.borderWidth = 1
    layer.cornerRadius = 2
    layer.shadowColor = UIColor.grayColor().CGColor
    layer.shadowOffset = CGSize(width: 3, height: 3)
    layer.shadowOpacity = 2
  }
}


// TopBar
@objc protocol TopBarDelegate {
  optional func topbar(topbar:TopBar, clicked:String)
}

class TopBar : UIView {
  let thisFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height * 0.10)
  
  var titleLabel  : UILabel!
  var menuButton  : UIButton!
  var delegate    : TopBarDelegate!
  
  var title : String {
    set { titleLabel.text = newValue }
    get { return titleLabel.text! }
  }
  
  var hiddenMenu : Bool {
    set { menuButton.hidden = newValue }
    get { return !menuButton.hidden }
  }
  
  init() {
    super.init(frame: thisFrame)
    
    // Custom Bar
    backgroundColor = UIColor(red: 253/255, green: 125/255, blue: 91/255, alpha: 1.0)
    tintColor = UIColor.whiteColor()
    
    // Title
    titleLabel = UILabel(frame: CGRectMake(0, 0, thisFrame.width, thisFrame.height))
    titleLabel.textAlignment = .Center
    titleLabel.textColor = UIColor.whiteColor()
    
    // Button
    menuButton = UIButton(frame: CGRectMake(5, 5, 30, 30))
    menuButton.setImage(UIImage(named:"menuIcon"), forState: .Normal)
    menuButton.addTarget(self, action: #selector(TopBar.clickBack(_:)), forControlEvents: .TouchUpInside)
    
    self.addSubview(titleLabel)
    self.addSubview(menuButton)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func clickBack(sender:AnyObject) {
    if(delegate != nil) {
      delegate.topbar!(self, clicked: "menu");
    }
  }
  
}