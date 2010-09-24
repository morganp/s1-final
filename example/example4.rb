require '../lib/tabular'
require 'pp'


table = Tabular::Table.new([["a","b","c"],[1,2,3],[4,5,6],[7,8,9]], true)
pp table

puts "\ntry to_a should include headers"
pp table.to_a

puts "\nselect_row on table"
tab = table.select_row do |x|
   (x.size==3) and (x[1] > 3)
end
pp tab
pp table

puts "\nselect_row! on table"
tab = table.select_row! do |x|
   pp x
   (x.size==3) and (x[1] > 3)
end
pp tab
pp table


puts "\nselect_column \"c\" >6"
col_c = table.select_column( "c" ) do |item|
   item > 6
end
pp col_c
pp table

puts "\nselect_column! 3 >6"
col_c = table.select_column!( 2 ) do |item|
   item > 6
end
pp col_c
pp table

