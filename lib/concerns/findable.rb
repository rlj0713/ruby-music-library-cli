
module Concerns
    module Findable
        def find_by_name(name)
            # binding.pry
            self.all.detect {|item| item.name == name}
        end

        def find_or_create_by_name(input)
            if self.find_by_name(input)
                self.find_by_name(input)
            else
                self.create(input)
            end
        end
    end
end