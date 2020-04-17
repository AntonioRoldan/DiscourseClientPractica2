import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    let id: Int
    let title: String
    let postsCount: Int
    let details: Detail
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case title = "title"
        case postsCount = "posts_count"
        case details = "details"
    }
}

/*
 Cuidado co el snake case de aquí, habría que haberlo pasado a CamelCase
 */
struct Detail : Codable {
    let can_delete: Bool?
}
