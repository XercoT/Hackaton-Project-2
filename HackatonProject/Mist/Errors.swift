//
//  Errors.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import Foundation


enum validationErrors: Error {
    case invalidEmail
    case weakPassword
    case invalidPhone
    case noName
    case noCompanyName
}
