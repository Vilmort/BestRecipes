//
//  RowData.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import Foundation

struct RowDataCell: Equatable, Codable {
    var textField1Text: String = ""
    var textField2Text: String = ""
    var isSelected: Bool = false
    var isField1: Bool = false
    var isField2: Bool = false
}

struct RowDataPiker {
    var serving: String = "1"
    var cookTime: String = "20 min"
}

