require 'pry'

bingo_to_call = [76,69,38,62,33,48,81,2,64,21,80,90,29,99,37,15,93,46,75,0,89,56,58,40,92,47,8,6,54,96,12,66,83,4,70,19,17,5,50,52,45,51,18,27,49,71,28,86,74,77,11,20,84,72,23,31,16,78,91,65,87,79,73,94,24,68,63,9,88,82,30,42,60,13,67,85,44,59,7,53,22,1,26,41,61,55,43,39,3,35,25,34,57,10,14,32,97,95,36,98]


data = File.open('input.txt').read.split("\n")


def build_boards(data)
  row = 1
  boards = []
  board = []
  data.each do |data_row|
    next if data_row == ''
    formatted_row = data_row.split(" ").map(&:to_i)
    board.push(formatted_row)
    if row == 5
      boards.push(board)
      board = []
      row = 0
    end
    row +=1
  end

  boards
end




def mark_called(called, board)
  board.each do |row|
    match_index = row.index(called)
    if match_index
      row[match_index] = 'x'
    end
  end
end



def has_bingo?(board)
  board.any?{|row| row == ['x', 'x', 'x', 'x', 'x']} ||
  board.transpose.any?{|row| row == ['x', 'x', 'x', 'x', 'x']}
end

def sum_board(board)
  sum = 0
  board.each do |row|
    row.each do |marker|
      if marker != 'x'
        sum += marker
      end
    end
  end
  sum
end

# boards = build_boards(data)
# stop = false
# winning_board = []
# winning_call = 0

# bingo_to_call.each do |called|
#   break if stop
#   boards.each do |board|
#     break if stop
#     mark_called(called, board)
#     if has_bingo?(board)
#       winning_board = board
#       winning_call = called
#       stop = true
#     end
#   end
# end


# p sum_board(winning_board) * winning_call



#2
boards = build_boards(data)


def find_winning_boards(boards, called)
  stop = false
  winning_boards = []

  boards.each do |board|
    mark_called(called, board)
    if has_bingo?(board)
      winning_boards.push(board) 
    end
  end
  winning_boards
end

result = []
stop = false
bingo_to_call.each do |called|
  break if stop
  winning_boards = find_winning_boards(boards, called)
  if winning_boards.length == 1 && boards.length == 1
    # binding.pry
    result = [winning_boards.first, called]
    stop = true
  elsif winning_boards.length >= 1
    # binding.pry
    winning_boards.each do |winning_board|
      boards.delete(winning_board)
    end
  end
end

# binding.pry


p sum_board(result.first) * result.last

=begin
post challenge thoughts:

crazy amount of iteration, and I was lucky to know transpose off the cuff
smaller methods proved valueable again
binding.pry seems super necessry to tease out viable outcomes

=end
