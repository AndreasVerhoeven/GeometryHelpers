//
//  CGRect+Helper.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 13/05/2021.
//

import UIKit

extension CGRect
{
	/// The center of this rectangle
	var center: CGPoint {
		return CGPoint(x: midX, y: midY)
	}

	/// Returns this rectangle with a different `origin`
	func with(origin: CGPoint) -> CGRect {
		return CGRect(origin: origin, size: size)
	}

	/// Returns this rectangle with a different `size`
	func with(size: CGSize) -> CGRect {
		return CGRect(origin: origin, size: size)
	}

	/// Returns this rectangle with a different `x` position
	func with(x: CGFloat) -> CGRect {
		return with(origin: origin.with(x: x))
	}

	/// Returns this rectangle with a different `y` position
	func with(y: CGFloat) -> CGRect {
		return with(origin: origin.with(y: y))
	}

	/// Returns this rectangle with a different `height`
	func with(height: CGFloat) -> CGRect {
		return with(size: size.with(height: height))
	}

	/// Returns this rectangle with a different `width`
	func with(width: CGFloat) -> CGRect {
		return with(size: size.with(width: width))
	}

	/// Returns this rectangle offsetted by the given `point`
	func offsettted(by point: CGPoint) -> CGRect {
		return offsetBy(dx: point.x, dy: point.y)
	}

	/// Returns this rectangle offsetted by the given x,y coordinates.
	func offsettted(x: CGFloat = 0, y: CGFloat = 0) -> CGRect {
		return offsetBy(dx: x, dy: y)
	}

	/// Returns this rectangle offsetted by the insets
	func offsettted(by insets: NSDirectionalEdgeInsets) -> CGRect {
		return offsetBy(dx: insets.leading, dy: insets.top)
	}

	/// Returns this rectangle offsetted by the given insets
	func offsettted(by insets: UIEdgeInsets) -> CGRect {
		return offsetBy(dx: insets.left, dy: insets.top)
	}

	/// Returns this rectangle with each corner rounded to the nearest pixel
	var roundedToNearestPixel: CGRect {
		let minX = self.minX.roundedToNearestPixel
		let minY = self.minY.roundedToNearestPixel
		let maxX = self.maxX.roundedToNearestPixel
		let maxY = self.maxY.roundedToNearestPixel
		return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
	}

	/// Returns this rectangle with the min coordinates floored, the max coordinates ceiled
	var ceiledToNearestPixel: CGRect {
		let minX = self.minX.flooredToNearestPixel
		let minY = self.minY.flooredToNearestPixel
		let maxX = self.maxX.ceiledToNearestPixel
		let maxY = self.maxY.ceiledToNearestPixel
		return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
	}

	/// Returns the rectangle that makes otherRect fit in this rectangle
	///
	/// - Parameters:
	///		- otherRect: the rectangle we want to fit in this rect
	/// - Returns: the rectangle of `otherRect` that we fitted in this rect
	func rectThatFitsInRect(_ otherRect: CGRect) -> CGRect {
		let sizeThatFits = self.size.sizeThatFitsSize(otherRect.size)

		let xPos = (otherRect.size.width - sizeThatFits.width) / 2 + otherRect.minX
		let yPos = (otherRect.size.height - sizeThatFits.height) / 2 + otherRect.minY

		let ret = CGRect(x: xPos, y: yPos, width: sizeThatFits.width, height: sizeThatFits.height)
		return ret
	}
}

