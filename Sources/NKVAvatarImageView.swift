//
//  NKVAvatarImageView.swift
//  NKVImagePicker
//
//  Created by Nik Kov on 31.07.17.
//  Copyright © 2017 nik.kov. All rights reserved.
//

import UIKit

open class NKVAvatarImageView: UIImageView {
    private var _round = true
    private var _placeholder = #imageLiteral(resourceName: "placeholder")
    fileprivate let picker = UIImagePickerController()

    @IBOutlet weak var viewController: UIViewController!
    
    open var alertTitle: String?
    open var alertMessage: String?
    open var alertStyle: UIAlertControllerStyle = .actionSheet
    
    // MARK: - Life cycle
    required public init(frame: CGRect, owner: UIViewController) {
        self.viewController = owner
        super.init(frame: frame)
        initialize()
    }
    
    convenience init(owner: UIViewController) {
        self.init(frame: CGRect.zero, owner: owner)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        isUserInteractionEnabled = true
        autoresizesSubviews = true
        clipsToBounds = true
        image = _placeholder
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didPress))
        self.addGestureRecognizer(tapGesture)
        
        picker.delegate = self
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        makeRound()
    }

    
    // MARK: - Action
    func didPress() {
        guard viewController != nil else {
            print("\(type(of: self)) needs a delegate UIViewController to show up the alert with choises to pick."); return }
        
        let alertController = UIAlertController(title: alertTitle,
                          message: alertMessage,
                          preferredStyle: alertStyle)
        let changeAction = UIAlertAction(title: "Change photo", style: .default) { action in
            
        }
        let deleteAction = UIAlertAction(title: "Remove photo", style: .destructive) { action in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(changeAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Rounding
    @IBInspectable var round: Bool {
        set {
            _round = newValue
            makeRound()
        }
        get {
            return self._round
        }
    }
    override open var frame: CGRect {
        set {
            super.frame = newValue
            makeRound()
        }
        get {
            return super.frame
        }
    }
    
    private func makeRound() {
        if self.round == true {
            if self.frame.width == self.frame.height {
            self.layer.cornerRadius = (self.frame.width + self.frame.height) / 4
            } else {
                self.layer.cornerRadius = 15
            }
        } else {
            self.layer.cornerRadius = 0
        }
    }
    
    // MARK: - Placeholder
    @IBInspectable var placeholder: UIImage {
        set {
            _placeholder = newValue
            self.image = _placeholder
        }
        get {
            return _placeholder
        }
    }
}

extension NKVAvatarImageView: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}

extension NKVAvatarImageView: UINavigationControllerDelegate {
    
}
