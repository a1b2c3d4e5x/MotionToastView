//
//  Extension.swift
//  MotionToast
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit

public enum ToastType {
    case success
    case error
    case warning
    case info
}

public enum ToastDuration {
    case short
    case long
	
	public var duration: TimeInterval {
		get {
			switch self {
			case .long:
				return 4.0
			case .short:
				return 2.0
			}
		}
	}
}

public enum ToastGravity {
	case top
	case centre
	case bottom
	
	public func rect(offset: CGPoint = .zero) -> CGRect {
		let size: CGSize = UIScreen.main.bounds.size
		switch self {
		case .top:
			return CGRect(x: 0.0 + offset.x, y: 80.0 + offset.y, width: size.width, height: 83.0)
		case .centre:
			return CGRect(x: 0.0 + offset.x, y: ((size.height / 2) - 41) + offset.y, width: size.width, height: 83.0)
		case .bottom:
			return CGRect(x: 0.0 + offset.x, y: (size.height - 190.0) + offset.y, width: size.width, height: 83.0)
		}
	}
}

public enum ToastStyle {
    case style_vibrant
    case style_pale
	
	public func create(message: String,
				toastType: ToastType,
				toastGravity: ToastGravity,
				toastCornerRadius: Int,
				pulseEffect: Bool) -> UIView {
		switch self {
			case .style_vibrant:
				let gravity: CGRect = toastGravity.rect()
				let toastView = MTVibrant(frame: gravity)
				toastView.setupViews(toastType: toastType)
				if pulseEffect { toastView.addPulseEffect() }
				toastView.msgLabel.text = message
				toastView.toastView.layer.cornerRadius = CGFloat(toastCornerRadius)
				return toastView
			
			case .style_pale:
				let gravity: CGRect = toastGravity.rect()
				let toastView = MTPale(frame: gravity)
				toastView.setupViews(toastType: toastType)
				if pulseEffect { toastView.addPulseEffect() }
				toastView.msgLabel.text = message
				return toastView
		}
	}
}

extension UIViewController {
    
	public func MotionToast(message: String, toastType: ToastType, duration: ToastDuration? = .short, toastStyle: ToastStyle? = .style_vibrant, toastGravity: ToastGravity? = .bottom, toastCornerRadius: Int? = 0, pulseEffect: Bool? = true) {

		//MotionToastView.MotionToast.show(message: message, toastType: toastType, duration: duration, toastStyle: toastStyle, toastGravity: toastGravity, toastCornerRadius: toastCornerRadius, pulseEffect: pulseEffect)
    }
    
    public func MotionToast_Customisation(header: String, message: String, headerColor: UIColor, messageColor: UIColor,
                                          primary_color: UIColor, secondary_color: UIColor, icon_image: UIImage,
                                          duration: ToastDuration? = .short, toastStyle: ToastStyle? = .style_vibrant,
										  toastGravity: ToastGravity? = .bottom, toastCornerRadius: Int? = 0, pulseEffect: Bool? = true) {
        
		guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        
        var toastDuration = 2.0
        switch duration {
            case .short: toastDuration = 2.0;break
            case .long: toastDuration = 4.0;break
            case .none: break
        }
        
        var toastUIView: UIView?
        switch toastStyle {
            case .style_vibrant:
				let gravity: CGRect = toastGravity!.rect()
                let toastView = MTVibrant(frame: gravity)
                if pulseEffect! { toastView.addPulseEffect() }
                toastView.toastView.layer.cornerRadius = CGFloat(toastCornerRadius!)
				
                toastView.msgLabel.text = message
                toastView.msgLabel.textColor = messageColor
                toastView.circleImg.image = icon_image
                toastView.toastView.backgroundColor = primary_color
                toastView.circleView.backgroundColor = secondary_color
                toastUIView = toastView
                break
            
            case .style_pale:
				let gravity: CGRect = toastGravity!.rect()
                let toastView = MTPale(frame: gravity)
                if pulseEffect! { toastView.addPulseEffect() }
                toastView.toastView.layer.cornerRadius = CGFloat(toastCornerRadius!)
                
                toastView.headLabel.text = header
                toastView.headLabel.textColor = headerColor
                toastView.msgLabel.text = message
                toastView.msgLabel.textColor = messageColor
                toastView.circleImg.image = icon_image
                toastView.toastView.backgroundColor = primary_color
                toastView.circleView.backgroundColor = secondary_color
                toastView.sideBarView.backgroundColor = secondary_color
                toastUIView = toastView
                break
            case .none: break
        }
        
        window.addSubview(toastUIView!)
        
        UIView.animate(withDuration: 1.0, delay: toastDuration, animations: {
            toastUIView!.alpha = 0
        }) { (_) in
            toastUIView!.removeFromSuperview()
        }
    }
}
