//
//  LoginView.swift
//  Jahez
//
//  Created by iOS Developer on 13/03/2022.
//

import UIKit

class LoginView: UIView {

    var closure: (()->())? = nil
    
    enum TypeAction {
        case Login
        case Register
        case ForgetPassword
    }
    
    var type: TypeAction = .Login
    
    var viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = Colors.background
        label.text = "Login to Jahez"
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var stackViewFields: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        return stackView
    }()

    
    var labelCodePhone: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Colors.background
        label.text = "+966"
        label.textAlignment = .center
        return label
    }()
    
    var viewContainerTextFieldPhone: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var textFieldNumberPhone : UITextField = {
        let textField = UITextField()
        textField.tintColor = .lightGray
        textField.keyboardType = .phonePad
        textField.sizeToFit()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var viewContainerTextFieldPassword: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textFieldPassword : UITextField = {
        let textField = UITextField()
        textField.placeholder = "You Password"
        textField.tintColor = .lightGray
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.sizeToFit()
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    var viewContainerTextFieldUserName: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textFieldUserName : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your name"
        textField.tintColor = .lightGray
        textField.textAlignment = .center
        textField.sizeToFit()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    
    var buttonLogin: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonLoginAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var buttonNew: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitleColor(Colors.background, for: .normal)
        button.setTitle("New? Register now!", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(buttonNewRegisterAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var buttonForgetPassword: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.background, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitle("Forget Password?", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(buttonForgetPasswordAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var viewCenterNewAndForget: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewBottomNewAndForget: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var buttonCancel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("X", for: .normal)
        button.setTitleColor(Colors.background, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(buttonCancelAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    @objc func buttonLoginAction() {
        if let closure = closure {
            self.animateOut()
            closure()
        }
    }
    
    var hideRegister: Bool = true
    @objc func buttonNewRegisterAction() {
        hideRegister = !hideRegister
        UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: [],
                           animations: {
            if self.hideRegister {
                self.viewContainerTextFieldUserName.alpha = 0
                self.labelTitle.text = "Login To Jahez"
                self.textFieldPassword.placeholder = "Your Password"
                self.buttonLogin.setTitle("Login", for: .normal)
                self.buttonForgetPassword.setTitle("Forget Password?", for: .normal)
                self.buttonNew.setTitle("New? Register now!", for: .normal)
            } else {
                self.viewContainerTextFieldPassword.alpha = 1
                self.viewContainerTextFieldUserName.alpha = 1
                self.textFieldPassword.placeholder = "New Password"
                self.labelTitle.text = "Registeration"
                self.buttonLogin.setTitle("Register", for: .normal)
                self.buttonNew.setTitle("Back To Login", for: .normal)
                self.buttonForgetPassword.setTitle("Forget Password?", for: .normal)
            }
            self.viewContainerTextFieldPassword.isHidden = false
            self.viewContainerTextFieldUserName.isHidden = self.hideRegister
            self.stackViewFields.layoutIfNeeded()
        }, completion: nil)
    }
    
    var hideForgetPassword: Bool = false
    @objc func buttonForgetPasswordAction() {
        hideForgetPassword = !hideForgetPassword
        UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: [],
                           animations: {
            if self.hideForgetPassword {
                self.viewContainerTextFieldPassword.alpha = 0
                self.labelTitle.text = "Reset Password"
                self.buttonLogin.setTitle("Reset", for: .normal)
                self.buttonForgetPassword.setTitle("Back To Login", for: .normal)
            } else {
                self.viewContainerTextFieldPassword.alpha = 1
                self.viewContainerTextFieldUserName.alpha = 0
                self.labelTitle.text = "Login To Jahez"
                self.buttonLogin.setTitle("Login", for: .normal)
                self.buttonForgetPassword.setTitle("Forget Password?", for: .normal)
            }
            self.viewContainerTextFieldPassword.isHidden = self.hideForgetPassword
            self.viewContainerTextFieldUserName.isHidden = true
            self.stackViewFields.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func buttonCancelAction() {
        if buttonCancel.backgroundColor == .clear {
            buttonCancel.backgroundColor = Colors.background
        } else {
            buttonCancel.backgroundColor = .clear
        }
        
        self.animateOut()
    }
    
}

//MARK: - Setup View:
extension LoginView {
    func setupView() {
        self.backgroundColor = .white.withAlphaComponent(0.2)
        self.frame = UIScreen.main.bounds
     
        self.addSubview(self.viewContainer)
        self.viewContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        self.viewContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40).isActive = true
        self.viewContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 120).isActive = true
        self.viewContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        self.viewContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        
        self.viewContainer.addSubview(self.labelTitle)
        self.labelTitle.topAnchor.constraint(equalTo: self.viewContainer.topAnchor, constant: 20).isActive = true
        self.labelTitle.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor).isActive = true
        
        self.viewContainerTextFieldPhone.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.viewContainerTextFieldPassword.heightAnchor.constraint(equalToConstant: 40).isActive = true
     
        
        self.viewContainerTextFieldPhone.addSubview(self.labelCodePhone)
        self.labelCodePhone.leadingAnchor.constraint(equalTo: self.viewContainerTextFieldPhone.leadingAnchor, constant: 20).isActive = true
        self.labelCodePhone.centerYAnchor.constraint(equalTo: self.viewContainerTextFieldPhone.centerYAnchor).isActive = true
        
        self.viewContainerTextFieldPhone.addSubview(self.textFieldNumberPhone)
        self.textFieldNumberPhone.leadingAnchor.constraint(equalTo: self.labelCodePhone.trailingAnchor, constant: 3).isActive = true
        self.textFieldNumberPhone.trailingAnchor.constraint(equalTo: self.viewContainerTextFieldPhone.trailingAnchor, constant: -23).isActive = true
        self.textFieldNumberPhone.centerYAnchor.constraint(equalTo: self.viewContainerTextFieldPhone.centerYAnchor).isActive = true
        self.textFieldNumberPhone.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.viewContainerTextFieldPassword.addSubview(self.textFieldPassword)
        self.textFieldPassword.leadingAnchor.constraint(equalTo: self.viewContainerTextFieldPassword.leadingAnchor, constant: 23).isActive = true
        self.textFieldPassword.trailingAnchor.constraint(equalTo: self.viewContainerTextFieldPassword.trailingAnchor, constant: -23).isActive = true
        self.textFieldPassword.centerYAnchor.constraint(equalTo: self.viewContainerTextFieldPassword.centerYAnchor).isActive = true

        self.viewContainerTextFieldUserName.addSubview(self.textFieldUserName)
        self.textFieldUserName.leadingAnchor.constraint(equalTo: self.viewContainerTextFieldUserName.leadingAnchor, constant: 23).isActive = true
        self.textFieldUserName.trailingAnchor.constraint(equalTo: self.viewContainerTextFieldUserName.trailingAnchor, constant: -23).isActive = true
        self.textFieldUserName.centerYAnchor.constraint(equalTo: self.viewContainerTextFieldUserName.centerYAnchor).isActive = true

        self.stackViewFields.insertArrangedSubview(self.viewContainerTextFieldUserName, at: 0)
        self.stackViewFields.insertArrangedSubview(self.viewContainerTextFieldPassword, at: 0)
        self.stackViewFields.insertArrangedSubview(self.viewContainerTextFieldPhone, at: 0)
        self.viewContainer.addSubview(self.stackViewFields)

        self.viewContainerTextFieldUserName.alpha = 0
        self.viewContainerTextFieldUserName.isHidden = true
        self.stackViewFields.layoutIfNeeded()
        
        self.stackViewFields.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor, constant: 20).isActive = true
        self.stackViewFields.trailingAnchor.constraint(equalTo: self.viewContainer.trailingAnchor, constant: -50).isActive = true
        self.stackViewFields.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor, constant: 50).isActive = true
//        self.stackViewFields.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor).isActive = true
        self.stackViewFields.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
     
        
        self.viewContainer.addSubview(self.buttonLogin)
        self.buttonLogin.topAnchor.constraint(equalTo: self.stackViewFields.bottomAnchor, constant: 10).isActive = true
        self.buttonLogin.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.buttonLogin.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor).isActive = true
        
        
        self.viewContainer.addSubview(self.buttonCancel)
        self.buttonCancel.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor).isActive = true
        self.buttonCancel.trailingAnchor.constraint(equalTo: self.viewContainer.trailingAnchor).isActive = true
        self.buttonCancel.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor).isActive = true
        self.buttonCancel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        self.viewContainer.addSubview(self.viewBottomNewAndForget)
        
        self.viewBottomNewAndForget.bottomAnchor.constraint(equalTo: self.buttonCancel.topAnchor).isActive = true
        self.viewBottomNewAndForget.trailingAnchor.constraint(equalTo: self.viewContainer.trailingAnchor).isActive = true
        self.viewBottomNewAndForget.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor).isActive = true
        self.viewBottomNewAndForget.heightAnchor.constraint(equalToConstant: 1).isActive = true

        self.viewContainer.addSubview(self.buttonNew)
        self.buttonNew.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor, constant: 30).isActive = true
        self.buttonNew.bottomAnchor.constraint(equalTo: self.viewBottomNewAndForget.topAnchor, constant: -10).isActive = true
        self.buttonNew.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        self.viewContainer.addSubview(self.viewCenterNewAndForget)
        self.viewCenterNewAndForget.leadingAnchor.constraint(equalTo: self.buttonNew.trailingAnchor, constant: 10).isActive = true
        self.viewCenterNewAndForget.widthAnchor.constraint(equalToConstant: 3).isActive = true
        self.viewCenterNewAndForget.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.viewCenterNewAndForget.bottomAnchor.constraint(equalTo: self.viewBottomNewAndForget.topAnchor, constant: -15).isActive = true
        
        self.viewContainer.addSubview(self.buttonForgetPassword)
        self.buttonForgetPassword.leadingAnchor.constraint(equalTo: self.viewCenterNewAndForget.trailingAnchor, constant: 10).isActive = true
        self.buttonForgetPassword.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.buttonForgetPassword.bottomAnchor.constraint(equalTo: self.viewBottomNewAndForget.topAnchor, constant: -10).isActive = true
        
        self.animateIn()
        
    }
}

//MARK: - Animations:
extension LoginView {
    func animateIn() {
        self.viewContainer.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.viewContainer.transform = .identity
            self.alpha = 1
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.viewContainer.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 9
        }) { complete in
            if complete {
//                self.removeFromSuperview()
                if let closure = self.closure {
                    closure()
                }
            }
        }

    }
}
