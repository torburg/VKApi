//
//  DateExtension.swift
//  VKApi
//
//  Created by Maksim Torburg on 07.08.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

extension Date {
    func toStringFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
}
