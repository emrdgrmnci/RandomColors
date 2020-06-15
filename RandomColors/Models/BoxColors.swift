//
//  Colors.swift
//  RandomColors
//
//  Created by Ali Emre Değirmenci on 14.06.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation


enum Lorem: String {

    case dummy = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sed vulputate mi sit amet mauris commodo quis imperdiet massa. Ipsum suspendisse ultrices gravida dictum fusce ut placerat orci. Suspendisse ultrices gravida dictum fusce ut placerat orci nulla. Ipsum faucibus vitae aliquet nec ullamcorper sit amet. Felis imperdiet proin fermentum leo. Leo vel orci porta non pulvinar neque laoreet suspendisse interdum. Urna neque viverra justo nec ultrices dui sapien. Lorem mollis aliquam ut porttitor leo a diam sollicitudin. Id diam vel quam elementum pulvinar etiam. Dictum non consectetur a erat nam at lectus. Nec feugiat nisl pretium fusce id velit.
    """
}

enum Color: String, CaseIterable {
    case systemRed = "#FF3B30"
    case systemGreen = "#34C759"
    case systemYellow = "#FFCC00"
    case systemBlue = "#007AFF"
}

protocol Box: class {
    var height: Float { get set }
    var boxName: String { get set }
    var boxNumber: Int { get set }
    var description: String { get set }
    var color: Color { get set }
}

class SystemRed: Box {
    var boxNumber: Int = 0
    var height: Float = 140
    var boxName: String = "SYSTEMRED"
    var description: String = Lorem.dummy.rawValue
    var color: Color = .systemRed
}

class SystemYellow: Box {
    var boxNumber: Int = 1
    var height: Float = 60
    var boxName: String = "SYSTEMYELLOW"
    var description: String = Lorem.dummy.rawValue
    var color: Color = .systemYellow
}

class SystemGreen: Box {
    var boxNumber: Int = 2
    var height: Float = 90
    var boxName: String = "SYSTEMGREEN"
    var description: String = Lorem.dummy.rawValue
    var color: Color = .systemGreen
}

class SystemBlue: Box {
    var boxNumber: Int = 3
    var height: Float = 110
    var boxName: String = "SYSTEMBLUE"
    var description: String = Lorem.dummy.rawValue
    var color: Color = .systemBlue
}

