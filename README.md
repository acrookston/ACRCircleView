# ACRCircleView

Just throwing this up temporarily. Theres' no Cocoapod yet but that will be added in time.

## Example output

![](https://github.com/acrookston/ACRCircleView/blob/master/example.png)

## Example code

Here's a fully working example using the circle view.

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
    var otherView = ACRCircleView(frame: CGRect(x: 40, y: 400, width: 100, height: 100))
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