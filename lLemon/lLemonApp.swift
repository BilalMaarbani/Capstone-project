//
//  lLemonApp.swift
//  lLemon
//
//  Created by Artem Listopadov on 30.05.23.
//

import SwiftUI

@main
struct lLemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
