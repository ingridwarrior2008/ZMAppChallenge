//
//  StringExtensions.swift
//  ZMAppChallenge
//
//  Created by Cris on 11/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, comment: "")
    }
}
