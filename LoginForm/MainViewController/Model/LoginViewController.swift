//
//  MainViewController.swift
//  LoginForm
//
//  Created by Mikita Piatrushka on 31.10.22.
//

import UIKit

final class LoginViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    let presenter = LoginPresenter()

    //MARK: - State
    private var loginInputText:String = ""
    private var passInputText: String = ""
    private var secureUITextFieldTitle: String = ""
    private var secureUITextFieldNumbers: [Int] = []

    
    //MARK: - Views
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.text = "RSSchool"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        let field = UITextField()
        field.setTextField(delegate: self,
                           placeholder: "enter login",
                           borderStyle: UITextField.BorderStyle.roundedRect,
                           tintColor: CustomColors.blackCoralDefoltColor,
                           borderColor: CustomColors.blackColor.cgColor,
                           borderWidth: 1.0,
                           cornerRadius: 5.0,
                           isSecureTextEntry: false as NSSecureCoding,
                           autocapitalizationType: .none)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        return field
    }()
    
    private lazy var passTextField: UITextField = {
        let field = UITextField()
        field.setTextField(delegate: self,
                           placeholder: "enter pass",
                           borderStyle: UITextField.BorderStyle.roundedRect,
                           tintColor: CustomColors.blackCoralDefoltColor,
                           borderColor: CustomColors.blackColor.cgColor,
                           borderWidth: 1.0,
                           cornerRadius: 5.0,
                           isSecureTextEntry: true as NSSecureCoding,
                           autocapitalizationType: .none)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        return field
    }()
    
    private let authorizeButton: AuthorizationButton = {
        let button = AuthorizationButton()
        button.backgroundColor = UIColor.white
        button.configuration = .borderless()
        button.configuration?.title = "authorize"
        button.configuration?.image = UIImage(systemName: "person")
        button.configuration?.titlePadding = 1
        button.configuration?.imagePadding = 5
        button.configuration?.imagePlacement = .leading
        button.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        return button
    }()
    
    private var secureView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.setViewBorderAndColor(borderColor: CustomColors.turquoiseGreenColor.cgColor, borderWith: 2.0, borderCornerRadius: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var secureUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.isHidden = true
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private func createRoundButton(title: String) -> RoundedButton{
        let button = RoundedButton()
        button.setTitle(title, for: .normal)
        button.tag = Int(title) ?? 0
        return button
    }
    
    private lazy var firstSecureNum: RoundedButton = createRoundButton(title: "1")
    private lazy var secondSecureNum: RoundedButton = createRoundButton(title: "2")
    private lazy var thirdSecureNum: RoundedButton = createRoundButton(title: "3")
    
    //MARK: - viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        createViews()
        createConstraintsInit()
        
    }
    //MARK: -method
    private func createViews(){
        //label RSSchool
        view.addSubview(labelView)
        
        //textFields
        view.addSubview(loginTextField)
        view.addSubview(passTextField)
        
        //Authorize button
        authorizeButton.addTarget(self, action: #selector(authorizeButtonPress), for: .touchUpInside)
        view.addSubview(authorizeButton)
        
        view.addSubview(secureView)
        
        //MARK: check this
        secureUITextFieldTitle = secureUILabel.text ?? ""
        view.addSubview(secureUILabel)
        
        firstSecureNum.addTarget(self, action: #selector(addButtonTagToSecureUILabel), for: .touchUpInside)
        view.addSubview(firstSecureNum)
        secondSecureNum.addTarget(self, action: #selector(addButtonTagToSecureUILabel), for: .touchUpInside)
        view.addSubview(secondSecureNum)
        thirdSecureNum.addTarget(self, action: #selector(addButtonTagToSecureUILabel), for: .touchUpInside)
        view.addSubview(thirdSecureNum)
    }
    
    private func createConstraintsInit(){
        NSLayoutConstraint.activate([
            
            labelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 80),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            passTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            authorizeButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 60),
            authorizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizeButton.widthAnchor.constraint(equalToConstant: 156),
            authorizeButton.heightAnchor.constraint(equalToConstant: 42),
            
            //secure view
            secureView.topAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: 67),
            secureView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secureView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 50),
            secureView.leadingAnchor.constraint(equalTo:  firstSecureNum.leadingAnchor, constant: -23),
            
            firstSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            firstSecureNum.widthAnchor.constraint(equalTo: firstSecureNum.heightAnchor, multiplier: 1),
            firstSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),
            firstSecureNum.trailingAnchor.constraint(equalTo: secondSecureNum.leadingAnchor,constant:  -20),
            
            secondSecureNum.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondSecureNum.widthAnchor.constraint(equalToConstant: 50),
            secondSecureNum.widthAnchor.constraint(equalTo: secondSecureNum.heightAnchor, multiplier: 1),
            secondSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            secondSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),
            
            thirdSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            thirdSecureNum.widthAnchor.constraint(equalToConstant: 50),
            thirdSecureNum.widthAnchor.constraint(equalTo: thirdSecureNum.heightAnchor, multiplier: 1),
            thirdSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),
            thirdSecureNum.leadingAnchor.constraint(equalTo: secondSecureNum.trailingAnchor, constant: 23),
            
            secureUILabel.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 15),
            secureUILabel.bottomAnchor.constraint(equalTo: secondSecureNum.topAnchor, constant: -15),
            secureUILabel.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: 96),
            secureUILabel.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -96),
    
        ])
    }

    //MARK: objC methods
    @objc func authorizeButtonPress() {
        presenter.authorizationAction()
        print("authorize button pressed")
        if loginTextField.text == "login" && passTextField.text == "pass"{
            showSecureNumbers()
        }else{
            errorUserInput()
        }
    }
    
    @objc func addButtonTagToSecureUILabel(sender: RoundedButton){
        secureUITextFieldNumbers.append(sender.tag)
        let intToString = secureUITextFieldNumbers.map(String.init)
        secureUITextFieldTitle = intToString.joined(separator: " ")
        secureUILabel.text = "\(secureUITextFieldTitle)"
        print("\(sender.tag)")
        print("secureUITextFieldNumbers = \(secureUITextFieldNumbers)")
        if secureUITextFieldNumbers.count == 3{
            checkSecureCode()
        }
    }
    
    //MARK: state func
    func showSecureNumbers(){
        loginTextField.layer.borderColor = CustomColors.turquoiseGreenColor.withAlphaComponent(0.5).cgColor
        loginTextField.isEnabled = false
        loginTextField.textColor = CustomColors.blackCoralDefoltColor.withAlphaComponent(0.5)
        
        passTextField.layer.borderColor = CustomColors.turquoiseGreenColor.withAlphaComponent(0.5).cgColor
        passTextField.isEnabled = false
        passTextField.textColor = CustomColors.blackCoralDefoltColor.withAlphaComponent(0.5)
        
        authorizeButton.layer.borderColor = CustomColors.littleBoyBlueColor.withAlphaComponent(0.5).cgColor
        
        firstSecureNum.isHidden = false
        secondSecureNum.isHidden = false
        thirdSecureNum.isHidden = false
                secureUILabel.isHidden = false
    }
    
    func errorUserInput(){
        loginTextField.layer.borderColor = CustomColors.redColor.cgColor
        //        loginTextField.isEnabled = false
        passTextField.layer.borderColor = CustomColors.redColor.cgColor
        //        passTextField.isEnabled = false
        //            invisibleButtonToPass.isHidden = false
        //            invisibleButtonToLogin.isHidden = false
        print("error")
    }
    
    func checkSecureCode(){
        if secureUITextFieldNumbers.count == 3 && secureUITextFieldNumbers == [1, 2, 3]{
            showAlert()
        }else{
            setDefaultState()
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Welcome", message: "You are successfuly authorized!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Refresh", style: UIAlertAction.Style.destructive, handler: { _ in
            self.setDefaultState()
            
        }))
        self.present(alert, animated: true, completion: nil)
        secureView.layer.borderColor = CustomColors.turquoiseGreenColor.cgColor
        secureView.isHidden = false
    }
    
    func setDefaultState(){
        loginTextField.isEnabled = true
        loginTextField.text = ""
        loginTextField.layer.borderColor = CustomColors.blackColor.cgColor
        loginTextField.textColor = CustomColors.blackColor
        
        passTextField.isEnabled = true
        passTextField.text = ""
        passTextField.layer.borderColor =  CustomColors.blackColor.cgColor
        passTextField.textColor = CustomColors.blackColor
        
        secureUITextFieldNumbers = []
        secureUILabel.text = ""
        secureUILabel.isHidden = true
        secureView.isHidden = true
        firstSecureNum.isHidden = true
        secondSecureNum.isHidden = true
        thirdSecureNum.isHidden = true
        
    }
    
}



//MARK: -extension
extension UITextField{
    public func setTextField(delegate:UITextFieldDelegate, placeholder: String,
                             borderStyle: BorderStyle, tintColor: UIColor,
                             borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat, isSecureTextEntry : NSSecureCoding, autocapitalizationType: UITextAutocapitalizationType){
        
        self.delegate = delegate
        self.placeholder = placeholder
        self.borderStyle = borderStyle
        self.tintColor = tintColor
        self.borderStyle = borderStyle
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.isSecureTextEntry = isSecureTextEntry as! Bool
        self.autocapitalizationType = autocapitalizationType
    }
}

extension UIView {
    public func setViewBorderAndColor(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius
    }
}

extension LoginViewController {
    
    func isValid(){
        
    }
}
