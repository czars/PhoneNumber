//
//  CreatePhoneNumberViewController.swift
//  iOSTeamHomework
//
//  Created by Paul.Chou on 2019/5/14.
//  Copyright © 2019 gogolook. All rights reserved.
//

import UIKit

class CreatePhoneNumberViewController: UIViewController {

    // UI properties
    lazy var zoneCode = { () -> UITextField in
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "zone"
        textField.borderStyle = .roundedRect
        textField.tag = 0
        return textField
    }()

    lazy var number = { () -> UITextField in
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "number"
        textField.borderStyle = .roundedRect
        textField.tag = 1
        return textField
    }()

    lazy var saveButton = { () -> UIButton in
        let button = UIButton.init(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add new number", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.green.cgColor
        button.addTarget(self, action: #selector(self.addNewNumberAction(_:)), for: .touchUpInside)
        return button
    }()

    lazy var closeButton = { () -> UIButton in
        let button = UIButton.init(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("close", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
        return button
    }()

    lazy var warning = { () -> UILabel in
        let warning = UILabel()
        warning.translatesAutoresizingMaskIntoConstraints = false
        warning.textColor = .red
        warning.isHidden = true
        return warning
    }()

    //UIView Life cycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("didn't implemented init with code")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        print("create phone number")
    }

    override func viewDidLoad() {
        print("view did load in \(String(describing: CreatePhoneNumberViewController.self))")
        zoneCode.delegate = self
        number.delegate = self
        view.addSubview(zoneCode)
        view.addSubview(number)
        view.addSubview(saveButton)
        view.addSubview(warning)
        view.addSubview(closeButton)
        view.backgroundColor = .white
        setupEditComponentsConstraints()
        setupCloseButtonConstraints()
    }

    func setupEditComponentsConstraints() {
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-160-[zone]-10-[warning]-20-[save]", options: [.alignAllLeading], metrics: nil, views: ["zone": zoneCode, "warning": warning, "save": saveButton]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-70-[zone(80)]-10-[number]-64-|", options: [.alignAllCenterY], metrics: nil, views: ["zone": zoneCode, "number": number]))
        zoneCode.heightAnchor.constraint(equalToConstant: 44).isActive = true
        number.heightAnchor.constraint(equalToConstant: 44).isActive = true
        warning.heightAnchor.constraint(equalToConstant: 20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        warning.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64).isActive = true
    }

    func setupCloseButtonConstraints() {
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        let topMargin = view.safeAreaInsets.top
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 52 + topMargin).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40)
        closeButton.widthAnchor.constraint(equalToConstant: 40)
    }

    @objc func dismissView() {
        dismiss(animated: true) {
            print("dismissed \(String(describing: CreatePhoneNumberViewController.self))")
        }
    }
}

extension CreatePhoneNumberViewController: UITextFieldDelegate {

}

extension CreatePhoneNumberViewController {
    @objc func addNewNumberAction(_ sender:UIButton) {
        //check duplicated by phonenumber manager
        //then add new number
        let d = NumberData(code: Int(arc4random() % 9 + 1), number: Int(arc4random() % 90000000 + 10000000))
        PhoneNumberManager.sharedInstance.add(d)
        warning.isHidden = false
        warning.text = "created new number"
    }
}
