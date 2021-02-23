//
//  Result.swift
//  OpenWeather
//
//  Created by Sara Gil González on 12/2/21.
//  Copyright © 2021 Sara Gil González. All rights reserved.
//

import UIKit

class Result: Codable {
    let datos:Datos?
    private enum CodingKeys: String, CodingKey{
        case datos = "data"
    }
}

struct Datos: Codable {
    let current:[Current]?
    let weather:[Weather]?
    private enum CodingKeys: String, CodingKey{
        case current = "current_condition"
        case weather = "weather"
    }
}

struct Current: Codable {
    let temp:String?
    let preci:String?
    let icon: [Icon]?
    let prono:[Prono]?
    private enum CodingKeys: String, CodingKey{
        case temp = "temp_C"
        case preci = "precipMM"
        case icon = "weatherIconUrl"
        case prono = "weatherDesc"
    }
}

struct Icon: Codable {
    let value:String?
    private enum CodingKeys: String, CodingKey{
        case value = "value"
    }
}


struct Prono: Codable {
    let value:String?
    private enum CodingKeys: String, CodingKey{
        case value = "value"
    }
}

struct Weather: Codable {
    let fecha: String?
    let max: String?
    let min:String?
    let hourly:[Hourly]?
    private enum CodingKeys: String, CodingKey{
        case fecha = "date"
        case max = "maxtempC"
        case min = "mintempC"
        case hourly = "hourly"
    }
}

struct Hourly: Codable {
    let icon:[Icon]?
    let prono:[Prono]?
    let preci:String?
    private enum CodingKeys: String, CodingKey{
        case icon = "weatherIconUrl"
        case prono = "weatherDesc"
        case preci = "precipMM"
    }
}
