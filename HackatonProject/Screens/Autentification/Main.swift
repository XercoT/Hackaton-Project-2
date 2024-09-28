//
//  Main.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import SwiftUI

struct Main: View {
    @State private var currentViewShowing: String = "Home"
    
    var body: some View {
        if currentViewShowing == "Home" {
            Home(currentShowingView: $currentViewShowing)
                .transition(.slide)
        } else if currentViewShowing == "CreateAccount" {
            
            CreateAccount(currentShowingView: $currentViewShowing)
                .transition(.slide)
        }

    }
}

#Preview {
    Main()
}
