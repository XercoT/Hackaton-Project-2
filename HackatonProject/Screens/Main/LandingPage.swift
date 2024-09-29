//
//  LandingPage.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        GeometryReader { geometry in

            TabView {

                InternshipPage()
                    .tabItem {
                           Image(systemName: "house.fill")
                           Text("Home")
                         }

                Text("Test1")
                    .tabItem {
                           Image(systemName: "figure.2.and.child.holdinghands")
                           Text("Community")
                         }

                Text("Test1")
                    .tabItem {
                           Image(systemName: "message.fill")
                           Text("Chat")
                         }

                Text("Account")
                    .tabItem {
                           Image(systemName: "person.crop.circle.fill")
                           Text("Profile")
                         }


            }
            .onAppear(perform: {
                UITabBar.appearance().unselectedItemTintColor = .systemPurple
                UITabBarItem.appearance().badgeColor = .systemGray
                UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
                UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
            })
        }

    }
}

#Preview {
    LandingPage()
}
