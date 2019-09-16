import UIKit
import Foundation
import PlaygroundSupport
//: ## Filtering an Array of Images
//: Now for a more real-world example.
let images = ["city", "dark_road"].map { UIImage(named: "\($0).jpg") }
var filteredImages = [UIImage]()
//: Create the queue with the default initializer:
// DONE: Create filterQueue
let filterQueue = OperationQueue()
//: Create a serial queue to handle additions to the array:
// DONE: Create serial appendQueue
let appendQueue = OperationQueue()
appendQueue.maxConcurrentOperationCount = 1
//: Create a filter operation for each of the images, adding a `completionBlock`:
for image in images {
    // DONE: as above
    let filterOp = TiltShiftOperation()
    filterOp.inputImage = image
    filterOp.completionBlock = {
        guard let output = filterOp.outputImage else { return }
        appendQueue.addOperation {
            filteredImages.append(output)
        }
    }
    filterQueue.addOperation(filterOp)
}
//: Need to wait for the queue to finish before checking the results
// DONE: wait
filterQueue.waitUntilAllOperationsAreFinished()
//: Inspect the filtered images
filteredImages

//PlaygroundPage.current.finishExecution()
