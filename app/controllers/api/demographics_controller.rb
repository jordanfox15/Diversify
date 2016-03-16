class Api::DemographicsController < ApplicationController
  skip_before_action :authenticate
  def categories
    genders = Gender.all
    countries = Country.all
    races = Race.all
    religions = Religion.all
    sex_ors = SexOr.all
    seses = Ses.all
    render json: {
                  genders: genders,
                  countries: countries,
                  races: races,
                  religions: religions,
                  sex_ors: sex_ors,
                  seses: seses
    }

  end
end
