//
//  SatData.swift
//  20211222-TeddyDemilew-NYCSchools
//
//  Created by Teddy Demilew on 12/22/21.
//

import Foundation

struct SatData: Codable {
    var dbn: String
    var schoolName: String?
    var numberOfSatTakers: String?
    var mathScore: String?
    var readingScore: String?
    var writingScore: String?

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numberOfSatTakers = "num_of_sat_test_takers"
        case mathScore = "sat_math_avg_score"
        case readingScore = "sat_critical_reading_avg_score"
        case writingScore = "sat_writing_avg_score"
    }
}
