//
//  CustomContainerView.swift
//  Assignment2
//
//  Created by abdrahman on 31/05/2022.
//

import UIKit

// this protocol is to enable picking images from inside the custom view
protocol CustomContainerViewDelegate: class{
    func didSelectImg(_ tag: Int)
}

class CustomContainerView: UIView{
    
    private let lineWidth: CGFloat = 2
    private let lineColor = UIColor.black

    private var bezierPath1: UIBezierPath?
    private var bezierPath2: UIBezierPath?
    private var bezierPath3: UIBezierPath?
    let imageView1 = UIImageView()
    let imageView2 = UIImageView()
    let imageView3 = UIImageView()
    
    weak var delegate: CustomContainerViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(imageView1)
        addSubview(imageView2)
        addSubview(imageView3)
        
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView1.tag = 1
        imageView2.tag = 2
        imageView3.tag = 3
        imageView2.image = UIImage(named: "HMD-RMB-2")
        imageView1.image = UIImage(named: "md")
        imageView3.image = UIImage(named: "socket")
        imageView1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:))))
        imageView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:))))
        imageView3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:))))
    }
    
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        delegate?.didSelectImg(sender.view?.tag ?? 0)
        print("did tap image view", sender.view?.tag)
    }
    
    override func draw(_ rect: CGRect) {
        if let path1 = bezierPath1 {
            lineColor.setStroke()
            path1.stroke()
        }
        if let path2 = bezierPath2 {
            lineColor.setStroke()
            path2.stroke()
        }
        
        if let path3 = bezierPath3 {
            lineColor.setStroke()
            path3.stroke()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()


        let path1 = UIBezierPath()
        path1.lineWidth = lineWidth

        let startPoint1 = CGPoint(x: 0, y: 0)
        path1.move(to: startPoint1)


        path1.addLine(to: CGPoint(x: 0, y: 0))

        path1.addLine(to: CGPoint(x: 321, y: 0))

        path1.addLine(to: CGPoint(x: 321, y: 110))

        path1.addLine(to: CGPoint(x:00, y: 110))

        path1.addLine(to: CGPoint(x: 0, y: 0))
        path1.close()

        let path2 = UIBezierPath()
        path2.lineWidth = lineWidth

        let startPoint2 = CGPoint(x: 0, y: 110)
        path2.move(to: startPoint2)


        path2.addLine(to: CGPoint(x: 0, y: 110))

        path2.addLine(to: CGPoint(x: 190, y: 110))

        path2.addLine(to: CGPoint(x: 120, y: 321))

        path2.addLine(to: CGPoint(x: 0, y: 321))

        path2.addLine(to: CGPoint(x: 0, y: 110))
        
        path2.close()

        let path3 = UIBezierPath()
        path3.lineWidth = lineWidth

        let startPoint3 = CGPoint(x: 321, y: 110)
        path3.move(to: startPoint3)

        path3.addLine(to: CGPoint(x: 321, y: 110))
        
        path3.addLine(to: CGPoint(x: 321, y: 321))
        
        path3.addLine(to: CGPoint(x: 120, y: 321))

        path3.addLine(to: CGPoint(x: 190, y: 110))

        path3.addLine(to: CGPoint(x: 321, y: 110))
        
        path3.close()
        
        imageView1.frame = path1.bounds
        let maskLayer1 = CAShapeLayer()
        maskLayer1.path = path1.cgPath
        imageView1.layer.mask = maskLayer1
        bezierPath1 = path1

        imageView2.frame = path2.bounds
        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = path2.cgPath
        imageView2.layer.mask = maskLayer2
        bezierPath2 = path2
        
        imageView3.frame = path3.bounds
        let maskLayer3 = CAShapeLayer()
        maskLayer3.path = path3.cgPath
        imageView3.layer.mask = maskLayer3
        bezierPath3 = path3
        setNeedsDisplay()
        
        print("path 1 bounds are :- \(path1.bounds)")
        print("path 2 bounds are :- \(path2.bounds)")
        print("path 3 bounds are :- \(path3.bounds)")
        print("bounds are :- \(bounds)")
    }
}
