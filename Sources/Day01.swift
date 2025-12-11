import Algorithms

enum Direction: String {

  case left = "L"
  case right = "R"

}

struct Instruction {
  
  var direction: Direction
  var distance: Int

}

struct Day01: AdventDay {

  var data: String

  // Splits input data into its component parts and convert from string.
  var instructions: [Instruction] {
    data.split(separator: "\n")
        .map { (subsequence: String.SubSequence) -> String in
          String(subsequence) 
        }
        .filter { (strInstruction: String) -> Bool in
          strInstruction.count > 1 
        }
      .compactMap { (strInstruction: String) -> Instruction? in
        if let direction = Direction(rawValue: String(strInstruction.prefix(1))),
          let distance = Int(String(strInstruction.dropFirst(1))) {
          return Instruction(direction: direction, distance: distance)
        } else {
          return nil
        }
      }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var position = 50
    var count = 0

    instructions.forEach { instruction in
      if instruction.direction == .left {
        position -= instruction.distance
      } else {
        position += instruction.distance
      }

      if position % 100 == 0 {
        count += 1
      }
    }

    return "\(count)"
  }

  func part2() -> Any {
    var position = 50
    var count = 0

    instructions.forEach { instruction in
      count += Int(instruction.distance / 100)

      let remaining = instruction.distance % 100
      let remainingPosition = position % 100

      if (position % 100 != 0) {
        if remainingPosition >= 0 {
          if instruction.direction == .right && remainingPosition + remaining >= 100 {
            count += 1
          } else if instruction.direction == .left && remainingPosition - remaining <= 0 {
            count += 1
          }
        } else {
          if instruction.direction == .right && remainingPosition + remaining >= 0 {
            count += 1
          } else if instruction.direction == .left && remainingPosition - remaining <= -100 {
            count += 1
          }
        }
      }

      if instruction.direction == .left {
        position -= instruction.distance
      } else {
        position += instruction.distance
      }
    }

    return "\(count)"
  }

}
