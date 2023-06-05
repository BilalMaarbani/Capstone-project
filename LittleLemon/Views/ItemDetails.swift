//
//  ItemDetails.swift
//  LittleLemon
//
//  Created by Bilal Maarbani on 05/06/2023.
//

import SwiftUI

struct ItemDetails: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dish: Dish
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .clipShape(Rectangle())
            .frame(minHeight: 150)
            Text(dish.title ?? "")
                .font(.subTitleFont())
                .foregroundColor(.pc1)
            Spacer(minLength: 20)
            Text(dish.descriptionDish ?? "")
                .font(.regularText())
            Spacer(minLength: 10)
            Text("$" + (dish.price ?? ""))
                .font(.highlightText())
                .foregroundColor(.pc1)
                .monospaced()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
}

struct DetailsPreviews: PreviewProvider {
    static var previews: some View {
        ItemDetails(dish: PersController.oneDish())
    }
}
