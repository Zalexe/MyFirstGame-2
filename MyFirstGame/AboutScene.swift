//
//  AboutScene.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 8/3/19.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//
import UIKit
import SpriteKit
import AVFoundation

protocol AboutSceneDelegate: class {
    func back(sender: AboutScene)
}
struct defaultsKeys {
    static let keyOne = "firstStringKey"
    static let keyTwo = "secondStringKey"
}
var cartas: [String] = [ "CardFront","obelisk","sliffer","Chimeratech","fusion","mirror","stardust","firewall","dhampir","chaosmax","pendulum","supreme"]
//opciones
class AboutScene: SKScene, ButtonDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    static let cardWidth: CGFloat = 100.0
    static let cardHeight: CGFloat = 150.0
    
    weak var aboutDelegate: AboutSceneDelegate?
    
    private var label : SKLabelNode?
    var carta : SKSpriteNode?
    
    var WhichCard: Int = 0
    
    //botones cambiar imagen carta
    private var nextCard = ClousureButton(rect: CGRect(x: 0, y: 0, width: 50, height: 50),cornerRadius: 10)
    private var backCard = ClousureButton(rect: CGRect(x: 0, y: 0, width: 50, height: 50),cornerRadius: 10)
    private var selectImage = Button(rect: CGRect(x: 0, y: 0, width: 180, height: 50),cornerRadius: 40)
   // private var MuteButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 180, height: 50),cornerRadius: 40)
    
    //comprobar si ya esta muteado o no para poner una textura o otra
    private var MuteButton = SpriteButton(texture: SKTexture(imageNamed: "mute"))
    
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    var swipeRightGesture = UISwipeGestureRecognizer()
    
    
    //para escribir texto
   // var text:UITextField
    let picNode = SKSpriteNode(color: .lightGray, size: CGSize(width: cardWidth, height: cardHeight))
    let picker = UIImagePickerController()
    
    weak var viewController: UIViewController?
    
    /*func displayImage(image: UIImage) {
        self.picNode.texture = SKTexture(image: image.fixedOrientation())
    }*/
    override func didMove(to view: SKView) {
        
        if(Preferences.isSoundOn() == true){
            let action = SKAction.setTexture(SKTexture(imageNamed: "speaker"), resize: false)
            self.MuteButton.run(action)
        }
        else if(Preferences.isSoundOn() == false){
            let action = SKAction.setTexture(SKTexture(imageNamed: "mute"), resize: false)
            self.MuteButton.run(action)
        }
        // let nombreArchivoCarta = "4corazones"
        Preferences.getCards()
        
        carta = SKSpriteNode(texture: SKTexture(imageNamed: cartas[WhichCard]))
        if let image = self.loadImage(imageName: cartas[self.WhichCard]) {
            self.setImageOnTexture(carta: carta!, image: image)
        } else {
            self.setImageOnTexture(carta: carta!, image: UIImage(named: cartas[self.WhichCard]) ?? UIImage())
        }
        
        addChild(carta!)
        
        carta!.scale(to: CGSize(width: AboutScene.cardWidth * 2,height: AboutScene.cardHeight * 2))
        carta!.position = CGPoint(x: view.frame.width / 2.0  , y: view.frame.height * 0.66)
        
        MuteButton.scale(to: CGSize(width: AboutScene.buttonWidth / 2.0, height: AboutScene.buttonHeight + AboutScene.buttonHeight))
        MuteButton.position = CGPoint(x: view.frame.width / 2 + view.frame.width / 3 , y: view.frame.height * 0.33)
        MuteButton.isUserInteractionEnabled = true
       // MuteButton.delegate = self
        MuteButton.onTap = {
            Preferences.toggleSound()
            if(Preferences.isSoundOn() == true){
                let action = SKAction.setTexture(SKTexture(imageNamed: "speaker"), resize: false)
                self.MuteButton.run(action)
            }
            else if(Preferences.isSoundOn() == false){
                let action = SKAction.setTexture(SKTexture(imageNamed: "mute"), resize: false)
                self.MuteButton.run(action)
            }
            
            //print("mute")
        }

        addChild(MuteButton)
        //
        backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: (view.frame.width / 2.0) - (AboutScene.buttonWidth / 2 ), y: (view.frame.height / 8.0) - (AboutScene.buttonHeight / 2 ))
        addChild(backButton)
        
        //botones cambiar imagen carta
        nextCard.fillColor = .white
        nextCard.isUserInteractionEnabled = true
        nextCard.position = CGPoint(x: view.frame.width / 2 + (AboutScene.cardWidth * 1.20) /*mitad de su tamaño*/, y: view.frame.height * 0.63)
        //playButton.fillColor = SKColor(named: "Color")!
        nextCard.strokeColor = .darkGray
        nextCard.setText(text: ">")
        nextCard.onTap = {
            self.WhichCard = self.WhichCard - 1
            if(self.WhichCard < 0){
                self.WhichCard = 11
            }

            if let image = self.loadImage(imageName: cartas[self.WhichCard]) {
                self.setImageOnTexture(carta: self.carta!, image: image)
            } else {
                self.setImageOnTexture(carta: self.carta!, image: UIImage(named: cartas[self.WhichCard]) ?? UIImage())
            }
            
            
        }

        addChild(nextCard)
        
        
        //swipe hacia la derecha, falta muchas cosas

      /*  if view == nil{
            
            swipeRightGesture.view?.removeGestureRecognizer(swipeRightGesture)
        }*/
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        backCard.fillColor = .white
        backCard.isUserInteractionEnabled = true
        backCard.position = CGPoint(x: view.frame.width / 3 - (AboutScene.cardWidth * 1.10) , y: view.frame.height * 0.63)
        //playButton.fillColor = SKColor(named: "Color")!
        backCard.strokeColor = .darkGray
        backCard.setText(text: "<")
        backCard.onTap = {
            self.WhichCard = self.WhichCard + 1
            if(self.WhichCard > 11){
                self.WhichCard = 0
            }
            
            if let image = self.loadImage(imageName: cartas[self.WhichCard]) {
                self.setImageOnTexture(carta: self.carta!, image: image)
            } else {
                self.setImageOnTexture(carta: self.carta!, image: UIImage(named: cartas[self.WhichCard]) ?? UIImage())
            }
            
        }
        addChild(backCard)
        

        
        
        
        selectImage.fillColor = .green
        selectImage.isUserInteractionEnabled = true
        selectImage.position = CGPoint(x: view.frame.width * 0.13, y: view.frame.height * 0.35)
        //playButton.fillColor = SKColor(named: "Color")!
        selectImage.strokeColor = .cyan
        selectImage.delegate = self
        selectImage.setText(text: "Sel.Image")
        addChild(selectImage)
        
        
        picNode.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.46)
       // addChild(picNode)
        
        picker.delegate = self
