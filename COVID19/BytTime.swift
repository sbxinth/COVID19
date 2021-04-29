//
//  BytTime.swift
//  COVID19
//
//  Created by Rachapol Burinwatthana on 27/4/2564 BE.
//

import Foundation

// MARK: - Bytime
struct Bytime: Codable {
    let updateDate: String
    let source, devBy, severBy: String
    let data: [Datum]?

    enum CodingKeys: String, CodingKey {
        case updateDate = "UpdateDate"
        case source = "Source"
        case devBy = "DevBy"
        case severBy = "SeverBy"
        case data = "Data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let date: String
    let newConfirmed, newRecovered, newHospitalized, newDeaths: Int
    let confirmed, recovered, hospitalized, deaths: Int

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case newConfirmed = "NewConfirmed"
        case newRecovered = "NewRecovered"
        case newHospitalized = "NewHospitalized"
        case newDeaths = "NewDeaths"
        case confirmed = "Confirmed"
        case recovered = "Recovered"
        case hospitalized = "Hospitalized"
        case deaths = "Deaths"
    }
}
