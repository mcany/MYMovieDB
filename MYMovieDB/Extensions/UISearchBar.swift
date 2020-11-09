//
//  UISearchBar.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

import UIKit

extension UISearchBar {

    var my_textField: UITextField {

        var textField: UITextField!
        if #available(iOS 13.0, *) {
            textField = searchTextField
        } else {
            let textFields: [UITextField] = subViews(type: UITextField.self)
            textField = textFields.first
        }
        return textField
    }

    func applyStyling() {
        backgroundColor = .clear
        barTintColor = .clear
        backgroundImage = UIImage()
        isTranslucent = true

        my_textField.backgroundColor = Theme.SearchBar.background
        my_textField.textColor = Theme.SearchBar.label
        my_textField.layer.cornerRadius = 18
        my_textField.layer.borderWidth = 1.0
        my_textField.clipsToBounds = true
    }
}
