//
//  APIRouter.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 14/10/2022.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
        
    case getCharacters(offset: Int, searchQuery: String?)
    case getItem(uri: String)
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getCharacters: return "characters"
            
        default:
            return ""
        }
    }
        
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        default: return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let ts = "\(Int((Date().timeIntervalSince1970 * 1000.0).rounded()))"
        let publicKey = ApiConstants.publicKey
        let privateKey = ApiConstants.privateKey
        let privateKeyMd5 = ("\(ts)\(privateKey)\(publicKey)").MD5Hex()
        var requestParams = [String : String]()

        var baseUrl = ""
        
        switch self {
        case .getCharacters(let offset, let searchQuery):
             baseUrl = ApiConstants.baseUrl + path

            requestParams["offset"] = "\(offset)"
            if let searchQuery = searchQuery {
                requestParams["nameStartsWith"] = searchQuery
            }
            
        case .getItem(let uri):
            baseUrl = uri
        }
        
        requestParams["ts"] = ts
        requestParams["apikey"] = publicKey
        requestParams["hash"] = privateKeyMd5
        requestParams["limit"] = "10"
        //build query string
        var queryItems = [URLQueryItem]()
        for (key, value) in requestParams {
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        print("URLS REQUEST :\(urlRequest)")

        
        // Parameters
        if let parameters = parameters {
            do {
                print("PARAMETERS IS: \(parameters)")
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        // Encoding
        print("URLS REQUEST :\(urlRequest)")
        
        return urlRequest as URLRequest
        
        
    }
}
