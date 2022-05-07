//
//  Json4Swift_Base.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 05.05.2022.
//
// swiftlint: disable: type_name
// swiftlint: disable: colon
// swiftlint: disable: force_cast
import Foundation
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Json4Swift_Base {
    public var birth : Int?
    public var occupation : String?
    public var name : String?
    public var lastname : String?
    public var country : String?
    init(birth: Int, occupation: String, name: String, lastname: String, country: String) {
        self.birth = birth
        self.occupation = occupation
        self.name = name
        self.lastname = lastname
        self.country = country
    }

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Json4Swift_Base] {
        var models:[Json4Swift_Base] = []
        for item in array {
            models.append(Json4Swift_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
    required public init?(dictionary: NSDictionary) {

        birth = dictionary["birth"] as? Int
        occupation = dictionary["occupation"] as? String
        name = dictionary["name"] as? String
        lastname = dictionary["lastname"] as? String
        country = dictionary["country"] as? String
    }
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.birth, forKey: "birth")
        dictionary.setValue(self.occupation, forKey: "occupation")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.lastname, forKey: "lastname")
        dictionary.setValue(self.country, forKey: "country")

        return dictionary
    }
}
