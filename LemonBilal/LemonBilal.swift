//
//  LemonBilal.swift
//  lLemon
//
//  Created by Bilal Maarbani
//

import SwiftUI

@main
struct LemonBilal: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
