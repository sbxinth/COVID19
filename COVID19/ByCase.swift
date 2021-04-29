// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let byCase = try? newJSONDecoder().decode(ByCase.self, from: jsonData)

import Foundation

// MARK: - ByCase
struct ByCase: Codable {
    let data: [Datum2]
    let lastData, updateDate: String
    let source, devBy, severBy: String

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case lastData = "LastData"
        case updateDate = "UpdateDate"
        case source = "Source"
        case devBy = "DevBy"
        case severBy = "SeverBy"
    }
}

// MARK: - Datum
struct Datum2: Codable {
    let confirmDate: String
    let no: String?
    let age: Double?
    let gender: Gender
    let genderEn: GenderEn
    let nation: Nation
    let nationEn: Nation?
    let province: Province
    let provinceID: Int
    let district: String
    let provinceEn: ProvinceEn
    let detail: JSONNull?
    let statQuarantine: Int

    enum CodingKeys: String, CodingKey {
        case confirmDate = "ConfirmDate"
        case no = "No"
        case age = "Age"
        case gender = "Gender"
        case genderEn = "GenderEn"
        case nation = "Nation"
        case nationEn = "NationEn"
        case province = "Province"
        case provinceID = "ProvinceId"
        case district = "District"
        case provinceEn = "ProvinceEn"
        case detail = "Detail"
        case statQuarantine = "StatQuarantine"
    }
}

enum Gender: String, Codable {
    case ชาย = "ชาย"
    case หญง = "หญิง"
    case ไมระบเพศ = "ไม่ระบุเพศ"
}

enum GenderEn: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "Unknown"
}

enum Nation: String, Codable {
    case afghanistan = "Afghanistan"
    case albania = "Albania"
    case american = "American"
    case argentina = "Argentina"
    case australia = "Australia"
    case azerbaijan = "Azerbaijan"
    case bahrain = "Bahrain"
    case bangladesh = "Bangladesh"
    case belarus = "Belarus"
    case belgium = "Belgium"
    case brazil = "Brazil"
    case british = "British"
    case bulgaria = "Bulgaria"
    case burma = "Burma"
    case burmese = "Burmese"
    case cambodia = "Cambodia"
    case cameroon = "Cameroon"
    case canada = "Canada"
    case china = "China"
    case colombia = "Colombia"
    case croatia = "Croatia"
    case czechia = "Czechia"
    case denmark = "Denmark"
    case deutsch = "deutsch"
    case egypt = "Egypt"
    case eritrea = "Eritrea"
    case estonia = "Estonia"
    case ethiopia = "Ethiopia"
    case finland = "Finland"
    case france = "France"
    case germany = "Germany"
    case greece = "Greece"
    case hongKong = "HongKong"
    case hungary = "Hungary"
    case india = "India"
    case indiaThailand = "India-Thailand"
    case indonesia = "Indonesia"
    case iran = "Iran"
    case ireland = "Ireland"
    case israel = "Israel"
    case italian = "Italian"
    case italy = "Italy"
    case japan = "Japan"
    case jordan = "Jordan"
    case kazakhstan = "Kazakhstan"
    case kazakhstani = "Kazakhstani"
    case kenya = "Kenya"
    case koreaSouth = "Korea,South"
    case kuwait = "Kuwait"
    case laos = "Laos"
    case laotian = "Laotian"
    case liberia = "Liberia"
    case libya = "Libya"
    case lithuania = "Lithuania"
    case macedonia = "Macedonia"
    case malaysia = "Malaysia"
    case maldives = "Maldives"
    case mali = "Mali"
    case mexico = "Mexico"
    case nationSpain = "Spain"
    case nepal = "Nepal"
    case netherlands = "Netherlands"
    case newZealand = "NewZealand"
    case nigeria = "Nigeria"
    case norway = "Norway"
    case oman = "Oman"
    case pakistan = "Pakistan"
    case palestine = "Palestine"
    case philippines = "Philippines"
    case portugal = "Portugal"
    case portuguese = "Portuguese"
    case qatar = "Qatar"
    case romania = "Romania"
    case russia = "Russia"
    case serbia = "Serbia"
    case singapore = "Singapore"
    case slovenia = "Slovenia"
    case somalia = "Somalia"
    case spain = "spain"
    case sudan = "Sudan"
    case sweden = "Sweden"
    case swiss = "Swiss"
    case switzerland = "Switzerland"
    case syria = "Syria"
    case taiwan = "Taiwan"
    case thailand = "Thailand"
    case tunisia = "Tunisia"
    case turkey = "Turkey"
    case uganda = "Uganda"
    case ukraine = "Ukraine"
    case unitedArabEmirates = "UnitedArabEmirates"
    case unitedKingdom = "UnitedKingdom"
    case unitedStatesofAmerica = "UnitedStatesofAmerica"
    case unknown = "Unknown"
    case uzbekistan = "Uzbekistan"
    case vietnam = "Vietnam"
    case yemen = "Yemen"
    case ตางดาว = "ต่างด้าว"
    case สหราชอาณาจกร = "สหราชอาณาจักร"
    case ไทยใหญ = "ไทยใหญ่"
    case ไทใหญ = "ไทใหญ่"
    case ไมทราบ = "ไม่ทราบ"
}

