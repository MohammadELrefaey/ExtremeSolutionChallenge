//
//  APIManager.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 14/10/2022.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()

    //MARK:- Request
     func request<T: Decodable>(route: APIRouter, completion:  @escaping (T?,ErrorResponse?, Error?) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(route).responseData { response in
            print("RESPONSE IS \(response)")

            switch response.result {
            case .success(_):
                do {
                    if  response.response?.statusCode == 200 {
                        guard let data = response.data else { return }
                        let results = try JSONDecoder().decode(T.self, from: data)
                        print("PARSED SUCCEED RESPONSE IS: \(results)")
                        completion(results,nil, nil)

                    }
                    else {
                        guard let data = response.data else { return }
                        let results = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        print("PARSED ERROR RESPONSE IS: \(results)")
                        completion(nil, results, nil)
                    }


                    
                } catch let error {
                    print ("Catch Parsing \(error) ")
                    completion(nil, nil, error)
                }

            case .failure(let error):
                completion(nil, nil, error)
            }


        }
    }
    
    func getCharacters(offset: Int, searchQuery: String? = nil, completion: @escaping (MainResponse<CharacterResponse>?, ErrorResponse?, Error?) -> ()) {
        request(route: .getCharacters(offset: offset, searchQuery: searchQuery)) { response, errorResponse, error in
            completion(response, errorResponse, error)
        }
    }
    
    func getItem(uri: String, completion: @escaping (MainResponse<ItemResponse>?, ErrorResponse?, Error?) -> ()) {
        request(route: .getItem(uri: uri)) { response, errorResponse, error in
            completion(response, errorResponse, error)
        }
    }


}
