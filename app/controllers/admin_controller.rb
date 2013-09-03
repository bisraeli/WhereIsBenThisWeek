class AdminController < ApplicationController
  before_filter :ensure_session
  before_filter do
    # Ensure user has authorized the app
    unless user_credentials.access_token || request.path_info =~ /auth/
      redirect_to oauth2authorize_admin_index_path
    end
  end

  after_filter do
    # Serialize the access/refresh token to the session
    session[:access_token] = user_credentials.access_token
    session[:refresh_token] = user_credentials.refresh_token
    session[:expires_in] = user_credentials.expires_in
    session[:issued_at] = user_credentials.issued_at
  end

  def index
    # Fetch list of events on the user's default calandar
    EventImporter.import_events!
    redirect_to events_path
  end

  def google_authorization_callback
    # Exchange token
    user_credentials.code = params[:code] if params[:code]
    user_credentials.fetch_access_token!
    redirect_to admin_index_path
  end

  def oauth2authorize
    response.status = 303
    redirect_to user_credentials.authorization_uri.to_s
  end

  private
  def ensure_session
    session[:activated] = true
  end

  def user_credentials
    # Build a per-request oauth credential based on token stored in session
    # which allows us to use a shared API client.
    @authorization ||= $client.authorization.dup.tap do |auth|
      auth.redirect_uri = google_authorization_callback_admin_index_url
      auth.update_token!(session.instance_variable_get('@delegate'))
    end
  end
end
