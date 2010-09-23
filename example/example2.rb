require '../lib/tabular'
require 'pp'

puts "Example of Column Methods, with initialized table"

table = Tabular::Table.new([[1,2,0],[4,5,0],[7,8,0]])
pp table

puts "\nNaming columns"
table.name_column(0, "first")
table.name_column(1, "second")
table.name_column(2, "third")
pp table

puts "\nSave column 2 [3,6,9]"
table.save_column(2, [3,6,9] )
pp table

puts "Retrieve data via named fetch"
pp table.fetch(1,"second")

puts "\nRetrieve data via column_at, with integer index then named"
pp table.column_at( 0 )
pp table.column_at( "third" )

puts "\nAppend Column"
table.append_column( [5,7,9] )
pp table

puts "\nInsert column"
table.insert_column( 0, [0,3,6] )
pp table

puts "\nDelete named column"
table.delete_column( "0" )
pp table

puts "\nDelete integer index column"
table.delete_column( 0 )
pp table

