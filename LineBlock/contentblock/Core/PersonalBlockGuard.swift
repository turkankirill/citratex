

import Foundation

class PersonalBlockGuard {
    
    static func getBlockersList() -> [Blocker] {
        customBlockersList
    }
}

private extension PersonalBlockGuard {
    static var customBlockersList: [Blocker] {
        get { [
            Blocker(
                triggers: [],
                state: false,
                title: "AdBlocker"
            ),
            Blocker(
                triggers: [BlockerTrigger(
                    action: Action(
                        type: .block,
                        selector: nil),
                    trigger: Trigger(
                        urlFilter: ".*",
                        loadType: [.thirdParty, .firstParty],
                        ifDomain: nil,
                        resourceType: [.script]))],
                state: false,
                title: "Block Scripts"
            ),
            Blocker(
                triggers: makeTriggers(with: pornKeywords),
                state: false,
                title: "Block Adult Sites"
            )
        ] }
    }
    
    static func makeTriggers(with keywords: [String], _ type: BlockerType = .block) -> [BlockerTrigger] {
        guard !keywords.isEmpty else { return [] }
        return  keywords.map {
            BlockerTrigger(
                action: Action(
                    type: type,
                    selector: nil),
                trigger: Trigger(
                    urlFilter: ".*\($0).*",
                    loadType: nil,
                    ifDomain: nil,
                    resourceType: nil))
        }
    }
    
    static let pornKeywords: [String] = [
        "pornhd8k", "fullxxxmovies", "netfapx", "waxtube", "pornrewind", "collectionofporn", "hd-easyporn",
        "thottok", "vporn", "eporner", "4tube", "porntrex", "fansleaks", "haporner", "perfectgirls", "pornhd",
        "xmoviesforyou", "letsierk", "tXXX", "cumlouder", "porn300", "likuoo", "pornktube", "porndish",
        "pornobae", "pornky", "freeomovie", "xtapes", "palimas", "pornbraze", "fux", "tubxporn", "xxVideoss",
        "motherless", "porntube", "yespornplease", "onlyfaps", "yourporn", "cliphunter",
        "3movs", "slutload", "realpornclip", "luxuretv﻿﻿﻿", "porndig", "theleakbay", "daftsex", "tnaflix",
        "porn", "pornhub", "xxx", "xvideos", "xhamster", "redtube", "youporn", "spankbang", "beeg", "youjizz",
        "onlyfaps", "youporn", "spankbang", "beeg", "youjizz", "hotscope", "tube8", "fapopedia", "fansteck",
        "drtuber", "hotgirlclub", "empflix", "porn00", "taxi69", "porn4days", "pussyspace", "anyporn",
        "hotscope", "tube8", "fapopedia", "fansteck", "motherless", "porntube", "thotleaks", "yespornplease",
        "ultrahorny", "laidhub", "xfantasy", "yeapornpis", "justswallows", "fuckamouth", "pornxbit",
        "pervertslut", "youngpornvideos", "yourdailypornvideos", "streamporn", "streamingporn", "sweext",
        "anysex", "pandamovies", "gotporn", "vidz7", "porndoe", "vrporn", "pornovideoshub", "watchxxxfree"
    ]
}
