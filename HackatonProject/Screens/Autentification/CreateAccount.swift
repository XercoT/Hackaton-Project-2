//
//  CreateAccount.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//



import SwiftUI

struct CreateAccount: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confrimPassword: String = ""
    @Binding var currentShowingView: String
    @State private var isShowingPassword = false
    @AppStorage("uid") var userID: String = ""
    @AppStorage("email") var savedEmail: String = ""
    @AppStorage("name") var savedName: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let screenWidth = size.width
            let screenHeight = size.height
            let isiPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

            
            VStack(spacing: scaleValue(for: 20, screenDimension: size,screenRefrence : screenWidth)) {
                Text("Create an Account")
                    .font(.custom(
                        "Archivo", size: 30))
                    .fontWeight(.bold)
                    .scaledToFit()
                    .padding(.trailing,scaleValue(for: 100, screenDimension: size,screenRefrence : screenWidth))
                    .frame(
                        width: scaleValue(for: 350, screenDimension: size,screenRefrence : screenWidth),
                        height: scaleValue(for: 50, screenDimension: size,screenRefrence : screenWidth)
                    )
                    .padding(.top,scaleValue(for: 50, screenDimension: size,screenRefrence : screenHeight))

                TextField(" Name", text: $name)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .keyboardType(.alphabet)
                    .textContentType(.name)
                    .frame(
                        width: scaleValue(for: 340, screenDimension: size,screenRefrence : screenWidth),
                        height: scaleValue(for: (screenWidth > screenHeight) ? 30 : 45, screenDimension: size,screenRefrence : screenWidth)
                    )
                    .cornerRadius(10)
                    .scaledToFit()
                    .buttonBorderShape(.roundedRectangle)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.trailing,scaleValue(for: 20, screenDimension: size,screenRefrence : screenWidth))

                TextField(" Email", text: $email)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .frame(
                        width: scaleValue(for: 340, screenDimension: size,screenRefrence : screenWidth),
                        height: scaleValue(for: (screenWidth > screenHeight) ? 30 : 45, screenDimension: size,screenRefrence : screenWidth)
                    )
                    .cornerRadius(10)
                    .scaledToFit()
                    .buttonBorderShape(.roundedRectangle)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.trailing,scaleValue(for: 20, screenDimension: size,screenRefrence : screenWidth))


                ZStack {
                    if isShowingPassword {
                        TextField(" Password", text: $password)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .keyboardType(.default)
                            .textContentType(.password)
                            .frame(
                                width: scaleValue(for: 340, screenDimension: size,screenRefrence : screenWidth),
                                height: scaleValue(for: (screenWidth > screenHeight) ? 30 : 45, screenDimension: size,screenRefrence : screenWidth)
                            )
                            .cornerRadius(10)
                            .scaledToFit()
                            .buttonBorderShape(.roundedRectangle)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                            )

                    } else {
                        SecureField(" Password", text: $password)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .keyboardType(.default)
                            .textContentType(.password)
                            .frame(
                                width: scaleValue(for: 340, screenDimension: size,screenRefrence : screenWidth),
                                height: scaleValue(for: (screenWidth > screenHeight) ? 30 : 45, screenDimension: size,screenRefrence : screenWidth)
                            )
                            .cornerRadius(10)
                            .scaledToFit()
                            .buttonBorderShape(.roundedRectangle)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                            )

                    }

                    Button(action: {
                        isShowingPassword.toggle()
                    }) {
                        Image(systemName: isShowingPassword ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                    }.padding(.leading,scaleValue(for: 280, screenDimension: size,screenRefrence : screenWidth))
                }
                .padding(.trailing,scaleValue(for: 20, screenDimension: size,screenRefrence : screenWidth))


                TextField(" Confrim Password", text: $confrimPassword)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .textContentType(.password)
                    .frame(
                        width: scaleValue(for: 340, screenDimension: size,screenRefrence : screenWidth),
                        height: scaleValue(for: (screenWidth > screenHeight) ? 30 : 45, screenDimension: size,screenRefrence : screenWidth)
                    )
                    .cornerRadius(10)
                    .scaledToFit()
                    .buttonBorderShape(.roundedRectangle)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.trailing,scaleValue(for: 20, screenDimension: size,screenRefrence : screenWidth))


                Button(action: {
                    Task {
                        do {
                            let sucess = try  validateInformation(email: self.email, password: self.password,fullName: self.name)

                            if sucess {

                                do {
                                    let authResult = try await createUser(withEmail: email, password: password)
                                    print("User created with UID: \(authResult.user.uid)")

                                    withAnimation {
                                        userID = authResult.user.uid
                                    }

                                    do {
                                        let _: Void = try await db.collection("users").document(String(authResult.user.uid)).setData([
                                            "name": name,
                                        ])

                                        savedEmail = email
                                        savedName = name

                                        print("Document added with ID: \(String(authResult.user.uid))")
                                    } catch {
                                        print("Error adding document: \(error)")
                                    }





                                } catch {
                                    showAlert = true
                                    alertMessage = error.localizedDescription
                                    print("Error creating user: \(error)")
                                }

                            }

                        } catch validationErrors.invalidEmail {
                            showAlert = true
                            alertMessage = "The email you entered is invalid"

                        } catch validationErrors.weakPassword {
                            showAlert = true
                            alertMessage = "The password you entered is weak"
                        } catch validationErrors.invalidPhone {
                            showAlert = true
                            alertMessage = "The phone number you entered is invalid"
                        } catch validationErrors.noName {
                            showAlert = true
                            alertMessage = "Please enter a valid name"
                        } catch validationErrors.noCompanyName {
                            showAlert = true
                            alertMessage = "Please enter a valid company name"
                        }
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(
                            width: scaleValue(for: 150, screenDimension: size,screenRefrence : screenHeight),
                            height: scaleValue(for: 50, screenDimension: size,screenRefrence : screenWidth)
                        )
                        .background(Color.purple)
                        .contentShape(Rectangle())
                        .cornerRadius(10)
                        .padding(.trailing,scaleValue(for: 20, screenDimension: size,screenRefrence : screenWidth))


                }.alert(alertMessage, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
                .padding(.top,scaleValue(for: 100, screenDimension: size,screenRefrence : screenHeight))
                .contentShape(Rectangle())

                Button(action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        currentShowingView = "Home"
                    }
                }) {
                    Text("Already have an account? Sign In")
                        .foregroundColor(.purple)
                        .scaledToFit()
                        .frame(
                            width: scaleValue(for: 150, screenDimension: size,screenRefrence : screenHeight),
                            height: scaleValue(for: 30, screenDimension: size,screenRefrence : screenWidth)
                        )
                        .padding(.trailing,scaleValue(for: 20, screenDimension: size,screenRefrence : screenWidth))



                }
                .contentShape(Rectangle())



            }.frame(maxWidth: .infinity,maxHeight: .infinity)
        }
        
    }
}