enum Province: String, Codable {
    case กรงเทพมหานคร = "กรุงเทพมหานคร"
    case กระบ = "กระบี่"
    case กาญจนบร = "กาญจนบุรี"
    case กาฬสนธ = "กาฬสินธุ์"
    case กำแพงเพชร = "กำแพงเพชร"
    case ขอนแกน = "ขอนแก่น"
    case จนทบร = "จันทบุรี"
    case ฉะเชงเทรา = "ฉะเชิงเทรา"
    case ชมพร = "ชุมพร"
    case ชยนาท = "ชัยนาท"
    case ชยภม = "ชัยภูมิ"
    case ชลบร = "ชลบุรี"
    case ตรง = "ตรัง"
    case ตราด = "ตราด"
    case ตาก = "ตาก"
    case นครนายก = "นครนายก"
    case นครปฐม = "นครปฐม"
    case นครพนม = "นครพนม"
    case นครราชสมา = "นครราชสีมา"
    case นครศรธรรมราช = "นครศรีธรรมราช"
    case นครสวรรค = "นครสวรรค์"
    case นนทบร = "นนทบุรี"
    case นราธวาส = "นราธิวาส"
    case นาน = "น่าน"
    case บรรมย = "บุรีรัมย์"
    case ปตตาน = "ปัตตานี"
    case ปทมธาน = "ปทุมธานี"
    case ประจวบครขนธ = "ประจวบคีรีขันธ์"
    case ปราจนบร = "ปราจีนบุรี"
    case พงงา = "พังงา"
    case พจตร = "พิจิตร"
    case พทลง = "พัทลุง"
    case พระนครศรอยธยา = "พระนครศรีอยุธยา"
    case พษณโลก = "พิษณุโลก"
    case พะเยา = "พะเยา"
    case ภเกต = "ภูเก็ต"
    case มกดาหาร = "มุกดาหาร"
    case มหาสารคาม = "มหาสารคาม"
    case ยะลา = "ยะลา"
    case ยโสธร = "ยโสธร"
    case รอยเอด = "ร้อยเอ็ด"
    case ระนอง = "ระนอง"
    case ระยอง = "ระยอง"
    case ราชบร = "ราชบุรี"
    case ลพบร = "ลพบุรี"
    case ลำปาง = "ลำปาง"
    case ลำพน = "ลำพูน"
    case ศรสะเกษ = "ศรีสะเกษ"
    case สกลนคร = "สกลนคร"
    case สงขลา = "สงขลา"
    case สงหบร = "สิงห์บุรี"
    case สตล = "สตูล"
    case สพรรณบร = "สุพรรณบุรี"
    case สมทรปราการ = "สมุทรปราการ"
    case สมทรสงคราม = "สมุทรสงคราม"
    case สมทรสาคร = "สมุทรสาคร"
    case สรนทร = "สุรินทร์"
    case สระบร = "สระบุรี"
    case สระแกว = "สระแก้ว"
    case สราษฎรธาน = "สุราษฎร์ธานี"
    case สโขทย = "สุโขทัย"
    case หนองคาย = "หนองคาย"
    case หนองบวลำภ = "หนองบัวลำภู"
    case อดรธาน = "อุดรธานี"
    case อตรดตถ = "อุตรดิตถ์"
    case อทยธาน = "อุทัยธานี"
    case อบลราชธาน = "อุบลราชธานี"
    case อางทอง = "อ่างทอง"
    case อำนาจเจรญ = "อำนาจเจริญ"
    case เชยงราย = "เชียงราย"
    case เชยงใหม = "เชียงใหม่"
    case เพชรบร = "เพชรบุรี"
    case เพชรบรณ = "เพชรบูรณ์"
    case เลย = "เลย"
    case แพร = "แพร่"
    case แมฮองสอน = "แม่ฮ่องสอน"
    case ไมพบขอมล = "ไม่พบข้อมูล"
}

