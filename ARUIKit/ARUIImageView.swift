//
//  ARUIImageView.swift
//  ARUIKit
//
//  Created by Doug Gandle on 7/1/18.
//  Copyright © 2018 Doug Gandle. All rights reserved.
//

import Foundation
import SpriteKit

public class ARUIImageView: ARUIView {
    
    // MARK: - Private properties
    
    private var imageNode: SKSpriteNode = SKSpriteNode()
    
    // MARK: - Public properties
    
    public var image: UIImage? {
        didSet {
            self.imageNode.texture = SKTexture(image: self.flip(image: image!))
            self.imageNode.size = CGSize(width: image!.size.width, height: image!.size.height)
        }
    }
    
    // MARK: - Initialization
    
    public init(image: UIImage?) {
        self.image = image
        
        guard let image = image else {
            super.init(frame: CGRect.zero)
            return
        }
        
        super.init(frame: CGRect(x: 0, y: 0, width: image.size.width / scaleFactor, height: image.size.height / scaleFactor))
        
        self.imageNode.anchorPoint = CGPoint(x: 0, y: 0)
        self.imageNode.texture = SKTexture(image: self.flip(image: image))
        self.imageNode.size = CGSize(width: image.size.width, height: image.size.height)
        
        self.shapeLayer.addChild(self.imageNode)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageNode.anchorPoint = CGPoint(x: 0, y: 0)
        self.shapeLayer.addChild(self.imageNode)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func flip(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContext(image.size)
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1.0, y: 1.0)
        context?.draw(image.cgImage!, in: CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // MARK: - Public methods
    
}
