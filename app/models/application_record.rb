class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_initialize :set_default_values

  @@default_values = {}

  before_save do
    if self.respond_to?(:slug)
      if self.new_record? && self.respond_to?(:name)
        self.slug = self.name.to_slug
      end
    end
  end

  def resource_id
    id.to_s
  end

  def self.search query
    return self.where("#{self.searchable_field} LIKE ?", "%#{query}%")
  end

  def self.searchable_field
    'name'
  end

  def self.default_sort_order
    "updated_at desc"
  end

  def reload_attribute attribute_name
    self[attribute_name] = self.class.where(id: id).limit(1).pluck(attribute_name).first
  end

  # dev helper
  def get_errors
    valid? ? {} : errors
  end

  # If default values are set at multiple levels of inheritance,
  #** this will NOT respect the order of inheritance
  def set_default_values
    self.class.get_default_values.each do |key, value|
      if self[key].nil?
        self[key] = (value.is_a?(Proc) ? self.class.instance_exec(&value) : value)
      end
    end
  end

  def self.get_default_values
    default_values = {}
    @@default_values.each do |klass, values|
      if self <= klass
        default_values.merge!(values)
      end
    end
    default_values
  end

  def self.default_values values
    @@default_values[self] = values
  end

  def perform_controller_save_callbacks
    return false if !saved_changes?

    if respond_to?(:controller_after_create) && previously_new_record?
      controller_save_create
    end
    if respond_to?(:controller_after_save)
      controller_save_save
    end
  end

  def logger
    @_logger ||= JsonLogger.new("log/#{self.class.name.underscore}.log")
  end

  class JsonIndifferentAccessSerializer < ActiveRecord::Coders::JSON
    def self.load(data)
      result = super
      (result.try(:with_indifferent_access) || result)
    end
  end
end
