//
//  Model.swift
//  LittleLemon
//
//  Created by Bilal Maarbani on 05/06/2023.
//

import Foundation
import Combine

public let isLoggedIn = "isLoggedIn"

class ViewModel: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var phoneNumber: String
    
    @Published var orderStatuses: Bool
    @Published var passwordChanges: Bool
    @Published var specialOffers: Bool
    @Published var newsletter: Bool
    
    @Published var errorMessageShow = false
    @Published var errorMessage = ""
    
    @Published var searchText = ""
    
    init() {
        firstName = UserDefaults.standard.string(forKey: "first name key") ?? ""
        lastName = UserDefaults.standard.string(forKey: "last name key") ?? ""
        email = UserDefaults.standard.string(forKey: "e-mail key") ?? ""
        phoneNumber = UserDefaults.standard.string(forKey: "phone number key") ?? ""
        
        orderStatuses = UserDefaults.standard.bool(forKey: "order statuses key")
        passwordChanges = UserDefaults.standard.bool(forKey: "password changes key")
        specialOffers = UserDefaults.standard.bool(forKey: "special offers key")
        newsletter = UserDefaults.standard.bool(forKey: "news letter key")
    }
    
    func validateUserInput(firstName: String, lastName: String, email: String, phoneNumber: String) -> Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            errorMessage = "All fields are required"
            errorMessageShow = true
            return false
        }
        
        guard email.contains("@") else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        let emailComponents = email.split(separator: "@")
        
        guard emailComponents.count == 2 else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        guard emailComponents[1].contains(".") else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        guard phoneNumber.first == "+" && phoneNumber.dropFirst().allSatisfy({ $0.isNumber }) || phoneNumber.isEmpty else {
            errorMessage = "Invalid phone number format."
            errorMessageShow = true
            return false
        }
        
        errorMessageShow = false
        errorMessage = ""
        return true
    }
}
