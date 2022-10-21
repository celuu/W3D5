require_relative 'polytreenode.rb'

class KnightPathFinder

    def initialize(pos)
        @start_pos = pos
        @considered_positions = [@start_pos]
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

    def new_move_positions(pos)
        potential_moves = KnightPathFinder.valid_moves(pos)
        @considered_positions.each do |p|
            if potential_moves.include?(p)
                potential_moves.delete(p)
            end
        end
        @considered_positions.concat(potential_moves)
        return potential_moves
    end

    def build_move_tree(start_pos)
        queue = new_move_positions(start_pos)
        until queue.empty?
            position = queue.shift
            position.each do |child|
                queue << child
            end
        end
    end

    # def bfs(target)
    #     queue = [self]
    #     until queue.empty?
    #         element = queue.shift
    #         return element if element.pos == target
    #         element.children.each do |child|
    #             queue << child
    #         end
    #     end
    #     nil
    # end



    attr_reader :start_pos
end

k = KnightPathFinder.new([2,2])
