//
//  CustomNavigationBar.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import UIKit

final class CustomNavigationBar: UINavigationBar {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAppearance()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupAppearance()
  }
  
  private func setupAppearance() {
    // Title Attributes (from image)
    let titleFont = UIFont(name: "HelveticaNeue-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
    titleTextAttributes = [.foregroundColor: UIColor.white, .font: titleFont]
    
    // Background Color (Yellow from image)
    backgroundColor = SmartTasksUI.Colors.yellowBackgroundColor
    tintColor = .white // Button colors
    barTintColor = SmartTasksUI.Colors.yellowBackgroundColor
    
    // Remove Separator (from image)
    shadowImage = UIImage()
    setBackgroundImage(UIImage(), for: .default)
  }
  
  // Function to set up the left and right bar buttons with custom images
  func setupBarButtonItems(target: Any?, backAction: Selector, forwardAction: Selector) {
    let backButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: target, action: backAction)
    let forwardButton = UIBarButtonItem(image: UIImage(named: "forward-arrow"), style: .plain, target: target, action: forwardAction)
    topItem?.leftBarButtonItem = backButton
    topItem?.rightBarButtonItem = forwardButton
  }
}
