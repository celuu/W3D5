require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  attr_reader :board, :next_mover_mark, :prev_move_pos
  def alternate_mark(mark)
    if mark == :x 
      mark = :o  
    else 
      mark = :x
    end
    return mark
  end

  def losing_node?(evaluator)
    if @board.over? && alternate_mark(evaluator) == @board.winner 
      return true
    elsif @board.tied? || evaluator == @board.winner 
      return false 
    end

      next_states = self.children
      if evaluator == @next_mover_mark
        return next_states.all? {|state| state.losing_node?(evaluator)}
      else
        evaluator = alternate_mark(evaluator)
        return next_states.any? {|state| state.winning_node?(evaluator)}
      end
  end

  def winning_node?(evaluator)
    if @board.over? && evaluator == @board.winner 
      return true
    elsif @board.tied? || alternate_mark(evaluator) == @board.winner 
      return false 
    end

      next_states = self.children
      if evaluator == @next_mover_mark
        return next_states.any? {|state| state.winning_node?(evaluator)}
      else
        evaluator = alternate_mark(evaluator)
        return next_states.all? {|state| state.losing_node?(evaluator)}
      end
    # end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    # prev_move_pos ||= :O
    state = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |el, j|
        if @board.empty?([i, j])
          new_board = @board.dup
          new_board[[i,j]]= @next_mover_mark
          next_move = nil
          if @next_mover_mark == :x 
            next_move = :o  
          else 
            next_move = :x
          end
          state << TicTacToeNode.new(new_board, next_move, [i,j])

        end
      end
    end
    state
  end
  
end
