//
//  ResourcesPage.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import SwiftUI

import SwiftUI

struct LeadingPaddingTextFieldModifier: ViewModifier {
    let padding: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(.leading, padding) // Custom leading padding
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
    }
}

extension View {
    func leadingPadding(_ padding: CGFloat) -> some View {
        self.modifier(LeadingPaddingTextFieldModifier(padding: padding))
    }
}


struct ResourcesPage: View {

    @State private var search: String = ""
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let screenWidth = size.width
            let screenHeight = size.height
            let isiPad: Bool = UIDevice.current.userInterfaceIdiom == .pad


            VStack(spacing: scaleValue(for: 10, screenDimension: size,screenRefrence : screenWidth) ) {

                HStack(spacing: 5) {
                    Text("Iternships & Events")
                        .font(.custom(
                            "Archivo", size: 30))
                        .fontWeight(.bold)
                        .scaledToFit()
                        .padding(.trailing,100)

                }

                ZStack {

                    Image(systemName: "magnifyingglass")
                        .scaledToFit()
                        .font(.system(size: 30))
                        .padding(.trailing, scaleValue(for: 300, screenDimension: size,screenRefrence : screenWidth))

                    TextField(" Search internships or events..", text: $search)
                        .leadingPadding(40)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .keyboardType(.alphabet)
                        .textContentType(.name)
                        .frame(
                            width: scaleValue(for: 340, screenDimension: size,screenRefrence : screenWidth),
                            height: scaleValue(for: 45, screenDimension: size,screenRefrence : screenWidth)
                        )
                        .cornerRadius(10)
                        .scaledToFit()
                        .buttonBorderShape(.roundedRectangle)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 2)
                        )
                }

                ScrollView(.horizontal) { // Horizontal scroll direction
                       HStack(spacing: 20) { // Items arranged horizontally with spacing
                           ForEach(0..<10) { index in
                               RoundedRectangle(cornerRadius: 10)
                                   .fill(Color.blue)
                                   .frame(width: 150, height: 150)
                                   .overlay(
                                       Text("Item \(index)")
                                           .foregroundColor(.white)
                                           .font(.headline)
                                   )
                           }
                       }
                       .padding() // Padding around the content
                   }  .frame(
                    width: scaleValue(for: 400, screenDimension: size,screenRefrence : screenWidth),
                    height: scaleValue(for: 240, screenDimension: size,screenRefrence : screenWidth)
                )
                .border(.black)




                }.frame(maxWidth: .infinity,maxHeight: .infinity)


            }
        }

    }



#Preview {
    ResourcesPage()
}
