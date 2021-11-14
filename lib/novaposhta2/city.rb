module Novaposhta2
  # Represents a known city.
  class City < Base
    attr_reader :id, :description, :description_ru, :ref, :area_description, :area_description_ru, :settlement_type, :settlement_type_ru # :nodoc:

    # {"Description"=>"Трохимівка", "DescriptionRu"=>"Трофимовка",
    # "Ref"=>"aac9169f-f981-11ea-80fb-b8830365bd04", "Delivery1"=>"1",
    # "Delivery2"=>"0", "Delivery3"=>"1", "Delivery4"=>"0",
    # "Delivery5"=>"1", "Delivery6"=>"0", "Delivery7"=>"0",
    # "Area"=>"7150813c-9b87-11de-822f-000c2965ae0e",
    # "SettlementType"=>"563ced13-f210-11e3-8c4a-0050568002cf",
    # "IsBranch"=>"0", "PreventEntryNewStreetsUser"=>"0",
    # "CityID"=>"6373", "SettlementTypeDescription"=>"село",
    # "SettlementTypeDescriptionRu"=>"село", "
    # SpecialCashCheck"=>1,
    # "AreaDescription"=>"Херсонська",
    # "AreaDescriptionRu"=>"Херсонская"}

    def initialize(params)
      @id = params['CityID']
      @description = params['Description']
      @description_ru = params['DescriptionRu']
      @ref = params['Ref']
      @settlement_type = params['SettlementTypeDescription']
      @settlement_type_ru = params['SettlementTypeDescriptionRu']
      @area_description = params['AreaDescription']
      @area_description_ru = params['AreaDescriptionRu']
    end

    # Lists all warehouses or returns warehouse by number.
    def warehouses(number = nil)
      @warehouses ||= post('Address', 'getWarehouses', CityRef: @ref)['data'].map { |data| Warehouse.new(data) }
      if number.nil?
        @warehouses
      else
        @warehouses.find { |w| w.number == number }
      end
    end

    alias [] warehouses

    # Creates new person that belongs to the city.
    def person(firstname, midname, lastname, phone)
      Person.new(self, firstname, midname, lastname, phone)
    end

    class << self

      # Returns city matching +ref+.
      def find_by_ref(ref)
        query(Ref: ref).first
      end

      # Returns all cities matching a pattern.
      def match(name)
        query(FindByString: name)
      end

      # Returns a city by name or part of the name.
      # If more than one city match a +name+ - returns nil.
      def find(name)
        m = match(name)
        m.count == 1 ? m[0] : nil
      end

      alias [] find

      # Returns list of all known cities.
      def all
        match(nil)
      end

    end

    private

    def self.query(params)
      post('Address', 'getCities', params)['data'].map do |data|
        City.new(data)
      end
    end
  end
end