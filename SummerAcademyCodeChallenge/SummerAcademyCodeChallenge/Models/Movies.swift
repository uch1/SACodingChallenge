//
//  Movies.swift
//  SummerAcademyCodeChallenge
//
//  Created by Uchenna  Aguocha on 5/27/18.
//  Copyright © 2018 Uchenna  Aguocha. All rights reserved.
//

import Foundation

//    let title: String
//    let poster: String
//    let releaseDate: String
//    let summary: String
//    let price: String


//  Create an intermediate model that closely matches the JSON

struct iTunes: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let entry: [Entry]
}

struct Poster: Decodable{
    let label: String
}

struct Link: Decodable {
    let attributes: [String: String]
}

struct Entry: Decodable {
    // MARK: Properties
    let title: String
    let poster: String
    let releaseDate: String
    let summary: String
    let price: String
    let link: String
    
    // Top-level Entry Keys
    enum EntryKeys: String, CodingKey {
        case title = "im:name"
        case poster = "im:image"
        case releaseDate = "im:releaseDate"
        case summary
        case price = "im:price"
        case link
        
        /* Representation of the nested json containers */
        enum TitleKey: String, CodingKey {
            case label
        }
        
        enum PosterKey: String, CodingKey {
            case label
        }
        
        enum ReleaseDateKey: String, CodingKey {
            case attributes
            /* Nested */
            enum AttributesKey: String, CodingKey {
                case label
            }
        }
        
        enum SummaryKey: String, CodingKey {
            case label
        }
        
        enum PriceKey: String, CodingKey {
            case label
        }
        
        enum LinkKey: String, CodingKey {
            case attributes
            enum AttributesKey: String, CodingKey {
                case href 
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        // Main Container
        let entryContainer = try decoder.container(keyedBy: EntryKeys.self)
        
        // Nested Title Container
        let titleContainer = try entryContainer.nestedContainer(keyedBy: EntryKeys.TitleKey.self , forKey: .title)
        title = try titleContainer.decode(String.self, forKey: .label)
        
        // Nested Poster (Image) Container
//        let posterContainer = try entryContainer.nestedContainer(keyedBy: EntryKeys.PosterKey.self, forKey: .poster)
        
        let posters = try entryContainer.decode([Poster].self, forKey: .poster)
        poster = (posters.last?.label)!
        
        // Nested Release Date & Attributes Container
        let releaseDateContainer = try entryContainer.nestedContainer(keyedBy: EntryKeys.ReleaseDateKey.self, forKey: .releaseDate)
        let attributesContainer = try releaseDateContainer.nestedContainer(keyedBy: EntryKeys.ReleaseDateKey.AttributesKey.self, forKey: .attributes)
        releaseDate = try attributesContainer.decode(String.self, forKey: .label)
        
        // Nested Summary Container
        let summaryContainer = try entryContainer.nestedContainer(keyedBy: EntryKeys.SummaryKey.self, forKey: .summary)
        summary = try summaryContainer.decode(String.self, forKey: .label)
        
        // Nested Price Container
        let priceContainer = try entryContainer.nestedContainer(keyedBy: EntryKeys.PriceKey.self, forKey: .price)
        price = try priceContainer.decode(String.self, forKey: .label)
        
        // Nested Link Container
//        let linkContainer = try entryContainer.nestedContainer(keyedBy: EntryKeys.LinkKey.self, forKey: .link)
//        let linkAttributesContainer = try linkContainer.nestedContainer(keyedBy: EntryKeys.LinkKey.AttributesKey.self, forKey: .attributes)
        let links = try entryContainer.decode([Link].self, forKey: .link)
        link = (links.first?.attributes["href"])!
        
    }
}

//extension Entry: Decodable {
//    init(from decoder: Decoder) throws {
//
//    }
//}





//struct Feed: Decodable {
//    var entry: [Entry]
//}
//
//// ** Entry/Movie
//struct Entry {
//    // MARK: Properties
//    let title: String
//    let poster: String
//    let releaseDate: String
//    let summary: String
//    let price: String
//}
//
//extension Entry: Decodable {
//
//    // MARK: CodingKeys
//    enum EntryKeys: String, CodingKey {
//        case title
//        case poster = "im:image"
//        case releaseDate = "im:releaseDate"
//        case summary
//        case price = "im:price"
//    }
//
//    // MARK: Nested CodingKeys
//    enum TitleKey: String, CodingKey {
//        case label
//    }
//
//    enum PosterKey: String, CodingKey {
//        case label
//    }
//
//    enum ReleaseDateKey: String, CodingKey {
//        case attributes
//
//        enum AttributesKey: String, CodingKey {
//            case label
//        }
//    }
//
//    enum SummaryKey: String, CodingKey {
//        case label
//    }
//
//    enum PriceKey: String, CodingKey {
//        case label
//    }
//
//    // Decoding
//    init(from decoder: Decoder) throws {
//        /* Entry */
//        let entryContainer = try decoder.container(keyedBy: EntryKeys.self)
//
//        /* Title */
//        let titleContainer = try entryContainer.nestedContainer(keyedBy: TitleKey.self, forKey: .title)
//        let title = try titleContainer.decodeIfPresent(String.self, forKey: .label) ?? "Title of Movie doesn't exist"
//
//        /* Poster */
//        let posterContainer = try entryContainer.nestedContainer(keyedBy: PosterKey.self, forKey: .poster)
//        let posters = try posterContainer.decodeIfPresent([String].self, forKey: .label)
//        let poster = posters?.last ?? "Image Doesn't exist"
//
//        /* Release Date */
//        let releaseDateContainer = try entryContainer.nestedContainer(keyedBy: ReleaseDateKey.self, forKey: .releaseDate)
//        let attributesContainer = try releaseDateContainer.nestedContainer(keyedBy: ReleaseDateKey.AttributesKey.self, forKey: .attributes)
//        let attributes = try attributesContainer.decodeIfPresent(String.self, forKey: .label) ?? "No Release Date"
//
//        /* Summary */
//        let summaryContainer = try entryContainer.nestedContainer(keyedBy: SummaryKey.self, forKey: .summary)
//        let summary = try summaryContainer.decodeIfPresent(String.self, forKey: .label) ?? "Summary of the movie doesn't exist."
//
//        /* Price */
//        let priceContainer = try entryContainer.nestedContainer(keyedBy: PriceKey.self, forKey: .price)
//        let price = try priceContainer.decodeIfPresent(String.self, forKey: .label) ?? "No price available"
//
//        self.init(title: title, poster: poster, releaseDate: attributes, summary: summary, price: price)
//
//    }
//}




//struct Feed: Decodable {
//
//    var entry: [Entry]
//
//    // Entry/Movie
//    struct Entry: Decodable {
//
//        // MARK: Entry/Movie Properties
//        var title: Title
//        var poster: Poster
//        var releaseDate: ReleaseDate
//        var summary: Summary
//        var price: Price
//
//        // Modeling 'entry' objects
//        struct Title: Decodable {
//            var label: String
//        }
//        struct Poster: Decodable {
//            var label: String
//        }
//        struct ReleaseDate: Decodable {
//            var label: String
//        }
//        struct Summary: Decodable {
//            var label: String
//        }
//        struct Price: Decodable {
//            var label: String
//        }
//
//        enum EntryKeys: String, CodingKey {
//            case title
//            case poster = "im:image"
//            case releaseDate = "im:releaseDate"
//            case summary
//            case price = "im:price"
//            case label // I need this data
//        }
//
//
//
//    }
//
//    // MARK: Feed Properties
//
//
//    enum FeedKeys: String, CodingKey {
//        case entry
//    }
//
//}






