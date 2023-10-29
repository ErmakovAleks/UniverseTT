//
//  OnboardingPageControl.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 28.10.2023.
	

import UIKit

fileprivate extension Constants {
    
    static let animationTimeInterval: Double = 0.3
    
    static let currentIndicatorLength: CGFloat = 25.0
    static let indicatorSpacing: CGFloat = 8.0
    static let indicatorLength: CGFloat = 14.0
    static let indicatorWidth: CGFloat = 4.0
    static let cornerRadius: CGFloat = 2.0
}

final class OnboardingPageControl: UIView {
    
    // MARK: -
    // MARK: Variables
    
    private var currentPageIndex = 0
    
    private let pagesNumber: Int
    private let containerStackView = UIStackView()
    
    // MARK: -
    // MARK: Initializers
    
    init(pagesNumber: Int, frame: CGRect = .zero) {
        self.pagesNumber = pagesNumber
        
        super.init(frame: frame)
        
        self.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Internal functions
    
    func flipPage(to page: Int) {
        if !(page >= self.pagesNumber || page < 0) {
            UIView.animate(withDuration: Constants.animationTimeInterval) {
                (0..<self.pagesNumber).forEach {
                    if $0 == page {
                        self.containerStackView.arrangedSubviews[page].snp.remakeConstraints {
                            $0.width.equalTo(Constants.currentIndicatorLength)
                            $0.height.equalTo(Constants.indicatorWidth)
                        }
                    } else {
                        self.containerStackView.arrangedSubviews[self.currentPageIndex].snp.remakeConstraints {
                            $0.width.equalTo(Constants.indicatorLength)
                            $0.height.equalTo(Constants.indicatorWidth)
                        }
                    }
                }
                
                self.layoutIfNeeded()
            } completion: { _ in
                self.containerStackView
                    .arrangedSubviews[self.currentPageIndex]
                    .backgroundColor = .inactiveGrey
                
                self.containerStackView.arrangedSubviews[page].backgroundColor = .activeBlue
                
                self.currentPageIndex = page
            }
        }
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func prepare() {
        self.prepareContainer()
        
        (0..<self.pagesNumber).forEach {
            if $0 == 0 {
                self.containerStackView.addArrangedSubview(self.currentIndicator())
            } else {
                self.containerStackView.addArrangedSubview(self.indicator())
            }
        }
    }
    
    private func prepareContainer() {
        self.containerStackView.axis = .horizontal
        self.containerStackView.alignment = .center
        self.containerStackView.distribution = .equalSpacing
        
        self.addSubview(self.containerStackView)
        
        let length = CGFloat(self.pagesNumber - 1)
        * (Constants.indicatorLength + Constants.indicatorSpacing)
        + Constants.currentIndicatorLength
        
        self.containerStackView.snp.makeConstraints {
            $0.width.equalTo(length)
            $0.height.equalTo(Constants.indicatorWidth)
            $0.center.equalToSuperview()
        }
    }
    
    private func currentIndicator() -> UIView {
        let view = UIView()
        view.backgroundColor = .activeBlue
        view.layer.cornerRadius = Constants.cornerRadius
        
        view.snp.makeConstraints {
            $0.width.equalTo(Constants.currentIndicatorLength)
            $0.height.equalTo(Constants.indicatorWidth)
        }
        
        return view
    }
    
    private func indicator() -> UIView {
        let view = UIView()
        view.backgroundColor = .inactiveGrey
        view.layer.cornerRadius = Constants.cornerRadius
        
        view.snp.makeConstraints {
            $0.width.equalTo(Constants.indicatorLength)
            $0.height.equalTo(Constants.indicatorWidth)
        }
        
        return view
    }
}
