//
//  TasksRouter.swift
//  SmartTasks
//
//  Created by Ali Shahid on 08/06/2024.
//

import UIKit

struct TasksRouter {
}

extension TasksRouter: TasksRouterProtocol {
  
  static func getTasksView() -> TasksViewProtocol? {
    let tasksViewController = TasksViewController()
    
    let interactor = TasksInteractor()
    var presenter = TasksPresenter()
    let router = TasksRouter()
    presenter.view = tasksViewController
    interactor.presenter = presenter
    tasksViewController.interactor = interactor
    tasksViewController.router = router
    
    return tasksViewController
  }
  
  func routeToTaskDetails(_ task: Task) {
    guard let rootNavigationController = UIApplication.shared.getRootNavigationController() else {
      return
    }
    TaskDetailsRouter.routeToTaskDetails(task, from: rootNavigationController)
  }
}



