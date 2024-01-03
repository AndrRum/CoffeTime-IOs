import UIKit

protocol ProductViewDelegate: AnyObject {

}

class ProductView: UIView {
    
    var product: ProductModel? {
        didSet {
            updateUI()
        }
    }
    
    private var isHeartFilled: Bool = false {
        didSet {
            let imageName = isHeartFilled ? "heart.fill" : "heart"
            let imageColor = isHeartFilled ? Colors.red : Colors.gray
            let image = UIImage(systemName: imageName)
            heartButton.setImage(image, for: .normal)
            heartButton.tintColor = imageColor
        }
    }
    
    private(set) var pageHeader = PageHeaderView()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.opacity = 0.6
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Заказать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.buttonGreen
        button.layer.cornerRadius = 0
        return button
    }()
    
    private let cashImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Cash"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "heart")
        button.setImage(image, for: .normal)
        button.tintColor = Colors.gray
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ProductViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderViewDelegate(_ delegate: PageHeaderViewDelegate?) {
        pageHeader.delegate = delegate
    }
    
    
    private func updateUI() {
        loadImage(imageUrl: product?.imagesPath)
        priceLabel.text = "\(String(describing: product?.price ?? 0))"
    }
}

extension ProductView {
    func configureUI() {
        backgroundColor = .white
        
        setupHeaderView()
        setupMainImage()
        setupPriceLabel()
        setupCashImageView()
        setupOrderButton()
        setupHeartButton()
    }
    
    func setupHeaderView() {
        addSubview(pageHeader)
        pageHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageHeader.topAnchor.constraint(equalTo: topAnchor),
            pageHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageHeader.bottomAnchor.constraint(equalTo: pageHeader.bottomAnchor)
        ])
        
        pageHeader.configureUI(showBackButton: true)
    }
    
    func setupMainImage() {
        addSubview(productImageView)
        productImageView.contentMode = .scaleAspectFit
        productImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: pageHeader.bottomAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45)
        ])
    }

    func setupPriceLabel() {
        addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    func setupCashImageView() {
        addSubview(cashImageView)
        cashImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cashImageView.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            cashImageView.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            cashImageView.widthAnchor.constraint(equalToConstant: 24),
            cashImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupOrderButton() {
        addSubview(orderButton)
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            orderButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            orderButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            orderButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupHeartButton() {
        addSubview(heartButton)
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heartButton.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor),
            heartButton.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            heartButton.widthAnchor.constraint(equalToConstant: 100),
            heartButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

private extension ProductView {
    func loadImage(imageUrl: String?) {
        guard let imageUrlString = imageUrl else {
            return
        }
        
        if imageUrlString.lowercased().contains("http"), let imageUrl = URL(string: imageUrlString) {
            LoadImageManager.loadImage(from: imageUrl) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.productImageView.image = image
                    }
                case .failure(let error):
                    print("Error loading image: \(error)")
                    DispatchQueue.main.async {
                        self.productImageView.image = UIImage(named: "DefaultImage")
                    }
                }
            }
        } else {
            self.productImageView.image = UIImage(named: imageUrlString)
        }
    }
    
    @objc func heartButtonTapped() {
        isHeartFilled.toggle()
        animateHeartButton()
    }

    func animateHeartButton() {
        UIView.animate(withDuration: 0.2, animations: {
            self.heartButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.heartButton.transform = .identity
            }
        }
    }
}
