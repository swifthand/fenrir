class CreatesInstitution

  attr_reader :institution

  def initialize(persistor: InstitutionRecord.new, **params)
    @institution = Institution.new(persistor: persistor, **params)
  end


  def apply
    institution.valid? && institution.persist
  end

end
