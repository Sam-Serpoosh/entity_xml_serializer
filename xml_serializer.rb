class XmlSerializer
  def initialize(object) 
    @object = object
  end

  def serialize_class
    class_name = @object.class.name
    "<#{class_name}></#{class_name}>"
  end

  def serialize_attribute(attribute_name)
    value = @object.instance_variable_get("@#{attribute_name}")
    return "" if value.nil?

    "<property=\"#{attribute_name}\" value=\"#{value}\" />"
  end

  def serialize_collection(collection_attribute_name)
    collection = @object.instance_variable_get("@#{collection_attribute_name}")
    return "" if collection.empty?

    element = "<collection>"
    collection.each do |item|
      element << "<#{item} />"
    end
    element << "</collection>"
    element
  end
end
