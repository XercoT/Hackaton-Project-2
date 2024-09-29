//
//  Home.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import SwiftUI



struct Home: View {
    @Binding var currentShowingView: String
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let screenWidth = size.width
            let screenHeight = size.height
            let isiPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

            VStack {
                Text("Welcome to TechConnect!")
                    .scaledToFit()
                    .frame(
                        width: scaleValue(for: 350, screenDimension: size,screenRefrence : screenWidth,landscapeFactor: isiPad ? 0.5 : 0.5),
                        height: scaleValue(for: 50, screenDimension: size,screenRefrence : screenWidth,landscapeFactor: isiPad ? 0.5 : 0.5)
                    )
                    .font(.custom(
                        "Archivo", size: 30))
                    .fontWeight(.bold)
                    .padding(.top,scaleValue(for: 50, screenDimension: size,screenRefrence : screenHeight))

                Text("Connecting you with blah blah ")
                    .scaledToFit()
                    .frame(
                        width: scaleValue(for: 350, screenDimension: size,screenRefrence : screenWidth,landscapeFactor: isiPad ? 0.5 : 0.5),
                        height: scaleValue(for: 30, screenDimension: size,screenRefrence : screenWidth,landscapeFactor: isiPad ? 0.5 : 0.5)
                    )
                    .font(.custom(
                        "Archivo", size: 20))

                Image("Logo")


                Button(action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        currentShowingView = "SignIn"
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(
                            width: scaleValue(for: 150, screenDimension: size,screenRefrence : screenHeight),
                            height: scaleValue(for: 50, screenDimension: size,screenRefrence : screenWidth)
                        )
                        .background(Color.purple)
                        .contentShape(Rectangle())
                        .cornerRadius(10)


                }
                .contentShape(Rectangle())
                .padding(.top,scaleValue(for: 100, screenDimension: size,screenRefrence : screenHeight))

                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        print("HERE")
                        currentShowingView = "CreateAccount"
                    }
                }) {
                    Text("New Here? Create an account")
                        .foregroundColor(.purple)
                        .scaledToFit()
                        .frame(
                            width: scaleValue(for: 150, screenDimension: size,screenRefrence : screenHeight),
                            height: scaleValue(for: 30, screenDimension: size,screenRefrence : screenWidth)
                        )



                }.contentShape(Rectangle())


            }.frame(maxWidth: .infinity,maxHeight: .infinity)


        }


    }
}
