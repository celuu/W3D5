class PolyTreeNode
    
    def initialize(pos)
        @pos = pos #[0,0]
        @parent = nil
        @children = []
    end

    attr_reader :pos, :parent, :children

    def parent=(node)
        return @parent=nil if node.nil?
        @parent.children.delete(self) if @parent
        @parent = node
        node.children << self if !node.children.include?(self)
    end

    def add_child(node)
        node.parent=(self)
        @children << node if !@children.include?(node)
    end

    def remove_child(node)
        if !@children.include?(node)
            raise "node is not a child, can't remove"
        end
        node.parent=(nil)
        @children.delete(node)
    end

    def dfs(target)
        return nil if self.nil?
        return self if self.pos == target

        self.children.each do |child|
            result = child.dfs(target)
            return result unless result.nil?
        end
        return nil
    end 

    def bfs(target)
        queue = [self]
        until queue.empty?
            element = queue.shift
            return element if element.pos == target
            element.children.each do |child|
                queue << child
            end
        end
        nil
    end
end