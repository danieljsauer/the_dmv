class Registrant

  attr_reader :name, :age, :permit, :license_data

  def initialize(name, age, permit = false)
    @name = name
    @age = age 
    @license_data = {:written => false, :drivers_license => false, :renewed => false}
    @permit = permit 
  end 

  def permit?
    @permit
  end 

  def earn_permit
    @permit = true 
  end 
end 