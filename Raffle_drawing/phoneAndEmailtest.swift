//
//  phoneAndEmailtest.swift
//  Raffle_drawing
//
//  Created by Sunny on 29/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import Foundation


extension String {
   var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
   var isValidPhone: Bool {
//      let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
    let regularExpressionForPhone = "^\\d{10}$"
      let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
      return testPhone.evaluate(with: self)
   }
}
