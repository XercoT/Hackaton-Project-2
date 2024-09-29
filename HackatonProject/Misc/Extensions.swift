//
//  Extensions.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
