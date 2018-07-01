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
    
    /// The SpriteKit scene to be set as the view's material.
    private let scene = SKScene()
    
    // MARK: - Public properties
    
    /// The receiver's immediate subviews.
    public var subviews: [ARUIView] = []
    
    /// The receiver's superview, or nil if it has none.
    public private(set) var superview: ARUIView? {
        didSet {
            self.didMoveToSuperview()
        }
    }
    
    /// An SKShapeNode defining the contents of the view.
    public var shapeLayer: SKShapeNode = SKShapeNode()
    
    /// The frame rectangle, which describes the view's location and size in it's superview's coordinate system. Analagous to a UIView frame.
    public var viewFrame: CGRect = CGRect.zero {
        didSet {
            self.geometry = SCNPlane(width: viewFrame.width, height: viewFrame.height)
            self.scene.size = CGSize(width: viewFrame.width * scaleFactor, height: viewFrame.height * scaleFactor)
            self.shapeLayer.path = CGPath(rect: CGRect(x: viewFrame.minX, y: viewFrame.minY, width: viewFrame.width * scaleFactor, height: viewFrame.height * scaleFactor), transform: nil)
        }
    }
    
    /// The view's background color.
    public var backgroundColor: UIColor = UIColor.white {
        didSet {
            self.shapeLayer.fillColor = backgroundColor
        }
    }
    
    /// The view's alpha value.
    public var alpha: CGFloat = 1.0 {
        didSet {
            self.shapeLayer.alpha = alpha
        }
    }
    
    /// The center point of the view's frame rectangle.
    public var center: CGPoint {
        return CGPoint(x: self.viewFrame.midX, y: self.viewFrame.midY)
    }
    
    /// The radius to use when drawing rounded corners for the view.
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            let plane = self.geometry as? SCNPlane
            plane?.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Initialization
    
    /// Initializes and returns a new allowcated 3D view object with a frame rectangle of CGRect.zero.
    public override convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    /// Initializes and returns a newly allocated 3D view object with the specific frame rectangle.
    ///
    /// - Parameter frame: The frame rectangle for the view, measured in meters. The origin on the frame is relative to a superview in which you plan to add it.
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
    
    /// Sets the frame property to the initialized frame parameter.
    ///
    /// - Parameter frame: The frame rectangle for the view, measured in meters.
    private func setFrame(frame: CGRect) {
        self.viewFrame = frame
    }
    
    /// Sets the shapeLayer property of the view for initialization.
    private func setLayer() {
        self.shapeLayer.lineWidth = 0.0
        self.scene.backgroundColor = UIColor.clear
        self.scene.addChild(shapeLayer)
    }
    
    /// Sets the material of the view to the scene, which contains the shapeLayer and any subviews (as SKNodes).
    private func setMaterial() {
        let material = SCNMaterial()
        material.isDoubleSided = true
        material.diffuse.contents = scene
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(1, 1, 1)
        self.geometry?.firstMaterial = material
    }
    
    /// Sets the proper default values for public properties on initialization.
    private func setDefaultPropertyValues() {
        self.shapeLayer.fillColor = self.backgroundColor
        self.shapeLayer.alpha = self.alpha
    }
    
    // MARK: - Public methods
    
    /// Adds a view to the end of the receiver's list of subviews.
    ///
    /// - Parameter view: The view to be added. After being added, this view appears on top of any other subviews.
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

