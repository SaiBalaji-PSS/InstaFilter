//
//  ViewController.swift
//  Project9
//
//  Created by Sai Balaji on 02/07/20.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var filterbtn: UIButton!
    @IBOutlet weak var sharebtn: UIBarButtonItem!
    @IBOutlet weak var imageview: UIImageView!
    
    var coreImage: CIImage!
    var context: CIContext!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        context = CIContext()
       
        
        filterbtn.layer.cornerRadius = 5
        filterbtn.layer.borderWidth = 1
        filterbtn.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        filterbtn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        filterbtn.layer.shadowOpacity = 20 
        
        filterbtn.isEnabled = false
      
        
       

    }

    @IBAction func addimagebtn(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        
        present(picker, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else{return}
        
        imageview.image = image
        coreImage = CIImage(image: image)
            
    
        
        
        filterbtn.isEnabled = true
      
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func shareimagebtn(_ sender: Any) {
        
        if let jpegimage = imageview.image?.jpegData(compressionQuality: 0.9)
        {
            let vc = UIActivityViewController(activityItems: [jpegimage], applicationActivities: [])
            
            vc.popoverPresentationController?.barButtonItem = sharebtn
            
            present(vc, animated: true, completion: nil)
            
        }
    }
    
    
    
  
    
    @IBAction func changefilterbtn(_ sender: Any) {
        let actionsheet = UIAlertController(title: "Select a filter", message: nil, preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: action))
        actionsheet.addAction(UIAlertAction(title: "CIPhotoEffectMono", style: .default, handler: action))
        actionsheet.addAction(UIAlertAction(title: "CIColorInvert", style: .default, handler: action))
        actionsheet.addAction(UIAlertAction(title: "CIPhotoEffectInstant", style: .default, handler: action))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionsheet, animated: true, completion: nil)
        
        
    }
    
    
    
    func action(act: UIAlertAction)
    {
        if act.title! == "CISepiaTone"
        {
            let filteredimage = sepiaFilter(image: coreImage, intensity: 0.9)
            let sepiaImage = UIImage(ciImage: filteredimage)
            imageview.image = sepiaImage
        }
        
        else if act.title! == "CIPhotoEffectMono"
        {
            let filteredimage = monoFilter(image: coreImage)
            let monoImage = UIImage(ciImage: filteredimage)
            imageview.image = monoImage
        }
        
        
        else if act.title! == "CIColorInvert"
        {
            let filteredimage = colorinvert(image: coreImage)
            let invertedImage = UIImage(ciImage: filteredimage)
            imageview.image = invertedImage
        }
        
        else if act.title! == "CIPhotoEffectInstant"
        {
            let filteredimage = photoeffectinstant(image: coreImage)
            let instantimage = UIImage(ciImage: filteredimage)
            imageview.image = instantimage
        }
    }
    
    
    
    
    
    
    
   
}



extension ViewController
{
    
    func sepiaFilter(image: CIImage,intensity: Float) -> CIImage
    {
        let sepiafiler = CIFilter(name: "CISepiaTone")
       
        sepiafiler!.setValue(image, forKey: kCIInputImageKey)
        sepiafiler!.setValue(intensity, forKey: kCIInputIntensityKey)
        
        return sepiafiler!.outputImage!
      
        
    }
    
    
    
    func monoFilter(image: CIImage) ->CIImage
    {
        let monofilter = CIFilter(name: "CIPhotoEffectMono")
        
        monofilter!.setValue(image, forKey: kCIInputImageKey)
       
        
        return monofilter!.outputImage!
    }
    
    
    func colorinvert(image: CIImage) -> CIImage
    {
        let colorinvertfilter = CIFilter(name: "CIColorInvert")
        
        colorinvertfilter!.setValue(image, forKey: kCIInputImageKey)
        
        return colorinvertfilter!.outputImage!
    }
    
    func photoeffectinstant(image: CIImage) -> CIImage
    {
        let instantfilter = CIFilter(name:"CIPhotoEffectInstant")
        
        instantfilter!.setValue(image, forKey: kCIInputImageKey)
        
        return instantfilter!.outputImage!
    }

   
}
