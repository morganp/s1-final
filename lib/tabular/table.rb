module Tabular
   class Table

      include Enumerable

      def initialize( table=nil, headers=nil )
         @table   = init_table( table )
         @headers = init_headers( headers )
      end

      def fetch(row, column=nil)
         # If only row supplied return entire row 
         if column.nil?
            @table[row]
         else
            column_id = check_column_id( column )
            @table[row][column_id]
         end
      end

      def row_at( row )
         @table[row]
      end

      def column_at( index )
         column_id = check_column_id( index )
         @table.inject([]) do |column, row|
            column << row[column_id]
         end
      end

      ###########################################
      ## ROW Modification Methods
      ###########################################
      def append_row( new_row )
         add_row( new_row )
      end

      def insert_row( index, new_row )
         add_row( new_row, index )
      end

      def save_row( index, new_row )
          @table[index] = new_row
      end

      def delete_row( index )
         @table.delete_at( index )
      end


      # Mixin in .map
      # http://ruby-doc.org/docs/ProgrammingRuby/html/tut_modules.html
      # Deligating each method from
      # http://snippets.dzone.com/posts/show/8247
      def each( &blk )
         @table.each( &blk )
      end

      def map!( &blk )
         @table.map!( &blk )
      end
      

      ###########################################
      ## COLUMN Modification Methods
      ###########################################
      def name_column( num, name )
         @headers[num] = name
      end

      def append_column( new_column )
         new_column.each_with_index do |x,index|
            @table[index] += [x]
         end
      end

      def insert_column( pos, new_column)

         @headers =  @headers[0...pos] + [pos.to_s] + @headers[pos...(@headers.size)]

         @table.each_with_index do |row, ind|
            @table[ind] = row[0...pos] + [new_column[ind]] + row[pos...(row.size)] 
         end
      end

      def save_column( index, new_column )
         column_id = check_column_id( index )

          @table.each_with_index do |row, ind|
             row[column_id] = new_column[ind]
          end
      end

      def delete_column( index )
         column_id = check_column_id( index )

         @headers.delete_at( column_id )

         @table.each do |row|
            row.delete_at( column_id )
         end
      end

      

      private

      def init_table( table )
         if table.nil?
            new_table   = []
         else 
            new_table   = table
         end
      end

      def init_headers( headers )
         #Strip header names from table
         if headers.class == TrueClass
            new_headers = rm_row( 0 )
         end  

         #Headers supplied as seperate array
         if headers.class == Array
            new_headers = headers
         end

         #Catch all for un-initialized headers
         return new_headers ||= []
      end
      
      #The method that does all the work for append and insert rows.
      def add_row( new_row, pos=@table.size)
         @table.insert(pos, new_row)
      end

      # check for ordinal (integer) or named Column refference
      def check_column_id( id )
         if id.class == Fixnum
            return id
         end

         if id.class == String
            return @headers.index( id )
         end
      end

   end
end
