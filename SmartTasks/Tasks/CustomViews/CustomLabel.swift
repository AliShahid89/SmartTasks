//
//  CustomLabel.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import UIKit

final class CustomLabel: UILabel {
  
  init(text: String? = nil, font: UIFont, textColor: UIColor = .black) {
    super.init(frame: .zero)
    
    self.text = text
    self.font = font
    self.numberOfLines = 0
    self.textColor = textColor
    self.textAlignment = .left
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
