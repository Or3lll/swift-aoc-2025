import Algorithms

struct Day03: AdventDay {

  var data: String

  // Splits input data into its component parts and convert from string.
  var banks: [String] {
    return data.split(separator: "\n")
        .map { (subsequence: String.SubSequence) -> String in
          String(subsequence) 
        }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var result = 0

    for bank in banks {
      var greater = -1
      var greaterIndex = bank.startIndex

      for (index, char) in bank.dropLast().enumerated() {
        if let digit = Int(String(char)), digit > greater {
          greater = digit
          greaterIndex = bank.index(bank.startIndex, offsetBy: index) 
        }
      }


      var secondGreater = -1
      for char in bank[bank.index(greaterIndex, offsetBy: 1)...] {
        if let digit = Int(String(char)), digit > secondGreater {
          secondGreater = digit
        }
      }

      result += (greater * 10) + secondGreater
    }

    return "\(result)"
  }

  func part2() -> Any {
    var result = 0

    for bank in banks {
      let digits = Array(bank).compactMap { Int(String($0)) }
      var joltage: [Int] = []
      var remaining = 12

      for index in digits.startIndex..<digits.endIndex {
       

        let digit = digits[index]

        let searchRange = index+1..<(digits.endIndex-remaining+1)
        if digits[searchRange].count(where: { nextDigit in nextDigit > digit }) == 0 {
          joltage.append(digit)
          remaining -= 1
        }

        if remaining == 0 {
          break
        }
      }

      result += Int(joltage.reduce("", { partialResult, Int in 
        partialResult + String(Int)
      }))!
    }

    return "\(result)"
  }

}
