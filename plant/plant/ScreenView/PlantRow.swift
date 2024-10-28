//
//  PlantRow.swift
//  plant
//
//  Created by atheer alshareef on 28/10/2024.

import SwiftUI
import SwiftData

struct PlantRow: View {
    var plant: Plant
    var toggleWatered: (Plant) -> Void

    var body: some View {
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

            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.gray)
                    Text("in \(plant.room)")
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .light))
                }
                
                Text(plant.name)
                    .font(.system(size: 28, weight: .regular))
                    .foregroundColor(plant.isWatered ? .gray : .primary)

                HStack {
                    Label(plant.sunlightType?.displayName() ?? "Unknown", systemImage: plant.sunlightType?.icon() ?? "questionmark")
                        .font(.system(size: 14, weight: .light))
                        .padding(4)
                        .foregroundColor(plant.isWatered ? .c3.opacity(0.2) : Color.c3)
                        .background(Color.gray.opacity(0.2))
                        .background(plant.isWatered ? .black : .gray.opacity(0.2))
                        .cornerRadius(9)
                    Label(plant.waterAmount, systemImage: "drop")
                        .font(.system(size: 14, weight: .light))
                        .padding(4)
                        .foregroundColor(plant.isWatered ? .c4.opacity(0.2) : Color.c4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(9)
                }
            }
            Spacer()
        }
    }
}
