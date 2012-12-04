require_relative "xml_serializer" 

describe XmlSerializer do
  it "creates an xml element for simple property with its value" do
    entity = DummyEntity.new
    entity.prop = 1
    serializer = XmlSerializer.new
    serialized = serializer.serialize_scalar_attribute(entity, "prop")
    serialized.should == "<property=\"prop\" value=\"1\" />"
  end

  it "creates nothing for nil attribute" do
    entity = DummyEntity.new
    entity.prop = nil
    serializer = XmlSerializer.new
    serializer.serialize_scalar_attribute(entity, "prop").should == ""
  end

  it "creates xml element for collection attribute" do
    entity = DummyEntity.new
    entity.collection = [1, 2, "hello"]
    serializer = XmlSerializer.new
    serialized = serializer.serialize_collection(entity, "collection")
    serialized.should == "<collection><item>1</item><item>2</item><item>hello</item></collection>"
  end

  it "creates nothing for empty collection" do
    entity = DummyEntity.new
    entity.collection = []
    serializer = XmlSerializer.new
    serializer.serialize_collection(entity, "collection").should == ""
  end

  it "creates element for entity and embed serialized attributes in it" do
    entity = DummyEntity.new
    serializer = XmlSerializer.new
    serialized = serializer.serialize_entity(entity, "test")
    serialized.should == "<DummyEntity>test</DummyEntity>"
  end

  it "serialize an entity" do
    entity = DummyEntity.new
    entity.prop = 1
    entity.collection = [1, "hello"]
    serializer = XmlSerializer.new
    serialized = serializer.serialize(entity)
    serialized.should == "<DummyEntity><property=\"prop\" value=\"1\" /><collection><item>1</item><item>hello</item></collection></DummyEntity>"
  end

  it "serialize the entity property as a child element of main entity" do
    fake_entity = FakeEntity.new
    fake_entity.number = 1
    fake_entity.name = "bob"
    entity = DummyEntity.new
    entity.prop = 1
    entity.collection = [1, "hello"]
    entity.entity_prop = fake_entity
    serializer = XmlSerializer.new
    serialized = serializer.serialize(entity)
    serialized.should == "<DummyEntity><property=\"prop\" value=\"1\" /><collection><item>1</item><item>hello</item></collection><FakeEntity><property=\"number\" value=\"1\" /><property=\"name\" value=\"bob\" /></FakeEntity></DummyEntity>"
  end

  def create_serializer(entity)
    serializer = XmlSerializer.new
    serializer.entity = entity
    serializer
  end
end

class DummyEntity
  attr_accessor :prop, :entity_prop, :collection
end

class FakeEntity < Entity
  attr_accessor :number, :name
end
