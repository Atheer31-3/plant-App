//
//  Untitled.swift
//  plant
//
//  Created by atheer alshareef on 28/10/2024.
//

import SwiftData
import SwiftUI

class PlantViewModel: ObservableObject {
    @Published var selectedPlant: Plant?
    @Published var showReminderForm = false
    @Published var isFirstTime = true
    @Published  var plantToEdit: Plant?
    @Published  var name = ""
    @Published  var room = "Bedroom"
    @Published  var sunlight : Int = SunlightType.fullSun.rawValue
    @Published  var wateringDays = "Every day"
    @Published  var waterAmount = "20-50 ml"
    
    func clearSelectedPlant() {
        self.selectedPlant = nil
    }
    
    
    
}
