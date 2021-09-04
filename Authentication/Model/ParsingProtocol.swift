//
//  ParsingProtocol.swift
//  Authentication
//
//  Created by ahmed sultan on 04/09/2021.
//

import UIKit

protocol ParsingProtocol {
    func parse<ResponseType: Decodable>(_ jsonDict: [AnyHashable : Any], responseType: ResponseType.Type) -> ResponseType?
}
