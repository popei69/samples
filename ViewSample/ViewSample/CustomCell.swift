//
//  CustomCell.swift
//  ViewSample
//
//  Created by Benoit PASQUIER on 18/08/2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var didTapAdd: (() -> Void)?
    var didTapRemove: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(tapRemoveButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setupViews() {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, spacer, addButton, removeButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            addButton.widthAnchor.constraint(equalToConstant: 120),
            removeButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    // MARK: - Actions
    @objc private func tapAddButton() {
        didTapAdd?()
    }
    
    @objc private func tapRemoveButton() {
        didTapRemove?()
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
