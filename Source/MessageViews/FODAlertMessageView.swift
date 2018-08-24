//
//  FODAlertMessageView.swift
//  SwiftEntryKit
//
//  Created by Thomas on 5/5/18.
//

import UIKit

public class FODAlertMessageView: EKSimpleMessageView {
    
    // MARK: Props
    private var buttonBarView: EKButtonBarView!
    private var buttonsBarCompressedConstraint: NSLayoutConstraint!
    private var buttonsBarExpandedConstraint: NSLayoutConstraint!
    
    // MARK: Setup
    public init(with message: EKAlertMessage) {
        super.init(with: message.simpleMessage)
        setupButtonBarView(with: message.buttonBarContent)
        layoutContent(with: message)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonBarView(with content: EKProperty.ButtonBarContent) {
        buttonBarView = EKButtonBarView(with: content)
        buttonBarView.clipsToBounds = true
        addSubview(buttonBarView)
    }
    
    func layoutContent(with message: EKAlertMessage) {

        switch message.imagePosition {
        case .top:
            // Modified for FOD
            messageContentView.verticalMargins = 40
            messageContentView.horizontalMargins = 16
            messageContentView.labelsOffset = 5
            
            if let thumbImageView = thumbImageView {
                thumbImageView.layoutToSuperview(.top, offset: 0)
                thumbImageView.layoutToSuperview(.centerX)
                messageContentView.layout(.top, to: .bottom, of: thumbImageView)
            } else {
                messageContentView.layoutToSuperview(.top)
            }

            messageContentView.layoutToSuperview(axis: .horizontally)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView)
        case .left:
            messageContentView.verticalMargins = 0
            messageContentView.horizontalMargins = 0
            messageContentView.labelsOffset = 5
            
            if let thumbImageView = thumbImageView {
                thumbImageView.layoutToSuperview(.top, .left, offset: 16)
                messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
                messageContentView.layout(to: .top, of: thumbImageView, offset: 2)
            } else {
                messageContentView.layoutToSuperview(.left, .top, offset: 16)
            }

            messageContentView.layoutToSuperview(.right, offset: -16)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView, offset: 10)
        }
        
        buttonBarView.layoutToSuperview(axis: .horizontally)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.alpha = 0

        if !message.buttonBarContent.content.isEmpty {
            if message.buttonBarContent.expandAnimatedly {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.buttonBarView.expand()
                }
            } else {
                buttonBarView.expand()
            }
        }
    }
}