//        loadImage(imageName: "image" + String(WhichCard) + ".jpg")
        //para escribir
        /*var textField = UITextField(frame: CGRect(x: 0,  y:-200, width: 10, height: 10))
        textField.delegate = self
        view.addSubview(scene: scene)*/
        
        scene?.backgroundColor = SKColor(named: "Color")!
        
        

    }
    
    func setImageOnTexture(carta: SKSpriteNode, image: UIImage) {
        var action = SKAction.setTexture(SKTexture(image: image), resize: false)
        
        carta.run(action)
        action = SKAction.run{
            carta.scale(to: CGSize(width: AboutScene.cardWidth * 2,height: AboutScene.cardHeight * 2))
            carta.position = CGPoint(x: self.view!.frame.width / 2.0, y: self.view!.frame.height * 0.66)}
        carta.run(action)
    }

    override func willMove(from view: SKView){
        view.removeGestureRecognizer(swipeRightGesture)
    }
    
    
    func onTap(sender: Button) {
        if sender == backButton {
            aboutDelegate?.back(sender: self)

        } else if sender == selectImage {
            openGallery()

        }

    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer){
        print("Swipe detectado")
    }
    
    
    
    
    //pa escribir
 /*   func onTap(sender: Button){
        textField.becomeFirstResponder()
    }
    override func touchesEnded(_ touches: set<UITouch>, with event: UIEvent?){
        textField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersInRange: NSRange, replacementString string:String) -> Bool{
        let newString =((textField.text ?? "")as NSString).replacingCharacters(in: range, with: string) as String
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }*/
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.cameraDevice = .front
            viewController?.present(picker, animated: true, completion: nil)
        } else {
            openGallery()
        }
    }
    
    func openGallery() {
        picker.sourceType = .photoLibrary
        viewController?.present(picker, animated: true, completion: nil)
    }
    
    func displayImage(image: UIImage) {
        self.picNode.texture = SKTexture(image: image.fixedOrientation())
        cartas[self.WhichCard] = "image" + String(WhichCard) + ".jpg"
        Preferences.saveCards()

    }
    
    func loadImage(imageName: String) -> UIImage? {
        let documentsDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        if let documentsDirectoryURL = documentsDirectoryURL {
            do {
                let data = try Data(contentsOf: documentsDirectoryURL.appendingPathComponent(imageName))
                if let image = UIImage(data: data) {
                    return image
                }
            } catch {
                print(error)
            }
            
        }
        return nil
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.displayImage(image: image)
                
                // guardar foto
                let documentsDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
                if let data = image.jpegData(compressionQuality: 0.8),
                    let documentsDirectoryURL = documentsDirectoryURL {
                    
                    do {
                        try data.write(to: documentsDirectoryURL.appendingPathComponent("image" + String(self.WhichCard) + ".jpg"))
                        if let image = self.loadImage(imageName: cartas[self.WhichCard]) {
                            self.setImageOnTexture(carta: self.carta!, image: image)
                        } else {
                            self.setImageOnTexture(carta: self.carta!, image: UIImage(named: cartas[self.WhichCard]) ?? UIImage())
                        }
                    } catch {
                        print(error)
                    }
                    
                }
                
                
                
            }
        }
    }
}

extension UIImage {
    func fixedOrientation() -> UIImage
    {
        if imageOrientation == .up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        }
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        return UIImage(cgImage: ctx.makeImage()!)
    }
    
    /// Aspect fit an image from a size. (center)
    ///
    /// The input size is the minimum size of the output image. The size of `self` is the
    /// maximum size of the output image. Aspect ratio is maintained. Transparency is added to the
    /// sides of the output image to keep the image centered.
    ///
    /// - parameter in: The `CGSize` in which to scale and center `self`.
    func scaleAndFit(in inputSize: CGSize) -> UIImage {
        // Scale rect to fit image, if image is larger.
        // E.g. image 6000x4000, rect 200x400, results in 6000 x 12000
        let scaledSize: CGSize = {
            let ratio = (size.height > size.width) ?
                max(size.height / inputSize.height, 1.0):
                max(size.width / inputSize.width, 1.0)
            return CGSize(width: inputSize.width*ratio, height: inputSize.height*ratio)
        }()
        
        // Fit image inside scaled rect
        // E.g. image 6000x4000, scaled rect 6000x12000, results in (0, 4000, 6000, 4000)
        let scaledAspectFitRect = AVMakeRect(aspectRatio: size, insideRect: CGRect(origin: .zero, size: scaledSize))
        
        // Create the image
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        draw(in: scaledAspectFitRect)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        
        return image
    }
}
