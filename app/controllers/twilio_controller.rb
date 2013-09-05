class TwilioController < ApplicationController
  def sms
    @client = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN
    @client.account.sms.messages.create(
      :from => '+14242887652',
      :to => '+13109232319',
      :body => params[:message]
    )
  end
end