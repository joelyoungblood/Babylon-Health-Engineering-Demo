//
//  UIViewController.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Toast_Swift

extension UIViewController {
    
    var isCurrentlyVisible: Bool {
        return self.isViewLoaded && (self.view.window != nil)
    }
    
    func showSnackbar(forError error: Error) {
        var errorMessage: String
        if error is BabylonError {
            let babError = error as! BabylonError
            errorMessage = babError.description
        } else {
            errorMessage = error.localizedDescription
        }
        view.makeToast(errorMessage, duration: 3.0, position: .bottom)
    }
}
