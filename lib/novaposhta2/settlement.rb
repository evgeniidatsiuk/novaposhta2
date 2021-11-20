module Novaposhta2
  # Represents a settlement.
  class Settlement < Base
    attr_reader :description, :description_ru, :ref, :region, :region_description, :region_description_ru, :area, :area_description, :area_description_ru, :settlement_type, :settlement_type_ru, :number, :longitude, :latitude, :warehouse #:nodoc:

    def initialize(params)
      #:nodoc:
      @number = params['Number'].to_i
      @longitude = params['Longitude']
      @latitude = params['Latitude']
      @id = params['CityID']
      @region = params['Region']
      @region_description = params['RegionsDescription']
      @region_description_ru = params['RegionsDescriptionRu']
      @description = params['Description']
      @description_ru = params['DescriptionRu']
      @ref = params['Ref']
      @settlement_type = params['SettlementTypeDescription']
      @settlement_type_ru = params['SettlementTypeDescriptionRu']
      @area = params['Area']
      @area_description = params['AreaDescription']
      @area_description_ru = params['AreaDescriptionRu']
      @warehouse = params['Warehouse']
    end

    # Returns 150 settlements per page.
    def self.get(params)
      query(params)
    end

    private

    def self.query(params)
      post('AddressGeneral', 'getSettlements', params)['data'].map do |data|
        Settlement.new(data)
      end
    end
  end
end