//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Bilal Maarbani on 05/06/2023.
//

import SwiftUI

struct UserProfile: View {
    @StateObject private var viewModel = ViewModel()
    
    @Environment(\.presentationMode) var presentation
    
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isLoggedOut = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { EmptyView() }
            VStack(spacing: 5) {
                VStack {
                    Text("Avatar")
                        .onboardingTextStyle()
                    HStack(spacing: 0) {
                        Image("profile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 75)
                            .clipShape(Circle())
                            .padding(.trailing)
                        Button("Change") { }
                            .buttonStyle(ButtonStylePrimaryColor1())
                        Button("Remove") { }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                        Spacer()
                    }
                }
                
                VStack {
                    Text("First name")
                        .onboardingTextStyle()
                    TextField("First Name", text: $firstName)
                }
                
                VStack {
                    Text("Last name")
                        .onboardingTextStyle()
                    TextField("Last Name", text: $lastName)
                    
                }
                
                VStack {
                    Text("E-mail")
                        .onboardingTextStyle()
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                }
                
                VStack {
                    Text("Phone number")
                        .onboardingTextStyle()
                    TextField("Phone number", text: $phoneNumber)
                        .keyboardType(.default)
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .padding()
            
            Text("Email notifications")
                .font(.regularText())
                .foregroundColor(.pc1)
            
            VStack {
                Toggle("Order statuses", isOn: $orderStatuses)
                Toggle("Password changes", isOn: $passwordChanges)
                Toggle("Special offers", isOn: $specialOffers)
                Toggle("Newsletter", isOn: $newsletter)
            }
            .padding()
            .font(.leadText())
            .foregroundColor(.pc1)
            
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                UserDefaults.standard.set("", forKey: "first name key")
                UserDefaults.standard.set("", forKey: "last name key")
                UserDefaults.standard.set("", forKey: "e-mail key")
                UserDefaults.standard.set("", forKey: "phone number key")
                UserDefaults.standard.set(false, forKey: "order statuses key")
                UserDefaults.standard.set(false, forKey: "password changes key")
                UserDefaults.standard.set(false, forKey: "special offers key")
                UserDefaults.standard.set(false, forKey: "news letter key")
                
                
                isLoggedOut = true
            }
            .buttonStyle(ButtonStyleYellowColorWide())
            
            Spacer(minLength: 20)
            
            HStack {
                Button("Discard Changes") {
                    firstName = viewModel.firstName
                    lastName = viewModel.lastName
                    email = viewModel.email
                    phoneNumber = viewModel.phoneNumber
                    
                    orderStatuses = viewModel.orderStatuses
                    passwordChanges = viewModel.passwordChanges
                    specialOffers = viewModel.specialOffers
                    newsletter = viewModel.newsletter
                    self.presentation.wrappedValue.dismiss()
                }
                .buttonStyle(ButtonStylePrimaryColorReverse())
                
                Button("Save changes") {
                    if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {

                        UserDefaults.standard.set(phoneNumber, forKey: "phone number key")
                        UserDefaults.standard.set(firstName, forKey: "first name key")
                        UserDefaults.standard.set(lastName, forKey: "last name key")
                        UserDefaults.standard.set(email, forKey: "e-mail key")
                        UserDefaults.standard.set(true, forKey: "order statuses key")
                        UserDefaults.standard.set(true, forKey: "password changes key")
                        UserDefaults.standard.set(true, forKey: "special offers key")
                        UserDefaults.standard.set(true, forKey: "news letter key")
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                .buttonStyle(ButtonStylePrimaryColor1())
            }
            
            if viewModel.errorMessageShow {
                withAnimation() {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
        }
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
            phoneNumber = viewModel.phoneNumber
            
            orderStatuses = viewModel.orderStatuses
            passwordChanges = viewModel.passwordChanges
            specialOffers = viewModel.specialOffers
            newsletter = viewModel.newsletter
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
