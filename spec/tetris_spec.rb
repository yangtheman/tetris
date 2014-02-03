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
    it "should create a board with ROW_NUM rows" do
      @tetris.board.keys.size.should == ROW_NUM
    end
    
    it "should have empty grids" do
      @tetris.board[1][1].should be_nil
      @tetris.board[ROW_NUM][COL_NUM].should be_nil
    end        
  end
  
  describe ".row_full?" do
    it "should return true if a given row is full" do
      (1..COL_NUM).each {|i| @tetris.board[1][i] = 1}
      @tetris.row_full?(1).should == true
    end
    
    it "should retuan false if a given row is not full" do
      (1..COL_NUM-1).each {|i| @tetris.board[1][i] = 1}
      @tetris.row_full?(1).should == false  
    end
  end
  
  describe ".copy_rows" do
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
  
  describe ".clear_rows" do
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
  
  describe ".top_row" do
    it "should return a top-most row for given column coordinates" do
      @tetris.board[1][1] = 1
      @tetris.board[1][2] = 1
      @tetris.top_row(2, 3).should == 1
    end
    
    it "should return 0 if there are no rows for given column coordinates" do
      @tetris.top_row(2, 3).should == 0
    end
  end
  
  describe ".drop_block" do
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
  
  describe ".play" do
    it "should break if .drop_block returns false" do
      @tetris.should_receive(:drop_block).and_return(false)
      result = @tetris.play
      result.should be_nil
    end
    # Not sure how to test an infinite loop...
  end   
end