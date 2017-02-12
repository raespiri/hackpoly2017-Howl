//
//  podParser.swift
//  podPopUp
//
//  Created by Ryan Espiritu and Leo Gould on 2/11/17.
//  Copyright © 2017 Ryan Espiritu. All rights reserved.
//

import Foundation

/**
 * WolframAlpha Pod Element
 */
struct Pod {
    var title = ""; // title of pod element
    var plaintext = ""; // plaintext of pod element
}

/**
 * podParser class, inherits from XMLParserDelegate
 */
class podParser: NSObject, XMLParserDelegate {
    
    var foundCharacters = ""
    var pod = Pod() // instantiate pod struct
    var pods = [Pod]() // list of pods
    var input = "" // input query string
    
    /**
     * Method to takes in user speech as input and properly replaces white spaces with +'s
     */
    init(input: String) {
        self.input = input
        self.input = self.input.replacingOccurrences(of: "+", with: " plus ")
        self.input = self.input.replacingOccurrences(of: "×", with: " times ")
        self.input = self.input.replacingOccurrences(of: "÷", with: " divided by ")
        self.input = self.input.replacingOccurrences(of: " ", with: "+")
    }
    
    /**
     * Method to begin parsing of XML File
     */
    func startParse() {
        let full_url = "http://api.wolframalpha.com/v2/query?input=" + self.input + "&appid=WG9JU4-2P288PAE5L"
        let url = NSURL(string:full_url)
        let parser = XMLParser(contentsOf: url as! URL)
        parser?.delegate = self
        parser?.parse()
    }
    
    /**
     * Method to find a pod element and grab its title attribute
     */
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        // Pod element is found, add title attribute to pod struct
        if elementName == "pod" {
            if let title = attributeDict["title"] {
                let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
                pod.title = trimmedTitle
            }
        }
    }
    
    /**
     * Method to find characters between XML tags
     */
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.foundCharacters += string;
    }
    
    /**
     * Method to find end of XML element and append value associated with that element
     */
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "plaintext" {
            let trimmedFoundCharacters = self.foundCharacters.trimmingCharacters(in: .whitespaces)
            self.pod.plaintext = trimmedFoundCharacters
            self.pods.append(self.pod)
        }
        self.foundCharacters = ""
    }
    
    /**
     * Method to print a pod element's title and its plaintext once the parser reaches the end
     * of document
     */
    func parserDidEndDocument(_ parser: XMLParser) {
        //temp
    }

    /**
     * Method to print a pod element's title and its associated image once the parser reaches the end
     * of document
     */
    func returnPods() -> [Pod] {
        return self.pods
    }
}


