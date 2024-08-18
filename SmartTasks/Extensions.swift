//
//  Extensions.swift
//  SmartTasks
//
//  Created by Ali Shahid on 08/06/2024.
//

import UIKit

extension UIView {
  
  var safeTopAnchor: NSLayoutYAxisAnchor {
    safeAreaLayoutGuide.topAnchor
  }
  
  var safeLeadingAnchor: NSLayoutXAxisAnchor {
    safeAreaLayoutGuide.leadingAnchor
  }
  
  var safeTrailingAnchor: NSLayoutXAxisAnchor {
    safeAreaLayoutGuide.trailingAnchor
  }
  
  var safeBottomAnchor: NSLayoutYAxisAnchor {
    safeAreaLayoutGuide.bottomAnchor
  }
  
  var trailing: NSLayoutXAxisAnchor {
    trailingAnchor
  }
  
  var leading: NSLayoutXAxisAnchor {
    leadingAnchor
  }
  
  var top: NSLayoutYAxisAnchor {
    topAnchor
  }
  
  var bottom: NSLayoutYAxisAnchor {
    bottomAnchor
  }
  
  var safeTop: NSLayoutYAxisAnchor {
    return self.safeAreaLayoutGuide.topAnchor
  }
  
  var safeLeading: NSLayoutXAxisAnchor {
    return self.safeAreaLayoutGuide.leadingAnchor
  }
  
  var safeTrailing: NSLayoutXAxisAnchor {
    return self.safeAreaLayoutGuide.trailingAnchor
  }
  
  var safeBottom: NSLayoutYAxisAnchor {
    return self.safeAreaLayoutGuide.bottomAnchor
  }
  
  var centerY: NSLayoutYAxisAnchor {
    centerYAnchor
  }
  
  var centerX: NSLayoutXAxisAnchor {
    centerXAnchor
  }
}

extension UITableViewCell {
  class var reuseIdentifier: String {
    return String(describing: self)
  }
}


public extension UIColor {
  
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt64()
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
}

extension UIApplication {
  
  func getRootNavigationController() -> UINavigationController? {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first,
       let rootNavigationController = window.rootViewController as? UINavigationController {
      return rootNavigationController
    }
    return nil
  }
}

extension String {
  
  func getFormattedDate() -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    guard let date = formatter.date(from: self) else {
      return nil
    }
    
    formatter.dateFormat = "MMM dd yyyy"
    return formatter.string(from: date)
  }
}

extension UIView {
  
  static var customSeparatorView: UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = SmartTasksUI.Colors.separatorBackgroundColor
    view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    return view
  }
  
  // Spacer view to add flexible space in the layout
  static var spacer: UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
}
