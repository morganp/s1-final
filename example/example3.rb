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


#b = table.fetch( 0 ).map! do |item|
#   item = item * 2
#end
#table.save_row( 0, b)
#
#pp table
#
#pp table.column_at( "first" )
#pp table.column_at( 1 )
#
#cola = table.fetch_column( "third" ).map! do |item|
#   item = item * 2
#end
#table.save_column( "third", cola )
#
#puts
#puts "Ran map on third column"
#pp table
#


