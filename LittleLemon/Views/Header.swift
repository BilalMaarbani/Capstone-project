//
//  Header.swift
//  LittleLemon
//
//  Created by Bilal Maarbani on 05/06/2023.
//

import Foundation
import SwiftUI

struct Header: View {
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image("logo")
                    HStack {
                        Spacer()
                        if isLoggedIn {
                            NavigationLink(destination: UserProfile()) {
                                Image("profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 50)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxHeight: 60)
        .padding(.bottom)
        .onAppear {
            isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
