//
//  Plant.swift
//  plant
//
//  Created by atheer alshareef on 17/10/2024.

import SwiftData

@Model
class Plant {
    var name: String
    var room: String
    var sunlight: Int
    var wateringDays: String
    var waterAmount: String
    var isWatered: Bool
    
    init(name: String, room: String, sunlight: SunlightType, wateringDays: String, waterAmount: String, isWatered: Bool = false) {
        self.name = name
        self.room = room
        self.sunlight = sunlight.rawValue
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
        self.isWatered = isWatered
    }
    var sunlightType: SunlightType? {
           get { SunlightType(rawValue: sunlight) }
           set { sunlight = newValue?.rawValue ?? SunlightType.fullSun.rawValue }
       }
}


enum SunlightType: Int, CaseIterable {
    case fullSun = 0
    case partialSun = 1
    case lowLight = 2

    func icon() -> String {
        switch self {
        case .fullSun: return "sun.max"
        case .partialSun: return "sun.haze"
        case .lowLight: return "moon"
        }
    }

    func displayName() -> String {
        switch self {
        case .fullSun: return "Full Sun"
        case .partialSun: return "Partial Sun"
        case .lowLight: return "Low Light"
        }
    }
}



