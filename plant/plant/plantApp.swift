//
//  plantApp.swift
//  plant
//
//  Created by atheer alshareef on 17/10/2024.
//

import SwiftUI
@main
struct plantApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.dark)
                .modelContainer(for: Plant.self)
        }
    }
}

