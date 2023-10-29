//
//  OnboardingCollectionViewCell.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 28.10.2023.
	

import UIKit
import SnapKit

fileprivate extension Constants {
    
    static let cornerRadius: CGFloat = 20.0
    static let containerHorizontalInset: CGFloat = 24.0
    static let imageViewTopInset: CGFloat = 49.0
    static let titleLabelTopOffset: CGFloat = 24.0
    static let descriptionLabelTopOffset: CGFloat = 16.0
    
    static let titleFont: CGFloat = 26.0
    static let descriptionFont: CGFloat = 17.0
}

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Variables
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .nebula
        view.layer.cornerRadius = Constants.cornerRadius
        
        return view
    }()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: -
    // MARK: CollectionViewCell Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.prepareContainerView()
        self.prepareImageView()
        self.prepareTitleLabel()
        self.prepareDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Internal functions
    
    func configure(with model: OnboardingCellModel) {
        self.imageView.image = UIImage(named: model.imageName)
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func prepareContainerView() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(self.containerView)
        self.containerView.frame = self.contentView.bounds
    }
    
    private func prepareImageView() {
        self.imageView.contentMode = .scaleAspectFit
        
        self.containerView.addSubview(self.imageView)
        
        self.imageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.containerHorizontalInset)
            $0.top.equalToSuperview().inset(Constants.imageViewTopInset)
        }
    }
    
    private func prepareTitleLabel() {
        self.titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFont, weight: .bold)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .white
        
        self.containerView.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.containerHorizontalInset)
            $0.top.equalTo(self.imageView.snp.bottom).offset(Constants.titleLabelTopOffset)
        }
    }
    
    private func prepareDescriptionLabel() {
        self.descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFont, weight: .medium)
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.textColor = .white
        
        self.containerView.addSubview(self.descriptionLabel)
        
        self.descriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.containerHorizontalInset)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Constants.descriptionLabelTopOffset)
        }
    }
}
