//
//  Main.swift
//  LittleLemon
//
//  Created by Bilal Maarbani on 05/06/2023.
//

import SwiftUI

struct Main: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            VStack {
                Header()
                Menu()
            }
        }
    }
}

struct MainPreviews: PreviewProvider {
    static var previews: some View {
        Main().environment(\.managedObjectContext, PersController.shared.container.viewContext)
    }
}
