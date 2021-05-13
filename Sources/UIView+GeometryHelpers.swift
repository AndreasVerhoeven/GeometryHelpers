//
//  UIView+GeometryHelpers.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 13/05/2021.
//

import UIKit

public extension UIView {
	/// Returns the scale to use for this view, falling back to the
	/// screen scale when this view has no window
	var scaleToUse: CGFloat {
		return window?.screen.scale ?? UIScreen.main.scale
	}

	/// The `safe` center of this view, ignoring transforms and making sure we are pixel aligned.
	/// Setting the center makes sure the center view will be pixel aligned for the current size.
	var safeCenter: CGPoint {
		get { return center}
		set(center) {
			let scale = scaleToUse
			var size = bounds.size
			size.width *= scale
			size.height *= scale

			var fixedCenter = center
			fixedCenter.x *= scale
			fixedCenter.y *= scale

			let xDiff = (fixedCenter.x - size.width * 0.5) - floor(fixedCenter.x - size.width * 0.5)
			fixedCenter.x -= xDiff

			let yDiff = (fixedCenter.y - size.height * 0.5) - floor(fixedCenter.y - size.height * 0.5)
			fixedCenter.y -= yDiff

			fixedCenter.x /= scale
			fixedCenter.y /= scale

			self.center = fixedCenter
		}
	}

	/// The 'safe' frame of this view, ignoring transforms.
	/// Gets/sets the frame of this view by get/setting the center and bounds
	var safeFrame: CGRect {
		get {
			let size = safeSize
			let center = safeCenter
			return CGRect(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5, width: size.width, height: size.height)
		}
		set(frame) {
			safeSize = frame.size
			safeCenter = CGPoint(x: frame.midX, y: frame.midY)
		}
	}

	/// The 'safe' size, ignoring transforms.
	/// Gets/sets the size of the bounds.
	var safeSize: CGSize {
		get {
			return bounds.size
		}
		set(size) {
			var newBounds = bounds
			newBounds.size = size
			bounds = newBounds
		}
	}

	/// calls sizeThatFits() and makes sure the returned size
	/// is never bigger than the given size in any dimension
	///
	/// - Parameters:
	///		- size: the size to fit
	/// - Returns: the size that fits, restricted to the given size in both dimensions
	func fittingSizeThatFits(_ size: CGSize) -> CGSize {
		return sizeThatFits(size).min(size)
	}
}
