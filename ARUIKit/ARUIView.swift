//
//  ARUIView.swift
//  ARUIKit
//
//  Created by Doug Gandle on 7/1/18.
//  Copyright © 2018 Doug Gandle. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

public class ARUIView: ARUIResponder {
    
    // MARK: - Private properties
    
    private let scene = SKScene()
    
    // MARK: - Public properties
    
    public var subviews: [ARUIView] = []
    
    public private(set) var superview: ARUIView? {
        didSet {
            self.didMoveToSuperview()
        }
    }
    
    public var shapeLayer: SKShapeNode = SKShapeNode()
    
    public var viewFrame: CGRect = CGRect.zero {
        didSet {
            self.geometry = SCNPlane(width: viewFrame.width, height: viewFrame.height)
            self.scene.size = CGSize(width: viewFrame.width * scaleFactor, height: viewFrame.height * scaleFactor)
            self.shapeLayer.path = CGPath(rect: CGRect(x: viewFrame.minX, y: viewFrame.minY, width: viewFrame.width * scaleFactor, height: viewFrame.height * scaleFactor), transform: nil)
        }
    }
    
    public var backgroundColor: UIColor = UIColor.white {
        didSet {
            self.shapeLayer.fillColor = backgroundColor
        }
    }
    
    public var alpha: CGFloat = 1.0 {
        didSet {
            self.shapeLayer.alpha = alpha
        }
    }
    
    public var center: CGPoint {
        return CGPoint(x: self.viewFrame.midX, y: self.viewFrame.midY)
    }
    
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            let plane = self.geometry as? SCNPlane
            plane?.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Initialization
    
    override convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public init(frame: CGRect) {
        super.init()
        self.setFrame(frame: frame)
        self.setLayer()
        self.setMaterial()
        self.setDefaultPropertyValues()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setFrame(frame: CGRect) {
        self.viewFrame = frame
    }
    
    private func setLayer() {
        self.shapeLayer.lineWidth = 0.0
        self.scene.backgroundColor = UIColor.clear
        self.scene.addChild(shapeLayer)
    }
    
    private func setMaterial() {
        let material = SCNMaterial()
        material.isDoubleSided = true
        material.diffuse.contents = scene
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(1, 1, 1)
        self.geometry?.firstMaterial = material
    }
    
    private func setDefaultPropertyValues() {
        self.shapeLayer.fillColor = self.backgroundColor
        self.shapeLayer.alpha = self.alpha
    }
    
    // MARK: - Public methods
    
    public func addSubview(_ view: ARUIView) {
        self.subviews.append(view)
        view.superview = self
        view.shapeLayer.removeFromParent()
        self.scene.addChild(view.shapeLayer)
        self.didAddSubview(view)
    }
    
    /// Inserts a subview at the specific index.
    ///
    /// - Parameters:
    ///   - view: The view to insert. This value cannot be nil.
    ///   - index: The index in the array of the subviews property at which to insert the view. Subview indices start at 0 and cannot be greater than the number of subviews.
    public func insertSubview(_ view: ARUIView, at index: Int) {
        self.subviews.insert(view, at: index)
        view.superview = self
        view.shapeLayer.removeFromParent()
        self.scene.insertChild(view.shapeLayer, at: index)
        self.didAddSubview(view)
    }
    
    /// Unlinks the view from its superview and its window, and removes it from the responder chain.
    public func removeFromSuperview() {
        guard let index = self.superview?.subviews.index(of: self) else { return }
        self.superview?.subviews.remove(at: index)
    }
    
    /// Tells the view that a subview was added.
    ///
    /// - Parameter view: The view that was added to the subview
    public func didAddSubview(_ view: ARUIView) { }
    
    /// Tells the view that its superview changed.
    public func didMoveToSuperview() { }
}

