//
//  NoTasksTodayView.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import UIKit

final class NoTasksView: UIView {
  
  private struct Constants {
    static let noTasksLabelText = "No tasks for today!"
  }
  
  private lazy var noTasksImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "empty_screen_icon") // Replace with the actual image name
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private lazy var noTasksLabel: UILabel = {
    let label = UILabel()
    label.text = Constants.noTasksLabelText
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var containerStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [noTasksImageView, noTasksLabel])
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 30
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor(hexString: "FAD961")
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    addSubview(containerStackView)
    
    NSLayoutConstraint.activate([
      // Center the stack view in the container view
      containerStackView.centerX.constraint(equalTo: centerX),
      containerStackView.centerY.constraint(equalTo: centerY),
      
      // Set width constraints for the image view to maintain aspect ratio
      noTasksImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
      noTasksImageView.heightAnchor.constraint(equalTo: noTasksImageView.widthAnchor)
    ])
  }
}
