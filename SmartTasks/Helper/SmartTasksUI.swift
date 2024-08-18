//
//  SmartTasksUI.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import UIKit

enum FontType: Int {
  case bold
  case regular
}

enum FontSize {
  case small, medium, large, Extralarge
  
  var size: CGFloat {
    switch self {
    case .small: return 10
    case .medium: return 15
    case .large: return 18
    case .Extralarge: return 22
    }
  }
}

struct SmartTasksUI {
  private struct Constants {
    static let amsiProBold = "AmsiPro-Bold"
    static let amsiProRegular = "AmsiPro-Regular"
  }
  
  struct Colors {
    static let yellowBackgroundColor = UIColor(hexString: "FFDE61")
    static let separatorBackgroundColor = UIColor(hexString: "F6EFDE")
    static let grayColor = UIColor(hexString: "3b877a")
    static let redColor = UIColor(hexString: "EF4B5E")
  }
  
  static func font(type: FontType, size: FontSize) -> UIFont {
    var font: UIFont?
    
    switch type {
    case .bold:
      font = UIKit.UIFont(name: Constants.amsiProBold, size: size.size)
    case .regular:
      font = UIKit.UIFont(name: Constants.amsiProRegular, size: size.size)
    }
    
    return font ?? UIFont.systemFont(ofSize: size.size)
  }
}
