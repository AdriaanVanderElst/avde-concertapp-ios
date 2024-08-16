

import JWTDecode


struct Profile {
  
  let id: String
  let name: String
  let email: String
}


extension Profile {
  
  static var empty: Self {
    return Profile(
      id: "",
      name: "",
      email: ""
    )
  }

  static func from(_ idToken: String) -> Self {
    guard
      let jwt = try? decode(jwt: idToken),
      let id = jwt.subject,
      let name = jwt.claim(name: "name").string,
      let email = jwt.claim(name: "email").string
    else {
      return .empty
    }

    return Profile(
      id: id,
      name: name,
      email: email
    )
  }
  
}
