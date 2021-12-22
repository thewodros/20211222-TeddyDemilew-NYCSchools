//
//  School.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import Foundation

struct School: Codable {
    
    var dbn: String
    var name: String?
    var overview: String?
    var phone: String?
    var email: String?
    var website: String?
    var location: String?
    var city: String?
    var zip: String?
    var state: String?
    var lat: String?
    var lng: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case overview = "overview_paragraph"
        case phone = "phone_number"
        case email = "school_email"
        case website
        case location
        case city
        case zip
        case state = "state_code"
        case lat = "latitude"
        case lng = "longitude"
    }
}
