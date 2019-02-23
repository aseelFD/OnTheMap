//
//  TextFeildController.swift
//  OnTheMap
//
//  Created by MAC on 9/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation
import UIKit

class TextFieldController: UITextField {
    
    
    /// ****************** ENABLE PAST ON TEXTFIELD **************
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return true
        }
        return false
    }
}
