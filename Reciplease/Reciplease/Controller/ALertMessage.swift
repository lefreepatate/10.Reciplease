//
//  Protocols.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 24/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import UIKit

protocol ALertMessage {
   func presentAlert(with message: String)
}
extension UIViewController: ALertMessage {
   func presentAlert(with message: String) {
      let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
   }
}
