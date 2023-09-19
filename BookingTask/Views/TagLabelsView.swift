//
//  TagLabelsView.swift
//  BookingTask
//
//  Created by Sergei on 15.09.2023.
//

import UIKit

class TagLabelsView: UIView {
    
    public var tagNames: [String] = [] {
        didSet {
            addTagLabels()
        }
    }
    
    private let tagHeight: CGFloat = 30
    private let tagPadding: CGFloat = 10
    private let tagSpacingX: CGFloat = 8
    private let tagSpacingY: CGFloat = 8
    private let cornerRadius: CGFloat = 5

    private var intrinsicHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() -> Void {
        clipsToBounds = true
    }

    private func addTagLabels() -> Void {
        
        // if we already have tag labels (or buttons, etc)
        //  remove any excess (e.g. we had 10 tags, new set is only 7)
        while self.subviews.count > tagNames.count {
            self.subviews[0].removeFromSuperview()
        }
        
        // if we don't have enough labels, create and add as needed
        while self.subviews.count < tagNames.count {

            // create a new label
            let newLabel = UILabel()
            
            // set its properties (title, colors, corners, etc)
            newLabel.textAlignment = .center
            newLabel.backgroundColor = Theme.cellBgColor
            newLabel.textColor = Theme.cellTextColor
            newLabel.layer.masksToBounds = true
            newLabel.layer.cornerRadius = cornerRadius

            addSubview(newLabel)
        }

        // now loop through labels and set text and size
        for (str, v) in zip(tagNames, self.subviews) {
            guard let label = v as? UILabel else {
                fatalError("non-UILabel subview found!")
            }
            label.text = str
            label.frame.size.width = label.intrinsicContentSize.width + 2 * tagPadding
            label.frame.size.height = tagHeight
        }

    }
    
    private func displayTagLabels() {
        
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0
        var labelIndex = 0
        // for each label in the array
        self.subviews.forEach { v in
            
            guard let label = v as? UILabel else {
                fatalError("non-UILabel subview found!")
            }

            // if current X + label width will be greater than container view width
            //  "move to next row"
            if currentOriginX + label.frame.width > bounds.width {
                currentOriginX = 0
                currentOriginY += labelIndex > 0 ? tagHeight + tagSpacingY : 0
            }
            
            // set the btn frame origin
            label.frame.origin.x = currentOriginX
            label.frame.origin.y = currentOriginY
            
            // increment current X by btn width + spacing
            currentOriginX += label.frame.width + tagSpacingX
            labelIndex += 1
        }
        
        // update intrinsic height
        intrinsicHeight = currentOriginY + tagHeight
        invalidateIntrinsicContentSize()
        
    }

    // allow this view to set its own intrinsic height
    override var intrinsicContentSize: CGSize {
        var sz = super.intrinsicContentSize
        sz.height = intrinsicHeight
        
        return sz
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayTagLabels()
    }
    
}
