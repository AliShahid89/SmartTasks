//
//  TaskDetailsRouter.swift
//  SmartTasks
//
//  Created by Ali Shahid on 09/06/2024.
//

import UIKit

struct TaskDetailsRouter {
}

extension TaskDetailsRouter: TaskDetailsRouterProtocol {
  
  static func routeToTaskDetails(_ task: Task, from navigationVC: UINavigationController) {
    
    let taskDetailsViewController = TaskDetailsViewController()
    
    let interactor = TaskDetailsInteractor(task: task)
    var presenter = TaskDetailsPresenter()
    let router = TaskDetailsRouter()
    presenter.view = taskDetailsViewController
    interactor.presenter = presenter
    taskDetailsViewController.interactor = interactor
    taskDetailsViewController.router = router
    
    navigationVC.pushViewController(taskDetailsViewController, animated: true)
  }
}



