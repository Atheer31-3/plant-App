////
////  Untitled.swift
////  plant
////
////  Created by atheer alshareef on 17/10/2024.
////
//

import SwiftUI

struct HomeView: View {
    @State private var plants: [Plant] = []
    @State private var showReminderForm = false
    @State private var selectedPlant: Plant?
    @State private var isFirstTime = true

    var body: some View {
        VStack {
            
            VStack {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Divider()
                    .background(Color.white)
            }
            
            if !plants.isEmpty {
                VStack(alignment: .leading) {
                    Text("Today")
                        .font(.system(size: 28, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)

                    Spacer().frame(height: 10)
                }
            }

            if plants.isEmpty {
                if isFirstTime {
                    VStack(spacing: 20) {
                        
                        Image("plantImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 150)
                        
                        Text("Start your plant journey!")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 40)
                        
                        Button(action: {
                            showReminderForm = true
                            isFirstTime = false
                        }) {
                            Text("Set Plant Reminder")
                                .font(.system(size: 14, weight: .medium))
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(Color.c1)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .padding(.horizontal, 60)
                        }
                    }
                    .padding(.top, 50)
                } else {
                    VStack(spacing: 15)  {
                        Spacer()
                        Image("plantImage2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 150)
                        Text("All Done! 🎉")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("All Reminders Completed")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 40)
                        
                        Spacer()
                    }
                }
                
            }  else {
                List {
                    ForEach(sortedPlants()) { plant in
                        VStack {
                            PlantRow(plant: plant, toggleWatered: toggleWatered)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            Divider()
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedPlant = plant
                            showReminderForm = true
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deletePlant(plant)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            
            Spacer()

            if !plants.isEmpty || !isFirstTime {
                Button(action: {
                    showReminderForm = true }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color.c1)
                            Text("New Reminder")
                                .foregroundColor(Color.c1)
                            Spacer()
                        }
                        .padding()
                    }
                    .sheet(isPresented: $showReminderForm) {
                        SetReminderView(plants: $plants, plantToEdit: selectedPlant)
                            .onDisappear {
                                selectedPlant = nil
                            }
                    }
            }
        }
    }

    private func sortedPlants() -> [Plant] {
        return plants.sorted { !$0.isWatered && $1.isWatered }
    }

    private func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
            plants = sortedPlants()
        }
    }
    
    private func deletePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: index)
        }
    }
}


struct PlantRow: View {
    var plant: Plant
    var toggleWatered: (Plant) -> Void
    
    var body: some View {
        
        HStack {
            
            HStack {
                Button(action: {
                    toggleWatered(plant)
                }) {
                    Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(plant.isWatered ? .c1 : .gray)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "location")
                        .foregroundColor(.gray)
                    
                    Text("in \(plant.room)")
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .light))
                }
                // هنا لازم اعدل يروح يمين شوي
                Text(plant.name)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(plant.isWatered ? .gray : .primary)
                
                HStack {
                    Label(plant.sunlight.rawValue, systemImage: plant.sunlight.icon())
                        .font(.system(size: 14, weight: .light))
                        .padding(4)
                        .foregroundColor(plant.isWatered ? .gray : Color.c3)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(9)
                    Label(plant.waterAmount, systemImage: "drop")
                        .font(.system(size: 14, weight: .light))
                        .padding(4)
                        .foregroundColor(plant.isWatered ? .gray : Color.c4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(9)
                }
            }
            Spacer()
            
        }
    }

  
}


#Preview {
    HomeView()
}
