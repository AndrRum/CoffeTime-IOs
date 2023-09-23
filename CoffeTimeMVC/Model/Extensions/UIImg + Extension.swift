//
//  UIImg + Extension.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 22.09.2023.
//

import UIKit
import ImageIO

extension UIImage {
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let count = CGImageSourceGetCount(source)
        
        var images: [UIImage] = []
        var duration: TimeInterval = 0.0
        
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                   let gifDict = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
                   let delayTime = gifDict[kCGImagePropertyGIFDelayTime as String] as? NSNumber {
                    duration += delayTime.doubleValue
                }
                
                images.append(UIImage(cgImage: cgImage))
            }
        }
        
        if duration == 0.0 {
            let defaultDuration = 0.1
            duration = Double(count) * defaultDuration
        }
        
        return UIImage.animatedImage(with: images, duration: duration)
    }
}
