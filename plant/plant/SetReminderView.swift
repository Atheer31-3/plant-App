////
////  Set Reminder.swift
////  plant
////
////  Created by atheer alshareef on 17/10/2024.
//

import SwiftUI

struct SetReminderView: View {
    @Binding var plants: [Plant]
    @State private var name = ""
    @State private var room = "Bedroom"
    @State private var sunlight: SunlightType = .fullSun
    @State private var wateringDays = "Every day"
    @State private var waterAmount = "20-50 ml"
    @Environment(\.presentationMode) var presentationMode
    var plantToEdit: Plant?

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                            .foregroundColor(.white)
                        TextField("Pothos", text: $name)
                            .foregroundColor(.white)
                            .tint(.c1)
                    }
                }
                
                Section {
                    HStack{
                        Image(systemName: "location")
                            .foregroundColor(.white)
                        Picker("Room", selection: $room) {
                            Text("Bedroom").tag("Bedroom")
                            Text("Living Room").tag("Living Room")
                            Text("Kitchen").tag("Kitchen")
                            Text("Balcony").tag("Balcony")
                            Text("Bathroom").tag("Bathroom")
                        }
                    }
                    
                    HStack {
                        Image(systemName: sunlight.icon())
                            .foregroundColor(.white)
                        
                        Picker("Light", selection: $sunlight) {
                            ForEach(SunlightType.allCases, id: \.self) { type in
                                HStack {
                                    Text(type.rawValue)
                                    Image(systemName: type.icon())
                                }.tag(type)
                            }
                        }
                    }
                }
                
                Section {
                    HStack {
                        Image(systemName: "drop")
                            .foregroundColor(.white)
                        Picker("Watering Days", selection: $wateringDays) {
                            Text("Every day").tag("Every day")
                            Text("Every 2 days").tag("Every 2 days")
                            Text("Every 3 days").tag("Every 3 days")
                            Text("Once a week").tag("Once a week")
                            Text("Every 10 days").tag("Every 10 days")
                            Text("Every 2 weeks").tag("Every 2 weeks")
                        }
                    }
                    
                    //   .padding(.vertical, 6)
                    
                    HStack {
                        Image(systemName: "drop")
                            .foregroundColor(.white)
                        Picker("Water Amount", selection: $waterAmount) {
                            Text("20-50 ml").tag("20-50 ml")
                            Text("50-100 ml").tag("50-100 ml")
                            Text("100-200 ml").tag("100-200 ml")
                            Text("200-300 ml").tag("200-300 ml")
                        }
                    }
                }
                
                if plantToEdit != nil {
                    Section {
                        Button(action: deletePlant) {
                            Text("Delete Reminder")
                                .foregroundColor(.c2)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20))
                                .padding(.vertical, 8)
                        }
                    }
                }
                
            }
            .navigationBarTitle(plantToEdit == nil ? "Set Reminder" : "Edit Reminder", displayMode: .inline)
            
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                    .foregroundColor(Color.c1),
                
                trailing: Button("Save") {
                    savePlant()
                }
                    .foregroundColor(Color.c1)
            )
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
