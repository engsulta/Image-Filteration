import Foundation


import UIKit

public func tiltShift(image: UIImage?) -> UIImage? {
    guard let image = image else { return .none }
    sleep(1)
    let mask = topAndBottomGradient(size: image.size)
    return image.applyBlur(radius: 6, maskImage: mask)
}

func tiltShiftAsync(image: UIImage?, callback: @escaping (UIImage?) ->()) {
    OperationQueue().addOperation {
        let result = tiltShift(image: image)
        callback(result)
    }
}

public class TiltShiftOperation : Operation {
    public var inputImage: UIImage?
    public var outputImage: UIImage?
    
    override public func main() {
        guard let inputImage = inputImage else { return }
        outputImage = tiltShift(image: inputImage)
    }
}
