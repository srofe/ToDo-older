//
//  APIClient.swift
//  ToDo
//
//  Created by Simon Rofe on 6/1/18.
//  Copyright © 2018 Simon Rofe. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case DataEmptyError
}

class APIClient {
    lazy var session: SessionProtocol = URLSession.shared

    func loginUser(withName username: String, password: String, completion: @escaping (Token?, Error?) -> Void) {
        let query = "username=\(username.percentEncoded)&password=\(password.percentEncoded)"
        guard let url = URL(string: "https://awsometodos.com/login?\(query)") else { fatalError() }
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, WebServiceError.DataEmptyError)
                return
            }
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String]

                var token: Token?
                if let tokenString = dict?["token"] {
                    token = Token(id: tokenString)
                } else {
                    token = nil
                }
                completion(token, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

protocol SessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}

extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { fatalError() }

        return encoded
    }
}
