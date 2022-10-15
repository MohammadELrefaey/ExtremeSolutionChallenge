//
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 11/10/2022.
//

import Foundation
struct ResponseData<T: Codable> : Codable {
	let offset : Int?
	let limit : Int?
	let total : Int?
	let count : Int?
	let results : [T]?

	enum CodingKeys: String, CodingKey {

		case offset = "offset"
		case limit = "limit"
		case total = "total"
		case count = "count"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		offset = try values.decodeIfPresent(Int.self, forKey: .offset)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		count = try values.decodeIfPresent(Int.self, forKey: .count)
		results = try values.decodeIfPresent([T].self, forKey: .results)
	}

}
