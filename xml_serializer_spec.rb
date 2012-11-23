require_relative "xml_serializer" 

describe XmlSerializer do
  it "creates an xml element for simple property with its value" do
    entity = DummyEntity.new
    entity.prop = 1
    serializer = XmlSerializer.new(entity)
    serialized = serializer.serialize_scalar_attribute("prop")
    serialized.should == "<property=\"prop\" value=\"1\" />"
  end

  it "creates nothing for nil attribute" do
    entity = DummyEntity.new
    entity.prop = nil
    serializer = XmlSerializer.new(entity) 
    serializer.serialize_scalar_attribute("prop").should == ""
  end

  it "creates xml element for collection attribute" do
    entity = DummyEntity.new
    entity.collection = [1, 2, "hello"]
    serializer = XmlSerializer.new(entity)
    serialized = serializer.serialize_collection("collection")
    serialized.should == "<collection><item>1</item><item>2</item><item>hello</item></collection>"
  end

  it "creates nothing for empty collection" do
    entity = DummyEntity.new
    entity.collection = []
    serializer = XmlSerializer.new(entity)
    serializer.serialize_collection("collection").should == ""
  end

  it "creates element for entity and embed serialized attributes in it" do
    serializer = XmlSerializer.new(DummyEntity.new)
    serialized = serializer.serialize_entity("test")
    serialized.should == "<DummyEntity>test</DummyEntity>"
  end

  it "serialize an entity entity" do
    entity = DummyEntity.new
    entity.prop = 1
    entity.collection = [1, "hello"]
    serializer = XmlSerializer.new(entity)
    serialized = serializer.serialize
    serialized.should == "<DummyEntity><property=\"prop\" value=\"1\" /><collection><item>1</item><item>hello</item></collection></DummyEntity>"
  end
end

class DummyEntity
  attr_accessor :prop, :collection
end
