//
//  Set Reminder.swift
//  plant
//
//  Created by atheer alshareef on 17/10/2024.

import SwiftUI
import SwiftData

struct SetReminderView: View {
    @ObservedObject var viewModel: PlantViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                         Text("Plant Name")
                         .foregroundColor(.white)
                        TextField("Pothos", text: $viewModel.name)
                         .foregroundColor(.white)
                         .tint(.c1)
                    }
                }
                Section {
                    HStack{
                    Image(systemName: "location")
                    .foregroundColor(.white)
                        Picker("Room", selection: $viewModel.room) {
                         Text("Bedroom").tag("Bedroom")
                         Text("Living Room").tag("Living Room")
                         Text("Kitchen").tag("Kitchen")
                         Text("Balcony").tag("Balcony")
                         Text("Bathroom").tag("Bathroom")
                       }
                    }
                    HStack {
                        Image(systemName: "sun.max")
                        .foregroundColor(.white)
                        Picker("Light", selection: $viewModel.sunlight) {
                            ForEach(SunlightType.allCases, id: \.self) { type in
                                HStack {
                                    Image(systemName: type.icon())
                                    Text(type.displayName())
                                }
                                .tag(type.rawValue)
                            }
                        }
                    }

                }
                Section {
                    HStack{
                        Image(systemName: "drop")
                            .foregroundColor(.white)
                        Picker("Watering Days", selection: $viewModel.wateringDays) {
                            Text("Every day").tag("Every day")
                            Text("Every 2 days").tag("Every 2 days")
                            Text("Every 3 days").tag("Every 3 days")
                            Text("Once a week").tag("Once a week")
                            Text("Every 10 days").tag("Every 10 days")
                            Text("Every 2 weeks").tag("Every 2 weeks")
                        }
                    }
                    HStack{
                        Image(systemName: "drop")
                            .foregroundColor(.white)
                        Picker("Water", selection: $viewModel.waterAmount) {
                            Text("20-50 ml").tag("20-50 ml")
                            Text("50-100 ml").tag("50-100 ml")
                            Text("100-200 ml").tag("100-200 ml")
                            Text("200-300 ml").tag("200-300 ml")
                        }
                    }
                }
                
                if viewModel.selectedPlant != nil {
                    Section {
                        Button(action: {
                            if let plant = viewModel.selectedPlant {
                                modelContext.delete(plant)
                            }
                            viewModel.clearSelectedPlant()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Delete Reminder")
                                .foregroundColor(.c2)
                                .font(.system(size: 20))
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 6)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            .navigationTitle(viewModel.selectedPlant == nil ? "Add Reminder" : "Edit Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                    .foregroundColor(.c1),
                trailing: Button("Save") {
                    savePlant()
                    presentationMode.wrappedValue.dismiss()
                }
                    .foregroundColor(.c1)
            )
            .onAppear {
                if let plant = viewModel.selectedPlant {
                    viewModel.name = plant.name
                    viewModel.room = plant.room
                    viewModel.sunlight = viewModel.sunlight
                    viewModel.wateringDays = plant.wateringDays
                    viewModel.waterAmount = plant.waterAmount
                }
            }
        }
    }
    
     func deletePlant() {
        if let plant = viewModel.plantToEdit {
            modelContext.delete(plant)
        }
        presentationMode.wrappedValue.dismiss()
    }

     func savePlant() {
        if let plant = viewModel.selectedPlant {
            plant.name = viewModel.name
            plant.room = viewModel.room
            plant.sunlight = viewModel.sunlight
            plant.wateringDays = viewModel.wateringDays
            plant.waterAmount = viewModel.waterAmount
        } else {
            _ = SunlightType(rawValue: viewModel.sunlight)?.rawValue ?? SunlightType.fullSun.rawValue
            let newPlant = Plant(
                name: viewModel.name,
                room: viewModel.room,
                sunlight: SunlightType(rawValue: viewModel.sunlight) ?? .fullSun,
                wateringDays: viewModel.wateringDays,
                waterAmount: viewModel.waterAmount
            )
            modelContext.insert(newPlant)
        }
        viewModel.clearSelectedPlant()
        viewModel.name = ""
        viewModel.room = ""
        
    }
}

