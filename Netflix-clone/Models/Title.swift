//
//  Movie.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 23/08/22.
//

import Foundation

struct TrendingTitleResponse:Codable{
    let results:[Title]
}

struct Title:Codable{
    let id:Int
    let media_type:String?
    let original_name:String?
    let original_title:String?
    let poster_path:String?
    let overview:String?
    let vote_count:Int?
    let release_date:String?
    let vote_average:Double?
}

/*
 adult = 0;
 "backdrop_path" = "/Aa9TLpNpBMyRkD8sPJ7ACKLjt0l.jpg";
 "first_air_date" = "2022-08-21";
 "genre_ids" =             (
     18,
     10759,
     10765
 );
 id = 94997;
 "media_type" = tv;
 name = "House of the Dragon";
 "origin_country" =             (
     US
 );
 "original_language" = en;
 "original_name" = "House of the Dragon";
 overview = "The prequel series finds the Targaryen dynasty at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires\U2014real and imagined\U2014crumble from such heights. In the case of the Targaryens, their slow fall begins almost 193 years before the events of Game of Thrones, when King Viserys Targaryen breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.";
 popularity = "1825.249";
 "poster_path" = "/z2yahl2uefxDCl0nogcRBstwruJ.jpg";
 "vote_average" = "8.939";
 "vote_count" = 280;
 */
