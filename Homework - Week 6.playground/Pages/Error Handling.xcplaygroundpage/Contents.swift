//: [Previous](@previous)

enum CompilerError: ErrorType {
    case InvalidInput
    case BunkedOut
}

struct Application {
    var compiled = false
}

class XamarinStudio {
    
    var counter = 0
    
    func compile(application: Application?) throws -> Application {
        
        guard var application = application else {
            throw CompilerError.InvalidInput
        }
        
        counter++
        
        if counter % 2 == 0 {
            application.compiled = true
        }
        else {
            throw CompilerError.BunkedOut
        }
        
        return application
    }
}

var xamarin = XamarinStudio()

let shinobiPlayV1: Application? = Application()
do {
   try xamarin.compile(shinobiPlayV1)
}
catch CompilerError.InvalidInput {
    print("Invalid input. Did you pass in nil you numpty?")
}
catch CompilerError.BunkedOut {
    print("Xamarin BUNKED out again!")
}

let shinobiPlayV2 = Application()

// Can use 'try?' to resolve any errors thrown to 'nil'.
if let compiledPlayAttempt1 = try? xamarin.compile(shinobiPlayV2) { print("Failed to compile!") }
if let compiledPlayAttempt2 = try? xamarin.compile(shinobiPlayV2) { print("Failed to compile again!!") }

//: Quick demonstration of force try!
enum TechThrobError: ErrorType {
    case TechThrobNotFound
}

enum CGError: ErrorType {
    case ChrisGrantNotFound
}

func chrisIsATechThrob() throws -> Bool {
    //return true
    
    throw TechThrobError.TechThrobNotFound
}

// Know that chrisIsATechThrob will always be true, therefore...
let result = try chrisIsATechThrob() // Prevents propragation of error messages

//: Cleaning up using DEFER
//
//enum FileReadError: ErrorType {
//    case FileNotFound
//    case FileCorrupted
//}
//
//func readFile(fileName: String) throws {
//    print("Opening file")
//    
//    defer {
//        print("Closing file")
//    }
//    
//    defer {
//        print("Ready to clear up this mess!")
//    }
//    
//    if fileName.isEmpty {
//        throw FileReadError.FileNotFound
//    }
//    
//    // Arbitrary character count
//    if fileName.characters.count < 3 {
//        throw FileReadError.FileCorrupted
//    }
//    
////    print("Successfully read file!")
//}
//
//try readFile("")
////try readFile("t1")
////try readFile("README.txt")
//
//: Partial capturing of exceptions

enum PrinterError: ErrorType {
    case OutOfInk
}

func print() throws -> String {
    throw PrinterError.OutOfInk
}

func performPrintOperation(operation: () throws -> String) rethrows {
    try operation()
}

func clickPrintMenuItem() {
    do {
        try performPrintOperation(print)
    }
    catch PrinterError.OutOfInk {
        Swift.print("Out of ink!")
    }
    catch {
        Swift.print("Unrecognized error")
    }
}

clickPrintMenuItem()

//: [Next](@next)
