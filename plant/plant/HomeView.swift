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
        //  NavigationView {
        VStack{
            
            VStack {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Divider()
                    .background(Color.white)
            }
            
            if plants.isEmpty {
                if isFirstTime {
                    VStack(spacing: 20) {
                        
                        Image("plantImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
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
                    VStack(spacing: 20)  {
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
                    }
                }
            }else {
                // عرض قائمة النباتات
                List {
                    ForEach(sortedPlants()) { plant in
                        PlantRow(plant: plant, toggleWatered: toggleWatered)
                            .contentShape(Rectangle()) // لجعل الصف كله قابل للنقر
                            .onTapGesture {
                                selectedPlant = plant
                                showReminderForm = true
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deletePlant(plant)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
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
    //}
    }
    
    private func sortedPlants() -> [Plant] {
        return plants.sorted { !$0.isWatered && $1.isWatered }
    }

    // تغيير حالة الري
    private func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
            plants = sortedPlants() // تحديث القائمة
        }
    }
    // حذف النبات من القائمة
      private func deletePlant(_ plant: Plant) {
          if let index = plants.firstIndex(where: { $0.id == plant.id }) {
              plants.remove(at: index)
          }
      }
}
// هذي كلاس جديد تابع للترتيب لازم اعدل عليها بالتنسيق

struct PlantRow: View {
    var plant: Plant
    var toggleWatered: (Plant) -> Void

    var body: some View {
        HStack {
            Button(action: {
                toggleWatered(plant)
            }) {
                Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(plant.isWatered ? .c1 : .gray)
            }

            VStack(alignment: .leading) {
                Text(" \(plant.room)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(plant.name)
                    .font(.headline)
       
                HStack {
                    Label("Full sun", systemImage: "sun.max")
                        .font(.system(size: 14, weight: .light))
                        .padding(3)
                        .foregroundColor(Color.yellow)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    Label("20-50 ml", systemImage: "drop")
                        .font(.system(size: 14, weight: .light))
                        .padding(3)
                        .foregroundColor(Color.blue)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            Spacer()
           // Divider
        }
    }
}

#Preview {
    HomeView()
}
