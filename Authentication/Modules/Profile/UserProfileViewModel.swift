//
//  UserProfileViewModel.swift
//  Authentication
//
//  Created by ahmed sultan on 03/09/2021.
//

import Foundation

struct UserProfileViewModel {
    
    var fullName:String
    var address:String
    var phoneNumber:String
    var userImageUrl:URL?
    
    init(profile: ProfileResponse) {
        fullName = "\(profile.firstName ?? "") \(profile.lastName ?? "")"
        address = profile.address ?? ""
        phoneNumber = profile.phone ?? ""
        userImageUrl = URL(string: profile.image ?? "")
    }
}
