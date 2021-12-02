data = File.open('input.txt').read.split("\n")

File.open('day3.rb', 'w') do |f|
  f.write("data = #{data}\n\n\n\n\n")
end