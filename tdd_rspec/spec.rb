# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
    def initialize(first_name:, middle_name: nil, last_name:)
      @first_name = first_name
      @middle_name = middle_name
      @last_name = last_name
    end
  
    def full_name
        @middle_name.nil? ? "#{@first_name} #{@last_name}" : "#{@first_name} #{@middle_name} #{@last_name}"
    end

    def full_name_with_middle_initial
        @middle_name.nil? ? "#{@first_name} #{@last_name}" : "#{@first_name} #{@middle_name[0]}. #{@last_name}"
    end

    def initials
        @middle_name.nil? ? @first_name[0]+@last_name[0] : @first_name[0]+@middle_name[0]+@last_name[0]
    end
    
end

  RSpec.describe Person do
    describe "#full_name" do
      it "concatenates first name, middle name, and last name with spaces" do 
        person = Person.new(first_name: "Peter", middle_name: "Sander", last_name: "Brofinson")

        expect(person.full_name).to eq "Peter Sander Brofinson"
      end

      it "does not add extra spaces if middle name is missing" do 
        person = Person.new(first_name: "Peter", last_name: "Brofinson")

        expect(person.full_name).to eq "Peter Brofinson"
      end
    end
  
    describe "#full_name_with_middle_initial" do 
       it "returns a first name, then an initial for middle name, then last name with spaces" do
        person = Person.new(first_name: "Peter", middle_name: "Sander", last_name: "Brofinson")

        expect(person.full_name_with_middle_initial).to eq "Peter S. Brofinson"
       end

       it "if no middle name is given, it does not have extra spaces" do 
        person = Person.new(first_name: "Peter", last_name: "Brofinson")

        expect(person.full_name_with_middle_initial).to eq "Peter Brofinson"
       end
    end
  
    describe "#initials" do 
        it "gives you initials for a person with a middle name without spaces" do 
          person = Person.new(first_name: "Peter", middle_name: "Monk", last_name: "Sanderson")

          expect(person.initials).to eq "PMS"        
        end

        it "gives you initials for a person without a middle name without spaces" do 
            person = Person.new(first_name: "Peter", last_name: "Sanderson")
  
            expect(person.initials).to eq "PS"        
        end
    end
  end