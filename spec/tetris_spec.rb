require_relative "../tetris"
require 'rspec'

describe Tetris do
  
  before(:all) do
    ROW_NUM = Tetris::ROW_NUM
    COL_NUM = Tetris::COL_NUM
  end
    
  before do
    @tetris = Tetris.new
  end
  
  describe ".new" do
    it "should initialize @max_play to -1 by default" do
      @tetris.max_play.should == -1
    end

    it "should initialize @max_play to given param" do
      tetris = Tetris.new(50)
      tetris.max_play.should == 50
    end
    
    it "should create a board with ROW_NUM rows" do
      @tetris.board.keys.size.should == ROW_NUM
    end
    
    it "should have empty grids" do
      @tetris.board[1][1].should be_nil
      @tetris.board[ROW_NUM][COL_NUM].should be_nil
    end        
  end
  
  describe "#row_full?" do
    it "should return true if a given row is full" do
      (1..COL_NUM).each {|i| @tetris.board[1][i] = 1}
      @tetris.row_full?(1).should == true
    end
    
    it "should retuan false if a given row is not full" do
      (1..COL_NUM-1).each {|i| @tetris.board[1][i] = 1}
      @tetris.row_full?(1).should == false  
    end
  end
  
  describe "#copy_rows" do
    it "should copy rows above the given row down one row each" do
      @tetris.board[1][1] = 1
      @tetris.board[2][2] = 1
      @tetris.board[3][3] = 1      
      @tetris.copy_rows(1)
      @tetris.board[1][1].should be_nil
      @tetris.board[1][2].should == 1
      @tetris.board[2][3].should == 1      
    end    
  end
  
  describe "#clear_rows" do
    it "should clear the given row if it's full" do
      (1..COL_NUM).each {|i| @tetris.board[1][i] = 1}
      @tetris.clear_rows
      @tetris.board[1].should == {}
    end
    
    it "should not clear the given row if it's not full" do
      (1..COL_NUM-1).each {|i| @tetris.board[1][i] = 1}
      prev_row_state = @tetris.board[1]
      @tetris.clear_rows
      @tetris.board[1].should == prev_row_state
    end
    
    it "should call copy_rows method" do
      @tetris.should_receive(:copy_rows)
      (1..COL_NUM).each {|i| @tetris.board[1][i] = 1}
      @tetris.clear_rows      
    end
  end
  
  describe "#top_row" do
    it "should return a top-most row for given column coordinates" do
      @tetris.board[1][1] = 1
      @tetris.board[1][2] = 1
      @tetris.top_row(2, 3).should == 1
    end
    
    it "should return 0 if there are no rows for given column coordinates" do
      @tetris.top_row(2, 3).should == 0
    end
  end
  
  describe "#drop_block" do
    it "should create 2x2 block on top of a row in the given column" do
      @tetris.board[1][1] = 1
      @tetris.board[1][2] = 1
      @tetris.drop_block(2)
      @tetris.board[2][2].should == 1
      @tetris.board[2][3].should == 1
      @tetris.board[3][2].should == 1
      @tetris.board[3][3].should == 1
    end
    
    it "should call clear_rows method" do
      @tetris.should_receive(:clear_rows)
      @tetris.drop_block(2)      
    end
    
    it "should return false user picks a row that will go over the limit" do
      @tetris.board[ROW_NUM-1][1] = 1
      @tetris.board[ROW_NUM-1][2] = 1
      @tetris.drop_block(2).should == false
    end
  end
  
  describe "#pick_the_best_column" do
    it "should return the column in the last row with no block" do
      @tetris.board[1][1] = 1
      @tetris.board[1][2] = 1
      @tetris.pick_the_best_column.should_not == 1
      @tetris.pick_the_best_column.should_not == 2      
    end
    
    it "should pick only two consecutive columms" do
      @tetris.board[1][1] = 1
      @tetris.board[1][3] = 1
      @tetris.pick_the_best_column.should_not == 2
    end
    
    it "should be able to detect first two empty columns" do
      (3..COL_NUM).each {|col| @tetris.board[1][col] = 1}
      @tetris.pick_the_best_column.should == 1
    end
  end
  
  
  describe "#play" do
    it "should break if .drop_block returns false" do
      @tetris.should_receive(:drop_block).and_return(false)
      result = @tetris.play
      result.should be_nil
    end
    
    it "should play at least max_play times" do
      tetris = Tetris.new(51)
      result = tetris.play
      result.should_not be_nil
    end
  end   
end