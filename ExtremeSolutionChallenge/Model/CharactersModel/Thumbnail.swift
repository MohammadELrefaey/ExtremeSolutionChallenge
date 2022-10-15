//
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 11/10/2022.
//



import Foundation
struct Thumbnail : Codable {
	let path : String?
	let extension_ : String?

	enum CodingKeys: String, CodingKey {

		case path = "path"
		case extension_ = "extension"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		path = try values.decodeIfPresent(String.self, forKey: .path)
		extension_ = try values.decodeIfPresent(String.self, forKey: .extension_)
	}

}
