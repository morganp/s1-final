# example/example1.rb

require '../lib/tabular'
require 'pp'

puts "Example of Row Methods"

table = Tabular::Table.new

puts "Created Empty table"
pp table

puts "\nAppend rows"
table.append_row([0,0,0])
table.append_row([7,8,0])
pp table

puts "\nInsert row"
table.insert_row(1, [4,5,6])
pp table

puts "\nSave 1,2,3 to row 0"
table.save_row( 0, [1,2,3] )
pp table


puts "\nRetrieve data via fetch"
pp table.fetch(1)
pp table.fetch(1,1)

puts "\nRetrieve data via row_at"
pp table.row_at(1)

puts "\nDeleting Last Row"
table.delete_row( 2 )
pp table
