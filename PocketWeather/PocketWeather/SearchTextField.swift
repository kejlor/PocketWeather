//
//  SearchTextField.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 14/04/2023.
//

import UIKit

protocol SearchTextFieldDelegate: AnyObject {
    func editingDidEnd(_ sender: SearchTextField)
}

class SearchTextField: UIView {
    
    let magnifyingglassImageView = UIImageView(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal))
    let textField = UITextField()
    let dividerView = UIView()
    
    let placeHolderText: String
    weak var delegate: SearchTextFieldDelegate?
    
    var text: String? {
        get { return textField.text}
        set { textField.text = newValue}
    }
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }
}

extension SearchTextField {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        magnifyingglassImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.placeholder = placeHolderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string:placeHolderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .white
    }
    
    func layout() {
        addSubview(magnifyingglassImageView)
        addSubview(textField)
        addSubview(dividerView)
        
        // magnifyingglassImageView
        NSLayoutConstraint.activate([
            magnifyingglassImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            magnifyingglassImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        // textField
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: magnifyingglassImageView.trailingAnchor, multiplier: 1),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // divider
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1)
        ])
        
        // CHCR
        magnifyingglassImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
}

// MARK: - UITextFieldDelegate
extension SearchTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
