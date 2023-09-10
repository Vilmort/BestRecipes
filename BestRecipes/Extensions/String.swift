//
//  String.swift
//  BestRecipes
//
//  Created by Vanopr on 04.09.2023.
//

import Foundation

extension String {
  var htmlToAttributedString: NSAttributedString? {
    guard let data = data(using: .utf8) else { return nil }
    do {
      return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
    } catch {
      return nil
    }
  }
  var htmlToString: String {
    return htmlToAttributedString?.string ?? ""
  }
}
