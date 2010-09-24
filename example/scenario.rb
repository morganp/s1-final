require '../lib/tabular'
require 'yaml'
require 'pp'

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

#Load data With Headers
table = Tabular::Table.new( data, true)

#Limit table to June of 2006 
table.select_column!("PROCEDURE_DATE") do |item|
   month,day,year = item.split('/')
   (month == '06') and (year == '06')
end


#Method local to these requirments for one off format conversion
def money_format_column( table, column_id )
   table.map_column!( column_id ) do |item|
      scaled = item.to_i/100.0
      int, frac = ("%.2f" % scaled).split('.')
      "$" + int + "." + frac
   end
end

#Format Specified columns as currency
money_format_column( table,"AMOUNT" )
money_format_column( table,"TARGET_AMOUNT" )
money_format_column( table,"AMTPINSPAID" )

#Remove the Count Column
table.delete_column( "Count" )

#Transform date format from MM/DD/YY to YYYY-MM-DD
#assuming dates from 1910 to 2010
table.map_column!( "PROCEDURE_DATE" ) do |item|
   month,day,year = item.split('/')
   if year.to_i > 10
      year = '19' + year.to_s
   else
      year = '20' + year.to_s
   end
   "#{year}-#{month}-#{day}"
end

#Convert table object into standard array of arrays with header. 
table_as_array = table.to_a

#Write out yaml file
File.open( './../data/s1-exam-data-transformed.yaml', 'w' ) do |out|
   YAML.dump( table_as_array , out )
end

puts "Done"
