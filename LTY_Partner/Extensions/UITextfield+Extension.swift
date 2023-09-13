//
//  UITextfield+Extension.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 05/06/23.
//

import UIKit
extension UITextField {
    
    enum PaddingSide {
           case left(CGFloat)
           case right(CGFloat)
           case both(CGFloat)
       }
    
    func setBottomBorder(height: CGFloat, color: UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func applyPadding(padding: Int){
        let paddingView = UIView.init(frame: CGRect(x: 0,y:0,width: padding,height: Int(self.frame.size.height)))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightView(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x:0,y:0,width: 40,height: 40))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.center = view.center
        imageView.image = image
        rightView = view
        //rightView?.backgroundColor = .green
        //imageView.backgroundColor = .red
        imageView.contentMode = .center
        rightViewMode = .always
    }
    
    
    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
       // self.layer.masksToBounds = true

        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing - 5, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    func setRightButtonWithImage(active: String, inactive: String){
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: 40,height: 40))
        let button = UIButton.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        button.setImage(UIImage(named: active), for: .selected)
        button.setImage(UIImage(named: inactive), for: .normal)
        view.addSubview(button)
        button.center = view.center
        rightView = view
        //rightView?.backgroundColor = .green
        //imageView.backgroundColor = .red
        rightViewMode = .always
        button.addTarget(self, action: #selector(buttonEyeTapped(_:)), for: .touchUpInside)
    }
    @objc func buttonEyeTapped(_ sender: UIButton){
        if sender.isSelected {
            isSecureTextEntry = true
        }else{
            isSecureTextEntry = false

        }
        sender.isSelected.toggle()
    }
    func setLeftView(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: 40,height: 40))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width:20,height: 20))
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.center = view.center
        imageView.image = image
        leftView = view
       // view.backgroundColor = .green
         //imageView.backgroundColor = .red
         imageView.contentMode = .scaleAspectFit
        leftViewMode = .always
    }
    func setLeftLabel(text: String){
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: 40,height: 40))
        let label = UILabel.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        view.addSubview(label)
        view.isUserInteractionEnabled = false
        label.center = view.center
        leftView = view
        label.text = text
       // label.style(fontType: .regular, fontSize: .size14, textColor: Color.appDarkBlue)
        //view.backgroundColor = .green#imageLiteral(resourceName: "simulator_screenshot_35CD207B-25A5-4B71-893A-EFEC5621842E.png")
        //imageView.backgroundColor = .red
        leftViewMode = .always
    }
    func setAttributedPlaceholder(placeHolder: String, color: UIColor , font: UIFont?) {
        if let font = font{
            let attributesDictionary = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
            self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: attributesDictionary)
        }else{
            let attributesDictionary = [NSAttributedString.Key.foregroundColor: color]
            self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: attributesDictionary)
        }
        
        
    }
    
    func setLeftViewForSearchBar(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x: 5,y:0,width: 40,height: 40))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.center = view.center
        imageView.image = image
        leftView = view
        imageView.contentMode = .scaleAspectFit
        leftViewMode = .always
    }
    
    func setRightButtonWithImageSearchBar(active: String, inactive: String){
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: 40,height: 40))
        let button = UIButton.init(frame: CGRect(x: 50,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        button.setImage(UIImage(named: active), for: .selected)
        button.setImage(UIImage(named: inactive), for: .normal)
        view.addSubview(button)
        button.center = view.center
        rightView = view
        rightViewMode = .never
        button.addTarget(self, action: #selector(clearText(_:)), for: .touchUpInside)
    }
    
    @objc func clearText(_ sender: UIButton) {
        
        text = ""
        rightViewMode = .never
        
    }
    
    
    
}


class CustomTextFieldNew:UITextField {
    
    var completion: (() -> ())? = nil
    func addRightView(imagName:String) {
        
        let image = UIImage.init(named: imagName)
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height),height: Int(self.frame.size.height)))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        let button = UIButton()
        button.addTarget(self, action: #selector(eyeButton(_:)), for: .touchUpInside)
        button.frame = view.frame
        view.addSubview(imageView)
        view.addSubview(button)
        imageView.center = view.center
        imageView.image = image
        self.rightView = view
        imageView.contentMode = .center
        self.rightViewMode = .always
    }
    
    @objc func eyeButton(_ sender: UIButton) {
        
        self.completion!()
    }
    
}


/// Extend UITextView and implemented UITextViewDelegate to listen for changes
extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}
