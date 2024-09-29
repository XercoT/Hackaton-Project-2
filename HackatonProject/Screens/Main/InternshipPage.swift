//
//  ResourcesPage.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import SwiftUI

struct LeadingPaddingTextFieldModifier: ViewModifier {
    let padding: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(.leading, padding)
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
    }
}

extension View {
    func leadingPadding(_ padding: CGFloat) -> some View {
        self.modifier(LeadingPaddingTextFieldModifier(padding: padding))
    }
}


struct InternshipPage: View {

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


            VStack(spacing: scaleValue(for: 10, screenDimension: size,screenRefrence : screenWidth) ) {

                HStack(spacing: 5) {
                    Text("Internships")
                        .font(.custom(
                            "Archivo", size: 30))
                        .fontWeight(.bold)
                        .scaledToFit()
                        .padding(.trailing,200)

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

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(items, id: \.self) { item in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.clear)
                                .frame(
                                    height: scaleValue(for: 150, screenDimension: size,screenRefrence : screenWidth)
                                )
                                .overlay(
                                    HStack {
                                        VStack(spacing: scaleValue(for: 15, screenDimension: size,screenRefrence : screenWidth)) {
                                            Text("Event Name")
                                                .font(.custom(
                                                    "Archivo", size: 20))
                                                .fontWeight(.bold)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .frame(
                                                    width: scaleValue(for: 70, screenDimension: size,screenRefrence : screenHeight)
                                                )
                                                .bold()
                                                .padding(.trailing,scaleValue(for: 110, screenDimension: size,screenRefrence : screenWidth))

                                            Text("Event descripting spanning multiple lines fsd dasd dasd dada dasda asda")
                                                .foregroundColor(.gray)
                                                .font(.custom(
                                                    "Archivo", size: 15))
                                                .fontWeight(.bold)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .frame(
                                                    width: scaleValue(for: 125, screenDimension: size,screenRefrence : screenHeight)
                                                )
                                                .padding(.leading,scaleValue(for: 20, screenDimension: size,screenRefrence : screenWidth))




                                            Button(action: {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    print("HERE")
                                                }
                                            }) {
                                                Text("More Details")
                                                    .foregroundColor(.purple)
                                                    .scaledToFit()
                                                    .frame(
                                                        width: scaleValue(for: 70, screenDimension: size,screenRefrence : screenHeight),
                                                        height: scaleValue(for: 35, screenDimension: size,screenRefrence : screenWidth)
                                                    )
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color.purple, lineWidth: 2)
                                                    )
                                                    .padding(.trailing,scaleValue(for: 90, screenDimension: size,screenRefrence : screenWidth))




                                            }.contentShape(Rectangle())
                                        }
                                        Image("placeHolder")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(
                                                width: scaleValue(for: 120, screenDimension: size,screenRefrence : screenWidth),
                                                height: scaleValue(for: 90, screenDimension: size,screenRefrence : screenWidth)
                                            )

                                    }


                                )
                        }
                    }
                    .padding() 


                }
            }

        }
    }
}

#Preview {
    InternshipPage()
}
