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
        }
        
            if plants.isEmpty {
                if isFirstTime {
                    VStack(spacing: 20) {
                        
                        Image("plantImage")                                .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        
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
                                .fontWeight(.bold)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            .padding(.horizontal, 60)                            }
                    }
                    .padding(.top, 50)
                } else {
                    VStack {
                        
                        Image("plantImage2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        Text("All Done! 🎉")
                            .font(.title)
                            .padding()
                        Text("All Reminders Completed")
                            .font(.subheadline)
                            .padding()
                    }
                }
            } else {
                // عرض قائمة النباتات
                List {
                    ForEach(sortedPlants()) { plant in
                        PlantRow(plant: plant, toggleWatered: toggleWatered)
                            .contentShape(Rectangle()) // لجعل الصف كله قابل للنقر
                            .onTapGesture {
                                selectedPlant = plant
                                showReminderForm = true
                            }
                    }
                    .onDelete { indexSet in
                        plants.remove(atOffsets: indexSet)
                    }
                }
            }
            
            Spacer()
            // هذي لازم اشوف وضعها انها تطلع بعدين مو بالبدايه
            // زر لإضافة تذكير جديد
            Button(action: {
                showReminderForm = true }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color.green)
                        Text("New Reminder")
                            .foregroundColor(Color.green)
                        
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

    //}
    }

 
    // ترتيب النباتات لإظهار غير المكتملة في الأعلى
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
}
// هذي كلاس جديد تابع للترتيب لازم اعدل عليها بالتنسيق

struct PlantRow: View {
    var plant: Plant
    var toggleWatered: (Plant) -> Void

    var body: some View {
        HStack {
            // زر تحديد الري
            Button(action: {
                toggleWatered(plant)
            }) {
                Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(plant.isWatered ? .green : .gray)
            }

            VStack(alignment: .leading) {
                Text("in \(plant.room)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(plant.name)
                    .font(.headline)
       
                // تعديل الألوان والعناصر
                HStack {
                    Label("Full sun", systemImage: "sun.max.fill")
                        .font(.system(size: 14, weight: .light))
                        .padding(3)
                        .foregroundColor(Color.yellow)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    Label("20-50 ml", systemImage: "drop.fill")
                        .font(.system(size: 14, weight: .light))
                        .padding(3)
                        .foregroundColor(Color.blue)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
