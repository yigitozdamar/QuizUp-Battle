//
//  Progressbar.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 11.02.2023.
//

import UIKit

class Progressbar: UIView {
    
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    
    public var progress: CGFloat = 10 {
        didSet {
            updateProgress()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let lineWidth = min(width, height) * 0.1
        
        backgroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        foregroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.red.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        textLayer = createTextLayer(rect: rect, textColor: UIColor.black.cgColor)
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
        layer.addSublayer(textLayer)
    }
    
    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        let width = rect.width
        let height = rect.height
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = fillColor
        shapeLayer.lineCap = .round
        
        return shapeLayer
    }
    
    private func createTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer {
        let width = rect.width
        let height = rect.height
        let fontSize = min(width, height) / 4
        let offset = min(width, height) * 0.1
        
        let layer = CATextLayer()
        layer.string = "10"
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = textColor
        layer.fontSize = fontSize
        layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: height)
        layer.alignmentMode = .center
        
        return layer
    }
    
    private func updateProgress() {
          
        let countDown = Int( (progress * 11.5) - 1)
          print(countDown)
          textLayer.string = "\(countDown)"
          foregroundLayer?.strokeEnd = progress
      }
  
}
