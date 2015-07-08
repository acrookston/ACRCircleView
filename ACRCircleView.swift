//
//  CircleView.swift
//  License: MIT
//
//  Created by Andrew Crookston <andrew@caoos.com> on 4/25/15.
//
//

import UIKit

class ACRCircleView: UIView {

    // MARK: Configurable values

    var strokeWidth : CGFloat = 2.0 {
        didSet {
            basePathLayer.lineWidth = strokeWidth
            circlePathLayer.lineWidth = strokeWidth
        }
    }

    override var tintColor : UIColor! {
        didSet {
            circlePathLayer.strokeColor = tintColor.CGColor
        }
    }

    var baseColor : UIColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1) {
        didSet {
            basePathLayer.strokeColor = baseColor.CGColor
        }
    }

    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if (newValue > 1.0) {
                circlePathLayer.strokeEnd = 1.0
            } else if (newValue < 0.0) {
                circlePathLayer.strokeEnd = 0.0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }

    // MARK: Init

    private let basePathLayer = CAShapeLayer()
    private let circlePathLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    func configure() {

        basePathLayer.frame = bounds
        basePathLayer.lineWidth = strokeWidth
        basePathLayer.fillColor = UIColor.clearColor().CGColor
        basePathLayer.strokeColor = baseColor.CGColor
        basePathLayer.actions = ["strokeEnd": NSNull()]
        layer.addSublayer(basePathLayer)

        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = strokeWidth
        circlePathLayer.fillColor = UIColor.clearColor().CGColor
        circlePathLayer.strokeColor = tintColor.CGColor
        // make optional for animated? See: http://stackoverflow.com/questions/21688363/change-cashapelayer-without-animation
        circlePathLayer.actions = ["strokeEnd": NSNull()]
        // rotate the layer negative 90deg to make it start at the top. 12 o'clock, default is 3 o'clock.
        circlePathLayer.transform = CATransform3DMakeRotation(-CGFloat(90.0 / 180.0 * M_PI), 0.0, 0.0, 1.0)
        layer.addSublayer(circlePathLayer)

        progress = 0
    }

    func circleFrame() -> CGRect {
        // keep the circle inside the bounds
        let shorter = (bounds.width > bounds.height ? bounds.height : bounds.width) - strokeWidth
        var circleFrame = CGRect(x: 0, y: 0, width: shorter, height: shorter)
        circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame)
        return circleFrame
    }

    func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalInRect: circleFrame())
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        basePathLayer.frame = bounds
        basePathLayer.path = circlePath().CGPath
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().CGPath
    }
}
