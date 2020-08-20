module Novaposhta2
  # Represents a warehouse.
  class Warehouse < Base
    attr_reader :description, :description_ru, :ref, :number, :longtitude, :latitude #:nodoc:

    def initialize(params) #:nodoc:
      @description_ru = params['DescriptionRu']
      @description    = params['Description']
      @ref            = params['Ref']
      @number         = params['Number'].to_i
      @longtitude     = params['Longtitude']
      @latitude       = params['Latitude']
    end
  end
end