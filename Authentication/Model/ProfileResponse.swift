//
//  ProfileResponse.swift
//  Authentication
//
//  Created by ahmed sultan on 03/09/2021.
//

import Foundation

struct ProfileResponse : Codable {
    let uuid : String?
    let image : String?
    let firstName : String?
    let lastName : String?
    let address : String?
    let phone : String?

    enum CodingKeys: String, CodingKey {

        case uuid = "uuid"
        case image = "image"
        case firstName = "firstName"
        case lastName = "lastName"
        case address = "address"
        case phone = "phone"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
    }

}
