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

    # Returns list of all known settlements.
    def self.all
      settlements = []
      has_more = true
      page = 1

      while (has_more)
        puts "Page: #{page}"

        result = query(Page: page)
        if result.blank?
          has_more = false
          return
        end
        puts "result: #{result}"
        settlements << result
        page += 1
      end

      puts "settlements: #{settlements.count}"

      return settlements
    end

    private

    def self.query(params)
      post('AddressGeneral', 'getSettlements', params)['data'].map do |data|
        Settlement.new(data)
      end
    end
  end
end