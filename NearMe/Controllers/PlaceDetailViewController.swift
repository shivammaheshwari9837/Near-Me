//
//  PlaceDetailViewController.swift
//  NearMe
//
//  Created by Shivam Maheshwari on 28/06/23.
//

import Foundation
import UIKit

class PlaceDetailViewController: UIViewController {
    
    private let place: PlaceAnnotation
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20,
                                                                     leading: 20,
                                                                     bottom: 20,
                                                                     trailing: 20)
        return stackView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.alpha = 0.4
        return label
    }()
    
    private let contactStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()
    
    private let addressButton: UIButton = {
        let config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Directions", for: .normal)
        return button
    }()
    
    private let callButton: UIButton = {
        let config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Call", for: .normal)
        return button
    }()
    
    init(place: PlaceAnnotation) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PlaceDetailViewController {
    func commonInit() {
        setupUI()
        setupHierarchy()
        setupConstraints()
        setupBinding()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.systemBackground
        
        addressButton.addTarget(self, action: #selector(directionButtonTapped),
                                for: .touchUpInside)
        callButton.addTarget(self, action: #selector(callButtonTapped),
                             for: .touchUpInside)
    }
    
    func setupHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(contactStackView)
        
        contactStackView.addArrangedSubview(addressButton)
        contactStackView.addArrangedSubview(callButton)
    }
    
    func setupConstraints() {
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func setupBinding() {
        nameLabel.text = place.name
        addressLabel.text = place.address
    }
}

private extension PlaceDetailViewController {
    
    @objc func directionButtonTapped(_ sender: UIButton) {
        let coordinate = place.location.coordinate
        guard let url = URL(string: "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)") else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    @objc func callButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: "tel://\(place.phone.formatPhoneNumber)") else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}
