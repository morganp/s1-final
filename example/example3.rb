require '../lib/tabular'
require 'pp'


table = Tabular::Table.new([["a","b","c"],[1,2,3],[4,5,6],[7,8,9]], true)
pp table

puts "\nmap! on table"
table.map! do |row|
   row[2] = row[2] * 2
   row
end
pp table

puts "\nmap_row 0 item**2"
row = table.map_row( 0 ) do |item|
   item**2
end
pp row
pp table

puts "\nmap_row! 0 item**2"
table.map_row!( 0 ) do |item|
   item**2
end
pp row
pp table

puts "\nmap_column 2 item+1"
d = table.map_column( "c" ) do |item|
   item+1
end
pp d
pp table

puts "\nmap_column! 2 item+1"
d = table.map_column!( "c" ) do |item|
   item+1
end
pp d
pp table

