# encoding: utf-8

module FFaker
  module Address
    extend ModuleUtils
    extend self

    COMPASS_DIRECTIONS = %w(North East West South).freeze
    CITY_PREFIXES = COMPASS_DIRECTIONS + %w(New Lake Port)
    SEC_ADDR = ['Apt. ###', 'Suite ###'].freeze

    # @deprecated US specific address info. Moved into {AddressUS}
    def zip_code
      warn '[zip_code] is deprecated. For US addresses please use the AddressUS module'
      FFaker::AddressUS.zip_code
    end

    def us_state
      warn '[us_state] is deprecated. For US addresses please use the AddressUS module'
      FFaker::AddressUS.state
    end

    def us_state_abbr
      warn '[state_abbr] is deprecated. For US addresses please use the AddressUS module'
      FFaker::AddressUS.state_abbr
    end
    # end US deprecation

    def city_prefix
      CITY_PREFIXES.sample
    end

    def city_suffix
      CITY_SUFFIXES.sample
    end

    def city
      case rand(4)
      when 0 then '%s %s%s' % [city_prefix, Name.first_name, city_suffix]
      when 1 then '%s %s'   % [city_prefix, Name.first_name]
      when 2 then '%s%s'    % [Name.first_name, city_suffix]
      when 3 then '%s%s'    % [Name.last_name, city_suffix]
      end
    end

    def street_suffix
      STREET_SUFFIX.sample
    end

    def building_number
      FFaker.numerify(('#' * rand(3)) << '###')
    end

    def street_name
      case rand(2)
      when 0 then "#{Name.last_name} #{street_suffix}"
      when 1 then "#{Name.first_name} #{street_suffix}"
      end
    end

    def street_address(include_secondary = false)
      str = "#{building_number} #{street_name}"
      str << " #{secondary_address}" if include_secondary
      str
    end

    def secondary_address
      FFaker.numerify(SEC_ADDR.sample)
    end

    # @deprecated UK specific address info. Moved into {AddressUK}
    # UK Variants
    def uk_county
      warn '[uk_county] is deprecated. For UK addresses please use the AddressUK module'
      FFaker::AddressUK.county
    end

    def uk_country
      warn '[uk_country] is deprecated. For UK addresses please use the AddressUK module'
      FFaker::AddressUK.country
    end

    def uk_postcode
      warn '[uk_postcode] is deprecated. For UK addresses please use the AddressUK module'
      FFaker::AddressUK.postcode
    end
    # end UK deprecation

    def neighborhood
      NEIGHBORHOOD.sample
    end

    def country(given_code = nil)
      country_index = COUNTRY_CODE.index(given_code)
      if given_code && country_index
        COUNTRY[country_index]
      else
        COUNTRY.sample
      end
    end

    def country_code(given_country = nil)
      code_index = COUNTRY.index(given_country)
      if given_country && code_index
        COUNTRY_CODE[code_index]
      else
        COUNTRY_CODE.sample
      end
    end

    def time_zone
      TIME_ZONE.sample
    end
  end
end