enum ProvinceEn: String, Codable {
    case amnatCharoen = "Amnat Charoen"
    case angThong = "Ang Thong"
    case bangkok = "Bangkok"
    case buriram = "Buriram"
    case chachoengsao = "Chachoengsao"
    case chainat = "Chainat"
    case chaiyaphum = "Chaiyaphum"
    case chanthaburi = "Chanthaburi"
    case chiangMai = "Chiang Mai"
    case chiangRai = "Chiang Rai"
    case chonburi = "Chonburi"
    case chumphon = "Chumphon"
    case kalasin = "Kalasin"
    case kamphaengPhet = "Kamphaeng Phet"
    case kanchanaburi = "Kanchanaburi"
    case khonKaen = "Khon Kaen"
    case krabi = "Krabi"
    case lampang = "Lampang"
    case lamphun = "Lamphun"
    case loei = "Loei"
    case lopburi = "Lopburi"
    case maeHongSon = "Mae Hong Son"
    case mahaSarakham = "Maha Sarakham"
    case mukdahan = "Mukdahan"
    case nakhonNayok = "Nakhon Nayok"
    case nakhonPathom = "Nakhon Pathom"
    case nakhonPhanom = "Nakhon Phanom"
    case nakhonRatchasima = "Nakhon Ratchasima"
    case nakhonSawan = "Nakhon Sawan"
    case nakhonSiThammarat = "Nakhon Si Thammarat"
    case nan = "Nan"
    case narathiwat = "Narathiwat"
    case nongBuaLamphu = "Nong Bua Lamphu"
    case nongKhai = "Nong Khai"
    case nonthaburi = "Nonthaburi"
    case pathumThani = "Pathum Thani"
    case pattani = "Pattani"
    case phangNga = "Phang Nga"
    case phatthalung = "Phatthalung"
    case phayao = "Phayao"
    case phetchabun = "Phetchabun"
    case phetchaburi = "Phetchaburi"
    case phichit = "Phichit"
    case phitsanulok = "Phitsanulok"
    case phraNakhonSiAyutthaya = "Phra Nakhon Si Ayutthaya"
    case phrae = "Phrae"
    case phuket = "Phuket"
    case prachinburi = "Prachinburi"
    case prachuapKhiriKhan = "Prachuap Khiri Khan"
    case ranong = "Ranong"
    case ratchaburi = "Ratchaburi"
    case rayong = "Rayong"
    case roiEt = "Roi Et"
    case saKaeo = "Sa Kaeo"
    case sakonNakhon = "Sakon Nakhon"
    case samutPrakan = "Samut Prakan"
    case samutSakhon = "Samut Sakhon"
    case samutSongkhram = "Samut Songkhram"
    case saraburi = "Saraburi"
    case satun = "Satun"
    case singBuri = "Sing Buri"
    case sisaket = "Sisaket"
    case songkhla = "Songkhla"
    case sukhothai = "Sukhothai"
    case suphanBuri = "Suphan Buri"
    case suratThani = "Surat Thani"
    case surin = "Surin"
    case tak = "Tak"
    case trang = "Trang"
    case trat = "Trat"
    case ubonRatchathani = "Ubon Ratchathani"
    case udonThani = "Udon Thani"
    case unknown = "Unknown"
    case uthaiThani = "Uthai Thani"
    case uttaradit = "Uttaradit"
    case yala = "Yala"
    case yasothon = "Yasothon"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
