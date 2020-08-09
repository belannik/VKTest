//
//  PreviewPhoto.swift
//  VKTest
//
//  Created by Anton on 09.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Foundation
import CoreGraphics

struct PreviewImage
{
	var height: CGFloat
	var width: CGFloat
	let path: String
	let type: ImageType
	let duration: Int?

	mutating func resize(maxWidth: CGFloat, maxHeight: CGFloat) {
		guard width > maxWidth || height > maxHeight else { return }

		var ratio: CGFloat {
			if height > width { return height / maxHeight }
			else { return width / maxWidth }
		}

		self.height = height / ratio
		self.width = width / ratio
	}
}
