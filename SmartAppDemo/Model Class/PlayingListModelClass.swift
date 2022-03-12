//
//  PlayingListModelClass.swift
//  SmartAppDemo
//
//  Created by Apple on 13/02/22.
//

import Foundation
class PlayingListModelClass : Codable
{
    let page : Int?
    let results : [PlayingList]
    let total_pages : Int?
    let total_results : Int?
}

class PlayingList : Codable
{
    var title: String?
    var original_language : String?
    var release_date:String?
    var vote_average : Double?
    var original_title:String?
    var poster_path:String?
    var vote_count:Int?
    var overview:String?
    var adult:Bool?
    var id:Int?
    var backdrop_path : String?
    var popularity : Float?
    var video:Bool?
   
}
