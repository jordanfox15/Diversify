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

  def update
    user = current_user
    demographic = user.demographic
    demographic.update(demographic_params)
    user.update(user_params)
    render json: [demographic, user]
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :race, :email, :religion, :sex_or, :ses, :country, :gender, :age, :avatar, :password, :password_confirmation, :interest_ids => [] )
  end

  def demographic_params
    params.require(:demographic).permit(:age, :gender_id, :country_id, :race_id, :religion_id, :sex_or_id, :ses_id)
  end

end
