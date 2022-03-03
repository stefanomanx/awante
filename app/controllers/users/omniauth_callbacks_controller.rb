class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip_before_action :verify_authenticity_token, only: :spotify

  def spotify
    # request.env['rack.session'][:ommiauth_spotify_force_approval?]
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.persisted?
      # flash[:ommiauth_spotify_force_approval?]
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Spotify') if is_navigational_format?
    else
      session['devise.spotify_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
