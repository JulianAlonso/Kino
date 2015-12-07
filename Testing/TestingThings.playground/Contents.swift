
protocol hello {
    typealias ClassType
}

struct AWAAA {
    
}

struct Awup: hello {
    typealias ClassType = AWAAA
}


extension hello {
    
    func sayHello() {
        print(ClassType.self)
    }
    
}

let awup = Awup()

awup.sayHello()

