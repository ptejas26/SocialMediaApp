
import Foundation


struct UserModel: Codable {
    
    internal init(address: Addres? = nil, company: Company? = nil, email: String? = nil, id: Int? = nil, name: String? = nil, phone: String? = nil, username: String? = nil, website: String? = nil) {
        self.address = address
        self.company = company
        self.email = email
        self.id = id
        self.name = name
        self.phone = phone
        self.username = username
        self.website = website
    }
    

    let address : Addres?
    let company : Company?
    let email : String?
    let id : Int?
    let name : String?
    let phone : String?
    let username : String?
    let website : String?


    enum CodingKeys: String, CodingKey {
        case address
        case company
        case email = "email"
        case id = "id"
        case name = "name"
        case phone = "phone"
        case username = "username"
        case website = "website"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(Addres.self, forKey: .address)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        website = try values.decodeIfPresent(String.self, forKey: .website)
    }
}

