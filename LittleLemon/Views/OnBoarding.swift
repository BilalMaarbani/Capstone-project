//
//  OnBoarding.swift
//  LittleLemon
//
//  Created by Bilal Maarbani on 05/06/2023.
//

import Foundation

import SwiftUI

struct Onboarding: View {
    @StateObject private var viewModel = ViewModel()
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isKeyboardVisible = false
    @State private var contentOffset: CGSize = .zero
    
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Header()
                    Hero()
                        .padding()
                        .background(Color.pc1)
                        .frame(maxWidth: .infinity, maxHeight: 240)
                    
                    VStack {
                        NavigationLink(destination: Home(), isActive: $isLoggedIn) { EmptyView() }
                        
                        Text("First name *")
                            .onboardingTextStyle()
                        TextField("First Name", text: $firstName)
                        
                        Text("Last name *")
                            .onboardingTextStyle()
                        TextField("Last Name", text: $lastName)
                        
                        Text("E-mail *")
                            .onboardingTextStyle()
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding()
                    
                    if viewModel.errorMessageShow {
                        withAnimation {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                    }
                    
                    Button("Register") {
                        if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                            UserDefaults.standard.set(firstName, forKey: "first name key")
                            UserDefaults.standard.set(lastName, forKey: "last name key")
                            UserDefaults.standard.set(email, forKey: "e-mail key")
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            UserDefaults.standard.set(true, forKey: "order statuses key")
                            UserDefaults.standard.set(true, forKey: "password changes key")
                            UserDefaults.standard.set(true, forKey: "special offers key")
                            UserDefaults.standard.set(true, forKey: "news letter key")
                            firstName = ""
                            lastName = ""
                            email = ""
                            isLoggedIn = true
                        }
                    }
                    .buttonStyle(ButtonStyleYellowColorWide())
                    
                    Spacer()
                }
                .offset(y: contentOffset.height)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    withAnimation {
                        let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let keyboardHeight = keyboardRect.height
                        isKeyboardVisible = true
                        contentOffset = CGSize(width: 0, height: -keyboardHeight / 2 + 50)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                    withAnimation {
                        isKeyboardVisible = false
                        contentOffset = .zero
                    }
                }
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                    isLoggedIn = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

