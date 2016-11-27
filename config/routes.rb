Rails.application.routes.draw do
  namespace :webhooks do
      post ':service/call/inbound' => 'calls#inbound_call'
      post ':service/call/hangup' => 'calls#hangup'
      post ':service/call/voicemail/complete' => 'calls#voicemail'
  end
end
