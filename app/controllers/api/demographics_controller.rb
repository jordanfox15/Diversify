class Api::DemographicsController < ApplicationController

  def new
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
