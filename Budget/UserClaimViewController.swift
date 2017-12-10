//
//  UserClaimViewController.swift
//  Budget
//
//  Created by Daniel Gauthier on 2016-11-24.
//  Copyright © 2016 Bandit Hat Apps. All rights reserved.
//

import UIKit

protocol UserClaimDelegate: class {
  func userClaimed()
}

class UserClaimViewController: UIViewController {

  weak var userClaimDelegate: UserClaimDelegate?
  
  @IBOutlet weak var topView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  
  @IBOutlet weak var bottomView: UIView!
  @IBOutlet weak var banditHatLabel: UILabel!
  @IBOutlet weak var budgetLabel: UILabel!
  
  @IBOutlet weak var selectUserButton: BHButton!
  @IBOutlet weak var createUserButton: BHButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let themeColor = UIColor.text
    selectUserButton.themeColor = themeColor
    createUserButton.themeColor = themeColor
    titleLabel.textColor = themeColor
    subtitleLabel.textColor = themeColor.withAlphaComponent(0.5)
    topView.backgroundColor = themeColor.withAlphaComponent(0.04)
    bottomView.backgroundColor = themeColor.withAlphaComponent(0.04)
    banditHatLabel.textColor = themeColor
    budgetLabel.textColor = themeColor
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func createUserButtonTapped() {
    
    let userCreationViewController = UserCreationViewController(nibName: "UserCreationViewController", bundle: nil)
    userCreationViewController.userClaimDelegate = userClaimDelegate
    
    if let navigationController = navigationController {
      navigationController.pushViewController(userCreationViewController, animated: true)
    }
  }
  
  @IBAction func selectUserButtonTapped() {
    
    let userSelectionViewController = UserSelectionViewController(nibName: "UserSelectionViewController", bundle: nil)
    userSelectionViewController.userClaimDelegate = userClaimDelegate
    
    if let navigationController = navigationController {
      navigationController.pushViewController(userSelectionViewController, animated: true)
    }
  }
}