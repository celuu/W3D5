class PolyTreeNode
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end
    attr_reader :value, :parent, :children

    def parent=(node)
        return @parent=nil if node.nil?
        @parent.children.delete(self) if @parent
        @parent = node
        node.children << self if !node.children.include?(self)
    end
end