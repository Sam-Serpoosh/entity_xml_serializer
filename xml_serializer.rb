class XmlSerializer
  def initialize(entity) 
    @entity = entity
  end

  def serialize
    attributes_names = get_instance_variables
    serialized_attributes = ""
    attributes_names.each do |attr_name|
      serialized_attributes += serialize_attribute(attr_name)
    end
    serialize_entity(serialized_attributes)
  end

  def serialize_attribute(attr_name)
    attribute = @entity.instance_variable_get("@#{attr_name}")
    attribute.kind_of?(Array) ? serialize_collection(attr_name)
                              : serialize_scalar_attribute(attr_name)
  end

  def serialize_scalar_attribute(attribute_name)
    value = @entity.instance_variable_get("@#{attribute_name}")
    return "" if value.nil?

    "<property=\"#{attribute_name}\" value=\"#{value}\" />"
  end

  def serialize_collection(collection_attribute_name)
    collection = @entity.instance_variable_get("@#{collection_attribute_name}")
    return "" if collection.empty?

    element = "<collection>"
    collection.each do |item|
      element << "<item>#{item}</item>"
    end
    element << "</collection>"
    element
  end

  def serialize_entity(serialized_attributes)
    class_name = @entity.class.name
    "<#{class_name}>#{serialized_attributes}</#{class_name}>"
  end

  private 

    def get_instance_variables
      instance_variables = @entity.instance_variables
      instance_variables.map { |var| var.to_s.gsub("@", "") }
    end
end
