//
//  TaskDetailsProtocols.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import Foundation
import UIKit

protocol TaskDetailsRouterProtocol {
  static func routeToTaskDetails(_ task: Task, from navigationVC: UINavigationController)
}

protocol TaskDetailsViewProtocol: AnyObject {
  func populateTaskDetails(_ viewModel: TaskDetailsViewModel)
}

protocol TaskDetailsInteractorProtocol {
  func getDetails()
  func markResolved()
  func markUnResolved()
}

protocol TaskDetailsPresenterProtocol {
  mutating func formatData(_ task: Task)
}
