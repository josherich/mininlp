module Mininlp
  class WER
    @@INSERT_COST = 1.0
    @@DELETE_COST = 1.0
    @@SUBSTITUTE_COST = 1.0

    def self.calculate(first, second)
      return self.getDistance(first, second) / first.size
    end

    def self.getDistance(first, second)
      bestDistances = Array.new(first.size + 1) { Array.new(second.size + 1) }
      return _getDistance(first, second, 0, 0, bestDistances)
    end

    private

    def self._getDistance(first, second, firstPosition, secondPosition, bestDistances)
      if firstPosition > first.size or secondPosition > second.size
        return Float::INFINITY
      end
      if firstPosition == first.size and secondPosition == second.size
        return 0.0
      end
      if bestDistances[firstPosition][secondPosition] == nil
        distance = Float::INFINITY
        distance = [distance, 
          @@INSERT_COST + self._getDistance(first, second, firstPosition + 1, secondPosition, bestDistances),
          @@DELETE_COST + self._getDistance(first, second, firstPosition, secondPosition + 1, bestDistances),
          @@SUBSTITUTE_COST + self._getDistance(first, second, firstPosition + 1, secondPosition + 1, bestDistances)
        ].min

        if firstPosition < first.size and secondPosition < second.size
          if first[firstPosition] == second[secondPosition]
            distance = [distance, self._getDistance(first, second, firstPosition + 1, secondPosition + 1, bestDistances)].min
          end
        end
        bestDistances[firstPosition][secondPosition] = distance
      end
      return bestDistances[firstPosition][secondPosition]
    end
  end

end