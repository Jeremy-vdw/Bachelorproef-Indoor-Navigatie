//
//  ViewController.swift
//  DemoApplicatie
//
//  Created by Jeremie Van de Walle on 27/04/18.
//  Copyright © 2018 Jeremie Van de Walle. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let tensorflow = ModelGrootTensorflow()
    let turiCreate = ModelGrootTuriCreate()
    let customVision = ModelGrootCustomVision()
    
    @IBOutlet weak var imageView: UIImageView!
    /* Tensorflow labels */
    @IBOutlet weak var tensorClassName1: UILabel!
    @IBOutlet weak var tensorProbability1: UILabel!
    @IBOutlet weak var tensorClassName2: UILabel!
    @IBOutlet weak var tensorProbability2: UILabel!
    @IBOutlet weak var tensorClassName3: UILabel!
    @IBOutlet weak var tensorProbability3: UILabel!
    /* Turi Create labels */
    @IBOutlet weak var turiClassName1: UILabel!
    @IBOutlet weak var turiProbability1: UILabel!
    @IBOutlet weak var turiClassName2: UILabel!
    @IBOutlet weak var turiProbability2: UILabel!
    @IBOutlet weak var turiClassName3: UILabel!
    @IBOutlet weak var turiProbability3: UILabel!
    /* Custom Vision labels */
    @IBOutlet weak var cvClassName1: UILabel!
    @IBOutlet weak var cvProbability1: UILabel!
    @IBOutlet weak var cvClassName2: UILabel!
    @IBOutlet weak var cvProbability2: UILabel!
    @IBOutlet weak var cvClassName3: UILabel!
    @IBOutlet weak var cvProbability3: UILabel!
    
    var tensorLabels:[UILabel]=[]
    var turiLabels:[UILabel]=[]
    var cvLabels:[UILabel]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tensorLabels = [tensorClassName1, tensorProbability1, tensorClassName2, tensorProbability2, tensorClassName3, tensorProbability3]
        turiLabels = [turiClassName1, turiProbability1, turiClassName2, turiProbability2, turiClassName3, turiProbability3]
        cvLabels = [cvClassName1, cvProbability1, cvClassName2, cvProbability2, cvClassName3, cvProbability3]
    }
    
    @IBAction func openImageLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image

            // Tensorflow
            let tensorImage = resizeImage(image: image, targetSize: CGSize(width: 299, height: 299))
            if let tensorBuffer = tensorImage.buffer(with: CGSize(width:299, height:299)) {
                guard let tensorPrediction = try? tensorflow.prediction(Placeholder__0: tensorBuffer) else { fatalError("Unexpected runtime error")}
                var counter = 0;
                for (name, score) in tensorPrediction.final_result__0 {
                    tensorLabels[counter].text = "\(name):"
                    tensorLabels[counter+1].text = String(format: "%.4f", score)
                    counter += 2
                }
            }
            // Turi Create
            let turiImage = resizeImage(image: image, targetSize: CGSize(width: 224, height: 224))
            if let turiBuffer = turiImage.buffer(with: CGSize(width:224, height:224)) {
                guard let turiPrediction = try? turiCreate.prediction(image: turiBuffer) else { fatalError("Unexpected runtime error")}
                var counter = 0;
                for (name, score) in turiPrediction.labelProbability {
                    turiLabels[counter].text = "\(name):"
                    turiLabels[counter+1].text = String(format: "%.4f", score)
                    counter += 2
                }
            }
            // Custom Vision
             let cvImage = resizeImage(image: image, targetSize: CGSize(width: 227, height: 227))
            if let cvBuffer = cvImage.buffer(with: CGSize(width:227, height:227)) {
                guard let cvPrediction = try? customVision.prediction(data: cvBuffer) else { fatalError("Unexpected runtime error")}
                var counter = 0;
                print(cvPrediction.loss)
                for (name, score) in cvPrediction.loss {
                    cvLabels[counter].text = "\(name):"
                    cvLabels[counter+1].text = String(format: "%.4f", score)
                    counter += 2
                }
            }
        }
        dismiss(animated:true, completion: nil)
    }
    
}

// source : https://stackoverflow.com/questions/44462087/how-to-convert-a-uiimage-to-a-cvpixelbuffer

extension UIImage {
    func buffer(with size:CGSize) -> CVPixelBuffer? {
        if let image = self.cgImage {
            let frameSize = size
            var pixelBuffer:CVPixelBuffer? = nil
            let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
            if status != kCVReturnSuccess {
                return nil
            }
            CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
            let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
            let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
            context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
            CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            
            return pixelBuffer
        }else{
            return nil
        }
    }
}

extension UIImage {
    
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(self.cgImage!, in: newRect)
            let newImage = UIImage(cgImage: context.makeImage()!)
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
}

