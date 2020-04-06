//
//  APIClient.swift
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//  Revisado por Roberto Garrido on 8 de Marzo de 2020
//

import Foundation
import UIKit

enum SessionAPIError: Error {
    case emptyData
}

/// Clase de utilidad para llamar al API. El método Send recibe una Request que implementa APIRequest y tiene un tipo Response asociado
final class SessionAPI {
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func sendWithNoJsonResponse<T: APIRequest>(request: T, completion: @escaping(Result<Void, Error>) -> ()) {
        let request = request.requestWithBaseUrl()
        let task = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200{
                DispatchQueue.main.async {
                    completion(.success(()))
                    return
                }
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func sendArray<T: APIRequest>(request: T, completion: @escaping(Result<[T.Response], Error>) -> ()){
        let request = request.requestWithBaseUrl()
        let task = session.dataTask(with: request) { data, response, error in
            do {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode >= 400 && response.statusCode < 500 {
                    if let data = data {
                        print("what?")
                        print(response.statusCode)
                        let errorModel = try JSONDecoder().decode(DiscourseAPIError.self, from: data)
                        DispatchQueue.main.async {
                            let errorString = errorModel.errors?.joined(separator: ", ") ?? "Unknown error"
                            completion(.failure(NSError(domain: "request error", code: 0, userInfo: [NSLocalizedDescriptionKey: errorString])))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(SessionAPIError.emptyData))
                        }
                    }
                }
                if let data = data {
                    //                    let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
                    //                    print(json)
                    print(data)
                    print(String(data: data, encoding: .utf8))
                    let model = try JSONDecoder().decode([T.Response].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(SessionAPIError.emptyData))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func send<T: APIRequest>(request: T, completion: @escaping(Result<T.Response, Error>) -> ()) {

        let request = request.requestWithBaseUrl()
        let task = session.dataTask(with: request) { data, response, error in
            do {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode >= 400 && response.statusCode < 500 {
                    if let data = data {
                        let errorModel = try JSONDecoder().decode(DiscourseAPIError.self, from: data)
                        DispatchQueue.main.async {
                            let errorString = errorModel.errors?.joined(separator: ", ") ?? "Unknown error"
                            completion(.failure(NSError(domain: "request error", code: 0, userInfo: [NSLocalizedDescriptionKey: errorString])))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(SessionAPIError.emptyData))
                        }
                    }
                }
                if let data = data {
//                    let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
//                    print(json)
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(SessionAPIError.emptyData))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

struct DiscourseAPIError: Codable {
    let action: String?
    let errors: [String]?
}
