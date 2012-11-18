class XmlSerializer
  def initialize(object) 
    @object = object
  end

  def serialize
    class_name = @object.class.name
    "<#{class_name}></#{class_name}>"
  end

  def serialize_attribute(attribute_name)
    value = @object.instance_variable_get("@#{attribute_name}")
    "<property=\"#{attribute_name}\" value=\"#{value}\" />"
  end
end
