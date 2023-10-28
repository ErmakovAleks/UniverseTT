//
//  OnboardingViewController.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import UIKit
import SnapKit

fileprivate extension Constants {
    
    static let collectionTopInset: CGFloat = 100.0
    static let collectionBottomInset: CGFloat = 170.0
    static let collectionItemHorizontalInset: CGFloat = 30.0
    static let collectionSectionInset: CGFloat = 30.0
    static let minimumInteritemSpacing: CGFloat = 0.0
    static let minimumLineSpacing: CGFloat = 16.0
    
    static let continueButtonFontSize: CGFloat = 17.0
    static let continueButtonHeight: CGFloat = 56.0
    static let continueButtonHorizontalInset: CGFloat = 30.0
    static let continueButtonBottomInset: CGFloat = 86.0
}

class OnboardingView: BaseView<OnboardingViewModel, OnboardingViewModelOutputEvents> {
    
    // MARK: -
    // MARK: Variables
    
    private var collectionView: UICollectionView?
    private var continueButton = UIButton()
    private let numberOfCards = 4
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareBackground()
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func prepareBackground() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "Background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
    }
    
    // MARK: -
    // MARK: Overrided functions
    
    override func setup() {
        super.setup()
        
        self.collectionSetup()
        self.continueButtonSetup()
    }
    
    override func style() {
        super.style()
        
        self.collectionStyle()
        self.continueButtonStyle()
    }
    
    override func layout() {
        super.layout()
        
        self.continueButtonLayout()
        self.collectionLayout()
    }
    
    // MARK: -
    // MARK: Prepare Collection
    
    private func collectionSetup() {
        let layout = CenterSnapCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        layout.sectionInset = UIEdgeInsets(
            top: 0.0,
            left: Constants.collectionSectionInset,
            bottom: 0.0,
            right: Constants.collectionSectionInset
        )
        
        layout.itemSize = CGSize(
            width: self.view.bounds.width - 2 * Constants.collectionItemHorizontalInset,
            height: self.view.bounds.height
                - Constants.collectionTopInset
                - Constants.collectionBottomInset
        )
        
        layout.pageHandler = { [weak self] index in
            // Здесь нужно будет передать индекс в pageControl
            print("<!> card # \(index)")
        }

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView?.decelerationRate = .fast // ?? может и не понадобится
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: OnboardingCollectionViewCell.self))
        
        self.view.addSubview(self.collectionView ?? UICollectionView())
    }
    
    private func collectionStyle() {
        self.collectionView?.backgroundColor = .clear
        self.collectionView?.showsHorizontalScrollIndicator = false
    }
    
    private func collectionLayout() {
        self.collectionView?.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(Constants.collectionTopInset)
            $0.bottom.equalToSuperview().inset(Constants.collectionBottomInset)
        }
    }
    
    // MARK: -
    // MARK: Prepare ContinueButton
    
    private func continueButtonSetup() {
        self.view.addSubview(self.continueButton)
    }
    
    private func continueButtonStyle() {
        self.continueButton.setTitle("Continue", for: .normal)
        self.continueButton.setTitleColor(.darkSpace, for: .normal)
        self.continueButton.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.continueButtonFontSize,
            weight: .semibold
        )
        
        self.continueButton.backgroundColor = .white
        self.continueButton.layer.cornerRadius = Constants.continueButtonHeight / 2
    }
    
    private func continueButtonLayout() {
        self.continueButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.continueButtonHorizontalInset)
            $0.bottom.equalToSuperview().inset(Constants.continueButtonBottomInset)
            $0.height.equalTo(Constants.continueButtonHeight)
        }
    }
}

extension OnboardingView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: OnboardingCollectionViewCell.self),
            for: indexPath
        ) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: OnboardingCellModel.data[indexPath.item])
        
        return cell
    }
}
