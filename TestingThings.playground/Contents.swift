//: Playground - noun: a place where people can play

import Cocoa


class BasePresenter {
    
}

class UIViewController {
    
}

class CustomViewController: UIViewController {
    
}

class CustomPresenter: BasePresenter {
    
}

protocol Marker {
    
}

class BaseRotuer<VC: UIViewController, P: BasePresenter> : Marker {
    
    let viewController: VC
    let presenter: P
    
    init(viewController: VC, presenter: P) {
        self.viewController = viewController
        self.presenter = presenter
    }
}

class CustomRouter: BaseRotuer<CustomViewController, CustomPresenter>  {
    
    override init(viewController: CustomViewController, presenter: CustomPresenter) {
        super.init(viewController: viewController, presenter: presenter)
    }
    
}

class Container {
    
    var routers = [Marker]()
    
    init(router: Marker) {
        self.routers.append(router)
    }
    
}

let customRouter = CustomRouter(viewController: CustomViewController(), presenter: CustomPresenter())

let container = Container(router: customRouter)


protocol Response {
    
}

protocol Pene {
    static func ereccion() -> Self
}

struct BaseResponse<T: Pene> : Response {
    
    var object: T?
    var error: NSError?
    
    init(object: T?, error: NSError?) {
        self.object = object
        self.error = error
    }
    
    static func from(any: AnyObject) -> BaseResponse<T> {
        return self.init(object: T.ereccion(), error: nil)
    }
    
    static func from(error: NSError) -> BaseResponse<T> {
        return self.init(object: nil, error: error)
    }
}
    