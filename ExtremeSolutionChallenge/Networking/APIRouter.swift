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
        }
    }
        
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
//        case .getCharacters(let page):
//            let param = ["offset": page]
//            return param
        default: return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let baseUrl = ApiConstants.baseUrl + path
        let ts = "\(Int((Date().timeIntervalSince1970 * 1000.0).rounded()))"
        let publicKey = ApiConstants.publicKey
        let privateKey = ApiConstants.privateKey
        let privateKeyMd5 = ("\(ts)\(privateKey)\(publicKey)").MD5Hex()
        var requestParams = [String : String]()
        requestParams["ts"] = ts
        requestParams["apikey"] = publicKey
        requestParams["hash"] = privateKeyMd5
        requestParams["limit"] = "10"

        switch self {
        case .getCharacters(let page, let searchQuery):
            requestParams["offset"] = "\(page)"
            if let searchQuery = searchQuery {
                requestParams["nameStartsWith"] = searchQuery
            }
        }

        
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
//        if  path.contains("confirm") || path.contains("login") || path.contains("phone_number") || path.contains("revoke") || path.contains("intention") {
//            return try JSONEncoding.default.encode(urlRequest, with: parameters)
//        }
        print("URLS REQUEST :\(urlRequest)")
        
        return urlRequest as URLRequest
        
        
    }
}
