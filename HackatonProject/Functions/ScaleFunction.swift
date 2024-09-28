//
//  ScaleFunction.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/28/24.
//

import Combine
import CoreFoundation
import CoreGraphics
import SwiftUI



func scaleValue(for baseValue: CGFloat, screenDimension: CGSize,screenRefrence: CGFloat, referenceDimension: CGFloat = 375.0,landscapeFactor: CGFloat = 0.7) -> CGFloat {
    if screenDimension.width > screenDimension.height {
        return (baseValue * (screenRefrence / referenceDimension)) * landscapeFactor
    } else {
        return baseValue * (screenRefrence / referenceDimension)
    }
}




