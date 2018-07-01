//
//  ARUILabel.swift
//  ARUIKit
//
//  Created by Doug Gandle on 7/1/18.
//  Copyright © 2018 Doug Gandle. All rights reserved.
//

import Foundation
import SpriteKit

public class ARUILabel: ARUIView {
    
    // MARK: - Private properties
    
    private var labelNode = SKLabelNode(text: nil)
    
    // MARK: - Public properties
    
    public var text: String? = nil {
        didSet {
            self.labelNode.text = text
        }
    }
    
    public var attributedText: NSAttributedString? = nil {
        didSet {
            self.labelNode.attributedText = attributedText
        }
    }
    
    public var font: UIFont! = UIFont.systemFont(ofSize: UIFont.systemFontSize) {
        didSet {
            self.labelNode.fontName = font.fontName
            self.labelNode.fontSize = font.pointSize * 10
        }
    }
    
    public var textColor: UIColor! = UIColor.black {
        didSet {
            self.labelNode.fontColor = textColor
        }
    }
    
    public var numberOfLines: Int = 1 {
        didSet {
            self.labelNode.numberOfLines = numberOfLines
        }
    }
    
    public var lineBreakMode: NSLineBreakMode = NSLineBreakMode.byTruncatingTail {
        didSet {
            self.labelNode.lineBreakMode = lineBreakMode
        }
    }
    
    public var preferredMaxLayoutWidth: CGFloat! {
        didSet {
            self.labelNode.preferredMaxLayoutWidth = preferredMaxLayoutWidth * scaleFactor
        }
    }
    
    public var horizontalTextAlignment: SKLabelHorizontalAlignmentMode = .center {
        didSet {
            switch horizontalTextAlignment {
            case .left:
                self.labelNode.horizontalAlignmentMode = .right
            case .right:
                self.labelNode.horizontalAlignmentMode = .left
            default:
                self.labelNode.horizontalAlignmentMode = .center
            }
        }
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.applyLabelDefaults()
        
        self.labelNode.zRotation = .pi
        self.labelNode.xScale = -1
        
        self.shapeLayer.addChild(self.labelNode)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyLabelDefaults() {
        self.labelNode.fontName = self.font.fontName
        self.labelNode.fontSize = self.font.pointSize * 10
        self.labelNode.fontColor = self.textColor
        self.labelNode.numberOfLines = self.numberOfLines
        self.labelNode.lineBreakMode = self.lineBreakMode
        self.labelNode.position = CGPoint(x: self.viewFrame.width/2 * scaleFactor, y: self.viewFrame.height/2 * scaleFactor)
        self.labelNode.horizontalAlignmentMode = .center
        self.labelNode.verticalAlignmentMode = .center
    }
    
}
