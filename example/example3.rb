require '../lib/tabular'
require 'pp'


table = Tabular::Table.new([[0,0,0],[4,5,6],[7,8,9]])
pp table

table.save_row( 0, [1,2,3] )
pp table



table.name_column(0, "first")
table.name_column(1, "second")
table.name_column(2, "third")

table.map! do |row|
   row[2] = row[2] * 2
   row
end
pp table

b = table.fetch( 0 ).map! do |item|
   item = item * 2
end
table.save_row( 0, b)

pp table

pp table.fetch_column( "first" )
pp table.fetch_column( 1 )

cola = table.fetch_column( "third" ).map! do |item|
   item = item * 2
end
table.save_column( "third", cola )

puts
puts "Ran map on third column"
pp table



