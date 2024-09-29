//
//  Profile.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import SwiftUI




struct ProfilePage: View {

    @State private var search: String = ""

    let items = Array(1...20)


    let columns = [
        GridItem(.flexible()),

    ]
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let screenWidth = size.width
            let screenHeight = size.height
            let isiPad: Bool = UIDevice.current.userInterfaceIdiom == .pad


            VStack() {
                Text("User Information")
                    .font(.custom(
                        "Archivo", size: 20))
                    .fontWeight(.bold)
                    .frame(
                        width: scaleValue(for: 100, screenDimension: size,screenRefrence : screenHeight)
                    )
                    .bold()
                    .padding(.trailing,scaleValue(for: 200, screenDimension: size,screenRefrence : screenWidth))

                Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: scaleValue(for: 100, screenDimension: size,screenRefrence : screenHeight),
                        height: scaleValue(for: 80, screenDimension: size,screenRefrence : screenHeight)
                    )

                Text("John Doe")
                    .font(.custom(
                        "Archivo", size: 30))
                    .fontWeight(.bold)
                    .frame(
                        width: scaleValue(for: 100, screenDimension: size,screenRefrence : screenHeight)
                    )
                    .bold()

                Text("johndoe@gmail.com")
                    .font(.custom(
                        "Archivo", size: 30))
                    .fontWeight(.bold)
                    .frame(
                        width: scaleValue(for: 170, screenDimension: size,screenRefrence : screenHeight)
                    )
                    .bold()


            }.frame(maxWidth: .infinity,maxHeight: .infinity)

        }
    }
}

#Preview {
    ProfilePage()
}
