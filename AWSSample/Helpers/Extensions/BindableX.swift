//
//  BindableX.swift
//  KoingX
//
//  Created by KoingDev on 4/12/18.
//  Copyright © 2018 koingdev. All rights reserved.
//

import UIKit

public final class BindableX<T> {
    
    fileprivate var bind: ((T) -> Void)?
    
    public var val: T {
        didSet {
            bind?(val)
        }
    }
    
    public init(_ val: T) {
        self.val = val
    }
    
    public func bind(_ callback: ((T) -> Void)?) {
        bind = callback
        bind?(val)
    }
    
}

// MARK: - TextFieldX

public final class TextFieldX: UITextField {
    
    fileprivate var onTextChanged: ((String) -> Void)?
    
    public func bind(callback: @escaping (String) -> Void) {
        onTextChanged = callback
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc fileprivate func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            onTextChanged?(text)
        }
    }
    
}










