//
//  Home.swift
//  LittleLemon
//
//  Created by Bilal Maarbani on 05/06/2023.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        Main()
            .navigationBarBackButtonHidden()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environment(\.managedObjectContext, PersController.shared.container.viewContext)
    }
}
