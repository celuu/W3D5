require_relative 'polytreenode.rb'

class KnightPathFinder

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [@root_node]
    end

    def self.valid_moves(pos) #[2,2], our current position
        #@root_node.pos is our starting point
        potential_moves = []
        [-1,1].each do |i|
            [-2,2].each do |j|
                potential_moves << [pos[0]+i, pos[1]+j] << [pos[0]+j, pos[1]+i]
            end
        end
        return potential_moves.select{|p| p[0]>=0 && p[0] <= 7 && p[1]>=0 && p[1] <= 7} 
    end

    def find_path(pos)

    end
end

k = KnightPathFinder.new([2,2])
# p k.valid_moves([7,7])