//
//  EvolveAssignmentApp.swift
//  EvolveAssignment
//
//  Created by Ganpat Jangir on 29/11/24.
//

import SwiftUI

@main
struct EvolveAssignmentApp: App {
    
    init() {
        let memoryCapacity = 20 * 1024 * 1024 // 20 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "EvolveCache")
        URLCache.shared = cache
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
