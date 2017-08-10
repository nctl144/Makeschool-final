import UIKit
import Material

class AppFABMenuController: FABMenuController, UIImagePickerControllerDelegate {
    fileprivate let fabMenuSize = CGSize(width: 56, height: 56)
    fileprivate let bottomInset: CGFloat = 60
    fileprivate let rightInset: CGFloat = 16
    
    fileprivate var fabButton: FABButton!
    fileprivate var notesFABMenuItem: FABMenuItem!
    fileprivate var remindersFABMenuItem: FABMenuItem!
    
    let imagePicker = UIImagePickerController()
    
    open override func prepare() {
        super.prepare()
        
        prepareFABButton()
        prepareCameraView()
        preparePhotoLibraryView()
        prepareFABMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AppFABMenuController {
    fileprivate func prepareFABButton() {
        fabButton = FABButton(image: Icon.cm.add, tintColor: .white)
        fabButton.pulseColor = .white
        fabButton.backgroundColor = Color.red.base
    }
    
    fileprivate func prepareCameraView() {
        notesFABMenuItem = FABMenuItem()
        notesFABMenuItem.title = "From Camera"
        notesFABMenuItem.fabButton.image = Icon.cm.photoCamera
        notesFABMenuItem.fabButton.tintColor = .white
        notesFABMenuItem.fabButton.pulseColor = .white
        notesFABMenuItem.fabButton.backgroundColor = Color.green.base
        notesFABMenuItem.fabButton.addTarget(self, action: #selector(handleCameraButton(button:)), for: .touchUpInside)
    }
    
    fileprivate func preparePhotoLibraryView() {
        remindersFABMenuItem = FABMenuItem()
        remindersFABMenuItem.title = "From Photo Library"
        remindersFABMenuItem.fabButton.image = Icon.cm.photoLibrary
        remindersFABMenuItem.fabButton.tintColor = .white
        remindersFABMenuItem.fabButton.pulseColor = .white
        remindersFABMenuItem.fabButton.backgroundColor = Color.blue.base
        remindersFABMenuItem.fabButton.addTarget(self, action: #selector(handlePhotoLibButton(button:)), for: .touchUpInside)
    }
    
    fileprivate func prepareFABMenu() {
        fabMenu.fabButton = fabButton
        fabMenu.fabMenuItems = [notesFABMenuItem, remindersFABMenuItem]
        
        view.layout(fabMenu)
            .size(fabMenuSize)
            .bottom(bottomInset)
            .right(rightInset)
    }
}

extension AppFABMenuController {
    @objc
    fileprivate func handleCameraButton(button: UIButton) {
        //implement initialze a uiimagepickerconroller
        let cameraViewController = UIImagePickerController()
        //set the type to camera
        cameraViewController.sourceType = .camera
        
        //delegate
        
        cameraViewController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        //present the imagepicker
        present(cameraViewController, animated: true, completion: nil)

        fabMenu.close()
        fabMenu.fabButton?.motion(.rotationAngle(0))
    }
    
    @objc
    fileprivate func handlePhotoLibButton(button: UIButton) {
        // transition(to: MainTabBarViewController())
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
        fabMenu.close()
        fabMenu.fabButton?.motion(.rotationAngle(0))
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            MGPhotoHelper.completionHandler?(selectedImage)
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension AppFABMenuController {
    @objc
    open func fabMenuWillOpen(fabMenu: FABMenu) {
        fabMenu.fabButton?.motion(.rotationAngle(45))
    }
    
    @objc
    open func fabMenuDidOpen(fabMenu: FABMenu) {
        
    }
    
    @objc
    open func fabMenuWillClose(fabMenu: FABMenu) {
        fabMenu.fabButton?.motion(.rotationAngle(0))
    }
    
    @objc
    open func fabMenuDidClose(fabMenu: FABMenu) {
        
    }
    
    @objc
    open func fabMenu(fabMenu: FABMenu, tappedAt point: CGPoint, isOutside: Bool) {
        
        guard isOutside else {
            return
        }
        
        // Do something ...
    }
}
