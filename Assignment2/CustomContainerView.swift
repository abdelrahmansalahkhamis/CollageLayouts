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
    
    // these properties will be included in the bezier paths
    private let lineWidth: CGFloat = 2
    private let lineColor: UIColor = UIColor.black

    // three UIBezierPath instances for three image sections
    private var bezierPath1: UIBezierPath?
    private var bezierPath2: UIBezierPath?
    private var bezierPath3: UIBezierPath?
    
    // three UIImageView instances for three image sections
    let imageView1 = UIImageView()
    let imageView2 = UIImageView()
    let imageView3 = UIImageView()
    
    // this delegate is to enable communication with main vc and pass image tag
    weak var delegate: CustomContainerViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImages()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImages()
    }
    
    // configure 3 image views, each is a container for images
    private func setupImages() {
        //backgroundColor = .white
        addSubview(imageView3)
        addSubview(imageView2)
        addSubview(imageView1)
        
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView1.tag = 1
        imageView2.tag = 2
        imageView3.tag = 3
        imageView1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:))))
        imageView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:))))
        imageView3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:))))
    }
    
    // action based on image tap
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        delegate?.didSelectImg(sender.view?.tag ?? 1)
    }
    
    // draw function automaticly invoked to draw the view's content
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
    
    // layoutSubviews is to set the frame rectangles of subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpBezierPath()
    }
    
    // create 3 bezier paths that will surround the images sections and will be invoked in the layoutSubviews function
    func setUpBezierPath(){
        
        // first, create 3 paths with specific lines
        // ---------------------------------------- path 1  ----------------------------------------
        let path1 = UIBezierPath(ovalIn: imageView1.frame)
        path1.lineWidth = lineWidth
        let startPoint1 = CGPoint(x: 0, y: 0)
        path1.move(to: startPoint1)
        path1.addLine(to: CGPoint(x: 0 , y: 0))
        path1.addLine(to: CGPoint(x: self.frame.size.width / 2, y: 0))
        path1.addLine(to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height))
        path1.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        path1.addLine(to: CGPoint(x: 0, y: 0))
        path1.close()
        bezierPath1 = path1

        // ---------------------------------------- path 2  ----------------------------------------
        let path2 = UIBezierPath(ovalIn: imageView2.frame)
        path2.lineWidth = lineWidth

        let startPoint2 = CGPoint(x: self.frame.size.width / 2, y: 0)
        path2.move(to: startPoint2)
        path2.addLine(to: CGPoint(x: self.frame.size.width / 2, y: 0))
        path2.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        path2.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height - 120))
        path2.addLine(to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 160))
        path2.addLine(to: CGPoint(x: self.frame.size.width / 2, y: 0))
        path2.close()
        bezierPath2 = path2

        // ---------------------------------------- path 3  ----------------------------------------
        let path3 = UIBezierPath(ovalIn: imageView3.frame)
        path3.lineWidth = lineWidth

        let startPoint3 = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 160)
        path3.move(to: startPoint3)
        path3.addLine(to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 160))
        path3.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height - 120))
        path3.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path3.addLine(to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height))
        path3.addLine(to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 160))
        path3.close()
        bezierPath3 = path3
        
        // then, create shape layers and assign to image views
        createMaskForImage(path1, imageView1)
        createMaskForImage(path2, imageView2)
        createMaskForImage(path3, imageView3)
        
        setNeedsDisplay()
    }
    
    // create shape layers and assign to image views
    func createMaskForImage(_ path: UIBezierPath, _ imageView: UIImageView){
        imageView.frame = path.bounds
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        imageView.layer.mask = maskLayer
    }
}

