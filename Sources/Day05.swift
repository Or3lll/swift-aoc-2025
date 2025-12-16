import Algorithms

struct KitchenData {

  var ranges: [ClosedRange<Int>]
  var ingredientIds: [Int]

}

struct Day05: AdventDay {

  var data: String

  // Splits input data into its component parts and convert from string.
  var kitchenData: KitchenData {
    let dataSplit = data.split(separator: "\n\n")
    let rangeLines = dataSplit[0].split(separator: "\n")
    let ingredientLines = dataSplit[1].split(separator: "\n")

    let ranges = rangeLines.map { line -> ClosedRange<Int> in
      let rangesParts = line.split(separator: "-")

      let start = Int(rangesParts[0])!
      let end = Int(rangesParts[1])!

      return start...end
    }

    let ingredientIds = ingredientLines.map { line -> Int in
      Int(line)!
    }

    return KitchenData(ranges: ranges, ingredientIds: ingredientIds)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var result = 0
    let kitchenData = self.kitchenData

    for ingredientId in kitchenData.ingredientIds {
      var isFresh = false

      for range in kitchenData.ranges {
        if range.contains(ingredientId) {
          isFresh = true
          break
        }
      }

      if isFresh {
        result += 1
      }
    }

    return "\(result)"
  }

  func part2() -> Any {
    let kitchenData = self.kitchenData

    var notContainedRanges = [ClosedRange<Int>]()
    for range in kitchenData.ranges {
      var isContained = false

      for otherRange in notContainedRanges {
        if otherRange.contains(range) {
          isContained = true
          break
        }
      }

      if !isContained {
        notContainedRanges.append(range)
      }
    }

    var mergedRanges = [ClosedRange<Int>]()
    for range in notContainedRanges.sorted(by: { $0.lowerBound < $1.lowerBound }) {
      mergedRanges = merge(range: range, mergedRanges: mergedRanges)
    }

    var count = 0
    for range in mergedRanges {
      count += range.count
    }

    return "\(count)"
  }

  func merge(range: ClosedRange<Int>, mergedRanges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
    var newMergedRanges = mergedRanges

    for (index, mergedRange) in mergedRanges.enumerated() {
      if range.overlaps(mergedRange) || range.lowerBound == mergedRange.upperBound + 1 || range.upperBound + 1 == mergedRange.lowerBound {
        let newRange = min(range.lowerBound, mergedRange.lowerBound)...max(range.upperBound, mergedRange.upperBound)
        newMergedRanges.remove(at: index)
        return merge(range: newRange, mergedRanges: newMergedRanges)
      }
    }

    newMergedRanges.append(range)
    return newMergedRanges
  }

}
