//
//  String+Extension.swift
//  NearMe
//
//  Created by Shivam Maheshwari on 28/06/23.
//

import Foundation

extension String {
    var formatPhoneNumber: String {
        self.replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
}
