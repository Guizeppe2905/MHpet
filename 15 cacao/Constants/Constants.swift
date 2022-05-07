//
//  Constants.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 28.04.2022.
//

import Foundation
import UIKit

enum Constants {

    enum Colors {
        static var primaryTeal: UIColor? {
            UIColor(named: "primaryTeal")
        }
    }
    enum Fonts {
        static var kHeadings: UIFont? {
            UIFont(name: "Kaspersky Regular", size: 40)
        }
        static var kSubtitles: UIFont? {
            UIFont(name: "KasperskyRegular", size: 28)
        }
        static var kRegular: UIFont? {
            UIFont(name: "KasperskyRegular", size: 10)
        }
        static var ui16semi: UIFont? {
            UIFont(name: "Inter-SemiBold", size: 16)
        }
        static var ui14regular: UIFont? {
            UIFont(name: "Inter-Regular", size: 14)
        }
    }
    enum Image {
        static let girlLeftSide = UIImage(named: "girlLeftSide")
        static let girl = UIImage(named: "girl")
        static let logo = UIImage(named: "logo")
        static let fish = UIImage(named: "fish")
        static let fish1 = UIImage(named: "fish1")
        static let fish2 = UIImage(named: "fish2")
        static let fish3 = UIImage(named: "fish3")
        static let fish4 = UIImage(named: "fish4")
        static let fish5 = UIImage(named: "fish5")
    }
}
