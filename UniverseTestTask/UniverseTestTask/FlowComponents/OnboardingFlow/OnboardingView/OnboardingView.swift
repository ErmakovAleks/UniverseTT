//
//  OnboardingViewController.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import UIKit
import StoreKit
import RxSwift
import RxCocoa
import SnapKit

fileprivate extension Constants {
    
    static let collectionTopInset: CGFloat = 100.0
    static let collectionBottomInset: CGFloat = 170.0
    static let collectionItemHorizontalInset: CGFloat = 30.0
    static let collectionSectionInset: CGFloat = 30.0
    static let minimumInteritemSpacing: CGFloat = 0.0
    static let minimumLineSpacing: CGFloat = 16.0
    
    static let buttonFontSize: CGFloat = 17.0
    static let buttonHeight: CGFloat = 56.0
    static let buttonHorizontalInset: CGFloat = 30.0
    static let buttonBottomInset: CGFloat = 86.0
    
    static let purcaseButtonHeight: CGFloat = 18.0
    static let purcahseButtonWidth: CGFloat = 135.0
    static let purchaseButtonFontSize: CGFloat = 14.0
    static let purchaseButtonTopInset: CGFloat = 57.0
    static let purchaseButtonLeadingInset: CGFloat = 16.0
    
    static let removeRestoreButtonSize: CGFloat = 24.0
    static let removeRestoreButtonTopInset: CGFloat = 54.0
    static let removeRestoreButtonTrailingInset: CGFloat = 16.0
    
    static let termsFontSize: CGFloat = 12.0
    static let termsHorizontalInset: CGFloat = 36.0
    static let termsBottomInset: CGFloat = 34.0
    
    static let pageControlTopOffset: CGFloat = 32.0
    static let pageControlHeight: CGFloat = 4.0
    
    static let animationTimeInterval: Double = 1.0
}

final class OnboardingView: BaseView<OnboardingViewModel, OnboardingViewModelOutputEvents> {
    
    // MARK: -
    // MARK: Variables
    
