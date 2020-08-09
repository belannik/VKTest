//
//  Post.swift
//  VKTest
//
//  Created by Anton on 07.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Foundation
import CoreGraphics

struct Post
{
	let totalHeight: CGFloat
	let textHeight: CGFloat
	var totalPhotosHeight: CGFloat
	let imageURLString: String
	let author: String
	let date: String
	let likes: String
	let reposts: String
	let comments: String
	let views: String
	let text: NSAttributedString
	let photos: [PreviewImage]
}
