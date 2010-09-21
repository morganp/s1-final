require '../lib/tabular'
require 'pp'


table = Tabular::Table.new

table.append_row([1,2,3])
table.append_row([7,8,0])
table.insert_row(1, [4,5,6])


pp table


table.name_column(0, "first")
table.name_column(1, "second")
table.name_column(2, "third")

puts table.fetch(1,"second")

table.append_column([5,7,9])

pp table

puts "Deleting Last Row"
table.delete_row( 1 )

pp table
