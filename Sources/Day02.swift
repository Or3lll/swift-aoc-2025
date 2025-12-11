import Algorithms

struct Day02: AdventDay {

  var data: String

  // Splits input data into its component parts and convert from string.
  var ranges: [ClosedRange<Int>] {
    return data.split(separator: ",")
        .map { (subsequence: String.SubSequence) -> ClosedRange<Int> in
          let rangesItems: [Int] = subsequence.split(separator: "-")
            .map { Int(String($0))! }
          
          return rangesItems[0]...rangesItems[1]
        }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var result = 0

    for range in ranges {
      for number in range {
        let strNumber = String(number) 

        guard strNumber.count % 2 == 0 else {
          continue
        }

        let splitSize = Int(strNumber.count / 2)
        let prefix = strNumber.prefix(splitSize)
        let suffix = strNumber.suffix(splitSize)

        if prefix == suffix {
          result += number
        }
      } 
    }

    return "\(result)"
  }

  func part2() -> Any {
    var result = 0

    for range in ranges {
      for number in range {
        let strNumber = String(number) 
        let splitSize = Int(strNumber.count / 2)

        guard splitSize > 0 else {
          continue
        }

        for subSplitSize in 1...splitSize {
          guard strNumber.count % subSplitSize == 0 else {
            continue
          }

          var subSplits = [String]()
          
          for index in stride(from: 0, to: strNumber.count, by: subSplitSize) {
            let startIndex = strNumber.index(strNumber.startIndex, offsetBy: index)
            let endIndex = strNumber.index(startIndex, offsetBy: subSplitSize)
            let substring = String(strNumber[startIndex..<endIndex])
            subSplits.append(substring)
          }

          if Set(subSplits).count == 1 {
            result += number
            break
          }
        }
      } 
    }

    return "\(result)"
  }

}
