require_relative 'polytreenode.rb'

class KnightPathFinder

    def initialize(pos)
        @start_pos = pos
        @considered_positions = [@start_pos]
        build_move_tree
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

    def build_move_tree
        @root_node = PolyTreeNode.new(@start_pos)
        queue = [@root_node]
        until queue.empty?
            current = queue.shift
            new_move_positions(current.pos).each do |child_pos|
                child = PolyTreeNode.new(child_pos)
                current.add_child(child)
                queue << child
            end
        end
    end

    def find_path(end_pos)
        end_node = @root_node.bfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        ans = []
        current_node = end_node
        ans << current_node.pos
        while @root_node != current_node
            current_node = current_node.parent
            ans << current_node.pos
        end
        ans.reverse
    end



    attr_reader :start_pos, :considered_positions, :root_node
end

k = KnightPathFinder.new([2,2])
