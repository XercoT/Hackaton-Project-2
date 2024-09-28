//
//  AccountCreationManager.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import Combine
import CoreFoundation
import CoreGraphics
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
let db = Firestore.firestore()

func createUser(withEmail email: String, password: String) async throws -> AuthDataResult {
    let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
    return authResult
}


func textFieldValidatorEmail(_ string: String) -> Bool {
    // Define the regex pattern for a valid email address
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"

    // Create an NSPredicate with the regex pattern
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

    // Evaluate the email string using the predicate
    return emailPredicate.evaluate(with: string)
}

func isWeakPassword(_ password: String) -> Bool {
    // Check for minimum length
    let minLength = 8
    if password.count < minLength {
        return true
    }

    // Define regex patterns for different character sets
    let uppercaseRegex = ".*[A-Z]+.*"
    let lowercaseRegex = ".*[a-z]+.*"
    let digitRegex = ".*[0-9]+.*"
    let specialCharRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"

    // Create NSPredicate for each pattern
    let uppercaseTest = NSPredicate(format:"SELF MATCHES %@", uppercaseRegex)
    let lowercaseTest = NSPredicate(format:"SELF MATCHES %@", lowercaseRegex)
    let digitTest = NSPredicate(format:"SELF MATCHES %@", digitRegex)
    let specialCharTest = NSPredicate(format:"SELF MATCHES %@", specialCharRegex)

    // Evaluate the password against each pattern
    let hasUppercase = uppercaseTest.evaluate(with: password)
    let hasLowercase = lowercaseTest.evaluate(with: password)
    let hasDigit = digitTest.evaluate(with: password)
    let hasSpecialChar = specialCharTest.evaluate(with: password)

    // Return true if any criteria are not met (weak password)
    return !(hasUppercase && hasLowercase && hasDigit && hasSpecialChar)
}

func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
    // Define the regex pattern for a valid phone number
    let phoneRegex = "^(\\+\\d{1,3}[- ]?)?\\(?\\d{1,4}\\)?[- ]?\\d{1,4}[- ]?\\d{1,9}$"

    // Create an NSPredicate with the regex pattern
    let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)

    // Evaluate the phone number string using the predicate
    return phonePredicate.evaluate(with: phoneNumber)
}

func isValidName(_ name: String) -> Bool {
    // Define the regex pattern for a valid name
    let nameRegex = "^[A-Za-z]+(?:[\\s'-][A-Za-z]+)*$"

    // Create an NSPredicate with the regex pattern
    let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)

    // Evaluate the name string using the predicate
    let isValid = namePredicate.evaluate(with: name)

    // Ensure the name is within a reasonable length
    let minLength = 2
    let maxLength = 50

    // Check for leading or trailing spaces
    let hasLeadingOrTrailingSpaces = name.trimmingCharacters(in: .whitespaces) != name

    // Combine all checks
    return isValid && name.count >= minLength && name.count <= maxLength && !hasLeadingOrTrailingSpaces
}

func validateInformation(email: String,password: String, fullName: String) throws -> Bool  {


    if textFieldValidatorEmail(email) == false {
        throw validationErrors.invalidEmail
    }

    if isWeakPassword(password) == true {
        throw validationErrors.weakPassword
    }


    if isValidName(fullName) == false {
        throw validationErrors.noName
    }


    return true

}