    private var collectionView: UICollectionView?
    private let restorePurchaseButton = UIButton()
    private let removeRestoreButton = UIButton()
    private let continueButton = UIButton()
    private let subscribeButton = UIButton()
    private let pageControl = OnboardingPageControl(pagesNumber: OnboardingCellModel.data.count)
    private let termsLabel = UILabel()
    private let numberOfCards = OnboardingCellModel.data.count
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareBackground()
    }
    
    // MARK: -
    // MARK: Overrided functions
    
    override func setup() {
        super.setup()
        
        self.collectionSetup()
        self.restorePurchaseButtonSetup()
        self.removeRestoreButtonSetup()
        self.continueButtonSetup()
        self.subscribeButtonSetup()
        self.pageControlSetup()
        self.termsLabelSetup()
    }
    
    override func style() {
        super.style()
        
        self.collectionStyle()
        self.restorePurchaseButtonStyle()
        self.removeRestoreButtonStyle()
        self.continueButtonStyle()
        self.subscribeButtonStyle()
        self.termsLabelStyle()
    }
    
    override func layout() {
        super.layout()
        
        self.restorePurchaseButtonLayout()
        self.removeRestoreButtonLayout()
        self.continueButtonLayout()
        self.subscribeButtonLayout()
        self.collectionLayout()
        self.pageControlLayout()
        self.termsLabelLayout()
    }
    
    // MARK: -
    // MARK: Prepare Bindings
    
    override func prepareBindings(disposeBag: DisposeBag) {
        self.continueButton.rx.tap.bind { [weak self] in
            self?.scrollToNextItem()
        }
        .disposed(by: disposeBag)
        
        self.removeRestoreButton.rx.tap.bind { [weak self] in
            self?.removeRestore()
        }
        .disposed(by: disposeBag)
        
        self.subscribeButton.rx.tap.bind { [weak self] in
            self?.productRequest()
        }
        .disposed(by: disposeBag)
        
        self.restorePurchaseButton.rx.tap.bind { [weak self] in
            self?.restoreRequest()
        }
        .disposed(by: disposeBag)
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
    
    private func handle(page: Int) {
        self.pageControl.flipPage(to: page)
        
        if page != 0 && page < (self.numberOfCards - 1) {
            self.continueButton.isHidden = false
            
            UIView.animate(withDuration: Constants.animationTimeInterval) {
                self.termsLabel.alpha = 0.0
                self.pageControl.alpha = 1.0
                
                self.continueButton.alpha = 1.0
                self.subscribeButton.alpha = 0.0
                self.restorePurchaseButton.alpha = 0.0
                self.removeRestoreButton.alpha = 0.0
            } completion: { _ in
                self.termsLabel.isHidden = true
                self.pageControl.isHidden = false
                self.subscribeButton.isHidden = true
                self.restorePurchaseButton.isHidden = true
                self.removeRestoreButton.isHidden = true
            }
        } else {
            if page >= (self.numberOfCards - 1) {
                self.subscribeButton.isHidden = false
                self.restorePurchaseButton.isHidden = false
                self.removeRestoreButton.isHidden = false
                self.subscribeButton.alpha = 0.0
                self.restorePurchaseButton.alpha = 0.0
                self.removeRestoreButton.alpha = 0.0
            }
            
            UIView.animate(withDuration: Constants.animationTimeInterval) {
                self.termsLabel.alpha = 1.0
                self.pageControl.alpha = 0.0
                
                if page >= (self.numberOfCards - 1) {
                    self.continueButton.alpha = 0.0
                    self.subscribeButton.alpha = 1.0
                    self.restorePurchaseButton.alpha = 1.0
                    self.removeRestoreButton.alpha = 1.0
                }
            } completion: { _ in
                self.termsLabel.isHidden = false
                self.pageControl.isHidden = true
                
                if page >= (self.numberOfCards - 1) {
                    self.continueButton.isHidden = true
                }
            }
        }
    }
    
    private func removeRestore() {
        UIView.animate(withDuration: Constants.animationTimeInterval) {
            self.restorePurchaseButton.alpha = 0.0
            self.removeRestoreButton.alpha = 0.0
        } completion: { _ in
            self.restorePurchaseButton.isHidden = true
            self.removeRestoreButton.isHidden = true
        }
    }
    
    private func scrollToNextItem() {
        if let index = self.collectionView?.indexPathsForVisibleItems.sorted().last?.row {
            if index < self.collectionView?.numberOfItems(inSection: 0) ?? 0 {
                self.handle(page: index)
                self.collectionView?.scrollToItem(
                    at: IndexPath(row: index, section: 0),
                    at: .centeredHorizontally,
                    animated: true
                )
            }
        }
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
            self?.handle(page: index)
        }

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView?.decelerationRate = .fast
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
    // MARK: Prepare Buttons
    
    private func restorePurchaseButtonSetup() {
        self.view.addSubview(self.restorePurchaseButton)
        self.restorePurchaseButton.isHidden = true
    }
    
    private func removeRestoreButtonSetup() {
        self.view.addSubview(self.removeRestoreButton)
        self.removeRestoreButton.isHidden = true
    }
    
    private func continueButtonSetup() {
        self.view.addSubview(self.continueButton)
    }
    
    private func subscribeButtonSetup() {
        self.view.addSubview(self.subscribeButton)
        self.subscribeButton.isHidden = true
    }
    
    private func restorePurchaseButtonStyle() {
        self.restorePurchaseButton.setTitle("Restore Purchase", for: .normal)
        self.restorePurchaseButton.setTitleColor(.inactiveGrey, for: .normal)
        self.restorePurchaseButton.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.purchaseButtonFontSize,
            weight: .semibold
        )
        
        self.restorePurchaseButton.backgroundColor = .clear
    }
    
    private func removeRestoreButtonStyle() {
        self.removeRestoreButton.setImage(UIImage(named: "cancel"), for: .normal)
    }
    
    private func continueButtonStyle() {
        self.buttonStyle(button: self.continueButton, title: "Continue")
    }
    
    private func subscribeButtonStyle() {
        self.buttonStyle(button: self.subscribeButton, title: "Try Free & Subscribe")
    }
    
    private func buttonStyle(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkSpace, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.buttonFontSize,
            weight: .semibold
        )
        
        button.backgroundColor = .white
        button.layer.cornerRadius = Constants.buttonHeight / 2
    }
    
    private func restorePurchaseButtonLayout() {
        self.restorePurchaseButton.snp.makeConstraints{
            $0.width.equalTo(Constants.purcahseButtonWidth)
            $0.height.equalTo(Constants.purcaseButtonHeight)
            $0.top.equalToSuperview().inset(Constants.purchaseButtonTopInset)
            $0.leading.equalToSuperview().inset(Constants.purchaseButtonLeadingInset)
        }
    }
    
    private func removeRestoreButtonLayout() {
        self.removeRestoreButton.snp.makeConstraints {
            $0.size.equalTo(Constants.removeRestoreButtonSize)
            $0.top.equalToSuperview().inset(Constants.removeRestoreButtonTopInset)
            $0.trailing.equalToSuperview().inset(Constants.removeRestoreButtonTrailingInset)
        }
    }
    
    private func continueButtonLayout() {
        self.buttonLayout(button: self.continueButton)
    }
    
    private func subscribeButtonLayout() {
        self.buttonLayout(button: self.subscribeButton)
    }
    
    private func buttonLayout(button: UIButton) {
        button.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.buttonHorizontalInset)
            $0.bottom.equalToSuperview().inset(Constants.buttonBottomInset)
            $0.height.equalTo(Constants.buttonHeight)
        }
    }
    
    // MARK: -
    // MARK: Prepare PageControl
    
    private func pageControlSetup() {
        self.view.addSubview(self.pageControl)
        self.pageControl.alpha = 0.0
    }
    
    private func pageControlLayout() {
        self.pageControl.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constants.pageControlHeight)
            $0.top.equalTo(self.continueButton.snp.bottom).offset(Constants.pageControlTopOffset)
        }
    }
    
    // MARK: -
    // MARK: Prepare TermsLabel
    
    private func termsLabelSetup() {
        let termsOfUse = NSAttributedString(
            string: "Terms of Use",
            attributes: [ .foregroundColor : UIColor.link ]
        )
        
        let privacyPolicy = NSAttributedString(
            string: "Privacy Policy",
            attributes: [ .foregroundColor : UIColor.link ]
        )
        
        let subscriptionTerms = NSAttributedString(
            string: "Subscription Terms",
            attributes: [ .foregroundColor : UIColor.link ]
        )
        
        let final = NSMutableAttributedString(string: "By continuing you accept our:\n")
        final.append(termsOfUse)
        final.append(NSAttributedString(string: ", "))
        final.append(privacyPolicy)
        final.append(NSAttributedString(string: " and "))
        final.append(subscriptionTerms)
        
        self.termsLabel.isUserInteractionEnabled = true
        self.termsLabel.textColor = .white
        self.termsLabel.attributedText = final
        self.addGestureRecognizerToTermsLabel()
        
        self.view.addSubview(self.termsLabel)
    }
    
    private func termsLabelStyle() {
        self.termsLabel.font = UIFont.systemFont(ofSize: Constants.termsFontSize)
        self.termsLabel.textAlignment = .center
        self.termsLabel.numberOfLines = 0
    }
    
    private func termsLabelLayout() {
        self.termsLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.termsHorizontalInset)
            $0.bottom.equalToSuperview().inset(Constants.termsBottomInset)
        }
    }
    
    private func addGestureRecognizerToTermsLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTermsTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.termsLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTermsTap(_ gesture: UITapGestureRecognizer) {
        guard let text = self.termsLabel.text else { return }
        
        let termsOfUseRange = (text as NSString).range(of: "Terms of Use")
        let privacyPolicyRange = (text as NSString).range(of: "Privacy Policy")
        let subscriptionTermsRange = (text as NSString).range(of: "Subscription Terms")
        
        if gesture.didTapAttributedTextInLabel(
            label: self.termsLabel,
            inRange: termsOfUseRange
        ) {
            self.viewModel.handleTermsOfUse()
        } else if gesture.didTapAttributedTextInLabel(
            label: self.termsLabel,
            inRange: privacyPolicyRange
        ) {
            self.viewModel.handlePrivacyPolicy()
        } else if gesture.didTapAttributedTextInLabel(
            label: self.termsLabel,
            inRange: subscriptionTermsRange
        ) {
            self.viewModel.handleSubscriptionTerms()
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

extension OnboardingView: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            self.purchase(product: product)
        } else {
            self.showAlert(
                title: "The product is not available",
                description: "Unfortunately, the selected product is not available at the moment"
            )
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchasing:
                print("<!> Customer is in the process of purchase")
            case .purchased:
                SKPaymentQueue.default().finishTransaction($0)
                self.showAlert(title: "Congratulaitons!", description: "You are Premium-user now!")
            case .failed:
                SKPaymentQueue.default().finishTransaction($0)
                self.showAlert(title: "Oh, no!", description: "Something went wrong :-(")
            case .restored:
                self.showAlert(title: "Welcome back!", description: "Subscription is restored!")
            case .deferred:
                self.showAlert(title: "Attention!", description: "Your purchase was deferred!")
            @unknown default:
                break
            }
        }
    }
    
    private func productRequest() {
        if SKPaymentQueue.canMakePayments() {
            let productRequest = SKProductsRequest(productIdentifiers: ["com.ermakov.monthly"])
            productRequest.delegate = self
            productRequest.start()
        }
    }
    
    private func restoreRequest() {
        if SKPaymentQueue.canMakePayments() {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    private func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
    
    private func showAlert(title: String, description: String) {
        self.viewModel.handleAlert(title: title, description: description)
    }
}
