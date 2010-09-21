require '../lib/tabular'
require 'yaml'

#  1. Restrict the rows to dates that occur in June 2006
#
#  2. Convert the AMOUNT, TARGET_AMOUNT, and AMTPINSPAID 
#columns to money format. (e.g 1500 becomes $15.00)
#
#  3. Remove the Count column
#
#  4. Change the date format to YYYY-MM-DD
#
#  5. Convert the table to an array of arrays, and then 
#write out a YAML file called 's1-exam-data-transformed.yaml',
#including the headers as the first row.
#
#  6. Check this file and the code used to generate it into
#your repository for review.

data = YAML::load_file('../data/s1-exam-data.yaml')

table = Tabular::Table.new( data, true)


puts table.get(0)
puts table.get(4,0)
puts table.get(4,"PROCEDURE_DATE")






