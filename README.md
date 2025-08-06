# 🌐 Harmo Network Layer

A flexible and type-safe way to define API requests in Swift.

## ✅ Features

- Strongly typed method and headers  
- Query parameters and body support  
- `Encodable` body for easy JSON encoding  
- Optional support for raw dictionary parameters  

## 🛠 Installation

### Swift Package Manager

Add the following to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/your-username/APIConfigProtocol.git", from: "1.0.0")
```

### Manual

To install manually, drag and drop the following files into your project navigator. Make sure they are added to your main app target.

* `APIConfig.swift`
* `NetworkError.swift`
* `NetworkManager.swift`
* `NetworkResponse.swift`
* `RequestMethod.swift`

**Pro Tip:** For better project organization, it's recommended to place these files inside a Group named `Networking` or `API` within Xcode.




## 💻 Protocol Definition
```swift
protocol APIConfigProtocol {
    var url: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var body: Encodable? { get }
    var parameters: [String: Any]? { get }
}
```

🚀 Example Usage
```swift
struct MyRequest: APIConfigProtocol {
    let url = "https://api.example.com/users"
    let method: RequestMethod = .get
    let headers: [String: String]? = ["Authorization": "Bearer token"]
    let queryParameters: [String: String]? = ["page": "1"]
    let body: Encodable? = nil
    let parameters: [String: Any]? = nil
}
```

With Body
```swift
struct LoginBody: Encodable {
    let username: String
    let password: String
}

struct LoginRequest: APIConfigProtocol {
    let url = "https://api.example.com/login"
    let method: RequestMethod = .post
    let headers: [String: String]? = ["Content-Type": "application/json"]
    let queryParameters: [String: String]? = nil
    let body: Encodable? = LoginBody(username: "user", password: "pass")
    let parameters: [String: Any]? = nil
}
```






