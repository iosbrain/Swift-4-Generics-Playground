//: Swift 4 Generics Playground
//
//  Created by Andrew Jaffee on 01/01/2017.
//
/*
 
 Copyright (c) 2018 Andrew L. Jaffee, microIT Infrastructure, LLC, and
 iosbrain.com.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

import UIKit

/*! Swift function to tell us if a specific string exists in an array of strings. */
func existsManual(item:String, inArray:[String]) -> Bool
{
    var index:Int = 0
    var found = false
    
    while (index < inArray.count && found == false)
    {
        if item == inArray[index]
        {
            found = true
        }
        else
        {
            index = index + 1
        }
    }
    
    if found
    {
        return true
    }
    else
    {
        return false
    }
}

// Test "existsManual" function.

let strings = ["Ishmael", "Jacob", "Ezekiel"]

let nameExistsInArray = existsManual(item: "Ishmael", inArray: strings)
// returns true

let nameExistsInArray1 = existsManual(item: "Bubba", inArray: strings)
// returns false

/*! Generic Swift function to test if anything Equatable exists in an array. */
func exists<T: Equatable>(item:T, inArray:[T]) -> Bool
{
    var index:Int = 0
    var found = false
    
    while (index < inArray.count && found == false)
    {
        if item == inArray[index]
        {
            found = true
        }
        else
        {
            index = index + 1
        }
    }
    
    if found
    {
        return true
    }
    else
    {
        return false
    }
}

// Test generic function "exists."

let myFriends:[String] = ["John", "Dave", "Jim"]

let isOneOfMyFriends = exists(item: "Dave", inArray: myFriends)
// returns true

let isOneOfMyFriends1 = exists(item: "Laura", inArray: myFriends)
// returns false

let myNumbers:[Int] = [1,2,3,4,5,6]

let isOneOfMyNumbers = exists(item: 3, inArray: myNumbers)
// returns true

let isOneOfMyNumbers1 = exists(item: 0, inArray: myNumbers)
// returns false

let myNumbersFloat:[Float] = [1.0,2.0,3.0,4.0,5.0,6.0,]

let isOneOfMyFloatNumbers = exists(item: 3.0000, inArray: myNumbersFloat)
// returns true

/*! Generic Swift function to find index of anything Equatable in an array. */
func find<T: Equatable>(item:T, inArray:[T]) -> Int?
{
    var index:Int = 0
    var found = false
    
    while (index < inArray.count && found == false)
    {
        if item == inArray[index]
        {
            found = true
        }
        else
        {
            index = index + 1
        }
    }
    
    if found
    {
        return index
    }
    else
    {
        return nil
    }
}

// Test generic function "find."

let myFriends1:[String] = ["John", "Dave", "Jim", "Arthur", "Lancelot"]

let findIndexOfFriend = find(item: "John", inArray: myFriends1)
// returns 0

let findIndexOfFriend1 = find(item: "Arthur", inArray: myFriends1)
// returns 3

let findIndexOfFriend2 = find(item: "Guinevere", inArray: myFriends1)
// returns nil

/*! Simple class to test with generics (and it doesn't work with generics) Why? */
class BasicPerson
{
    var name:String
    var weight:Int
    var sex:String
    
    init(weight:Int, name:String, sex:String)
    {
        self.name = name
        self.weight = weight
        self.sex = sex
    }
}

// Test "BasicPerson" class.

let Jim = BasicPerson(weight: 180, name: "Jim Patterson", sex: "M")
let Sam = BasicPerson(weight: 120, name: "Sam Patterson", sex: "F")
let Sara = BasicPerson(weight: 115, name: "Sara Lewis", sex: "F")

let basicPersons = [Jim, Sam, Sara]

// Un-comment the next line to see why "exists" throws the following error:
// "error: in argument type '[BasicPerson]', 'BasicPerson' does not conform to expected type 'Equatable'"
//
// let isSamABasicPerson = exists(item: Sam, inArray: basicPersons)

let basicPeople:[BasicPerson] = [Jim, Sam, Sara]

// Crazy closure you'd have to write every time you called "contains" on "BasicPerson" class.
let isBasicPerson = basicPeople.contains { (Sam) -> Bool in
    var found = false
    for person in basicPeople
    {
        if person.name == Sam.name
        {
            found = true
        }
    }
    return found
}

/*! Version of "BasicPerson" class that conforms to Equatable protocol and overrides == operator. */
class Person : Equatable
{
    var name:String
    var weight:Int
    var sex:String
    
    init(weight:Int, name:String, sex:String)
    {
        self.name = name
        self.weight = weight
        self.sex = sex
    }
    
    // Teaser: Why does an operator overload have to be declared "static?"
    static func == (lhs: Person, rhs: Person) -> Bool
    {
        if lhs.weight == rhs.weight &&
            lhs.name == rhs.name &&
            lhs.sex == rhs.sex
        {
            return true
        }
        else
        {
            return false
        }
    }
}

// Testing "Person" class with generics.

let Joe = Person(weight: 180, name: "Joe Patterson", sex: "M")
let Pam = Person(weight: 120, name: "Pam Patterson", sex: "F")
let Sue = Person(weight: 115, name: "Sue Lewis", sex: "F")
let Jeb = Person(weight: 180, name: "Jeb Patterson", sex: "M")
let Bob = Person(weight: 200, name: "Bob Smith", sex: "M")

let myPeople:Array = [Joe, Pam, Sue, Jeb]

let indexOfOneOfMyPeople = find(item: Jeb, inArray: myPeople)
// returns 3 from custom generic function

let indexOfOneOfMyPeople1 = myPeople.index(of: Jeb)
// returns 3 from built-in Swift member function

let isSueOneOfMyPeople = exists(item: Sue, inArray: myPeople)
// returns true from custom generic function

let isSueOneOfMyPeople1 = myPeople.contains(Sue)
// returns true from built-in Swift member function

let indexOfBob = find(item: Bob, inArray: myPeople)
// returns nil from custom generic function

let indexOfBob1 = myPeople.index(of: Bob)
// returns nil from built-in Swift member function

let isBobOneOfMyPeople1 = exists(item: Bob, inArray: myPeople)
// returns false from custom generic function

let isBobOneOfMyPeople2 = myPeople.contains(Bob)
// returns false from built-in Swift member function

if Joe == Pam
{
    print("they're equal")
}
else
{
    print("they're not equal")
}
// returns "they're not equal"

// Notice the compiler warns us that this statement is always true.
// Why do you think it does that?
let isPerson = Sue is Person



