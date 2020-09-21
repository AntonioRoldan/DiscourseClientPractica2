import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    let latestPosters: [latestPoster]
    let topicList: TopicList?
    enum CodingKeys : String, CodingKey {
        case topicList = "topic_list"
        case latestPosters = "users"
    }
}

struct TopicList: Codable {
    let topics: [Topic]?
}

struct Topic: Codable {
    let id: Int
    let title: String
    let postsCount: Int
    let lastPosterUserName: String
    let lastPostedAt: String
    let posters: [Poster]
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case title = "title"
        case postsCount = "posts_count"
        case lastPosterUserName = "last_poster_username"
        case lastPostedAt = "last_posted_at"
        case posters = "posters"
    }
}

struct Poster: Codable {
    let userId: Int
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}


struct latestPoster: Codable {
    let userName: String
    let avatarLink: String
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case avatarLink = "avatar_template"
    }
}
