require 'mongoid'

# load mongoid config
Mongoid.load!("config/mongoid.yml", :development)

def stub_save!(obj)
  obj.stub(:save!).and_return true if obj.respond_to? :save! 
end