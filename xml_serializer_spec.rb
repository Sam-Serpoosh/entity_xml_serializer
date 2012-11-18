require_relative "xml_serializer" 

describe XmlSerializer do
  it "creates a root xml element with the class name" do
    serializer = XmlSerializer.new(DummyClass.new(1))
    serialized = serializer.serialize
    serialized.should == "<DummyClass></DummyClass>"
  end

  it "creates an xml element for simple property with its value" do
    object = DummyClass.new(1)
    serializer = XmlSerializer.new(object)
    serialized = serializer.serialize_attribute("prop")
    serialized.should == "<property=\"prop\" value=\"1\" />"
  end
end

class DummyClass
  attr_reader :prop
  def initialize(prop)
    @prop = prop
  end
end
