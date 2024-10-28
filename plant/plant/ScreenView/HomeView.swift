//////
//////  Untitled.swift
//////  plant
//////
//////  Created by atheer alshareef on 17/10/2024.
//////
////
//
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var viewModel = PlantViewModel()
    @Query var plants: [Plant]
    
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
                if viewModel.isFirstTime {
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
                            viewModel.showReminderForm = true
                            viewModel.isFirstTime = false
                        }) {
                            Text("Set Plant Reminder")
                                .font(.system(size: 14, weight: .bold))
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
                    VStack {
                        Spacer()
                        Image("plantImage2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 150)
                        Text("All Done! 🎉")
                            .font(.title)
                            .padding()
                        Text("All Reminders Completed")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 40)
                        Spacer()
                    }
                }
            } else {
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
                            viewModel.selectedPlant = plant
                            viewModel.showReminderForm = true
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
            
            if !plants.isEmpty || !viewModel.isFirstTime {
                Button(action: {
                    viewModel.showReminderForm = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color.c1)
                        Text("New Reminder")
                            .foregroundColor(Color.c1)
                        Spacer()
                    }
                    .padding()
                }
                .sheet(isPresented: $viewModel.showReminderForm) {
                    SetReminderView(viewModel: viewModel)
                        .onDisappear {
                            viewModel.selectedPlant = nil
                        }
                }
            }
        }
    }

     func sortedPlants() -> [Plant] {
        return plants.sorted { !$0.isWatered && $1.isWatered }
    }

     func deletePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            withAnimation {
                let plantToDelete = plants[index]
                modelContext.delete(plantToDelete)
            }
        }
    }

     func toggleWatered(_ plant: Plant) {
        plant.isWatered.toggle()
        try? modelContext.save()
    }


}

