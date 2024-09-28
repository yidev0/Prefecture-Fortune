//
//  FortuneResponse.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

struct FortuneResponse: Codable {
    let name: String
    let capital: String
    let citizenDay: MonthDay?
    let hasCoastLine: Bool
    let logoUrl: String
    let brief: String
}

extension FortuneResponse {
    static let sample: Self = .init(
        name: "富山県",
        capital: "富山市",
        citizenDay: .init(
            month: 5,
            day: 9
        ),
        hasCoastLine: true,
        logoUrl: "https://japan-map.com/wp-content/uploads/toyama.png",
        brief: "富山県（とやまけん）は、日本の中部地方に位置する県。県庁所在地は富山市。\n中部地方の日本海側、新潟県を含めた場合の北陸地方のほぼ中央にある。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』,"
    )
}
