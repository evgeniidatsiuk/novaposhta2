module Novaposhta2
  # Represents a known area.
  class Area < Base

    attr_reader :description, :areas_center, :ref # :nodoc:

    def initialize(params)
      @description = params['Description']
      @areas_center = params['AreasCenter']
      @ref = params['Ref']
    end

    # Lists all cities or returns city by number.
    def areas_center
      @areas_center ||= post('Address', 'getCities', Ref: @areas_center)['data'].map do |data|
        City.new(data)
      end
    end

    alias [] areas_center

    class << self

      # Returns area matching +ref+.
      def find_by_ref(ref)
        query(Ref: ref).first
      end

      # Returns all cities matching a pattern.
      def match(name)
        query(FindByString: name)
      end

      # Returns a area by name or part of the name.
      # If more than one area match a +name+ - returns nil.
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
      post('Address', 'getAreas', params)['data'].map do |data|
        Area.new(data)
      end
    end
  end
end