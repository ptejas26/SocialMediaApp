//
//	Addres.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Addres : Codable {
    internal init(city: String? = nil, geo: Geo? = nil, street: String? = nil, suite: String? = nil, zipcode: String? = nil) {
        self.city = city
        self.geo = geo
        self.street = street
        self.suite = suite
        self.zipcode = zipcode
    }
    

	let city : String?
	let geo : Geo?
	let street : String?
	let suite : String?
	let zipcode : String?


	enum CodingKeys: String, CodingKey {
		case city = "city"
		case geo
		case street = "street"
		case suite = "suite"
		case zipcode = "zipcode"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		geo = try Geo(from: decoder)
		street = try values.decodeIfPresent(String.self, forKey: .street)
		suite = try values.decodeIfPresent(String.self, forKey: .suite)
		zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
	}


}
