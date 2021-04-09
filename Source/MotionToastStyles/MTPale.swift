//
//  MTPale.swift
//  MotionToast
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit

class MTPale: UIView {
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var circleImg: UIImageView!
    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var sideBarView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
		self.commonInit()
		self.addBlurView()
		
		self.toastView.clipsToBounds = true
		self.sideBarView.layer.cornerRadius = 3
		self.toastView.layer.cornerRadius = 12
		self.toastView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
		self.circleView.layer.cornerRadius = self.circleView.bounds.size.width/2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
		self.commonInit()
		self.addBlurView()
    }
    
    func commonInit() {
        let bundle = Bundle(for: MTPale.self)
        let viewFromXib = bundle.loadNibNamed("MTPale", owner: self, options: nil)![0] as! UIView
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
    
    func setupViews(toastType: ToastType) {
        switch toastType {
            case .success:
				self.headLabel.text = "Success"
				self.circleImg.image = loadImage(name: "success_icon_white")
				self.sideBarView.backgroundColor = loadColor(name: "green")
				self.circleView.backgroundColor = loadColor(name: "green")
				self.toastView.backgroundColor = loadColor(name: "alpha_green_dark")
                break
            case .error:
				self.headLabel.text = "Error"
				self.circleImg.image = loadImage(name: "error_icon_white")
				self.sideBarView.backgroundColor = loadColor(name: "red")
				self.circleView.backgroundColor = loadColor(name: "red")
				self.toastView.backgroundColor = loadColor(name: "alpha_red_dark")
                break
            case .warning:
				self.headLabel.text = "Warning"
				self.circleImg.image = loadImage(name: "warning_icon_white")
				self.sideBarView.backgroundColor = loadColor(name: "yellow")
				self.circleView.backgroundColor = loadColor(name: "yellow")
				self.toastView.backgroundColor = loadColor(name: "alpha_yellow_dark")
                break
            case .info:
				self.headLabel.text = "Info"
				self.circleImg.image = loadImage(name: "info_icon_white")
				self.sideBarView.backgroundColor = loadColor(name: "blue")
				self.circleView.backgroundColor = loadColor(name: "blue")
				self.toastView.backgroundColor = loadColor(name: "alpha_blue_dark")
                break
        }
    }
    
    func loadImage(name: String) -> UIImage? {
        let podBundle = Bundle(for: MTPale.self)
        if let url = podBundle.url(forResource: "MotionToastView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
    
    func loadColor(name: String) -> UIColor? {
        let podBundle = Bundle(for: MTPale.self)
        if let url = podBundle.url(forResource: "MotionToastView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIColor(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
}
