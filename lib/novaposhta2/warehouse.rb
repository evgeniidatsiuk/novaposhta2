module Novaposhta2
  # Represents a warehouse.
  class Warehouse < Base
    attr_reader :description, :description_ru, :ref, :number, :longitude, :latitude #:nodoc:

    def initialize(params) #:nodoc:
      @description_ru = params['DescriptionRu']
      @description    = params['Description']
      @ref            = params['Ref']
      @number         = params['Number'].to_i
      @longitude      = params['Longitude']
      @latitude       = params['Latitude']
    end
  end
end