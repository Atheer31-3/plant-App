//
//  Set Reminder.swift
//  plant
//
//  Created by atheer alshareef on 17/10/2024.

//  Bedroom
//Living Room
//Kitchen
//Balcony
//Bathroom

//􀆭  Light
//􀆭 Full Sun
//􀆷 Partial Sun
//􀆹 Low Light

//􀠑  Watering Days
//Every day
//Every 2 days
//Every 3 days
//Once a week
//Every 10 days
//Every 2 weeks
//􀠑  Water
//20-50 ml
//50-100 ml
//100-200 ml
//200-300 ml

import SwiftUI

struct SetReminderView: View {
    @Binding var plants: [Plant]
    @State private var name = ""
    @State private var room = "Bedroom"
    @State private var sunlight = "Full sun"
    @State private var wateringDays = "Every day"
    @State private var waterAmount = "20-50 ml"
    @Environment(\.presentationMode) var presentationMode
    var plantToEdit: Plant? 

    var body: some View {
        NavigationView {
            Form {
                TextField("Plant Name", text: $name)
                
                Picker("Room", selection: $room) {
                    Text("Bedroom").tag("Bedroom")
                    Text("Living Room").tag("Living Room")
                    Text("Kitchen").tag("Kitchen")
                    Text("Balcony").tag("Balcony")
                    Text("Bathroom").tag("Bathroom")
                }
                
                Picker(" Light", selection: $sunlight) {
                    Text("􀆭 Full Sun").tag("Full Sun")
                    Text("Partial Sun").tag("Partial Sun")
                    Text("Low Light").tag("Low Light")
                }
                      
                Picker("Watering Days", selection: $wateringDays) {
                    Text("Every day").tag("Every day")
                    Text("Every 2 days").tag("20-50 ml")
                    Text("Every 3 days").tag("Every 3 days")
                    Text("Once a week").tag("Once a week")
                    Text("Every 10 days").tag("Every 10 days")
                    Text("Every 2 weeks").tag("Every 2 weeks")
                }
                //TextField("Watering Days", text: $waterAmount)
                Picker("Watering Days", selection: $waterAmount) {
                    Text("20-50 ml").tag("Every day")
                    Text("50-100 ml").tag("50-100 ml")
                    Text("100-200 ml").tag("100-200 ml")
                    Text("Once a week").tag("Once a week")
                    Text("200-300 ml").tag("200-300 ml")
                }
                                           
                if plantToEdit != nil {
                    Button(action: deletePlant) {
                        Text("Delete Reminder")
                            .foregroundColor(.red)
                    }
                }

            }
            // her most change color to color design Cancel,Save
            .navigationBarTitle(plantToEdit == nil ? "Set Reminder" : "Edit Reminder", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                savePlant()
            })
            .onAppear {
                if let plant = plantToEdit {
                    name = plant.name
                    room = plant.room
                    sunlight = plant.sunlight
                    wateringDays = plant.wateringDays
                    waterAmount = plant.waterAmount
                }
            }
        }
    }


    private func savePlant() {
        if let plant = plantToEdit {
            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                plants[index] = Plant(id: plant.id, name: name, room: room, sunlight: sunlight, wateringDays: wateringDays, waterAmount: waterAmount)
            }
        } else {
            let newPlant = Plant(name: name, room: room, sunlight: sunlight, wateringDays: wateringDays, waterAmount: waterAmount)
            plants.append(newPlant)
        }
        presentationMode.wrappedValue.dismiss()
    }

    private func deletePlant() {
        if let plant = plantToEdit, let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: index)
        }
        presentationMode.wrappedValue.dismiss()
    }
}

