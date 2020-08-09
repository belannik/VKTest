//
//  UIViewController + Extensions.swift
//  VKTest
//
//  Created by Anton on 10.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

extension UIViewController
{
	func showAlert(title: String? = nil, message: String? = nil, action: (() -> () )? = nil) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
			action?()
		})
		alertController.addAction(action)
		present(alertController, animated: true)
	}
}
