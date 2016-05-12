//: [Previous](@previous)
import UIKit
import CoreImage

struct GaussianBlur
{
    private var filter: CIFilter
    
    init?(inputImage: CIImage, radius: Double)
    {
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: radius
            ])
        else
        {
            return nil
        }
        
        self.filter = filter
    }
}

extension GaussianBlur {
    var inputImage: CIImage {
        get { return filter.valueForKey(kCIInputImageKey) as! CIImage }
        set { filter.setValue(newValue, forKey: kCIInputImageKey) }
    }
    var radius: Double {
        get { return filter.valueForKey(kCIInputRadiusKey) as! Double }
        set { filter.setValue(newValue, forKey: kCIInputRadiusKey) }
    }
}

extension GaussianBlur {
    var outputImage: CIImage {
        return filter.outputImage!
    }
}

let image = [#Image(imageLiteral: "DOGS.png")#]

let blur = GaussianBlur(inputImage: CIImage(image: image)!, radius: 0)
blur?.outputImage

var copiedBlur = blur
copiedBlur?.radius = 10

blur?.outputImage // Uh oh, we've mutated our original blur filter, even though we adjusted the radius on copiedBlur

// Both struct instances point at the same filter reference
//: [Next](@next)
