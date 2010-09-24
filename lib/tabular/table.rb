module Tabular
   class Table

      include Enumerable

      def initialize( table=nil, headers=nil )
         @table   = init_table( table )
         @headers = init_headers( headers )
      end

      def [](row, column=nil)
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

      def map_row( index )
         @table[index].map do |item|
            yield item
         end
      end

      def map_row!( index, &block )
         @table[index] = map_row( index, &block )
      end

      def select_row( &block )
         @table.select( &block )
      end

      def select_row!( &block )
         @table = select_row( &block )
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

         @headers =  @headers[0...pos] + [pos.to_s] + @headers[pos..-1]

         @table.each_with_index do |row, ind|
            @table[ind] = row[0...pos] + [new_column[ind]] + row[pos..-1] 
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

      def map_column( index )
         column_at(index).map do |item|
            yield item
         end
      end

      def map_column!( index, &block )
         col = map_column( index, &block )
         save_column( index, col )
         #Add return col here so it returns the same as map_column
         return col
      end  

      def select_column( index, &block )
         column_id = check_column_id( index )

         #create new table containing only valid rows
         @table.inject([]) do |new_table, row|
            if block.call( row[column_id] )
               row
            end
         end
      end

      def select_column!( index, &block )
         @table = select_column( index, &block )
      end


      ###################################
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
         case headers
         when true
            new_headers = delete_row( 0 )
         when Array
            new_headers = headers
         when nil
            new_headers = []
         else
            raise ArgumentError
         end
      end
      
      #The method that does all the work for append and insert rows.
      def add_row( new_row, pos=@table.size)
         @table.insert(pos, new_row)
      end

      # check for ordinal (integer) or named Column refference
      def check_column_id( id )
         case id
         when Fixnum
            return id
         when String
            return @headers.index( id )
         else
            raise ArgumentError
         end
      end

   end
end
