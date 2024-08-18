//
//  TasksWorker.swift
//  SmartTasks
//
//  Created by Ali Shahid on 08/06/2024.
//

struct TasksWorker {
  private let remoteDataSource: TasksRemoteDataSourceProtocol
  
  init(remoteDataSource: TasksRemoteDataSourceProtocol = TasksRemoteDataSource()) {
    self.remoteDataSource = remoteDataSource
  }
}

extension TasksWorker: TasksWorkerProtocol {
  
  func fetchTasks(completion: @escaping (TasksResponse) -> Void) {
    remoteDataSource.fetchTasks { taskResponse in
      completion(taskResponse)
    }
  }
}
