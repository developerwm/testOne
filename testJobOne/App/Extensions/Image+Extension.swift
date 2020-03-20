//
//  Image+Extension.swift
//  testJobOne
//
//  Created by Tauã on 20/03/20.
//  Copyright © 2020 Tauã. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

   func setRounded() {
      let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}

