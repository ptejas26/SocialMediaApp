//
//	Company.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Company : Codable {
    internal init(bs: String? = nil, catchPhrase: String? = nil, name: String? = nil) {
        self.bs = bs
        self.catchPhrase = catchPhrase
        self.name = name
    }
    

	let bs : String?
	let catchPhrase : String?
	let name : String?


	enum CodingKeys: String, CodingKey {
		case bs = "bs"
		case catchPhrase = "catchPhrase"
		case name = "name"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bs = try values.decodeIfPresent(String.self, forKey: .bs)
		catchPhrase = try values.decodeIfPresent(String.self, forKey: .catchPhrase)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}


}
