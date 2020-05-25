//
//  ViewController.swift
//  VisionSample
//
//  Created by Benoit PASQUIER on 05/12/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var sublayers: [CALayer] = []
    
    lazy var faceDetectionRequest: VNDetectFaceRectanglesRequest = {
        let faceLandmarksRequest = VNDetectFaceRectanglesRequest(completionHandler: { [weak self] request, error in
            self?.handleDetection(request: request, errror: error)
        })
        return faceLandmarksRequest
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Action & Navigation
    @IBAction func didTapImport(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Import picture", message: nil, preferredStyle: .actionSheet)
        let galleryButton = UIAlertAction(title: "Photo Library", style: .default, handler: { [unowned self] _ in
            self.presentImageController(from: .photoLibrary)
        })
        let pictureButton = UIAlertAction(title: "Camera", style: .default, handler: { [unowned self] _ in
            self.presentImageController(from: .camera)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(galleryButton)
        alertController.addAction(pictureButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func presentImageController(from source: UIImagePickerController.SourceType) {
        let viewController = UIImagePickerController()
        viewController.sourceType = source
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    // MARK: - Face recognition
    
    fileprivate func launchDetection(image: UIImage) {
        
        let orientation = image.coreOrientation()
        guard let coreImage = CIImage(image: image) else { return }
        
        DispatchQueue.global().async {
            let handler = VNImageRequestHandler(ciImage: coreImage, orientation: orientation)
            do {
                try handler.perform([self.faceDetectionRequest])
            } catch {
                print("Failed to perform detection .\n\(error.localizedDescription)")
            }
        }
    }
    
    fileprivate func handleDetection(request: VNRequest, errror: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let observations = request.results as? [VNFaceObservation] else {
                fatalError("unexpected result type!")
            }
            
            print("Detected \(observations.count) faces")
            
            observations.forEach( { self?.addFaceRecognitionLayer($0) })
        }
    }
    
    fileprivate func addFaceRecognitionLayer(_ face: VNFaceObservation) {
        
        guard let image = imageView.image else { return }
        
        UIGraphicsBeginImageContextWithOptions(image.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // draw the image
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        // draw line
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -image.size.height)
        let translate = CGAffineTransform.identity.scaledBy(x: image.size.width, y: image.size.height)
        let facebounds = face.boundingBox.applying(translate).applying(transform)
        
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        context?.setLineWidth(1.0)
        context?.addRect(facebounds)
        context?.drawPath(using: .stroke)
        context?.restoreGState()
        
        // get the final image
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end drawing context
        UIGraphicsEndImageContext()
        
        imageView.image = finalImage
        
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
            self.launchDetection(image: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
