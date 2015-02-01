# This probably doesn't belong here but we'll figure out where it does later.
class MockComparison
  attr_reader :mock_methods, :actual_methods

  def initialize(mock_class, actual_class,
      only: :not_provided, superclass: false, ignore: [])
    @mock_methods   = determine_mock_methods(mock_class, only, superclass, ignore)
    @actual_methods = determine_actual_methods(actual_class)
  end

  def comparable?
    mock_methods.all? { |msg| actual_methods.include?(msg) }
  end

  def difference
    mock_methods - actual_methods
  end

private #######################################################################

  def determine_mock_methods(mock, explicit_methods, superclass, ignore)
    return explicit_methods unless explicit_methods == :not_provided
    ( mock.instance_methods(false)      +
      active_record_columns(mock)       +
      active_record_associations(mock)  +
      superclass_methods(mock, superclass)
    ).uniq - ignore
  end

  def determine_actual_methods(actual)
    ( actual.instance_methods         +
      active_record_columns(actual)   +
      active_record_associations(actual)
    ).uniq
  end

  def active_record_columns(klass)
    return [] unless klass < ActiveRecord::Base
    column_names = klass.columns.map(&:name)
    column_names.map(&:to_sym) + column_names.map { |col| "#{col}=".to_sym }
  end

  def active_record_associations(klass)
    return [] unless klass < ActiveRecord::Base
    assoc_names = klass.reflections.select do |assoc_name, assoc_class|
      assoc_class.class <= ActiveRecord::Reflection::AssociationReflection
    end.keys
    assoc_names + assoc_names.map { |assoc| "#{assoc}=".to_sym }
  end

  def superclass_methods(mock, superclass)
    return [] unless superclass
    mock.superclass.instance_methods(false)
  end
end

