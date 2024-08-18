//
//  TasksRemoteDataSource.swift
//  SmartTasks
//
//  Created by Ali Shahid on 08/06/2024.
//

import Foundation
import SwiftyJSON

struct TasksRemoteDataSource {
  
  private let networkHelper: NetworkHelperProtocol
  
  private struct APIConstants {
    public static let path = "https://demo1414406.mockable.io/"
  }
  
  init(networkHelper: NetworkHelperProtocol = NetworkHelper()) {
    self.networkHelper = networkHelper
  }
}

extension TasksRemoteDataSource: TasksRemoteDataSourceProtocol {
  
  func fetchTasks(completion: @escaping (TasksResponse) -> Void) {
    let requestInfo = self.requestInfoObject(path: APIConstants.path, forType: .get)
    
    networkHelper.getRequest(requestInfo: requestInfo) { (result: Result<TasksResponse, Error>) in
      switch result {
      case .success(let data):
        completion(data)
        break
      case .failure(let error):
        break
      }
    }
  }
}

private extension TasksRemoteDataSource {
  
  func requestInfoObject(path: String,
                         forType: RequestInfoMethod,
                         parameters: [String: Any]? = nil) -> RequestInfo {
    return RequestInfo(path: path,
                       method: forType,
                       headers: [:],
                       parameters: parameters)
  }
}
