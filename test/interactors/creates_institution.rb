require 'test_helper'

class CreatesInstitutionTest < ActiveSupport::TestCase

  def hash_persistor
    @hash_persistor ||= Bifrost::HashPersistor.new(via: :object_id)
  end

  def valid_institution(overrides = {})
    { name:           "Texas Children's Hospital",
      street_address: '6621 Fannin St',
      city:           'Houston',
      state:          'TX',
      postalcode:     '77030',
      country:        'US',
    }.merge(overrides)
  end


  test "apply succeeds for valid institution" do
    command = CreatesInstitution.new(valid_institution)
    assert(command.apply)
  end


  # |TF| Public Side Effects
  test "institution is persisted upon success (memory)" do
    command = CreatesInstitution.new(valid_institution(persistor: hash_persistor))
    assert(command.apply)
    institution = command.institution
    id          = institution.id
    refute_equal(nil, id)
    assert_equal(hash_persistor.find(id).id, institution.id)
  end


  # |TF| Public Side Effects
  test "institution is persisted upon success (db)" do
    record  = InstitutionRecord.new
    command = CreatesInstitution.new(valid_institution(persistor: record))
    assert(command.apply)
    institution = command.institution
    inst_id     = institution.id
    refute_equal(nil, inst_id)
    assert_equal(record.id, inst_id)
    assert_equal(InstitutionRecord.find(inst_id).as_entity.id, institution.id)
  end

end
