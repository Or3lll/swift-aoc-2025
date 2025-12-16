import Algorithms

struct Day04: AdventDay {

  var data: String

  // Splits input data into its component parts and convert from string.
  var availableRolls: [[Int]] {
    return data.split(separator: "\n")
        .map { (subsequence: String.SubSequence) -> [Int] in
          var lineAvailableRolls: [Int] = []
          for char in subsequence {
            if char == "@" {
              lineAvailableRolls.append(1)
            } else {
              lineAvailableRolls.append(0)
            }
          }
          return lineAvailableRolls
        }
  }

  var lineLength: Int {
    return data.split(separator: "\n").first?.count ?? 0
  }

  var lineCount: Int {
    return data.split(separator: "\n").count
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var result = 0
    let availableRolls = self.availableRolls
    let lineCount = self.lineCount
    let lineLength = self.lineLength

    for (lineIndex, line) in availableRolls.enumerated() {
      for (index, _) in line.enumerated() {
        if availableRolls[lineIndex][index] == 0 {
          continue
        }

        var neighbors = 0

        if lineIndex > 0 {
          if index > 0 {
            neighbors += availableRolls[lineIndex-1][index-1]
          }

          neighbors += availableRolls[lineIndex-1][index]

          if index < lineLength - 1 {
            neighbors += availableRolls[lineIndex-1][index+1]
          }
        }

        if index > 0 {
          neighbors += availableRolls[lineIndex][index-1]
        }

        if index < lineLength - 1 {
          neighbors += availableRolls[lineIndex][index+1]
        }

        if lineIndex < lineCount - 1 {
          if index > 0 {
            neighbors += availableRolls[lineIndex+1][index-1]
          }

          neighbors += availableRolls[lineIndex+1][index]

          if index < lineLength - 1 {
            neighbors += availableRolls[lineIndex+1][index+1]
          }
        }

        if neighbors < 4 {
          result += 1
        }
      }
    }

    return "\(result)"
  }

  func part2() -> Any {
    var result = 0

    var availableRolls = self.availableRolls
    let lineCount = self.lineCount
    let lineLength = self.lineLength

    var nextAvailableRolls = [[Int]]()

    var currentCount = 0
    var previousCount = -1

    while currentCount != previousCount {
      previousCount = currentCount
      currentCount = 0

      for (lineIndex, line) in availableRolls.enumerated() {
        var nextLine = [Int]()
        for (index, _) in line.enumerated() {
          if availableRolls[lineIndex][index] == 0 {
            nextLine.append(0)
            continue
          }

          var neighbors = 0

          if lineIndex > 0 {
            if index > 0 {
              neighbors += availableRolls[lineIndex-1][index-1]
            }

            neighbors += availableRolls[lineIndex-1][index]

            if index < lineLength - 1 {
              neighbors += availableRolls[lineIndex-1][index+1]
            }
          }

          if index > 0 {
            neighbors += availableRolls[lineIndex][index-1]
          }

          if index < lineLength - 1 {
            neighbors += availableRolls[lineIndex][index+1]
          }

          if lineIndex < lineCount - 1 {
            if index > 0 {
              neighbors += availableRolls[lineIndex+1][index-1]
            }

            neighbors += availableRolls[lineIndex+1][index]

            if index < lineLength - 1 {
              neighbors += availableRolls[lineIndex+1][index+1]
            }
          }

          if neighbors < 4 {
            result += 1
            nextLine.append(0)
          } else {
            currentCount += 1
            nextLine.append(1)
          }
        }

        nextAvailableRolls.append(nextLine)
      }

      availableRolls = nextAvailableRolls
      nextAvailableRolls = [[Int]]()
    }

    return "\(result)"
  }

}
