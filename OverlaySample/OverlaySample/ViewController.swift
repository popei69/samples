//
//  ViewController.swift
//  OverlaySample
//
//  Created by Benoit Pasquier on 8/1/21.
//

import UIKit

class ViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label
        label.text = "Hello and welcome!"
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.text = "Here is different options to start your journey"
        return label
    }()

    lazy var redbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Red Pill", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 6
        return button
    }()

    lazy var blueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Blue Pill", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonStackView = UIStackView(arrangedSubviews: [redbutton, blueButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            buttonStackView
        ])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showFirstOverlay()
    }

    func showSecondOverlay() {
        let overlayView = OverlayView(title: "You take the red pill, you stay in Wonderland and I show you how deep the rabbit hole goes.", anchorView: redbutton)
        
        overlayView.frame = view.frame
        view.addSubview(overlayView)
        overlayView.showOverlay()
        overlayView.onTap = { [weak overlayView] in
            overlayView?.hideOverlay { _ in
                overlayView?.removeFromSuperview()
            }
        }
    }

    func showFirstOverlay() {
        let overlayView = OverlayView(title: "This is your last chance. After this there is no turning back. You take the blue pill, the story ends; you wake up in your bed and believe whatever you want to believe.", anchorView: blueButton)
        overlayView.frame = view.frame
        view.addSubview(overlayView)
        overlayView.showOverlay()
        overlayView.onTap = { [weak self, weak overlayView] in
            overlayView?.hideOverlay { _ in
                overlayView?.removeFromSuperview()
                self?.showSecondOverlay()
            }
        }
    }
}
