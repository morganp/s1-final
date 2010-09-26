Tabular::Table
==============

This project was originally written to complete the ASSIGNMENT as detailed in the ASSIGNMENT file.

Quick Demo
----------

    require 'tabular'
    table = Tabular::Table.new

    table.append_row([1,2,3])
    table.append_row([4,5,6])
    table.append_row([7,8,9])

    table.row_at( 0 ) 
    #=> [1,2,3]

    table[0, 1]
    #=> 2

    table.append_column( [4,7,0] )
    # Table is now
    # [ [1,2,3,4]
    #   [4,5,6,7]
    #   [7,8,9,0] ]

    table.name_column(0, "first")
    table.name_column(1, "second")
    table.name_column(2, "third")
    table.name_column(3, "fourth")

    table.column_at( 1 )
    #=> [2,5,8]

    table.column_at( "second" )
    #=> [2,5,8]

    table.save_row(1, [9,9,9,9] )
    # Table is now
    # [ [1,2,3,4]
    #   [9,9,9,9]
    #   [7,8,9,0] ]

    table.save_column("fourth", [1,2,3] )
    # Table is now
    # [ [1,2,3,1]
    #   [9,9,9,2]
    #   [7,8,9,3] ]

Further Examples
----------------

cd examples  
example1.rb, details use of row methods   
example2.rb, details use of column methods  
example3.rb, details map_row and map_column methods  
example4.rb, details select_row and select_column methods  


