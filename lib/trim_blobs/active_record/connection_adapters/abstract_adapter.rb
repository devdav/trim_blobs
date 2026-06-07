module TrimBlobs
  module ActiveRecord
    module ConnectionAdapters
      module AbstractAdapter
        def log(sql, name = "SQL", binds = [], statement_name = nil)
          if sql
            sql = sql.gsub(/'\\x((?:[0-9a-f]{2})+)'/) do |blob|
              (blob.size > 32) ? "'\\x#{$1[0,32]}... (TRIMMED #{blob.size} hexadecimal digits)'" : $&
            end
          end
          if statement_name
            super(sql, name, binds, statement_name){ yield }
          else
            super(sql, name, binds){ yield }
          end
        end
      end
    end
  end
end
