//: [Previous](@previous)

struct DataCruncher {
    
    init() {
        for _ in 0...1000 {
            // Heavy lifting
        }
    }
    
    func crunchData() {
        print("Crunching data!")
    }
    
}

class Application {
    
    // Initialisation of DataCruncher struct is intensive (or at least imagine it is!). We only want to create it if we really have to, so we declare it as 'lazy'.
    lazy var dataCruncher = DataCruncher()
    
    func bootUp() {
        print("Booting up!")
    }
    
    func runCommands() {
        print("Getting to work!")
        dataCruncher.crunchData()
    }
    
}

//: We can see dataCruncher property is nil after Application class instance has been created.
let app = Application()
app.bootUp()
//: However, when we call **runCommands**, which makes use of the dataCruncher property, we find it has now been created.
app.runCommands()

//: [Next](@next)
