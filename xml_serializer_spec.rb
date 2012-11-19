require_relative "xml_serializer" 

describe XmlSerializer do
  it "creates a root xml element with the class name" do
    serializer = XmlSerializer.new(DummyClass.new)
    serialized = serializer.serialize_class
    serialized.should == "<DummyClass></DummyClass>"
  end

  it "creates an xml element for simple property with its value" do
    object = DummyClass.new
    object.prop = 1
    serializer = XmlSerializer.new(object)
    serialized = serializer.serialize_attribute("prop")
    serialized.should == "<property=\"prop\" value=\"1\" />"
  end

  it "creates nothing for nil attribute" do
    object = DummyClass.new
    object.prop = nil
    serializer = XmlSerializer.new(object) 
    serializer.serialize_attribute("prop").should == ""
  end

  it "creates xml element for collection attribute" do
    object = DummyClass.new
    object.collection = [1, 2, "hello"]
    serializer = XmlSerializer.new(object)
    serialized = serializer.serialize_collection("collection")
    serialized.should == "<collection><1 /><2 /><hello /></collection>"
  end

  it "creates nothing for empty collection" do
    object = DummyClass.new
    object.collection = []
    serializer = XmlSerializer.new(object)
    serializer.serialize_collection("collection").should == ""
  end
end

class DummyClass
  attr_accessor :prop, :collection
end
