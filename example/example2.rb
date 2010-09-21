require '../lib/tabular'
require 'pp'


table = Tabular::Table.new([[1,2,3],[4,5,6],[7,8,9]])

pp table


table.name_column(0, "first")
table.name_column(1, "second")
table.name_column(2, "third")

puts table.fetch(1,"second")

pp table.fetch_column( 0 )
pp table.fetch_column( "third" )

table.append_column( [5,7,9] )
pp table

table.insert_column( 0, [0,3,6] )
pp table

table.delete_column( "0" )
pp table

