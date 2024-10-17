//
//  CGSize+Helper.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 13/05/2021.
//

import UIKit

public extension CGSize {
	/// Returns a size with `width` and `height` set to `value`
	static func all(_ value: CGFloat) -> CGSize {
		return CGSize(width: value, height: value)
	}

	/// Returns a size that makes `other` fit in this size, while maintaing aspect ratio
	func sizeThatFitsSize(_ other: CGSize) -> CGSize {
		let width = Swift.min(self.width * other.height / self.height, other.width)
		return CGSize(width: width, height: self.height * width / self.width)
	}

	/// Returns the minimum of `self` and `other` by taking the minimum of the width and height
	/// independently.
	func min(_ other: CGSize) -> CGSize {
		var result = self
		result.width = Swift.min(other.width, result.width)
		result.height = Swift.min(other.height, result.height)
		return result
	}

	/// Returns the maximum of `self` and `other` by taking the minimum of the width and height
	/// independently.
	func max(_ other: CGSize) -> CGSize {
		var result = self
		result.width = Swift.max(other.width, result.width)
		result.height = Swift.max(other.height, result.height)
		return result
	}

	/// Returns a rectangle with this size at position (0,0)
	var rectAtZeroOrigin: CGRect {
		return CGRect(x: 0, y: 0, width: width, height: height)
	}

	/// Returns the point if we take the center of this size
	/// We imagine a box from (0,0) -> (width, height) and take the center of it
	var center: CGPoint {
		return CGPoint(x: width * 0.5, y: height * 0.5)
	}

	/// Returns this size with a different width
	func with(width: CGFloat) -> CGSize {
		return CGSize(width: width, height: height)
	}

	/// Returns this size with a different height
	func with(height: CGFloat) -> CGSize {
		return CGSize(width: width, height: height)
	}

	/// Returns this size with the given width and height added to it
	func adding(width: CGFloat = 0, height: CGFloat = 0) -> CGSize {
		return self.adding(CGSize(width: width, height: height))
	}

	/// Returns this size with the given size added to it
	func adding(_ size: CGSize) -> CGSize {
		return CGSize(width: width + size.width, height: height + size.height)
	}

	/// Returns this size with the given size added to it
	func adding(_ insets: NSDirectionalEdgeInsets) -> CGSize {
		return CGSize(width: width + insets.leading + insets.trailing, height: height + insets.top + insets.bottom)
	}

	/// Returns this size with the given size added to it
	func adding(_ insets: UIEdgeInsets) -> CGSize {
		return CGSize(width: width + insets.left + insets.right, height: insets.top + insets.bottom)
	}

	/// Returns the size that is needed to stack this with other (and optional spacing)
	func verticallyStacked(with other: CGSize, spacing: CGFloat = 0) -> CGSize {
		return CGSize(width: Swift.max(width, other.width), height: height + spacing + other.height)
	}

	/// Returns the size that is needed to stack this with other (and optional spacing)
	func horizontallyStacked(with other: CGSize, spacing: CGFloat = 0) -> CGSize {
		return CGSize(width: width + spacing + other.width, height: Swift.max(height, other.height))
	}

	/// Returns this size with the given width and height added to it
	func subtracting(width: CGFloat = 0, height: CGFloat = 0) -> CGSize {
		return self.subtracting(CGSize(width: width, height: height))
	}

	/// Returns this size with the given size added to it
	func subtracting(_ size: CGSize) -> CGSize {
		return CGSize(width: width - size.width, height: height - size.height)
	}

	/// Returns this size scaled by the given scale
	func scaled(_ scale: CGFloat) -> CGSize {
		return CGSize(width: width * scale, height: height * scale)
	}

	/// Returns this size rounded to the nearest pixel
	func roundedToNearestPixel() -> CGSize {
		return CGSize(width: width.roundedToNearestPixel, height: height.roundedToNearestPixel)
	}

	/// Returns this size ceiled to the nearest pixel
	func ceiledToNearestPixel() -> CGSize {
		return CGSize(width: width.ceiledToNearestPixel, height: height.ceiledToNearestPixel)
	}

	/// Returns this size floored to the nearest pixel
	func flooredToNearestPixel() -> CGSize {
		return CGSize(width: width.flooredToNearestPixel, height: height.flooredToNearestPixel)
	}

	/// Returns this size rounded to full points (e.g. integers)
	func roundedToFullPoints() -> CGSize {
		return CGSize(width: round(width), height: round(height))
	}

	/// Returns this size ceiled to full points (e.g. integers)
	func ceiledToFullPoints() -> CGSize {
		return CGSize(width: ceil(width), height: ceil(height))
	}

	/// Returns this size floored to full points (e.g. integers)
	func flooredToFullPoints() -> CGSize {
		return CGSize(width: floor(width), height: floor(height))
	}

	/// Returns this size insetted by the given insets
	func insetted(by insets: UIEdgeInsets) -> CGSize {
		return CGSize(width: width - insets.left - insets.right, height: height - insets.top - insets.bottom)
	}

	/// Returns this size insetted by the given insets
	func insetted(by insets: NSDirectionalEdgeInsets) -> CGSize {
		return CGSize(width: width - insets.leading - insets.trailing, height: height - insets.top - insets.bottom)
	}

	/// Returns the size that aspect fills this size in the given boundingSize
	func aspectFill(for boundingSize: CGSize) -> CGSize {
		let ratio = height != 0 ? width / height : 0
		let outputRectRatio = boundingSize.height != 0 ? boundingSize.width / boundingSize.height : 0

		if outputRectRatio > ratio {
			let ratio = width != 0 ? boundingSize.width / width : 0
			return CGSize(width: ratio * width, height: ratio * height)
		} else if(outputRectRatio < ratio) {
			let ratio = height != 0 ? boundingSize.height / height : 0
			return CGSize(width: ratio * width, height: ratio * height);
		} else {
			return boundingSize
		}
	}

	/// Returns the size that aspect fits this size in the given boundingSize
	func aspectFit(for boundingSize: CGSize) -> CGSize {
		guard width >= boundingSize.width || height >= boundingSize.height else {return self}
		return aspectScale(for: boundingSize)
	}


	/// Returns the size that aspect scales this size in the given boundingSize
	func aspectScale(for boundingSize: CGSize) -> CGSize {
		guard width != 0 && height != 0 else {return .zero}

		let mW = boundingSize.width / width
		let mH = boundingSize.height / height

		if mH < mW {
			return boundingSize.with(width: boundingSize.height / height * width)
		} else if mW < mH {
			return boundingSize.with(height: boundingSize.width / width * height)
		} else {
			return boundingSize
		}
	}

	/// Returns true if this size is empty
	var isEmpty: Bool {
		return width <= 0 || height <= 0
	}

	/// a CGSize with width and height set to `greatestFiniteMagnitude`, useful when using `UIView.sizeThatFits()`
	static var greatestFiniteMagnitude = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
}
