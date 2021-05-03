//
//  URL.swift
//  Quiz
//
//  Created by SRV InfoTech on 10/05/20.
//

import Foundation


struct  QUIZ {
    public  static let  CATEGORY_URL = "https://opentdb.com/api_category.php"
    public  static let  QUESTIONBYCATEGORY_URL = "https://opentdb.com/api.php?amount=5&category="
}


struct categoryData {
    var catid = String()
    var catname = String()
}
extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}
