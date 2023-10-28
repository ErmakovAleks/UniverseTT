//
//  TermsOfUseView.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 28.10.2023.
	

import UIKit

final class TermsOfUseView: BaseView<TermsOfUseViewModel, TermsOfUseViewModelOutputEvents> {
    
    // MARK: -
    // MARK: Variables
    
    private let scrollView = UIScrollView()
    private let textView = UITextView()
    
    // MARK: -
    // MARK: Overrided functions
    
    override func setup() {
        self.scrollViewSetup()
        self.textViewSetup()
    }
    
    override func style() {
        self.view.backgroundColor = .white
        self.textViewStyle()
    }
    
    override func layout() {
        self.scrollViewLayout()
        self.textViewLayout()
    }
    
    // MARK: -
    // MARK: ScrollView functions
    
    private func scrollViewSetup() {
        self.view.addSubview(self.scrollView)
    }
    
    private func scrollViewLayout() {
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
    }
    
    // MARK: -
    // MARK: TextView functions
    
    private func textViewSetup() {
        self.scrollView.addSubview(self.textView)
    }
    
    private func textViewStyle() {
        let text =
"""
Lorem ipsum dolor sit amet consectetur. Bibendum nibh ornare ultricies bibendum pretium sed senectus. Nulla rhoncus lacus turpis faucibus phasellus nec mattis nullam. Turpis leo egestas nec lorem volutpat eget mauris sed amet. Dignissim orci pharetra blandit urna nunc.Lorem ipsum dolor sit amet consectetur. Bibendum nibh ornare ultricies bibendum pretium sed senectus. Nulla rhoncus lacus turpis faucibus phasellus nec mattis nullam. Turpis leo egestas nec lorem volutpat eget mauris sed amet. Dignissim orci pharetra blandit urna nunc.Lorem ipsum dolor sit amet consectetur. Bibendum nibh ornare ultricies bibendum pretium sed senectus. Nulla rhoncus lacus turpis faucibus phasellus nec mattis nullam. Turpis leo egestas nec lorem volutpat eget mauris sed amet. Dignissim orci pharetra blandit urna nunc.Lorem ipsum dolor sit amet consectetur. Bibendum nibh ornare ultricies bibendum pretium sed senectus. Nulla rhoncus lacus turpis faucibus phasellus nec mattis nullam. Turpis leo egestas nec lorem volutpat eget mauris sed amet. Dignissim orci pharetra blandit urna nunc.
"""
        let titleAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.boldSystemFont(ofSize: 28.0),
            .foregroundColor: UIColor.activeBlue,
            .paragraphStyle: {
                let paragraph = NSMutableParagraphStyle()
                paragraph.lineSpacing = 20.0
                paragraph.alignment = .center
                
                return paragraph
            }()
        ]
        
        let bodyAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.systemFont(ofSize: 15.0),
            .foregroundColor: UIColor.black,
            .paragraphStyle: {
                let paragraph = NSMutableParagraphStyle()
                paragraph.lineSpacing = 15.0
                paragraph.alignment = .justified
                
                return paragraph
            }()
        ]
        
        let title = NSAttributedString(string: "Terms of Use\n", attributes: titleAttributes)
        let body = NSAttributedString(string: text, attributes: bodyAttributes)
        let final = NSMutableAttributedString(attributedString: title)
        final.append(body)
        
        self.textView.backgroundColor = .white
        self.textView.attributedText = final
    }
    
    private func textViewLayout() {
        self.textView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view).inset(24.0)
            $0.height.top.bottom.equalToSuperview()
        }
    }
}
