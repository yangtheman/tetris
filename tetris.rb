class Tetris
  
  ROW_NUM = 20
  COL_NUM = 10
  
  attr_reader :board, :max_play
  
  def initialize(max_play=-1)
    @board = {}
    @max_play = max_play
    (1..ROW_NUM).each do |row|
      @board[row] = {}
    end
  end

  def row_full?(row)
    (1..COL_NUM).each do |col| 
      return false if @board[row][col].nil?
    end
    true
  end
  
  def copy_rows(row)
    (row..ROW_NUM-1).each do |row|
      break if @board[row+1] == {}
      @board[row] = @board[row+1] 
      @board[row+1] = {} 
    end
  end
  
  def clear_rows
    ROW_NUM.downto(1) do |row|
      if row_full?(row)
        @board[row] = {} 
        copy_rows(row)
      end
    end
  end
  
  def top_row(col1, col2)
    ROW_NUM.downto(1) do |row|
      return row if @board[row][col1] || @board[row][col2]
    end
    0
  end
  
  # We will take left-most column and drop a 2x2 block
  def drop_block(col)
    next_row = top_row(col, col+1) + 1
    puts "User picked #{col}, #{col+1} where last row is #{next_row-1}"

    return false if next_row > ROW_NUM-1
        
    @board[next_row][col] = @board[next_row][col+1] = 
      @board[next_row+1][col] = @board[next_row+1][col+1] = 1      
    
    clear_rows
  end
  
  def pick_the_best_column
    (1..ROW_NUM).each do |row|
      (1..COL_NUM-1).each do |col|
        return col if @board[row][col].nil? && @board[row][col+1].nil?
      end
    end
  end
  
  def play
    play_num = 0
    while @max_play != play_num
      col = pick_the_best_column
      if result = drop_block(col)
        play_num += 1
      else
        puts "GAME OVER!"
        return nil
      end
    end
    true
  end
end