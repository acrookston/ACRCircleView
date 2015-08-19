# ACRCircleView

A simple Swift UIView class using CAShapeLayer to create pie charts or circular progress bars.

Just throwing this up temporarily. There is no Cocoapod yet but that will be added in time.

It can animate the circle to create a customized loading / spinning indicator for iOS.

## Demo

![](https://github.com/acrookston/ACRCircleView/blob/master/demo.gif)

## Demo code

Here's the code I used for rendering the above demo. The top progress view is rendered in a storyboard / nib to demo that it can be added that way too.

```
//
//  ViewController.swift
//  License: MIT
//
//  Created by Andrew Crookston <andrew@caoos.com> on 4/25/15.
//
//  Demonstrates who to use two different kinds of ACRCircleView first with Interface Builder, second manually.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: ACRCircleView!
    var otherView = ACRCircleView(frame: CGRect(x: 40, y: 200, width: 100, height: 100))
    var animating = ACRCircleView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
    var timer : NSTimer?
    var time : Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.baseColor = UIColor.darkGrayColor()
        progressView.tintColor = UIColor.redColor()
        progressView.strokeWidth = 10

        // Full circle "pie chart" style.
        // progressView.strokeWidth = progressView.bounds.width / 2

        otherView.baseColor = UIColor.clearColor()
        otherView.strokeWidth = otherView.bounds.width / 2
        otherView.progress = 0.66
        self.view.addSubview(otherView)

        animating.baseColor = UIColor(white: 0, alpha: 0.2)
        animating.tintColor = UIColor(white: 0, alpha: 0.5)
        animating.strokeWidth = 4
        animating.progress = 0.2
        self.view.addSubview(animating)
        animating.startAnimating()


        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }

    func update() {
        time = time + 0.1
        if time >= 1.0 {
            progressView.progress = 1.0
            timer?.invalidate()
        } else {
            progressView.progress = CGFloat(time % 1.0)
        }
    }
}

```