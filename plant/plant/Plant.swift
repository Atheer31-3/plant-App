//
//  Plant.swift
//  plant
//
//  Created by atheer alshareef on 17/10/2024.
// data for plantas

import SwiftUI
struct Plant: Identifiable {
    var id = UUID()
    var name: String
    var room: String
    var sunlight: String
    var wateringDays: String
    var waterAmount: String
    var isWatered: Bool = false

    // Custom initializer
    init(id: UUID = UUID(), name: String, room: String, sunlight: String, wateringDays: String, waterAmount: String, isWatered: Bool = false) {
        self.id = id
        self.name = name
        self.room = room
        self.sunlight = sunlight
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
        self.isWatered = isWatered
    }
}
