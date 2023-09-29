//
//  ImageSliderView.swift
//  BookingTask
//
//  Created by Sergei on 17.09.2023.
//

import UIKit

class ImageSliderView: UIView {
    
    public var imageUrls: [String]? {
        didSet {
            guard let imageUrls else { return }
            
            if let view = views.removeLast() {
                stackView.removeArrangedSubview(view)
            }
            for imageUrl in imageUrls {
                views.append(makeImageView(imageUrl))
            }
            pageControl.numberOfPages = views.count
            setupViewsConstrains()
        }
    }
    
    private var views: [UIView?] = []
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        
        return view
    }()
    
    private var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        view.spacing = 20
        
        return view
    }()
    
    var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.currentPageIndicatorTintColor = .black
        control.backgroundStyle = .prominent
        control.layer.cornerRadius = 5
        
        return control
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 16
        
        setup()
        views.append(UIImageView(image: UIImage(named: "placeholder")))
        setupViewsConstrains()
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        scrollView.delegate = self
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        addSubview(pageControl)
        pageControl.numberOfPages = views.count
        pageControl.addTarget(self, action: #selector(pageControlTapped(sender:)), for: .valueChanged)
        
    }
    
    private func makeImageView(_ imageUrl: String) -> UIImageView? {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        if let url = URL(string: imageUrl) {
            ImageLoader.shared.downloadImage(url) { result in
                switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            imageView.image = UIImage(data: data)
                        }
                    case .failure:
                        break
                }
            }
        }

        return imageView
    }
    
    private func setupViewsConstrains() {
        views.forEach { (view) in
            guard let view else { return }
            if !stackView.arrangedSubviews.contains(view) {
                view.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(view)

                view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
                view.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor).isActive = true
            }
        }
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        let pageWidth = scrollView.bounds.width
        let offset = sender.currentPage * Int(pageWidth)
        UIView.animate(withDuration: 0.33, animations: { [weak self] in
            self?.scrollView.contentOffset.x = CGFloat(offset)
        })
    }
    
    private func addConstraints() {
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -padding),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}

extension ImageSliderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x/pageWidth
        
        pageControl.currentPage = Int((round(pageFraction)))
    }
}
