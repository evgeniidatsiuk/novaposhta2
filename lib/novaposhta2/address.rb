module Novaposhta2
  # Represents a address delivery.
  class Address < Base
    attr_reader :description, :ref, :street_ref, :street_type, :street_type_ref #:nodoc:

    def initialize(contact_ref, city_ref, address = '') #:nodoc:
      data_str = post('Address', 'getStreet', 
        {
          FindByString: address.split(',')[0],
          CityRef: city_ref
        })['data'][0]

      if address == ''
        building = ''
        flat     = ''
      else 
        if address.split(',')[1]
          if address.split(',')[1].match(/\//)
            building = address.split(',')[1].split('/')[0].to_s.strip
            flat     = address.split(',')[1].split('/')[1].to_s.strip
          else
            building = address.split(',')[1].to_s.strip
            flat     = ''
          end
        end
      end

      data = post('Address', 'save',
        {
          CounterpartyRef: contact_ref,
          StreetRef: data_str['Ref'],
          BuildingNumber: building,
          Flat: flat,
          Note: address
        })['data'][0]

      @ref             = data['Ref']
      @street_ref      = data_str['Ref']
      @description     = data_str['Description']
      @street_type     = data_str['StreetsType'] # тип улицы
      @street_type_ref = data_str['StreetsTypeRef'] #Описание типа улицы
    end
  end
end
