//
//  APIService.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 02/03/23.
//

import Foundation

enum CustomAPIError: String, Error {
    case forbidden = "FORBIDDEN"
    case unknown = "unknown"
    case tokenExpired = "tokenExpired"
}

enum HttpMethodType : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIService {
    static let shared = APIService()
    private let timeInterval = 60
    func makeApiTypeRequest<T: Codable>(
        url: String,
        param: [String: Any]? = nil,
        methodType: HttpMethodType,
        expecting: T.Type,
        passToken: Bool = true,
        completion: @escaping (Result<T, Error>, _ data:Data?)->Void) {
            
            guard let url = URL(string: url) else {
                return
            }
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: TimeInterval(timeInterval))
            if let param = param {
                let finalData = try? JSONSerialization.data(withJSONObject: param)
                request.httpBody = finalData
            }
            
            request.httpMethod = methodType.rawValue //"post"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        
            
            if passToken {
                let data = KeychainHelper.standard.read(service: Constants.tokenKey)
                if let data = data {
                    let accessToken = String(data: data, encoding: .utf8)
                    if let accessToken, accessToken != "" {
                        //let headers = ["Content-Type": "application/json", "token": "Bearer " + accessToken]
                        let headers = ["Content-Type": "application/json", "token": accessToken]
                        print("accessToken::: \(accessToken)")
                        request.allHTTPHeaderFields = headers
                    }
                }
            }
        
            
            
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            do {
                
                if let error = error {
                    completion(.failure(error), data)
                    return
                }
                
//                if let data = data {
//                        do {
//                            let a = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                            print("check \(a)")
//                        } catch {
//                            print("ERROR \(error.localizedDescription)")
//                        }
//                    }
                
                
                if let data = data {
                    if let httpStatus = response as? HTTPURLResponse {
                        print("Status code::: \(httpStatus.statusCode)")
                        switch httpStatus.statusCode {
                        case 400:
                            completion(.failure(CustomAPIError.forbidden), data)
                        case 200:
                            let resp = String(decoding: data, as: UTF8.self)
                            print("JSON Response: \(resp)")
                            let respObj = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(respObj), data)
                        case 500:
                            // token expired
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: Notification.Name("test.token.expired"), object: nil)
                            }
                            completion(.failure(CustomAPIError.tokenExpired), data)
                        default:
                            completion(.failure(CustomAPIError.unknown), data)
                        }
                    }
                    
                } else {
                    completion(.failure(CustomAPIError.unknown), data)
                    print("no data found")
                }
            } catch(let error) {
                completion(.failure(CustomAPIError.unknown), nil)
                print("Error A123::: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
    
    
    
    func makeApiTypeRequest2<T: Codable>(
        url: String,
        param: [String: Any]? = nil,
        methodType: HttpMethodType,
        expecting: T.Type,
        passToken: Bool = true,
        completion: @escaping ((Bool), _ data:Data?)->Void) {
            
            guard let url = URL(string: url) else {
                return
            }
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: TimeInterval(timeInterval))
            if let param = param {
                let finalData = try? JSONSerialization.data(withJSONObject: param)
                request.httpBody = finalData
            }
            
            request.httpMethod = methodType.rawValue //"post"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        
            
            if passToken {
                let data = KeychainHelper.standard.read(service: Constants.tokenKey)
                if let data = data {
                    let accessToken = String(data: data, encoding: .utf8)
                    if let accessToken, accessToken != "" {
                        //let headers = ["Content-Type": "application/json", "token": "Bearer " + accessToken]
                        let headers = ["Content-Type": "application/json", "token": accessToken]
                        print("accessToken::: \(accessToken)")
                        request.allHTTPHeaderFields = headers
                    }
                }
            }
        
            
            
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            do {
                
                if let error = error {
                    completion(false, data)
                    return
                }
                
//                if let data = data {
//                        do {
//                            let a = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                            print("check \(a)")
//                        } catch {
//                            print("ERROR \(error.localizedDescription)")
//                        }
//                    }
                
                
                if let data = data {
                    if let httpStatus = response as? HTTPURLResponse {
                        print("Status code::: \(httpStatus.statusCode)")
                        switch httpStatus.statusCode {
                        case 400:
                            completion(false, data)
                        case 200:
                            let resp = String(decoding: data, as: UTF8.self)
                            print("JSON Response: \(resp)")
                            let respObj = try JSONDecoder().decode(T.self, from: data)
                            completion(true, data)
                        case 500:
                            // token expired
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: Notification.Name("test.token.expired"), object: nil)
                            }
                            completion(false, data)
                        default:
                            completion(false, data)
                        }
                    }
                    
                } else {
                    completion(false, data)
                    print("no data found")
                }
            } catch(let error) {
                completion(false, nil)
                print("Error A123::: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
    
    
    func parseModel<T: Codable>(
        data: Data,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>, _ data:Data?)->Void) {
            do {
                let respObj = try JSONDecoder().decode(T.self, from: data)
                completion(.success(respObj), data)
            } catch {
                completion(.failure(CustomAPIError.unknown), nil)
            }
            
        }
    
}

