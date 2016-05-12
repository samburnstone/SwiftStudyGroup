//: [Previous](@previous)
import UIKit
import CoreImage

//: `isUniquelyReferencedNonObjC` only works on Swift types, as you may be able to guess. To get around this, we can employ a trick by boxing the ObjC class (in this case a CIFilter) inside a lightweight Swift class.
//:___
//: On a side note, there is a `isUniquelyReferenced` method that does accept ObjC classes, however it will always return false, making it a little pointless.
final class Box<A>
{
    var unbox: A
    init(_ value: A)
    {
        unbox = value
    }
}

struct GaussianBlur
{
    private var filter: CIFilter
    {
        get { return boxedFilter.unbox }
        set { boxedFilter = Box(newValue) }
    }
        
    private var boxedFilter: Box<CIFilter> = {
        var filter = CIFilter(name: "CIGaussianBlur", withInputParameters:[:])!
        return Box(filter)
    }()
    
    init(inputImage: CIImage, radius: Double)
    {
        self.inputImage = inputImage
        self.radius = radius
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
            // Here's the magic
            if !isUniquelyReferencedNonObjC(&boxedFilter)
            {
                filter = filter.copy() as! CIFilter
            }
            return filter
        }
    }
}

let image = CIImage(image:[#Image(imageLiteral: "DOGS.png")#])!

let blur = GaussianBlur(inputImage: image, radius: 0)
blur.outputImage

var copiedBlur = blur
blur.filter === copiedBlur.filter

// Now, let's see what happens if we alter the radius of the copiedBlur struct
copiedBlur.radius = 15

blur.filter === copiedBlur.filter // Now false (i.e. a new filter has been created)
//: [Next](@next)
