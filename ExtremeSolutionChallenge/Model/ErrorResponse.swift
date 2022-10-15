//
//  ErrorResponse.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import Foundation

struct ErrorResponse : Codable {
    let code : Int?
    let status : String?
    
    enum CodingKeys: String, CodingKey {

        case code = "code"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
