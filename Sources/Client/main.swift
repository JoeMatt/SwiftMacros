import SwiftMacros
import Foundation
import Combine
import SwiftUI

@Singleton
struct TestSingletonMacro {
    let name = "Tim Wang"
}

@Singleton
public struct TestPublicSingletonMacro {
    let name = "Tim Wang"
}

@Singleton
class TestPublicSingletonNSOjbectMacro: NSObject {
    let name = "Tim Wang"
}

struct TestStruct: Codable {
    var name = "Tim Wang"
}

let data = try #encode(TestStruct(), dateEncodingStrategy: .iso8601, dataEncodingStrategy: .base64)
let value = try #decode(TestStruct.self, from: data, dateDecodingStrategy: .deferredToDate)

struct MyType {
    @AddPublisher
    private let mySubject = PassthroughSubject<Void, Never>()
}

_ = MyType().mySubjectPublisher.sink { _ in

}

struct TestNotification {
    func post() {
        #postNotification(.NSCalendarDayChanged, object: NSObject(), userInfo: ["value": 0])
    }
}

@AddInit
struct InitStruct {
    let a: Int
    let b: Int?
    let c: (Int?) -> Void
    let d: ((Int?) -> Void)?
}

@AddInit
actor InitActor {
    let a: Int
    let b: Int?
    let c: (Int?) -> Void
    let d: ((Int?) -> Void)?
}

@AddAssociatedValueVariable
enum MyEnum {
    case first
    case second(Int)
    case third(String, Int)
    case forth(a: String, b: Int), forth2(String, Int)
    case seventh(() -> Void)
}

assert(MyEnum.first.forth2Value == nil)

let url = #buildURL("http://google.com",
                   URLScheme.https,
                   URLQueryItems([.init(name: "q1", value: "q1v"), .init(name: "q2", value: "q2v")]))

let url2 = buildURL {
    "http://google.com"
    URLScheme.https
    URLQueryItems([.init(name: "q1", value: "q1v"), .init(name: "q2", value: "q2v")])
}

let urlrequest = #buildURLRequest(url!, RequestTimeOutInterval(100))
let urlRequest2 = buildURLRequest {
    url!
    RequestTimeOutInterval(100)
}

print(urlrequest?.timeoutInterval)

class AStruct {
    let a: Float
    @Mock(typeName: "AStruct")
    init(a: Float) {
        self.a = a
    }
}

@AddInit(withMock: true)
class BStruct {
    let a: Float
    let b: CStruct
}

struct CStruct {
    static let mock = CStruct()
}
print(AStruct.mock.a)
print(BStruct.mock.a)

let date = #buildDate(DateString("03/05/2003", dateFormat: "MM/dd/yyyy"),
                      Date(),
                      Month(10),
                      Year(1909),
                      YearForWeekOfYear(2025))

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .medium
dateFormatter.timeStyle = .medium
print("here")
print(dateFormatter.string(from: Date()))

let string = #formatDate(Date(), dateStyle: .full)
