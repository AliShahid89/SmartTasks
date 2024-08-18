//
//  NetworkHelper.swift
//  SmartTasks
//
//  Created by Ali Shahid on 08/06/2024.
//

import Alamofire

protocol NetworkHelperProtocol {
  func getRequest<T: Decodable>(requestInfo: RequestInfo, completion: @escaping (Result<T, Error>) -> Void)
}

struct NetworkHelper {
  static var session: Session?
  
  init() {
    let configuration = URLSessionConfiguration.default
    if NetworkHelper.session == nil {
      NetworkHelper.session = Session(configuration: configuration)
    }
  }
}

extension NetworkHelper: NetworkHelperProtocol {
  
  func getRequest<T: Decodable>(requestInfo: RequestInfo, completion: @escaping (Result<T, Error>) -> Void) {
    
    NetworkHelper.session?.request(
      requestInfo.path,
      method: HTTPMethod(rawValue: requestInfo.method),
      parameters: requestInfo.parameters,
      headers: HTTPHeaders(requestInfo.headers ?? [:]),
      interceptor: nil)
    .validate()
    .responseDecodable(of: T.self) { response in
      switch response.result {
      case .success(let decodedObject):
        completion(.success(decodedObject))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

struct RequestInfo {
  public let path: String
  public let method: String
  public let headers: [String: String]?
  public let parameters: [String: Any]?
  
  init(path: String,
       method: RequestInfoMethod,
       headers: [String: String]?,
       parameters: [String: Any]?) {
    
    self.path = path
    self.method = method.rawValue
    self.headers = headers
    self.parameters = parameters
  }
}

enum RequestInfoMethod: String {
  case get = "GET"
  case post = "POST"
}
