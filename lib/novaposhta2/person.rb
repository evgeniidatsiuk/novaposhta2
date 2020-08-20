module Novaposhta2
  # Represents a package recipient.
  class Person < Base
    attr_reader :city, :firstname, :middlename, :lastname, :phone, :ref, :contact_ref # :nodoc:

    def initialize(city, firstname, middlename, lastname, phone) #:nodoc:
      @city, @firstname, @middlename, @lastname, @phone = city, firstname, middlename, lastname, phone


      data = post('Counterparty', 'save',
        {
          CityRef: @city.ref,
          FirstName: @firstname,
          MiddleName: @middlename,
          LastName: @lastname,
          Phone: @phone,
          CounterpartyType: :PrivatePerson,
          CounterpartyProperty: :Recipient
        })['data'][0]

      @ref = data['Ref']
      @contact_ref = data['ContactPerson']['data'][0]['Ref']
    end

    # Creates a new package for the person.
    def package(address, options)
      Package.new(address, self, options)
    end
  end
end