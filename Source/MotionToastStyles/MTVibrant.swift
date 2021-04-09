//
//  MotionToastView.swift
//  MotionToast
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit

class MTVibrant: UIView {
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var circleImg: UIImageView!
    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var circleView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
		self.commonInit()
		self.addBlurView()
		
		self.toastView.clipsToBounds = true
		self.circleView.layer.cornerRadius = self.circleView.bounds.size.width/2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
		self.commonInit()
		self.addBlurView()
    }
    
    func commonInit() {
        let bundle = Bundle(for: MTVibrant.self)
        let viewFromXib = bundle.loadNibNamed("MTVibrant", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
		self.addSubview(viewFromXib)
    }
	
	func addBlurView() {
		let blurEffect = UIBlurEffect(style: .prominent)
		let blurView = UIVisualEffectView(effect: blurEffect)
		self.toastView.insertSubview(blurView, at: 0)
		
		blurView.translatesAutoresizingMaskIntoConstraints = false
		blurView.topAnchor.constraint(equalTo: self.toastView.topAnchor).isActive = true
		blurView.bottomAnchor.constraint(equalTo: self.toastView.bottomAnchor).isActive = true
		blurView.leadingAnchor.constraint(equalTo: self.toastView.leadingAnchor).isActive = true
		blurView.trailingAnchor.constraint(equalTo: self.toastView.trailingAnchor).isActive = true
	}
    
    func addPulseEffect() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0.7
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
		self.circleImg.layer.add(pulseAnimation, forKey: "animateOpacity")
    }
    
	func configureMask(view: UIView, with image: UIImage){
		let masklayer = CALayer()
		masklayer.frame.origin = CGPoint(x: 0, y: 0 )
		masklayer.frame.size = view.frame.size
		masklayer.contents = image.cgImage
		view.layer.mask = masklayer
	}

    func setupViews(toastType: ToastType) {
		self.toastView.backgroundColor = nil
		
        switch toastType {
            case .success:
				self.circleImg.image = self.loadImage(name: "success_icon_white")
				self.circleView.backgroundColor = self.loadColor(name: "green")
                break
            case .error:
				self.circleImg.image = self.loadImage(name: "error_icon_white")
				self.circleView.backgroundColor = self.loadColor(name: "red")
                break
            case .warning:
				self.circleImg.image = self.loadImage(name: "warning_icon_white")
				self.circleView.backgroundColor = self.loadColor(name: "yellow")
                break
            case .info:
				self.circleImg.image = self.loadImage(name: "info_icon_white")
				self.circleView.backgroundColor = self.loadColor(name: "blue")
                break
		}
		
		let x = self.loadColor(name: "white_black")
    }
    
    func loadImage(name: String) -> UIImage? {
        let podBundle = Bundle(for: MTVibrant.self)
        if let url = podBundle.url(forResource: "MotionToastView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
    
    func loadColor(name: String) -> UIColor? {
        let podBundle = Bundle(for: MTVibrant.self)
        if let url = podBundle.url(forResource: "MotionToastView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIColor(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
}

