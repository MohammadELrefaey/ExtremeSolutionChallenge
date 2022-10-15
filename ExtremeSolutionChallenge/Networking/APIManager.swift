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
     func request<T: Decodable>(route: APIRouter, completion:  @escaping (T?, Error?) -> ()) {
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
                        completion(results, nil)

                    }
//                    else {
//                        guard let data = response.data else { return }
//                        let results = try JSONDecoder().decode(ErrorResponse.self, from: data)
//                        print("PARSED ERROR RESPONSE IS: \(results)")
//                        completion(nil, results, nil)
//                    }


                    
                } catch let error {
                    print ("Catch Parsing \(error) ")
                    completion(nil, error)
                }

            case .failure(let error):
                completion(nil, error)
            }


        }
    }
    
    func getCharacters(offset: Int, searchQuery: String? = nil, completion: @escaping (MainResponse<CharacterResponse>?, Error?) -> ()) {
        request(route: .getCharacters(offset: offset, searchQuery: searchQuery)) { response, error in
            completion(response, error)
        }
    }
    
    func getItem(uri: String, completion: @escaping (MainResponse<ItemResponse>?, Error?) -> ()) {
        request(route: .getItem(uri: uri)) { response, error in
            completion(response, error)
        }
    }


}
