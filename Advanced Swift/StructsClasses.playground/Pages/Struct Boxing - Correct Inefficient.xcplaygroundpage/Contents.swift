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
        set { filterForWriting.setValue(newValue, forKey: kCIInputImageKey) }
    }
    var radius: Double {
        get { return filter.valueForKey(kCIInputRadiusKey) as! Double }
        set { filterForWriting.setValue(newValue, forKey: kCIInputRadiusKey) }
    }
}

extension GaussianBlur {
    var outputImage: CIImage {
        return filter.outputImage!
    }
}

extension GaussianBlur
{
    private var filterForWriting: CIFilter
    {
        mutating get
        {
            filter = filter.copy() as! CIFilter
            return filter
        }
    }
}

let image = [#Image(imageLiteral: "DOGS.png")#]

let blur = GaussianBlur(inputImage: CIImage(image: image)!, radius: 0)
blur?.outputImage

var copiedBlur = blur
copiedBlur?.radius = 10

blur?.outputImage // Note that this is no longer being blurred

copiedBlur?.outputImage // This has a radius of 10 like we expect

//: Q. So what's the problem?
//: A. We're copying filter every single time, even if we're just making changes to the same struct instance
var s = GaussianBlur(inputImage: CIImage(image: image)!, radius: 10)
let originalFilter = s?.filter
s?.radius = 5 // This creates a brand new filter = INEFFICIENT!!
let newFilter = s?.filter
originalFilter === newFilter // See how the two filters are not the same instance?

//: [Next](@next)
